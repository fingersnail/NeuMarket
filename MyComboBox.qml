//import QtQuick 2.0
//import QtQuick.Controls.Styles 1.2
//import QtQuick.Controls 1.2

//ComboBox {
//    width: 50
//    height:30
//    property string borderColor: "#4F4F4F"
//    property int borderWidth: 1
//    style: ComboBoxStyle{
//        id:style
//        dropDownButtonWidth: 50
//        background:Rectangle {
//            id:background
//            width: control.width - borderWidth
//            height: control.height - borderWidth
//            border.color: borderColor
//            border.width: borderWidth
////            Image {
////                id: imageDropdown
////                width: height
////                height: 0.5 * parent.height
////                anchors.right: parent.right
////                anchors.rightMargin: 10
////                anchors.verticalCenter: parent.verticalCenter
////                fillMode: Image.Stretch
////                source: "qrc:/images/dropdown.png"
////            }
//        }

//        label: Text {
//            id: text1
//            height: control.height
//            color: "#4f4f4f"
//            text:control.currentText
//            verticalAlignment: Text.AlignVCenter
//            horizontalAlignment: Text.AlignHCenter
//            font.pixelSize: 14
//        }
//    }
//}
import QtQuick 2.0
Rectangle {
    id:comboBox
    property variant items: ["0", "1"]
    property alias selectedItem: chosenItemText.text;
    property alias selectedIndex: listView.currentIndex;
    signal comboClicked;
    width: 50;
    height: 30;
    smooth:true;
    Rectangle {
        id:chosenItem
        width:parent.width;
        height:comboBox.height;
        color: "#FFFFFF"
        smooth:true;
        Text {
            anchors.top: parent.top;
            anchors.left: parent.left;
            anchors.margins: 3;
            anchors.verticalCenter: parent.verticalCenter
            id:chosenItemText
            text:comboBox.items[0];
            font.family: "Arial"
            font.pointSize: 14;
            smooth:true
        }
        MouseArea {
            anchors.fill: parent;
            onClicked: {
                comboBox.state = comboBox.state==="dropDown"?"":"dropDown"
            }
        }
    }
    Rectangle {
        id:dropDown
        width:comboBox.width;
        height:0
        clip:true;
        anchors.top: chosenItem.bottom;
        anchors.topMargin: 2
        color: "#F0F0F0"
        Rectangle{
            id: dropDownMask
            height: 3
            width:parent.width
            anchors.bottom: listView.top
        }
        ListView {
            id:listView
            height:250
            width: dropDown.width-4
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: dropDownMask.bottom
            anchors.topMargin: -1
            z:1
            model: comboBox.items
            currentIndex: 0
            delegate: Item{
                width:listView.width;
                height: comboBox.height;
                Rectangle {
                    id: mouseMoveHighLight
                    width:listView.width;
                    height:comboBox.height;
                    color: "#450000ff";
                    opacity: 0
                    radius: 4
                    z:0
                }
                Text {
                    text: modelData
                    anchors.top: parent.top;
                    anchors.left: parent.left;
                    anchors.margins: 5;
                    font.pointSize: 14;
                    z:1
                }
                MouseArea {
                    anchors.fill: parent;
                    hoverEnabled: true
                    onClicked: {
                        comboBox.state = ""
                        var preSelection = chosenItemText.text
                        chosenItemText.text = modelData
                        if(chosenItemText.text != preSelection){
                            comboBox.comboClicked();
                        }
                        listView.currentIndex = index;
                    }
                    onEntered: mouseMoveHighLight.opacity = 0.5;
                    onExited: mouseMoveHighLight.opacity = 0;
                }
            }
            highlight: Rectangle {
                width:listView.width;
                height:comboBox.height;
                color: "#450000ff";
                radius: 4
            }
        }
        MouseArea{
            anchors.fill: dropDown
            hoverEnabled: true
            onExited: {
                if(!containsMouse)
                    comboBox.state = "";
            }
        }
    }
    states: State {
        name: "dropDown";
        PropertyChanges { target: dropDown; height:30*comboBox.items.length+4 }
    }
    transitions: Transition {
        NumberAnimation { target: dropDown; properties: "height"; easing.type: Easing.OutExpo; duration: 200 }
    }
}
