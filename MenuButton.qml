import QtQuick 2.0

Rectangle {
    property alias text: textElement.text;
    property url active_source;
    property url original_source;
    property real size;
    property bool active: false;
    property int function_id;

    Column {
        id: menu_button_column
        spacing: 5
        Image {
            id: imageElement
            width: size
            height: size
            source: original_source
        }

        Text {
            id: textElement
            font.pointSize: 12
            color: 'black'
        }
    }

    function change_active(is_active) {
        if (is_active == active)
            return;

        if (is_active) {
            imageElement.source = active_source;
            textElement.color = 'white'
            active = true;
        } else {
            imageElement.source = original_source;
            textElement.color = 'black'
            active = false;
        }
    }
}

