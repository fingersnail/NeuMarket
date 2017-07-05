import QtQuick 2.0

Rectangle {
    signal colorChange(int red, int green, int blue);
    signal becomeTransparent();
    ColorPage {
        id: color_wheel
    }

    Rectangle {
        id: ok_button
        width: 80
        height: 50
        x: parent.width - width
        y: parent.height - height
        color: "transparent"
        Text {
            anchors.centerIn: parent
            text: qsTr("确定")
            color: 'black'
        }
    }

    MouseArea {
        anchors.fill: ok_button
        onClicked:  {
            function_panel.color = Qt.rgba(color_wheel.red / 255,
                                           color_wheel.green / 255,
                                           color_wheel.blue / 255, 0.8);
            colorChange(color_wheel.red, color_wheel.green, color_wheel.blue);
            parent.visible = false;
        }
    }

    Rectangle {
        id: transparent_button
        width: 80
        height: 50
        x: 0
        y: parent.height - height
        color: "transparent"
        Text {
            anchors.centerIn: parent
            text: qsTr("全透明")
            color: 'black'
        }
    }

    MouseArea {
        anchors.fill: transparent_button
        onClicked:  {
            function_panel.color = Qt.rgba(color_wheel.red / 255,
                                           color_wheel.green / 255,
                                           color_wheel.blue / 255, 0);
            becomeTransparent();
            parent.visible = false;
        }
    }
}

