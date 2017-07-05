import QtQuick 2.0

Item {
    property alias search_area: search_area
    property var panels: new Array(
                             new Array(person_info_panel, supplier_info_panel),
                             new Array(sale_query_panel, sale_static_panel),
                             new Array(stock_query_panel),
                             new Array(repertory_query_panel, repertory_maintain_panel),
                             new Array(password_manage_panel, user_manage_panel));

    SubMenuBar {
        id: sub_bar
        x: 0
        y: 10
        onSub_menu_clicked: {
            for (var i = 0; i < panels.length; i++) {
                for (var j = 0; j < panels[i].length; j++) {
                    if (main_selected == i && sub_selected == j) {
                        panels[i][j].active();
                    } else {
                        panels[i][j].visible = false;
                    }
                }
            }
        }
    }

    Connections {
        target:color_pick_panel
        onBecomeTransparent: {
            content_panel.color =  Qt.rgba(1,1,1,0);
        }
    }

    Connections {
        target:color_pick_panel
        onColorChange: {
            content_panel.color =  Qt.rgba(1,1,1,0.8);
        }
    }

    Rectangle {
        x: 0
        y: 50
        id: content_panel
        width: parent.width - x
        height: parent.height - y
        color: Qt.rgba(1,1,1,0.8);

        PersonInfoPanel {
            anchors.fill: parent
            id: person_info_panel
            visible: false
            color: 'transparent';
        }

        SupplierInfoPanel {
            id: supplier_info_panel
            anchors.fill: parent
            visible: false
            color: 'transparent';
        }

        SaleQueryPanel {
            id: sale_query_panel
            anchors.fill: parent
            visible: false
            color: 'transparent';
        }

        SaleStaticPanel {
            id: sale_static_panel
            anchors.fill: parent
            visible: false
            color: 'transparent';
        }

        StockPlanPanel {
            id: stock_query_panel
            anchors.fill: parent
            visible: false
            color: 'transparent';
        }


        RepertoryQueryPanel {
            id: repertory_query_panel
            anchors.fill: parent
            visible: false
            color: 'transparent';
        }

        RepertoryStatisPanel {
            id: repertory_maintain_panel
            anchors.fill: parent
            visible: false
            color: 'transparent';
        }

        PasswordManagePanel {
            id: password_manage_panel
            anchors.fill: parent
            visible: false
            color: 'transparent';
        }

        UserManagePanel {
            id: user_manage_panel
            anchors.fill: parent
            visible: false
            color: 'transparent';
        }
    }

    SearchBar {
        id: search_area
        x: parent.width - width
        y: 0
        visible: false
    }


    function change_page(selected) {
        sub_bar.change_sub_bar(selected);
    }
}

