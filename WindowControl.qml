import QtQuick 2.0
import QtQuick.Window 2.2

Rectangle {
    width: close_button.width + min_button.width
    height: close_button.height
    color: 'transparent'
    Image {
        id:close_button
        x:min_button.width
        y:0
        source:"/pic/close_stay.png"
    }
    MouseArea {
        anchors.fill:close_button
        onClicked: Qt.quit()
        hoverEnabled: true
        onEntered:close_button.source="/pic/close_active.png"
        onExited: close_button.source="/pic/close_stay.png"
    }

    Image {
        id:min_button
        x:0
        y:0
        source:"/pic/min_stay.png"
    }
    MouseArea {
        anchors.fill:min_button
        onClicked: mainwindow.visibility = Window.Minimized
        hoverEnabled: true
        onEntered:min_button.source="/pic/min_active.png"
        onExited: min_button.source="/pic/min_stay.png"
    }
}

