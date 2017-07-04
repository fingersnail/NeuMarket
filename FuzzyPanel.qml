import QtQuick 2.0
import QtGraphicalEffects 1.0

Rectangle{
    id: panelFg
    color:Qt.rgba(0.5,0.5,0.5,0.3)
    width: 200
    height: 200
    clip: true

    // 属性
    property Item target : panelBg  // 模糊源
    property bool dragable : true   // 是否可拖动

    // 毛玻璃效果
    FastBlur {
        id: blur
        source: parent.target
        width: source.width;
        height: source.height
        radius: 64
    }

    // 可拖移
    MouseArea {
        id: dragArea
        anchors.fill: parent
        drag.target: dragable ? parent : null
    }

    // 设置模糊组件的位置
    onXChanged: setBlurPosition();
    onYChanged: setBlurPosition();
    Component.onCompleted: setBlurPosition();
    function setBlurPosition(){
        blur.x = target.x - x;
        blur.y = target.y - y;
    }
}
