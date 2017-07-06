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

    Image{
        x:10
        y:0
        id:shop_icon
        width:sourceSize.width*0.9
        height:sourceSize.height*0.8
        source:"pic/titleicon.png"
    }
}

