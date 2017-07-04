import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.3
import QtQuick 2.4
import ColorTransFormer 1.0
import QtGraphicalEffects 1.0

Rectangle {
    property var angle;
    property int pointx;
    property int pointy;
    property int red:0
    property int blue:0
    property int green:0
    property int groupR:ma.width/2
    property int lightness:100

    property int cv: 255;
    property int cs;
    property int ch;

    anchors.fill: parent

    MColorTransFormer{
        id:color_hsv
    }



    function caculate_angle(){
        var r=Math.sqrt((pointx*pointx+pointy*pointy))
        if(pointx>=0&&pointy>=0){
            angle=Math.asin(pointy/r)
        }

        if(pointx<0&&pointy>=0){
            angle=Math.PI-Math.asin(pointy/r)
        }

        if(pointx<0&&pointy<0){
            angle=Math.PI+Math.asin(Math.abs(pointy)/r)
        }

        if(pointx>=0&&pointy<0){
            angle=2*Math.PI-Math.asin(Math.abs(pointy)/r)

        }
        //console.log("angle:"+angle)
        caculate_h_s(r)
    }

    function caculatx(angle,r){
        if(angle>=0&&angle<=Math.Pi/2){
            return Math.cos(angle)*r
        }
        if(angle>Math.Pi/2&&angle<=Math.Pi){
            return -Math.cos(Math.PI-angle)*r
        }
        if(angle>Math.Pi&&angle<=Math.Pi*3/2){
            return -Math.cos(angle-Math.PI)*r
        }
        if(angle>Math.Pi*3/2&&angle<=Math.Pi*2){
            return Math.cos(Math.PI*2-angle)*r
        }
    }
    function caculaty(angle,r){
        if(angle>=0&&angle<=Math.Pi/2){
            return Math.sin(angle)*r
        }
        if(angle>Math.Pi/2&&angle<=Math.Pi){
            return Math.sin(Math.PI-angle)*r
        }
        if(angle>Math.Pi&&angle<=Math.Pi*3/2){
            return -Math.sin(angle-Math.PI)*r
        }
        if(angle>Math.Pi*3/2&&angle<=Math.Pi*2){
            return -Math.sin(Math.PI*2-angle)*r
        }
    }

    function caculate_h_s(r){
        ch=Math.round(360*angle/(2*Math.PI))
        cs=Math.round(255*(1-(groupR-r)/groupR))
        color_hsv.set_hsv(ch,cs,cv)
        red=color_hsv.get_red()
        blue=color_hsv.get_blue()
        green=color_hsv.get_green()
    }

    function caculatAngleWithH(h){
        return 2*Math.PI*h/360
    }
    function caculatRWithS(s){
        return 255*groupR/(510-s)
    }

    //颜色选择器件
    Image {
        id: colorimg
        source: "pic/hsv.png"
        width: parent.width
        height: width
        anchors.horizontalCenter: parent.horizontalCenter
        //y:10*mainWin.dentisty
        //transform: Scale { origin.x: colorimg.width/2; origin.y: colorimg.width/2; xScale: -1}


    }

    MouseArea{
        id:ma
        anchors.fill: colorimg

        Rectangle{
            id:pointer
            width: 30
            height: 30
            color:"#00000000"
            x:parent.width/2-width/2
            y:parent.width/2-width/2
            Rectangle{
                width: parent.width
                height: 1
                anchors.centerIn: parent
                color: "#101010"
            }
            Rectangle{
                width: 1
                height: parent.height
                anchors.centerIn: parent
                color: "#101010"
            }
        }
        onPositionChanged: {
            pointx=ma.mouseX-ma.width/2
            pointy=-(ma.mouseY-ma.width/2)
            caculate_angle()

            if(Math.sqrt((pointx*pointx+pointy*pointy))<=groupR){
                pointer.x=pointx+ma.width/2-pointer.width/2
                pointer.y=ma.width/2-pointy-pointer.width/2
                //console.log("r1:"+Math.sqrt((pointx*pointx+pointy*pointy))+"  r2:"+groupR)
            }
        }
        onPressed: {
            pointx=ma.mouseX-ma.width/2
            pointy=-(ma.mouseY-ma.width/2)
            caculate_angle()
            if(Math.sqrt((pointx*pointx+pointy*pointy))<=groupR){
                pointer.x=pointx+ma.width/2-pointer.width/2
                pointer.y=ma.width/2-pointy-pointer.width/2
//                console.log("r1:"+Math.sqrt((pointx*pointx+pointy*pointy))+"  r2:"+groupR)
            }
        }
        onPressAndHold: {
            pointx=ma.mouseX-ma.width/2
            pointy=-(ma.mouseY-ma.width/2)
            caculate_angle()
            if(Math.sqrt((pointx*pointx+pointy*pointy))<=groupR){
                pointer.x=pointx+ma.width/2-pointer.width/2
                pointer.y=ma.width/2-pointy-pointer.width/2
                console.log("r1:"+Math.sqrt((pointx*pointx+pointy*pointy))+"  r2:"+groupR)
            }
        }
    }
}
