#include "logincontroller.h"

LoginController::LoginController()
{

}

LoginController::LoginState LoginController::login(QString name, QString password) {
    LoginState state;
    if (name == "admin" && password == "123")
        state = LoginState::SUCCESS;
    else
        state = LoginState::NO_CONNECTION;

    //完成登陆代码

    emit loginFinish(state); //发出登陆完成信号

    return state;
}
