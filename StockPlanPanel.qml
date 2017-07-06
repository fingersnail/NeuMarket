import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls 1.4
import QtQuick.Dialogs 1.2

Rectangle {
    //property alias functionpart: functionpart
    property alias tableView: tableView
    property real tableWidth: 80
    property real singleLineHeight:30
    property int current_index: -1
    property date current_date
    property var supplier_list: {"id":[], "name":[]};

    Rectangle {
        id:leftrect
        width:parent.width*0.55
        height:parent.height*0.85

        TableView {
            property int var0;  //purchase_id
            property int var2;  //plan_employee_id
            property int var3;  //purchase_employee_id
            property string var4;  //supplier_name
            property double var7;  //money_amount
            property string var9;  //comment


            id:tableView
            anchors.fill: parent
            model:tableModel
            headerDelegate:headerDele
            rowDelegate:rowDele
            backgroundVisible:false
            clip: true
            horizontalScrollBarPolicy: Qt.ScrollBarAlwaysOff
            signal signalShowMenu(var id,int x,int y)
            ListModel
            {
                id:tableModel
                ListElement
                {
                    var5:"2017.05.01"
                    var1: 104341
                    var10:"三等奖方块"
                    var8: true
                    var6: 10
                    var0: 100
                    var2: 111
                    var3: 113
                    var4: "faf"
                    var7: 12.232
                    var9: "haha"
                }
                ListElement
                {
                    var5:"2017.05.03"
                    var1: 104346
                    var10:"迪克曼"
                    var8: true
                    var6: 100
                    var0: 100
                    var2: 111
                    var3: 113
                    var4: "faf"
                    var7: 12.232
                    var9: "haha"
                }
                ListElement
                {
                    var5:"2017.05.07"
                    var1: 104348
                    var10:"付款进度"
                    var8: true
                    var6: 1000
                    var0: 100
                    var2: 111
                    var3: 113
                    var4: "faf"
                    var7: 12.232
                    var9: "haha"
                }
            }
            //定义表头格式
            Component{
                id:headerDele
                Rectangle{
                    id:changecolorcom
                    implicitWidth:tableWidth
                    implicitHeight: 45
                    Connections {
                        target: color_pick_panel;
                        onColorChange: {changecolorcom.color = Qt.rgba(red / 255,green / 255,blue / 255, 0.8)}
                    }
                    Text {
                        text:styleData.value
                        anchors.centerIn:parent
                        font.pointSize: 14
                    }
                }
            }
            //定义行样式
            Component{
                id:rowDele
                Rectangle {
                    width:tableWidth
                    height:singleLineHeight
                    color:styleData.selected?"#450000ff":"#F0F0F0"
                    border.width: 1
                    border.color: "lightsteelblue"
                }
            }
            //id列样式
            TableViewColumn
            {

                width: tableView.width*0.17
                role: "var5" //purchase_date
                title: "日期"
                delegate:Rectangle
                {
                    color:"transparent"
                    height:singleLineHeight
                    Text{
                        anchors.centerIn:parent
                        text:styleData.value
                    }
                }

            }
            TableViewColumn
            {

                width: tableView.width*0.17
                role: "var1"
                title: "商品id"
                delegate:Rectangle
                {
                    color:"transparent"
                    height:singleLineHeight
                    Text{
                        anchors.centerIn:parent
                        text:styleData.value
                    }
                }

            }
           TableViewColumn
            {

                width: tableView.width*0.22
                role:"var10"
                title:"商品名称"
                delegate:Rectangle
                {
                    color:"transparent"
                    height:singleLineHeight
                    Text{
                        anchors.centerIn:parent
                        text:styleData.value
                    }
                }
            }
            TableViewColumn {
                width: tableView.width*0.12
                role:"var6"  //quantity
                title:"个数"
                delegate:Rectangle {
                    color:"transparent"
                    height:singleLineHeight
                    Text{
                        anchors.centerIn:parent
                        text:styleData.value
                    }
                 }
            }
            TableViewColumn{
                width: tableView.width*0.32
                role:"var8"  //is_finish
                title: "完成"
                delegate: Rectangle{
                    color: "transparent"
                    height:  singleLineHeight
                    Row{
                        anchors.centerIn: parent
                        spacing: 5
                        ExclusiveGroup{
                            id:finish_group
                        }

                        RadioButton{
                            text:"已完成"
                            exclusiveGroup: finish_group
                            checked: styleData.value ? true :false
                            onClicked: {
                                if (!tableModel.get(styleData.row).var8)
                                    controller.changePlanState(tableModel.get(
                                styleData.row).var0, true);
                            }
                        }
                        RadioButton{
                            text:"未完成"
                            exclusiveGroup: finish_group
                            checked: styleData.value ? false :true
                            onClicked: {
                                if (tableModel.get(styleData.row).var8)
                                    controller.changePlanState(tableModel.get(
                                styleData.row).var0, false);
                            }
                        }
                    }
                }

            }

            onClicked:  {
                current_index = row;
                show_detail(row);
            }

            onDoubleClicked: {
                console.log("item double click.");
                current_index = row;
                show_detail(row);
            }
        }

    }

Rectangle {
    //add item
    id: buttonrect_one
    width:leftrect.width/2
    height:parent.height*0.15
    anchors.top:leftrect.bottom

    color: 'transparent'
    Image {
        width: 50
        height: 50
        anchors.centerIn: parent
        source: "pic/add.png"
    }
    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onEntered:{

            parent.color = Qt.rgba(220/225, 220/225, 220/225, 0.5);
        }
        onExited:{
            parent.color = 'transparent'
        }
        onReleased: {
            clear_input_area();
        }
    }
}
Rectangle
{
    id:buttonrect_two
    width:leftrect.width/2
    height:parent.height*0.15
    anchors.left:buttonrect_one.right
    anchors.top:leftrect.bottom
    color: "transparent"
    Image {
        width: 50
        height: 50
        anchors.centerIn: parent
        source: "pic/delete.png"
    }
    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onEntered:{

            parent.color = Qt.rgba(220/225, 220/225, 220/225, 0.5);
        }
        onExited:{
            parent.color = 'transparent'
        }
        onClicked: {
            if (current_index >= 0)
                message_dialog.open();
        }
    }
}

property int input_width: 250
Column {
    x: 560
    y: 30
//        height: parent.height - 100
//        width: 420
    spacing: 20

    Row {
        z: 1
        Text {
            text: "日期:"
            font.pointSize: 20
            width: max_length_text.width
        }

        DatePicker {
            id: plan_date
            width: input_width
            height: 40;
            font.pointSize: 20
            dateValue: (new Date()).toLocaleString(Qt.locale(), "yyyy-MM-dd")
            onDateValueChanged: current_date = dateValue
        }
    }
    Row {
        Text {
            id: max_length_text
            text: "商品id:"
            font.pointSize: 20
        }
        MyTextField {
            id: product_id
            width: input_width
        }
    }
    Row {
        Text {
            text: "供货商:"
            font.pointSize: 20
            width: max_length_text.width
        }

        ComboBox{
            id: suppliers
            width: input_width
            height: 40;
            model: []
        }
    }
    Row {
        Text {
            text: "数量:"
            width: max_length_text.width
            font.pointSize: 20
        }
        MyTextField {
            id: product_num
            width: input_width / 3
        }
        Text {
            //id: total_price_text
            //width: max_length_text.width
            text: "总价:"
            font.pointSize: 20
        }
        MyTextField {
            id: product_price
            width: input_width / 3
        }
    }
    Row {
        id: create_row;
        Text {
            text: "创建人:"
            font.pointSize: 20
            width: max_length_text.width
        }
        Text {
            id: create_id
            width: input_width
            font.pointSize: 20
            text: "12342134534"
        }
    }
    Row {
        id: finish_row;
        Text {
            text: "完成人:"
            font.pointSize: 20
            width: max_length_text.width
        }
        Text {
            id: finish_id
            width: input_width
            font.pointSize: 20
            text: "1234213324"
        }
    }

    Row {
        Text {
            text: "状态:"
            font.pointSize: 20
            width: max_length_text.width
        }
        Row{
            spacing: 50
            ExclusiveGroup{
                id:state_group
            }

            RadioButton{
                id: finish_check
                height: 40
                text:"已完成"
                exclusiveGroup: state_group
                checked: true
            }
            RadioButton{
                id: unfinish_check
                height: 40
                text:"未完成"
                exclusiveGroup: state_group
                checked: false
            }
        }
    }
    Row {
        //spacing: 5
        Text {
            text: "备注:"
            font.pointSize: 20
            width: max_length_text.width
        }
        TextArea {
            id: additional_info
            width: input_width
            verticalScrollBarPolicy: Qt.ScrollBarAlwaysOff
        }
    }
    Row {
        anchors.right: parent.right
        spacing: 30
        SaveButton {
            onClicked: {
                if (current_index == -1) {
                    add_plan();
                } else {
                    save_plan();
                }
            }
        }
    }
}

MessageDialog{
  id:message_dialog
  standardButtons: StandardButton.Yes | StandardButton.No
  modality: Qt.ApplicationModal
  title: "删除"
  text:"你确定要删除该计划吗？"
  onYes: {
      delete_row = current_index;
      controller.deletePlan(tableModel.get(current_index).var0);
  }
}

function active() {
    visible = true;
    refresh_list();
}

function refresh_list() {
    controller.getStockPlans();
}

function clear_input_area() {
    current_index = -1;
    plan_date.dateValue = (new Date()).toLocaleString(Qt.locale(), "yyyy-MM-dd");
    product_id.text = "";
    product_num.text = "";
    product_price.text = "";
    create_row.visible = false;
    finish_row.visible = false;
    finish_check.checked = false;
    unfinish_check.checked = true;
    additional_info.text = ""
    controller.getSupplierNames();
}

function show_detail(index) {
    plan_date.dateValue = tableModel.get(index).var5;
    product_id.text = tableModel.get(index).var1;
    product_num.text = tableModel.get(index).var6;
    product_price.text = tableModel.get(index).var7;
    if (tableModel.get(index).var3 != -1) {
        finish_row.visible = true;
        finish_id.text = tableModel.get(index).var3;
    } else {
        finish_row.visible = false;
    }
    if (tableModel.get(index).var2 != -1) {
        create_row.visible = true;
        create_id.text = tableModel.get(index).var2;
    } else {
        create_row.visible = false;
    }

    if (tableModel.get(index).var8) {
        unfinish_check.checked = false;
        finish_check.checked = true;
    }
    else {
        finish_check.checked = false;
        unfinish_check.checked = true;
    }

    additional_info.text = tableModel.get(index).var9;

    suppliers.currentIndex = suppliers.find(tableModel.get(index).var4);
}

function save_plan() {
    var one = tableModel.get(current_index);
    controller.savePlan([one.var0,product_id.text,
                         supplier_list.id[suppliers.currentIndex],plan_date.dateValue,
                         product_num.text,product_price.text,
                         additional_info.text]);
    if (finish_check.checked != one.var8) {
        controller.changePlanState(one.var0, finish_check.checked);
    }
}

function add_plan() {
    controller.addPlan([product_id.text, supplier_list.id[suppliers.currentIndex],
                         plan_date.dateValue,product_num.text,
                         product_price.text,finish_check.checked,
                         additional_info.text]);
}

Connections {
    target: controller
    onStockPlans: {
        tableModel.clear();

        for (var i = 0; i <theclassmodel.rowCount(); i++) {
            tableModel.append({"var0":theclassmodel.rowColData(i,0), "var1":theclassmodel.rowColData(i,1),
                             "var2":theclassmodel.rowColData(i,2), "var3":theclassmodel.rowColData(i,3),
                             "var4":theclassmodel.rowColData(i,4), "var5":theclassmodel.rowColData(i,5),
                             "var6":theclassmodel.rowColData(i,6), "var7":theclassmodel.rowColData(i,7),
                             "var8":theclassmodel.rowColData(i,8), "var9":theclassmodel.rowColData(i,9),
                             "var10":theclassmodel.rowColData(i,10)})
        }
        current_index = -1;
        clear_input_area();
    }
}

Connections {
    target: controller
    onSupplierNames: {
        suppliers.model = names;
        supplier_list.name = names;
        supplier_list.id = ids;
    }
}

Connections {
    target: controller
    onPlanSaved:{
        if(ok){
            color_true.running = true;
            refresh_list();
        } else {
            color_false.running = true;
        }
    }
}

property int delete_row: -1;
Connections {
    target: controller
    onPlanDeleted:{
        if(ok){
            tableModel.remove(delete_row);
            clear_input_area();
            color_true.running = true;
        } else {
            color_false.running = true;
        }
    }
}
Connections {
    target: controller
    onPlanAdded:{
        if(ok){
            color_true.running = true;
            refresh_list();
        } else {
            color_false.running = true;
        }
    }
}


Connections {
    target: controller
    onPlanStateChanged: {
        if(ok){
            color_true.running = true;
        } else {
            color_false.running = true;
            refresh_list();
        }
    }
}
}

