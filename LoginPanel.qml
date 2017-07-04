import QtQuick 2.0
import QtQuick.Window 2.2
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import neuintership.market.ControlLayer 1.0

Rectangle {
    width: 600
    height: 600

    Rectangle {
        x: 0
        y: 0
        width: 500
        height: 250
        color: 'transparent'
        Image {
            anchors.fill: parent
            source: "/pic/login_background.png"
        }

        Image {
            id:car
            x: 80
            y: 65
            width:130
            height:130
            source: "/pic/car.png"
        }

        Text {
            x: parent.width/2-width/2
            y: 10
            color:'white'
            text:"超市管理系统"
            font.pointSize: 15
            font.bold: true
        }

        SequentialAnimation {
            id: car_Anim
            NumberAnimation {
                target: car
                property: "x"
                from: car.x
                to: 500
                duration: 2000
            }
            NumberAnimation {
                target: car
                property: "x"
                from: -car.width
                to: 500
                duration: 2500
                loops: Animation.Infinite
            }
        }
    }

    Rectangle {
        x: 0
        y: 250
        width: 500
        height: 250
        color: Qt.rgba(242/256,242/256,242/256,1)
    }

    Text {
        x:50
        y:307
        color: 'black'
        text: '职工号'
        font.pointSize: 15
    }

    TextField {
        id:username
        x:150
        y:300
        //inputMethodHints: Qt.ImhDigitsOnly | Qt.ImhNoPredictiveText
        style: TextFieldStyle {
                  textColor: "black"
                  background: Rectangle {
                      implicitWidth: 300
                      implicitHeight: 40
                      border.color: "#333"
                      border.width: 1
                  }
              }
        font.family: "Helvetica"
        font.pointSize: 20
        focus: true
    }


    Text {
        x:50
        y:347
        color: 'black'
        text: '密 码'
        font.pointSize: 15
    }

    TextField {
        id:password
        x:150
        y:340
        echoMode: TextInput.Password
        style: TextFieldStyle {
                  textColor: "black"
                  //passwordCharacter:'·'
                  background: Rectangle {
                      implicitWidth: 300
                      implicitHeight: 40
                      border.color: "#333"
                      border.width: 1
                  }
              }
        font.family: "Helvetica"
        font.pointSize: 20
        focus: true
    }

    Image {
        id: login_button
        x: 250 - width/2
        y: 420
        source: "/pic/login_stay.png"
    }
    Text {
        id: login_text
        x: login_button.x + login_button.width + 10
        y: login_button.y + login_button.height/2
        font.pointSize: 10
    }


    ShadowRactangle{
        anchors.fill: parent
        color:'transparent'
    }

    WindowControl{
        x:parent.width - width
        y:0
    }

//    ControlLayer {
//        id: controller
//        onLoginFinish: {
//            changeLoginState(loginstate,workertype);
//            car_Anim.stop();
//        }
//    }

    Connections {
        target: controller
        onLoginFinish: {
            changeLoginState(loginstate,workertype);
            car_Anim.stop();
        }
    }

    MouseArea {
        anchors.fill:login_button
        //onClicked: mainwindow.visibility = Window.Minimized
        hoverEnabled: true
        onClicked: {
            car_Anim.running = true;
            login_text.text = "登陆中...";
            controller.login(username.text, password.text);
            //changeLoginState(state);
            //car_Anim.stop();
        }
        onEntered:login_button.source="/pic/login_active.png"
        onExited: login_button.source="/pic/login_stay.png"
    }

    function changeLoginState(loginstate,workertype){
        switch (loginstate) {
            case ControlLayer.SUCCESS:
                login_text.text = "登陆成功";
                login_panel.visible = false;
                mainwindow.width = function_panel.width + 14;
                mainwindow.height = function_panel.height + 14;
                function_panel.visible = true;
                break;
            case ControlLayer.INVALID_INPUT:
                login_text.text = "输入不合法";
                username.text = "";
                username.focus = true;
                break;
            case ControlLayer.NO_CONNECTION:
                login_text.text = "无网络连接";
                break;
            case ControlLayer.PASSWORD_WRONG:
                login_text.text = "密码错误";
                password.text = "";
                password.focus = true;
                break;
            case ControlLayer.USERNAME_WRONG:
                login_text.text = "用户名错误";
                username.text = "";
                username.focus = true;
                break
            default:
                break;
        }
    }
}
