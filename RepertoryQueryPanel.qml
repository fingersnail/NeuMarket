import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls 1.4
import QtQuick.Dialogs 1.2

Rectangle {
    //property alias functionpart: functionpart
    property alias tableView: tableView
    property real tableWidth: 80
    property real singleLineHeight:25

    Rectangle {
        id:leftrect
        width:parent.width*0.55
        height:parent.height*0.85

        TableView
        {
            id:tableView
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
                    product_id:"104341"
                    product_name:"三等奖方块"
                    finish: true
                    repertory_number: "10"
                }
                ListElement
                {
                    product_id:"104346"
                    product_name:"迪克曼"
                    finish: true
                    repertory_number: "100"
                }
                ListElement
                {
                    product_id:"104348"
                    product_name:"付款进度"
                    finish: true
                    repertory_number: "1000"
                }
            }
            //定义表头格式
            Component{
                id:headerDele
                Rectangle{
                    implicitWidth:tableWidth
                    implicitHeight: 25
                    color:"#969696"
                    Text{
                        text:styleData.value
                        anchors.centerIn:parent
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
                    color:styleData.selected?"#450000ff":"#22000000"
                    border.width: 1
                    border.color: "lightsteelblue"
                }
            }
            TableViewColumn
            {

                width: tableView.width*0.4
                role:"product_id"
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
                role:"product_name"
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
                role:"repertory_number"
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
        onClicked: {
//            c_index++;
//            tableView.model.append({ "c_id":c_index.toString(),
//                                     "code":"09090",
//                                     "name":"xiaoxiao"});
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
            width: input_width
            height: 40;
            model: ["食品","饮品","日用品","文具","服饰","体育用品","其它"]
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
        //var filepath = new String(fileUrl);
    }
}

function active() {
    visible = true;
}

//function refresh_list() {

//}

//function change_detail_supplier(index) {

//}


}
