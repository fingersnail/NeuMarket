import QtQuick 2.0

Rectangle {
    signal colorChange(int red, int green, int blue);

    ColorPage {
        id: color_wheel
    }

    Text {
        id: ok_button
        x: parent.width - width - 10
        y: parent.height - height - 10
        text: qsTr("确定")
        color: 'black'
    }

    MouseArea {
        anchors.fill: ok_button
        onClicked:  {
            function_panel.color = Qt.rgba(color_wheel.red / 255,
                                           color_wheel.green / 255,
                                           color_wheel.blue / 255, 0.85);
            colorChange(color_wheel.red, color_wheel.green, color_wheel.blue);
            parent.visible = false;
        }
    }
}

