import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
Rectangle {
    property date from_data;
    property date end_data;
    property real tableWidth: 80
    property real signleLineHeight:30
    property int  c_index: 10
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
            id: supplier_address
            font.pointSize: 12
            width: 180
        }

        Text {
            anchors.verticalCenter: parent.verticalCenter
            text: "开始:"
            font.pointSize: 12
        }
        DatePicker {
            height: supplier_address.height;
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
            height: supplier_address.height;
            width: 180
            z:3
            font.pointSize: 12
            dateValue: (new Date()).toLocaleString(Qt.locale(), "yyyy-MM-dd")
            onDateValueChanged: end_data = dateValue
        }

        Rectangle {
            width: 80
            height: supplier_address.height
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
                }
                onClicked: {

                }
            }
        }
    }
    Rectangle {
        id:leftrect
        width:parent.width*0.5
        height:(parent.height-searchrect.height-25)*0.85
        anchors.top:searchrect.bottom
        anchors.topMargin: 15
        z:1

        TableView
        {
            id:tableView
            z:1
            anchors.fill: parent
            model:tableModel
            headerDelegate:headerDele
            rowDelegate:rowDele
            backgroundVisible:false
            clip: true
            signal signalShowMenu(var id,int x,int y)
            ListModel
            {
                id:tableModel
                ListElement
                {
                    c_id:"1"
                    time:"2017-01-01"
                    item_id:"001"
                    item_name:"泡面"
                }
                ListElement
                {
                    c_id:"2"
                    time:"2017-01-02"
                    item_id:"002"
                    item_name:"矿泉水"
                }
                ListElement
                {
                    c_id:"3"
                    time:"2017-01-03"
                    item_id:"003"
                    item_name:"旺旺雪饼"

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
                role:"time"
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
                role:"item_id"
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
                role:"item_name"
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

        }
    }
            Rectangle {
                //add item
                id: buttonrect_one
                width:leftrect.width/2
                height:(parent.height-searchrect.height-25)*0.15
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
                        c_index++;
                        tableView.model.append({ "c_id":c_index.toString(),
                                                 "code":"09090",
                                                 "name":"xiaoxiao"});
                    }
                }
            }
            Rectangle
            {

                id:buttonrect_two
                width:leftrect.width/2
                height:buttonrect_one.height
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
                        if(tableView.model.count > 0)
                        {
                            tableView.model.remove(0);
                        }
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

                    }
              }
              Row {
                   Text {
                       text: "商品名称: "
                       font.pointSize: 14
                    }
                    Text {
                       id:item_name
                       text: "商品名称 "
                       font.pointSize: 14
                    }
              }
              Row {
                     Text {
                         text: "售价:     "
                         font.pointSize: 14
                      }
                      MyTextField {
                          id:item_price
                          width: rightrect.width*0.6
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
               }
                Row {
                        z:1
                     Text {
                          text: "销售时间："
                          font.pointSize: 14
                      }
                      DatePicker {
                          id:sale_time
                          height:item_price.height
                          width: rightrect.width*0.6
                          font.pointSize: 12
                          z:5
                          dateValue: (new Date()).toLocaleString(Qt.locale(), "yyyy-MM-dd")
                          onDateValueChanged: end_data = dateValue
                      }
                    }
              }
              SaveButton {
                    anchors.right:rightrect.right
                    anchors.rightMargin: 55
                    anchors.top:infolist.bottom
                    anchors.topMargin: 15
               }

         }

    function active() {
        visible = true;
    }
}
