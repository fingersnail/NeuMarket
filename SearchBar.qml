import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2

Rectangle {
    width: 300
    height: 40

    signal on_search(string search_content);

    TextField {
        id: search_input
        anchors.fill: parent
        style: TextFieldStyle {
                  textColor: "black"
                  background: Rectangle {
                      id: srearch_rectangle
                      border.color: "#333"
                      border.width: 1
                      Image {
                          x: 300 - width - 6
                          y: 6
                          width: 28
                          height: 28
                          id: search_image
                          source: "pic/search.png"
                      }
                  }
              }
        font.family: "Helvetica"
        font.pointSize: 20
        focus: true
    }

//    MouseArea {
//        anchors.fill: search_image
//        onClicked: {
//            on_search(search_input.text);
//        }
//    }

    Keys.onReturnPressed: {
        if (search_input.focus) {
            on_search(search_input.text);
        }
    }


}

