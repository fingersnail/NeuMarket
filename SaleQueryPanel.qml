import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
Rectangle {
    property date from_data;
    property date end_data;
    property real tableWidth: 80
    property real signleLineHeight:30
    property int current_index: -1
    property bool is_edit: true
    Row {
        x: 10
        y: 15
        spacing: 14
        id:searchrect
        z:2
        Text {
            anchors.verticalCenter: parent.verticalCenter
            text: "商品代码:"
            font.pointSize: 12
        }
        MyTextField {
            height: 32
            id: product_search_id
            font.pointSize: 12
            width: 180
        }

        Text {
            anchors.verticalCenter: parent.verticalCenter
            text: "开始:"
            font.pointSize: 12
        }
        DatePicker {
            height: product_search_id.height;
            width: 180
            font.pointSize: 12
            z:4
            dateValue: (new Date()).toLocaleString(Qt.locale(), "yyyy-MM-dd")
            onDateValueChanged: {from_data = dateValue}
        }
        Text {
            anchors.verticalCenter: parent.verticalCenter
            text: "结束:"
            font.pointSize: 12
        }
        DatePicker {
            height: product_search_id.height;
            width: 180
            z:3
            font.pointSize: 12
            dateValue: (new Date()).toLocaleString(Qt.locale(), "yyyy-MM-dd")
            onDateValueChanged: end_data = dateValue
        }

        Rectangle {
            width: 80
            height: product_search_id.height
            color: "#2d91ea"
            radius: 8
            Text {
                anchors.centerIn: parent
                text: qsTr("查询")
                font.pointSize: 12
                color: '#ffffff'
                font.bold: true;
            }
            MouseArea {
                anchors.fill: parent
                onPressed: {
                    parent.color = "#1785e6"
                }
                onReleased: {
                    parent.color = "#2d91ea"
                    if (product_search_id.text.trim() == "" || product_search_id.text.trim() == "-1")
                        controller.getSaleRecords(from_data, end_data);
                    else
                        controller.getSaleRecords(product_search_id.text.trim(),
                                                  from_data, end_data);
                    clear_input_area();
                }
            }
        }
    }
    Rectangle {
        id:leftrect
        width:parent.width*0.5
        height:(parent.height-searchrect.height-30)*0.85
        anchors.top:searchrect.bottom
        anchors.topMargin: 15
        z:1

        TableView
        {
            property double var2;
            property int var3;

            id:tableView
            z:1
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
                    c_id:1
                    var4:"2017-01-01 12:12:12"
                    var0:2345
                    var1:"泡面"
                    var2: 432.53
                    var3: 5
                }
                ListElement
                {
                    c_id:2
                    var4:"2017-01-02"
                    var0:534
                    var1:"矿泉水"
                }
                ListElement
                {
                    c_id:3
                    var4:"2017-01-03"
                    var0:5423
                    var1:"旺旺雪饼"

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
                    Text{
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
                    height:signleLineHeight
                    color:styleData.selected?"#450000ff":"#F0F0F0"
                    border.width: 1
                    border.color: "lightsteelblue"
                }

            }
            //id列样式
            TableViewColumn
            {

                width: tableView.width*0.1
                role:"c_id"
                title:" "
                delegate:Rectangle
                {
                    color:"transparent"
                    height:signleLineHeight
                    Text{
                        anchors.centerIn:parent
                        text:styleData.value
                    }
                }

            }
            TableViewColumn
            {

                width: tableView.width*0.3
                role:"var4"
                title:"销售日期"
                delegate:Rectangle
                {
                    color:"transparent"
                    height:signleLineHeight
                    Text{
                        anchors.centerIn:parent
                        text:styleData.value
                    }
                }

            }
           TableViewColumn
            {

                width: tableView.width*0.3
                role:"var0"
                title:"商品id"
                delegate:Rectangle
                {
                    color:"transparent"
                    height:signleLineHeight
                    Text{
                        anchors.centerIn:parent
                        text:styleData.value
                    }
                }

            }
            TableViewColumn
            {

                width: tableView.width*0.3
                role:"var1"
                title:"商品名称"
                delegate:Rectangle
                {
                    color:"transparent"
                    height:signleLineHeight
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
                width:leftrect.width
                height:(parent.height-searchrect.height-30)*0.15
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
                    onClicked: {
                        clear_input_area();
                    }
                }
            }

     Rectangle
     {
        id: rightrect
        width:leftrect.width
        height:leftrect.height
        anchors.left:leftrect.right
        anchors.top:leftrect.top
        anchors.topMargin: 25
        color:"transparent"
        visible: true
        Column {
            id:infolist
            spacing: 15
            anchors.left:parent.left
            anchors.leftMargin: 40
            z:2
            Row {
                  Text {
                      text: "商品id：  "
                      font.pointSize: 14
                   }
                   MyTextField {
                       id:item_id
                       width: rightrect.width*0.6
                       onFocusChanged: {
                           if (!focus && is_edit && text != "")
                               controller.getProductName(text);
                       }
                   }
                   Text {
                       id:item_id_text
                       width: rightrect.width*0.6
                       visible: false
                       font.pointSize: 14
                   }
              }
              Row {
                   Text {
                       text: "商品名称: "
                       font.pointSize: 14
                    }
                    Text {
                       id:item_name
                       text: ""
                       font.pointSize: 14
                    }
              }
              Row {
                     Text {
                         text: "售价:     "
                         font.pointSize: 14
                      }
//                      MyTextField {
//                          id:item_price
//                          width: rightrect.width*0.6
//                      }
                      Text {
                          id:item_price_text
                          width: rightrect.width*0.6
                          visible: true
                          font.pointSize: 14
                      }
               }
               Row {
                   Text {
                      text: "数量:     "
                      font.pointSize: 14
                   }
                   MyTextField {
                       id:item_quantity
                       width: rightrect.width*0.6
                   }
                   Text {
                       id:item_quantity_text
                       width: rightrect.width*0.6
                       visible: false
                       font.pointSize: 14
                   }
               }
                Row {
                        z:1
                        id: sale_time_row
                     Text {
                          text: "销售时间："
                          font.pointSize: 14
                      }
                     Text {
                        id: sale_time
                        text: ""
                        font.pointSize: 14
                     }
                    }
              }
              SaveButton {
                    id: save_btn
                    anchors.right:rightrect.right
                    anchors.rightMargin: 55
                    anchors.top:infolist.bottom
                    anchors.topMargin: 15
                    onClicked: {
                        if (current_index == -1) {
                            add_sale_record();
                        }
                    }
               }

         }

    function active() {
        visible = true;
        refresh_list();
        clear_input_area();
    }

    function refresh_list() {
        controller.getAllRecords();
    }

    function clear_input_area() {
        is_edit = true;
        current_index = -1;
        item_id_text.visible = false;
        item_id.visible = true;
        item_id.text = "";
        item_name.text = "";
        item_price_text.text = "";
        //item_price.visible = true;
        //item_price.text = "";
        item_quantity_text.visible = false;
        item_quantity.visible = true;
        item_quantity.text = ""
        sale_time_row.visible = false;
        save_btn.visible = true;
    }

    function show_detail(index) {
        is_edit = false;
        item_id.visible = false;
        item_id_text.visible = true;
        item_id_text.text = tableModel.get(index).var0;
        item_name.text = tableModel.get(index).var1;
       // item_price.visible = false;
        //item_price_text.visible = true;
        item_price_text.text = tableModel.get(index).var2;
        item_quantity.visible = false;
        item_quantity_text.visible = true;
        item_quantity_text.text = tableModel.get(index).var3;
        sale_time_row.visible = true;
        sale_time.text = tableModel.get(index).var4;
        save_btn.visible = false;
    }

    function add_sale_record() {
        controller.addSaleRecord([item_id.text,item_price_text.text,
                            item_quantity.text]);
    }

    Connections {
        target: controller
        onAllSaleRecords: {
            tableModel.clear();

            for (var i = 0; i <theclassmodel.rowCount(); i++) {
                tableModel.append({"c_id": i + 1, "var0":theclassmodel.rowColData(i,0), "var1":theclassmodel.rowColData(i,1),
                                 "var2":theclassmodel.rowColData(i,2), "var3":theclassmodel.rowColData(i,3),
                                 "var4":theclassmodel.rowColData(i,4)})
            }
            current_index = -1;
        }
    }
    Connections {
        target: controller
        onSaleRecordAdded:{
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
        onProductName:{
            item_name.text = name;
            item_price_text.text = price;
        }
    }

    Connections {
        target: controller
        onSaleRecords: {
            tableModel.clear();

            for (var i = 0; i <theclassmodel.rowCount(); i++) {
                tableModel.append({"c_id": i + 1, "var0":theclassmodel.rowColData(i,0), "var1":theclassmodel.rowColData(i,1),
                                 "var2":theclassmodel.rowColData(i,2), "var3":theclassmodel.rowColData(i,3),
                                 "var4":theclassmodel.rowColData(i,4)})
            }
            current_index = -1;
        }
    }
}
