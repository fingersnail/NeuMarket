import QtQuick 2.0
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
Rectangle{
    property alias tableView: tableView
    property alias mainrect:mainrect
    property real tableWidth: 80
    property real signleLineHeight:30
    property int  c_index: 10
    id:mainrect

    Rectangle {
        id:leftrect
        width:parent.width*0.5
        height:parent.height*0.85

        TableView
        {
            id:tableView
            anchors.fill: parent
            model:tableModel
            headerDelegate:headerDele
            rowDelegate:rowDele
            backgroundVisible:false
            clip: true
            signal signalShowMenu(var id,int x,int y)
            ListModel
            {
                id:tableModel
                ListElement
                {
                    c_id:"1"
                    code:"101"
                    name:"xiaoli"
                }
                ListElement
                {
                    c_id:"2"
                    code:"102"
                    name:"xiaoming"
                }
                ListElement
                {
                    c_id:"3"
                    code:"103"
                    name:"xiaotong"

                }

            }
            //定义表头格式
            Component{
                id:headerDele
                Rectangle{
                    id:changecolorcom
                    implicitWidth:tableWidth
                    implicitHeight: 45
                    Connections {
                        target: color_pick_panel;
                        onColorChange: {changecolorcom.color = Qt.rgba(red / 255,green / 255,blue / 255, 0.8)}
                    }
                    Text{
                        text:styleData.value
                        anchors.centerIn:parent
                        font.pointSize: 14
                        }

                }
            }
            //定义行样式
            Component{
                id:rowDele
                Rectangle
                {

                    width:tableWidth
                    height:signleLineHeight
                    color:styleData.selected?"#450000ff":"#F0F0F0"
                    border.width: 1
                    border.color: "lightsteelblue"
                }

            }
            //id列样式
            TableViewColumn
            {

                width: tableView.width*0.2
                role:"c_id"
                title:" "
                delegate:Rectangle
                {
                    color:"transparent"
                    height:signleLineHeight
                    Text{
                        anchors.centerIn:parent
                        text:styleData.value
                    }
                }

            }
            TableViewColumn
            {

                width: tableView.width*0.4
                role:"code"
                title:"员工号"
                delegate:Rectangle
                {
                    color:"transparent"
                    height:signleLineHeight
                    Text{
                        anchors.centerIn:parent
                        text:styleData.value
                    }
                }

            }
           TableViewColumn
            {

                width: tableView.width*0.4
                role:"name"
                title:"姓名"
                delegate:Rectangle
                {
                    color:"transparent"
                    height:signleLineHeight
                    Text{
                        anchors.centerIn:parent
                        text:styleData.value
                    }
                }

            }

        }
    }
//            itemDelegate:Rectangle
//            {
//                id:signalitem
//                MouseArea{
//                    id:mouse_delegate
//                    acceptedButtons: Qt.RightButton|Qt.LeftButton
//                    hoverEnabled: true
//                    propagateComposedEvents: true
//                    enabled:true
//                    anchors.fill: parent
//                    onEntered:{
//                        signalitem.color = "blue"
//                    }
//                    onExited:{
//                        signalitem.color = "transparent"
//                    }
//                    onDoubleClicked: {
//                        mouse.accepted = false;
//                        console.log("item double click.");
//                        //鼠标双击属性进入编辑界面
//                        functionpart.visible=true;
//                    }
//                }
//            }


//        }

//    }
Rectangle {
    //add item
    id: buttonrect_one
    width:leftrect.width/2
    height:parent.height*0.15
    anchors.top:leftrect.bottom

    color: 'transparent'
    Image {
        width: 50
        height: 50
        anchors.centerIn: parent
        source: "pic/add.png"
    }
    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onEntered:{

            parent.color = Qt.rgba(220/225, 220/225, 220/225, 0.5);
        }
        onExited:{
            parent.color = 'transparent'
        }
        onClicked: {
            c_index++;
            tableView.model.append({ "c_id":c_index.toString(),
                                     "code":"09090",
                                     "name":"xiaoxiao"});
        }
    }
}
Rectangle
{

    id:buttonrect_two
    width:leftrect.width/2
    height:parent.height*0.15
    anchors.left:buttonrect_one.right
    anchors.top:leftrect.bottom
    color: "transparent"
    Image {
        width: 50
        height: 50
        anchors.centerIn: parent
        source: "pic/delete.png"
    }
    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onEntered:{

            parent.color = Qt.rgba(220/225, 220/225, 220/225, 0.5);
        }
        onExited:{
            parent.color = 'transparent'
        }
        onClicked: {
            if(tableView.model.count > 0)
            {
                tableView.model.remove(0);
            }
        }
    }


}

Rectangle
{
    id: rightrect
    width:mainrect.width*0.5
    height:mainrect.height
    anchors.right:mainrect.right
    anchors.top:mainrect.top
    anchors.topMargin: 55
    color:"transparent"
    visible: true
    Column {
        id:infolist
        spacing: 15
        anchors.left:parent.left
        anchors.leftMargin: 40
        Row {
            Text {
                text: "用户id：  "
                font.pointSize: 14
            }
            MyTextField {
                id: person_id
                width: mainrect.width*0.3

            }
        }
        Row {
            Text {
                text: "姓名：    "
                font.pointSize: 14
            }
            MyTextField {
                id: person_name
                width: mainrect.width*0.3

            }
        }
        Row {
            Text {
                text: "密码：    "
                font.pointSize: 14
            }
            MyTextField {
                id: person_address
                width: mainrect.width*0.3

                }
            }
               }
        SaveButton {
            anchors.right:rightrect.right
            anchors.rightMargin: 55
            anchors.top:infolist.bottom
            anchors.topMargin: 15

        }

    }

    function active() {
        visible = true;
    }
}

