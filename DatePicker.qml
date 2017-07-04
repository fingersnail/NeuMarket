import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2

TextField {
    property string dateValue
    Calendar{
        id: calendar
        anchors.topMargin: 0
        anchors.top: parent.bottom
        visible: false
        activeFocusOnTab: true
        onReleased: {
            text = date;
            text = text.substr(0, 10);
            dateValue = text;
            visible = false;
        }
    }
    Button{
        id: downBtn
        width: 22
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0
        iconSource: "pic/arrow_down.png"
        style: ButtonStyle {
                background: Rectangle {
                    color: 'transparent'
                }
            }
        onClicked: calendar.visible = !calendar.visible
    }
    style: TextFieldStyle {
              textColor: "black"
              background: Rectangle {
                  border.color: "#a19e9e"
                  border.width: 1
              }
          }
    onDateValueChanged:{
        text = dateValue;
        calendar.selectedDate = dateValue;
    }
}
