import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2

TextField {
    style: TextFieldStyle {
              textColor: "black"
              background: Rectangle {
                  border.color: "#a19e9e"
                  border.width: 1
              }
          }
    //font.family: "Helvetica"
    font.pointSize: 20
    //focus: true
}
