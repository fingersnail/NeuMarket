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

    Rectangle {
        id:leftrect
        width:parent.width*0.55
        height:parent.height*0.85

        TableView {
            property string var2;
            property double var4;
            property string var5;
            property string var6;

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
                    var0:104341
                    var1:"三等奖方块"
                    var2:"食品"
                    var3: 10
                    var4: 3.43
                    var5: "haha"
                    var6: "pic/bilibili.png"
                }
                ListElement
                {
                    var0:104346
                    var1:"迪克曼"
                    var3: 100
                }
                ListElement
                {
                    var0:104348
                    var1:"付款进度"
                    var3: 1000
                }
            }
            //定义表头格式
            Component{
                id:headerDele
                Rectangle{
                    id:changecolorcom
                    implicitWidth:tableWidth
                    implicitHeight: 45
                    //color:"midnightblue"
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
                Rectangle
                {
                    width:tableWidth
                    height:singleLineHeight
                    color:styleData.selected?"#450000ff":"#F0F0F0"
                    border.width: 1
                    border.color: "lightsteelblue"
                }
            }
            TableViewColumn
            {

                width: tableView.width*0.4
                role:"var0"
                title:"商品id"
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

                width: tableView.width*0.4
                role:"var1"
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
                width: tableView.width*0.2
                role:"var3"
                title:"库存数"
                delegate:Rectangle {
                    color:"transparent"
                    height:singleLineHeight
                    Text{
                        anchors.centerIn:parent
                        text:styleData.value
                    }
                 }
            }

            onClicked:  {
                current_index = row;
                show_detail(row);
            }

            onDoubleClicked: {
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

    spacing: 20

    Image {
        id: product_pic
        height: 100
        width: 100
        source: "pic/click.png"
        anchors.horizontalCenter: parent.horizontalCenter
        MouseArea {
            cursorShape: Qt.PointingHandCursor;
            anchors.fill: parent
            onDoubleClicked: file_dialog.open()
            onClicked: file_dialog.open()
        }
    }
    Row {
        id: product_row
        Text {
            width: max_length_text.width
            text: "商品id:"
            font.pointSize: 20
        }
        Text {
            id: product_id
            width: input_width
            font.pointSize: 20
            text: "1234213324"
        }
    }
    Row {
        Text {
            id: max_length_text
            text: "商品名称:"
            font.pointSize: 20
        }
        MyTextField {
            id: product_name
            width: input_width
        }
    }
    Row {
        Text {
            text: "类别:"
            font.pointSize: 20
            width: max_length_text.width
        }

        ComboBox{
            id: product_cat
            width: input_width
            height: 40;
            model: ["食品","饮品","日常用品","文具","服饰","体育用品","其它"]
        }
    }
    Row {
        Text {
            text: "库存数量:"
            width: max_length_text.width
            font.pointSize: 20
        }
        MyTextField {
            id: product_num
            width: input_width/3
        }

        Text {
            text: "单价:"
            font.pointSize: 20
        }
        MyTextField {
            id: product_price
            width: input_width / 3
        }
    }


    Row {
        //spacing: 5
        Text {
            text: "描述:"
            font.pointSize: 20
            width: max_length_text.width
        }
        TextArea {
            id: additional_info
            width: input_width
            verticalScrollBarPolicy: Qt.ScrollBarAlwaysOff
            //text: "hahahahaha,hahaha,haaaa, ha, ha, hahaha";
        }
    }
    Row {
        anchors.right: parent.right
        spacing: 30
        SaveButton {
            onClicked: {
                if (current_index == -1) {
                    add_product();
                } else {
                    save_product();
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
  text:"你确定要删除该商品吗？"
  onYes: {
      delete_row = current_index;
      controller.deleteProduct(tableModel.get(current_index).var0);
  }
}

FileDialog {
    id: file_dialog;
    title: qsTr("请选择图像");
    nameFilters: [
            "Image Files (*.jpg *.png *.gif *.bmp *.ico)",
        ];
    onAccepted: {
        product_pic.source = fileUrl;
        //var filepath = new String(fileUrl);
    }
}

function active() {
    visible = true;
    refresh_list();
    clear_input_area();
}

function refresh_list() {
    controller.getAllProducts();
}

function clear_input_area() {
    current_index = -1;
    product_row.visible = false;
    product_name.text = "";
    product_num.text = "";
    product_price.text = "";
    additional_info.text = "";
    product_pic.source = "pic/click.png";
}

function show_detail(index) {
    product_row.visible = true;
    product_id.text = tableModel.get(index).var0;
    product_name.text = tableModel.get(index).var1;
    product_cat.currentIndex = product_cat.find(tableModel.get(index).var2);
    product_num.text = tableModel.get(index).var3;
    product_price.text = tableModel.get(index).var4;
    additional_info.text = tableModel.get(index).var5;
    product_pic.source = tableModel.get(index).var6;
}

function save_product() {
    controller.saveProduct([tableModel.get(current_index).var0,product_name.text,
                         product_cat.currentText,product_num.text,
                         product_price.text, additional_info.text,
                         product_pic.source]);
}

function add_product() {
    controller.addProduct([product_name.text, product_cat.currentText,
                       product_num.text, product_price.text,
                       additional_info.text, product_pic.source]);
}

Connections {
    target: controller
    onAllProducts: {
        tableModel.clear();

        for (var i = 0; i <theclassmodel.rowCount(); i++) {
            tableModel.append({"var0":theclassmodel.rowColData(i,0), "var1":theclassmodel.rowColData(i,1),
                             "var2":theclassmodel.rowColData(i,2), "var3":theclassmodel.rowColData(i,3),
                             "var4":theclassmodel.rowColData(i,4),"var5":theclassmodel.rowColData(i,5),
                             "var6":theclassmodel.rowColData(i,6)})
        }
        current_index = -1;
    }
}

Connections {
    target: controller
    onProductSaved:{
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
    onProductDeleted:{
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
    onProductAdded:{
        if(ok){
            color_true.running = true;
            refresh_list();
        } else {
            color_false.running = true;
        }
    }
}

}
