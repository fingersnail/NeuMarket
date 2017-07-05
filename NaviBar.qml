import QtQuick 2.0

Rectangle {
    property real image_size;
    property int user_function;
    signal menu_clicked(int selected);

    property var buttons: new Array;
    property var areas: new Array(menu_area0, menu_area1, menu_area2,
                        menu_area3, menu_area4);
    property var enter_anims: new Array(enter_anim0, enter_anim1, enter_anim2,
                        enter_anim3, enter_anim4);
    property var exit_anims: new Array(exit_anim0, exit_anim1, exit_anim2,
                        exit_anim3, exit_anim4);
    property var num: 0;

    function set_function() {
        var authority = user_function;

        if (authority % 2 == 1) {
            person_manage_btn.y = num * navi_bar.height/6;
            person_manage_btn.visible = true;
            areas[num].visible = true;
            buttons.push(person_manage_btn);
            enter_anims[num].target = person_manage_btn;
            exit_anims[num].target = person_manage_btn;
            num++;
            authority--;
        }
        authority /= 2;
        if (authority % 2 == 1) {
            sale_manage_btn.y = num * navi_bar.height/6;
            sale_manage_btn.visible = true;
            areas[num].visible = true;
            buttons.push(sale_manage_btn);
            enter_anims[num].target = sale_manage_btn;
            exit_anims[num].target = sale_manage_btn;
            num++;
            authority--;
        }
        authority /= 2;
        if (authority % 2 == 1) {
            stock_manage_btn.y = num * navi_bar.height/6;
            stock_manage_btn.visible = true;
            areas[num].visible = true;
            buttons.push(stock_manage_btn);
            enter_anims[num].target = stock_manage_btn;
            exit_anims[num].target = stock_manage_btn;
            num++;
            authority--;
        }
        authority /= 2;
        if (authority % 2 == 1) {
            repertory_manage_btn.y = num * navi_bar.height/6;
            repertory_manage_btn.visible = true;
            areas[num].visible = true;
            buttons.push(repertory_manage_btn);
            enter_anims[num].target = repertory_manage_btn;
            exit_anims[num].target = repertory_manage_btn;
            num++;
            authority--;
        }
        authority /= 2;
        if (authority % 2 == 1) {
            system_manage_btn.y = num * navi_bar.height/6;
            system_manage_btn.visible = true;
            areas[num].visible = true;
            buttons.push(system_manage_btn);
            enter_anims[num].target = system_manage_btn;
            exit_anims[num].target = system_manage_btn;
            num++;
            authority--;
        }
        if (num > 1)
            enter_anims[0].running = true;
        change_function(0);
        menu_clicked(buttons[0].function_id);
    }

        MenuButton {
            x: 0
            id: person_manage_btn
            size: image_size
            original_source: "pic/Person_manage.png"
            active_source: "pic/person_manage_active.png";
            text: "人事管理"
            visible: false
            function_id: 0
        }

        MenuButton {
            x: 0
            id: sale_manage_btn
            size: image_size
            original_source: "pic/sale_manage.png"
            active_source: "pic/sale_manage_active.png";
            text: "销售管理"
            visible: false
            function_id: 1
        }

        MenuButton {
            x: 0
            id: stock_manage_btn
            size: image_size
            original_source: "pic/stock_manage.png"
            active_source: "pic/stock_manage_active.png"
            text: "进货管理"
            visible: false
            function_id: 2
        }

        MenuButton {
            x: 0
            id: repertory_manage_btn
            size: image_size
            original_source: "pic/repertory_manage.png"
            active_source: "pic/repertory_manage_active.png";
            text: "库存管理"
            visible: false
            function_id: 3
        }

        MenuButton {
            x: 0
            id: system_manage_btn
            size: image_size
            original_source: "pic/system_manage.png"
            active_source: "pic/system_manage_active.png";
            text: "系统管理"
            visible: false
            function_id: 4
        }

        NumberAnimation {
            id: enter_anim0
            property: "x"
            from: 0
            to: 50
            easing.type: Easing.OutBack
            duration: 200
        }

        NumberAnimation {
            id: exit_anim0
            property: "x"
            from: 50
            to: 0
            easing.type: Easing.OutBack
            duration: 200
        }

        NumberAnimation {
            id: enter_anim1
            property: "x"
            from: 0
            to: 50
            easing.type: Easing.OutBack
            duration: 200
        }

        NumberAnimation {
            id: exit_anim1
            property: "x"
            from: 50
            to: 0
            easing.type: Easing.OutBack
            duration: 200
        }

        NumberAnimation {
            id: enter_anim2
            property: "x"
            from: 0
            to: 50
            easing.type: Easing.OutBack
            duration: 200
        }

        NumberAnimation {
            id: exit_anim2
            property: "x"
            from: 50
            to: 0
            easing.type: Easing.OutBack
            duration: 200
        }

        NumberAnimation {
            id: enter_anim3
            property: "x"
            from: 0
            to: 50
            easing.type: Easing.OutBack
            duration: 200
        }

        NumberAnimation {
            id: exit_anim3
            property: "x"
            from: 50
            to: 0
            easing.type: Easing.OutBack
            duration: 200
        }

        NumberAnimation {
            id: enter_anim4
            property: "x"
            from: 0
            to: 50
            easing.type: Easing.OutBack
            duration: 200
        }

        NumberAnimation {
            id: exit_anim4
            property: "x"
            from: 50
            to: 0
            easing.type: Easing.OutBack
            duration: 200
        }


        MouseArea{
            id: menu_area0
            x:0
            y:0
            width: image_size
            height: navi_bar.height/6
            cursorShape: Qt.PointingHandCursor;
            hoverEnabled: true
            onClicked: {
                navi_bar.menu_clicked(buttons[0].function_id);
                change_function(0);
            }
            onEntered: {
                if (!buttons[0].active)
                    enter_anim0.running = true;
            }
            onExited: {
                if (!buttons[0].active)
                    exit_anim0.running = true;
            }
            visible: false
        }

        MouseArea{
            id: menu_area1
            x:0
            y: navi_bar.height/6;
            width: image_size
            height: navi_bar.height/6
            cursorShape: Qt.PointingHandCursor;
            hoverEnabled: true
            onClicked: {
                navi_bar.menu_clicked(buttons[1].function_id);
                change_function(1);
            }
            onEntered: {
                if (!buttons[1].active)
                    enter_anim1.running = true;
            }
            onExited: {
                if (!buttons[1].active)
                    exit_anim1.running = true;
            }
            visible: false
        }

        MouseArea{
            id: menu_area2
            x:0
            y: 2*navi_bar.height/6;
            width: image_size
            height: navi_bar.height/6
            cursorShape: Qt.PointingHandCursor;
            hoverEnabled: true
            onClicked: {
                navi_bar.menu_clicked(buttons[2].function_id);
                change_function(2);
            }
            onEntered: {
                if (!buttons[2].active)
                    enter_anim2.running = true;
            }
            onExited: {
                if (!buttons[2].active)
                    exit_anim2.running = true;
            }
            visible: false
        }

        MouseArea{
            id: menu_area3
            x:0
            y: 3*navi_bar.height/6;
            width: image_size
            height: navi_bar.height/6
            cursorShape: Qt.PointingHandCursor;
            hoverEnabled: true
            onClicked: {
                navi_bar.menu_clicked(buttons[3].function_id);
                change_function(3);
            }
            onEntered: {
                if (!buttons[3].active)
                    enter_anim3.running = true;
            }
            onExited: {
                if (!buttons[3].active)
                    exit_anim3.running = true;
            }
            visible: false
        }

        MouseArea{
            id: menu_area4
            x:0
            y: 4*navi_bar.height/6;
            width: image_size
            height: navi_bar.height/6
            cursorShape: Qt.PointingHandCursor;
            hoverEnabled: true
            onClicked: {
                navi_bar.menu_clicked(buttons[4].function_id);
                change_function(4);
            }
            onEntered: {
                if (!buttons[4].active)
                    enter_anim4.running = true;
            }
            onExited: {
                if (!buttons[4].active)
                    exit_anim4.running = true;
            }
            visible: false
        }

        function change_function(n) {
            for (var i = 0; i < num; i++) {
                if (i == n) {
                    buttons[i].change_active(true);
                    areas[i].visible = false;
                } else if (buttons[i].active){
                    buttons[i].change_active(false);
                    areas[i].visible = true;
                    exit_anims[i].running = true;
                }
            }
        }
}

