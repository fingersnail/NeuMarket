import QtQuick 2.0
import QtQuick.Controls.Styles 1.2
import QtQuick.Controls 1.2
RadioButton {
    style: RadioButtonStyle {
        indicator: Rectangle {
                implicitWidth: 16
                implicitHeight: 16
                radius: 9
                border.color: control.activeFocus ? "darkblue" : "gray"
                border.width: 1
                Rectangle {
                    anchors.fill: parent
                    visible: control.checked
                    color: "#555"
                    radius: 9
                    anchors.margins: 4
                }
        }
        Text
        {
            font.pointSize:14
        }
    }
 }
