import QtQuick 2.0

Rectangle {
    property int user_function: navi_bar.user_function

    ShadowRactangle{
        anchors.fill: parent
        color:'transparent'
    }

    Title {
        x: 0
        y: 0
        width: parent.width
        color: 'transparent'
    }

    DetailPanel {
        id: detail_panel
        x: 180
        y: 50
        width:  980//parent.width - x
        height: 710//parent.height - y
        //color: Qt.rgba(1,1,1,0.8);
    }

    NaviBar {
        id: navi_bar
        color: 'transparent'
        x:30
        y:80
        height: parent.height
        width: 85 + 50
        image_size: 85
        user_function: 31
        Component.onCompleted: set_function()

        onMenu_clicked: {
            detail_panel.change_page(selected);
        }
    }


    ColorPickPanel {
        id: color_pick_panel
        width: 400
        height: 400
        x: 700
        y: 10
        visible: false
    }
    SequentialAnimation {
            id: color_true;
            ColorAnimation {
                target: function_panel;
                properties: 'color'
                from: function_panel.color;
                to: Qt.rgba(0, 255, 0, 0.85);
                duration: 200
            }
            ColorAnimation {
                target: function_panel;
                properties: 'color'
                from: Qt.rgba(0, 255, 0, 0.85);
                to: function_panel.color;
                duration: 200
            }
        }

        SequentialAnimation {
            id: color_false;
            ColorAnimation {
                target: function_panel;
                properties: 'color'
                from: function_panel.color;
                to: Qt.rgba(255, 0, 0, 0.85);
                duration: 200
            }
            ColorAnimation {
                target: function_panel;
                properties: 'color'
                from: Qt.rgba(255, 0, 0, 0.85);
                to: function_panel.color;
                duration: 200
            }
        }

}

