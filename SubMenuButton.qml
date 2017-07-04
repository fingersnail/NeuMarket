import QtQuick 2.0

Rectangle {
    property alias text: textElement.text;
    property bool active: false;
    property int num;
    height: 40;
    color: 'transparent'

    Text {
        id: textElement
        anchors.centerIn: parent
        color: 'black'
        font.pointSize: 15
    }

    MouseArea{
        id: sub_area
        anchors.fill: textElement
        cursorShape: Qt.PointingHandCursor;
        hoverEnabled: true
        onClicked: {
            if (!active)
                sub_bar.change_sub_active(num);
        }
        onEntered: {
            if (!active)
                color = Qt.rgba(242/256,242/256,242/256,0.5)
        }
        onExited: {
            if (!active)
                color = 'transparent'
        }
    }

    function set_active(is_active) {
        if (is_active == active)
            return;
        if (is_active) {
            color = Qt.rgba(242/256,242/256,242/256,0.5);
            active = true;
            sub_area.visible = false;
        } else {
            color = 'transparent';
            active = false;
            sub_area.visible = true;
        }
    }
}

