import QtQuick 2.0

Rectangle{
    width: 100
    height: 50
    color: "#09BA07"

    signal clicked();


    Text {
        anchors.centerIn: parent
        text: qsTr("保存")
        color: 'white'
        font.pointSize: 15
    }

    MouseArea {
        id: save_area
        anchors.fill: parent;
        hoverEnabled: true;
        onEntered: parent.color = "#08A906"
        onExited: parent.color = "#09BA07"
        onClicked: parent.clicked();
    }

}
