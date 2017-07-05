import QtQuick 2.0
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
Rectangle{
    property alias tableView: tableView
    property alias mainrect:mainrect
    property real tableWidth: 80
    property real signleLineHeight:30
    property int current_index: -1
    id:mainrect

    Rectangle {
        id:leftrect
        width:parent.width*0.5
        height:parent.height

        TableView
        {
            property string var2;

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
                    c_id:"1"
                    var0:101
                    var1:"xiaoli"
                    var2: "231ju"
                }
                ListElement
                {
                    c_id:"2"
                    var0:102
                    var1:"xiaoming"
                    var2: "231ju"
                }
                ListElement
                {
                    c_id:"3"
                    var0:103
                    var1:"xiaotong"
                    var2: "231ju"
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

                width: tableView.width*0.2
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

                width: tableView.width*0.4
                role:"var0"
                title:"员工号"
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

                width: tableView.width*0.4
                role:"var1"
                title:"姓名"
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


Rectangle
{
    id: rightrect
    width:mainrect.width*0.5
    height:mainrect.height
    anchors.right:mainrect.right
    anchors.top:mainrect.top
    anchors.topMargin: 55
    color:"transparent"
    visible: true
    Column {
        id:infolist
        spacing: 15
        anchors.left:parent.left
        anchors.leftMargin: 40
        Row {
            Text {
                text: "用户id：  "
                font.pointSize: 14
            }
            MyTextField {
                id: person_id
                width: mainrect.width*0.3

            }
        }
        Row {
            Text {
                text: "姓名：    "
                font.pointSize: 14
            }
            MyTextField {
                id: person_name
                width: mainrect.width*0.3

            }
        }
        Row {
            Text {
                text: "密码：    "
                font.pointSize: 14
            }
            MyTextField {
                id: person_password
                width: mainrect.width*0.3

                }
            }
               }
        SaveButton {
            anchors.right:rightrect.right
            anchors.rightMargin: 55
            anchors.top:infolist.bottom
            anchors.topMargin: 15
            onClicked: {
                if (current_index != -1) {
                    save_user();
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
        controller.getStuffMainInfo();
    }

    function show_detail(index) {
        person_id.text = tableModel.get(index).var0;
        person_name.text = tableModel.get(index).var1;
        person_password.text = tableModel.get(index).var2;
    }

    function save_user() {
        controller.addUser([person_id.text,person_name.text,
                            person_password.text]);
    }

    Connections {
        target: controller
        onStuffMainInfo: {
            tableModel.clear();

            for (var i = 0; i <theclassmodel.rowCount(); i++) {
                tableModel.append({"c_id": i + 1,"var0":theclassmodel.rowColData(i,0), "var1":theclassmodel.rowColData(i,1),
                                 "var2":theclassmodel.rowColData(i,2)})
            }
            current_index = -1;
        }
    }

    Connections {
        target: controller
        onStuffMainInfoSaved:{
            if(ok){
                color_true.running = true;
                refresh_list();
            } else {
                color_false.running = true;
            }
        }
    }
}

