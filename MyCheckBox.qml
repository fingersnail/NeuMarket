import QtQuick 2.0
import QtQuick.Controls.Styles 1.2
import QtQuick.Controls 1.2
CheckBox {
    style: CheckBoxStyle {
        indicator: Rectangle {
            implicitWidth: 16
            implicitHeight: 16
            radius: 3
            border.color: control.activeFocus ? "darkblue" : "gray"
            border.width: 1
            Rectangle {
                visible: control.checked
                color: "#555"
                border.color: "#333"
                radius: 1
                anchors.margins: 4
                anchors.fill: parent
            }
            Label{
                font.pointSize: 14
            }
        }

    }
}
