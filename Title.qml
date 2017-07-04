import QtQuick 2.0

Rectangle {
    height:60

    WindowControl{
        id: window_control
        x:parent.width - width
        y:0
    }

    Image {
        id: hsv_button
        width: window_control.height - 5
        height: window_control.height - 5
        source: "pic/hsv_button.png"
        x:parent.width - window_control.width - width - 10
        y:5
    }

    MouseArea {
        anchors.fill: hsv_button;
        onClicked:  {
            color_pick_panel.visible = true;
        }
    }
    Text {
        x: 10
        y: 5
        text: "超市管理系统"
        font.pointSize: 15
        color: 'white'
    }
}

