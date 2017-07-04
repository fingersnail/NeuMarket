import QtQuick 2.0

Item {
    property alias color: rectangle.color
    property alias source: image.source

    BorderImage {
        anchors.fill: rectangle
        anchors {
            leftMargin: -5
            topMargin: -3
            rightMargin: -5
            bottomMargin: -6
        }
        border {
            left: 10
            top: 10
            right: 10
            bottom: 10
        }
        source: "/pic/shadow.png"
        smooth: true
    }
    Rectangle {
        id: rectangle
        anchors.fill: parent
        Image{
            id:image
            anchors.fill: rectangle
            fillMode: Image.PreserveAspectFit
            smooth: true
        }
    }
}

