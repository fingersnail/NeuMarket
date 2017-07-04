import QtQuick 2.0

Rectangle{
    width: 100
    height: 50
    color: "#FF0000"

    signal clicked();

    Text {
        anchors.centerIn: parent
        text: qsTr("删除")
        color: 'white'
        font.pointSize: 15
    }

    MouseArea {
        anchors.fill: parent;
        hoverEnabled: true;
        onEntered: parent.color = "#DC143C"
        onExited: parent.color = "#FF0000"
        onClicked: parent.clicked();
    }
}
