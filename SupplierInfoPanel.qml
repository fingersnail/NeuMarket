import QtQuick 2.0
//import QtQuick.Controls 1.2
import QtQml.Models 2.2
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls 1.4
import QtQuick.Dialogs 1.2

Rectangle {
    property int list_width: 430
    property int current_index: -1

    ScrollView {
        x: 0
        y: 0
        height: parent.height - 60
        width: list_width
        verticalScrollBarPolicy: Qt.ScrollBarAlwaysOff
            ListView {
                id: supplier_list
                clip:true
                orientation:  ListView.Vertical
                snapMode   :  ListView.SnapToItem       //停靠在列表的最开始
                cacheBuffer:  20
                anchors.fill: parent
                spacing: 25

                delegate: Rectangle{
                    property int supplier_id: var3 //s_id
                    property string supplier_addr: var4 //address
                    property string supplier_info: var5 //info

                    id:delegate_list
                    color: "white"
                    height: 170
                    width: 430
                    signal signalShowMenu(var id,int x,int y)

                    Row {
                        Image {
                            id: supplier_image
                            source: var2  //pic
                            anchors.verticalCenter: parent.verticalCenter
                            height: 170
                            width: 170
                        }

                        Column {
                            anchors.verticalCenter: parent.verticalCenter
                            Text {
                                text: var0  // name
                                font.bold: true
                                font.pointSize: 15
                            }
                            Row {
                                Text {
                                    text: "电话："
                                    font.pointSize: 10
                                }
                                Text {
                                    text: var1 // tel
                                    font.pointSize: 10
                                }
                            }
                            spacing: 30
                        }

                        spacing: 30
                    }

                    //高亮
                    MouseArea{
                        id:mouse_delegate

                        acceptedButtons: Qt.RightButton|Qt.LeftButton
                        hoverEnabled: true
                        propagateComposedEvents: true
                        enabled:true
                        anchors.fill: parent
                        onEntered:{
                            delegate_list.color = "#DCDCDC"
                            //btn_del.visible     = true
                            //  console.log("in")
                        }
                        onExited:{
                            delegate_list.color = "white";
                        }
                        onClicked: {
                            mouse.accepted = false;
                            controller.getSupplierDetail(
                                        listModel.get(index).var3);
                            current_index = index;
                            show_detail(index);
                        }
                        onDoubleClicked: {
                            mouse.accepted = false;
                            console.log("item double click.");
                            controller.getSupplierDetail(
                                        listModel.get(index).var3);
                            current_index = index;
                        }
                    }
                }

                model: ListModel {
                    id: listModel
//                    ListElement {
//                        var0: "哔哩哔哩鸭脖公司"; var1: "12345678 ;"; var2: "`"; var3: "123";}
//                    ListElement {var3: 123; var2: "pic/panegg.png";
//                        var0: "煎蛋熟食"; var1: "12345678"}
//                    ListElement {var3: 123;var2: "pic/penguin.png";
//                        var0: "企鹅绒服饰"; var1: "12345678"}
//                    ListElement {var3: 123;var2: "pic/instantnoodles.png";
//                        var0: "一根方便面"; var1: "12345678"}
//                    ListElement {var3: 123;var2: "pic/tao.png";
//                        var0: "淘宝百货"; var1: "12345678"}
//                    ListElement {var3: 123;var2: "pic/squirrel.png";
//                        var0: "松鼠坚果"; var1: "12345678"}
//                    ListElement {var3: 123;var2: "pic/realmadrid.png";
//                        var0: "巴萨体育用品公司"; var1: "12345678"}
//                    ListElement {var3: 123;var2: "pic/59Pen.png";
//                        var0: "59文具"; var1: "12345678"
//                    }
                }
            }
        }

    Rectangle {
        id: add_one_button
        x: 0
        y: parent.height - 60
        height: 60
        width: list_width / 2
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
                //parent.color = "#DCDCDC"
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

    Rectangle{
        id: delete_one_button
        x: list_width / 2
        y: parent.height - 60
        height: 60
        width: list_width / 2
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

    Column {
        x: 480
        y: 30
//        height: parent.height - 100
//        width: 420
        spacing: 30
        Image {
            id: supplier_pic
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
            Text {
                text: "名称："
                font.pointSize: 20
            }
            MyTextField {
                id: supplier_name
                width: 300
                text: "新建"
            }
        }
        Row {
            Text {
                text: "电话："
                font.pointSize: 20
            }
            MyTextField {
                id: supplier_tel
                width: 300
            }
        }
        Row {
            Text {
                text: "地址："
                font.pointSize: 20
            }
            MyTextField {
                id: supplier_address
                width: 300
            }
        }
        Row {
            //spacing: 5
            Text {
                text: "介绍："
                font.pointSize: 20
            }
            TextArea {
                id: supplier_info
                width: 300
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
                        add_supplier();
                    } else {
                        save_supplier();
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
      text:"你确定要删除该供货商吗？"
      onYes: {
          if (listModel.get(current_index).var3 != -1) {
              delete_row = current_index;
              controller.deleteSupplier(listModel.get(current_index).var3);
          }
      }
    }

    FileDialog {
        id: file_dialog;
        title: qsTr("请选择图像");
        nameFilters: [
                "Image Files (*.jpg *.png *.gif *.bmp *.ico)",
            ];
        onAccepted: {
            supplier_pic.source = fileUrl;
            var filepath = new String(fileUrl);
            console.log(fileUrl);
            console.log(filepath);
        }
    }

    function active() {
        visible = true;
        refresh_list();
    }

    function refresh_list() {
        controller.getSupplierList();
        console.log("refresh");
    }

    function clear_input_area() {
        current_index = -1;
        supplier_pic.source = "pic/click.png";
        supplier_name.text = "新建";
        supplier_tel.text = "";
        supplier_address.text = "";
        supplier_info.text = "";
        //listModel.append({var3: "", pic: "pic/click.png",
                            // var0: "新建", var1: " "})
    }

    function save_supplier() {
        controller.saveSupplier([supplier_name.text,supplier_tel.text,supplier_pic.source,listModel.get(current_index).var3,
                                supplier_address.text,supplier_info.text]);
    }

    function add_supplier() {
        controller.addSupplier([supplier_name.text,supplier_tel.text,supplier_pic.source,
                                supplier_address.text,supplier_info.text]);
    }

    function show_detail(index) {
        supplier_pic.source = listModel.get(index).var2;
        supplier_name.text = listModel.get(index).var0;
        supplier_tel.text = listModel.get(index).var1;
        supplier_address.text = listModel.get(index).var4;
        supplier_info.text = listModel.get(index).var5;
    }

    Connections {
        target: controller
        onSupplierList: {
            listModel.clear();
//            supplier_list.model = theclassmodel;
//            listModel = theclassmodel;

            for (var i = 0; i <theclassmodel.rowCount(); i++) {
                listModel.append({"var0":theclassmodel.rowColData(i,0), "var1":theclassmodel.rowColData(i,1),
                                 "var2":theclassmodel.rowColData(i,2), "var3":theclassmodel.rowColData(i,3),
                                 "var4":theclassmodel.rowColData(i,4), "var5":theclassmodel.rowColData(i,5)})
            }
            current_index = -1;
        }
    }
    Connections {
        target: controller
        onSupplierSaved:{
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
        onSupplierDeleted:{
            if(ok){
                listModel.remove(delete_row);
                clear_input_area();
                color_true.running = true;
            } else {
                color_false.running = true;
            }
        }
    }
    Connections {
        target: controller
        onSupplierAdded:{
            if(ok){
                color_true.running = true;
                refresh_list();
            } else {
                color_false.running = true;
            }
        }
    }
}

