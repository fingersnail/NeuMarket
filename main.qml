import QtQuick 2.3
import QtQuick.Window 2.2
import QtQuick.Controls 1.2
import QtGraphicalEffects 1.0
import neuintership.market.ControlLayer 1.0

Window {
    id: mainwindow
    //width: 514
    //height: 514
    width: 1214
    height: 814
    visible: true
    color:'transparent'
    flags: Qt.FramelessWindowHint | Qt.WindowSystemMenuHint
           | Qt.WindowMinimizeButtonHint| Qt.Window

    MouseArea{
        id: dragRegion
        anchors.fill: parent
        property point clickPos:"0,0"
        onPressed:{
            clickPos =Qt.point(mouse.x,mouse.y)
        }
        onPositionChanged:{
            //鼠标偏移量
            var delta =Qt.point(mouse.x-clickPos.x, mouse.y-clickPos.y)
            //如果mainwindow继承自QWidget,用setPos
            mainwindow.setX(mainwindow.x+delta.x)
            mainwindow.setY(mainwindow.y+delta.y)
        }
        onClicked: {
            function_panel.detail_panel.search_area.focus = false
        }
    }


    ControlLayer {
        id: controller
    }

    LoginPanel {
        id: login_panel
        width: 500
        height: 500
        x: 7
        y: 7
        color:Qt.rgba(242/256,242/256,242/256,0.8)
        visible: false
    }

    FunctionPanel {
        id: function_panel
        width: 1200
        height: 800
        x: 7
        y: 7
        //color:Qt.rgba(40/256,176/256,242/256,0.8)
        color:Qt.rgba(230/256,10/256,10/256,0.85)
        visible: true
    }
}
