import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2

Rectangle {
    id: sub_menu

    signal sub_menu_clicked(int main_selected, int sub_selected);

    Row {
        SubMenuButton {
            id: sub_button1
            width: 160
            num: 0
        }
        SubMenuButton {
            id: sub_button2
            width: 160
            num: 1
        }
    }


    property var sel;
    function change_sub_bar(selected) {
        sel = selected;
        switch(selected) {
            case 0:
                sub_button1.text = qsTr("职工信息");
                sub_button2.text = qsTr("进货商信息");
                sub_button2.visible = true;
                break;
            case 1:
                sub_button1.text = qsTr("销售记录");
                sub_button2.text = qsTr("销售盘点");
                sub_button2.visible = true;
                break;
            case 2:
                sub_button1.text = qsTr("进货计划");
                sub_button2.visible = false;
                break;
            case 3:
                sub_button1.text = qsTr("商品信息");
                sub_button2.text = qsTr("库存统计");
                sub_button2.visible = true;
                break;
            case 4:
                sub_button1.text = qsTr("密码管理");
                sub_button2.text = qsTr("用户管理");
                sub_button2.visible = true;
                break;
            default:
                break;
        }
        change_sub_active(0);
    }

    function change_sub_active(num) {
        sub_menu_clicked(sel, num);
        switch(num) {
            case 0:
                sub_button1.set_active(true);
                sub_button2.set_active(false);
                break;
            case 1:
                sub_button1.set_active(false);
                sub_button2.set_active(true);
                break;
            default:
                break;
        }
    }
}

