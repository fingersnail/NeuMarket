import QtQuick 2.0
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Dialogs 1.2

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
                //var0 user_id, var1 user_name, var2 tel,
                //var3 address, var4 authority

                property string var2;
                property string var3;
                property int var4;

                id:tableModel
                ListElement {
                    c_id:"1"
                    var0:"101"
                    var1:"xiaoli"
                    var2:"14522231321"
                    var3:"iu"
                    var4:31
                }
                ListElement {
                    c_id:"2"
                    var0:"102"
                    var1:"xiaoming"
                    var2:"14522231321"
                    var3:"iu"
                    var4:31
                }
                ListElement {
                    c_id:"3"
                    var0:"103"
                    var1:"xiaoing"
                    var2:"14522231321"
                    var3:"iu"
                    var4:15
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

                width: tableView.width*0.45
                role:"var0"
                title:"用户id号"
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

                width: tableView.width*0.45
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
            onClicked: {
                if (current_index >= 0)
                    message_dialog.open();
            }
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
                text: "联系方式："
                font.pointSize: 14
            }
            MyTextField {
                id: person_tel
                width: mainrect.width*0.3

            }
        }
        Row {
            Text {
                text: "地址：    "
                font.pointSize: 14
            }
            MyTextField {
                id: person_address
                width: mainrect.width*0.3

                }
            }

        Row {
            Text {
                text: "权限：    "
                font.pointSize: 14
            }
            Grid{
                rows:2
                columns:3
                columnSpacing: 3
                rowSpacing: 15
                MyCheckBox {
                    id: authority1
                    text: qsTr("人事管理")
                    width:90
                }
                MyCheckBox {
                    id: authority2
                    text: qsTr("销售管理")
                    width:90
                }
                MyCheckBox {
                    id: authority3
                    text: qsTr("进货管理")
                    width:90
                }
                MyCheckBox {
                    id: authority4
                    text: qsTr("库存管理")
                    width:90
                }
                MyCheckBox {
                    id: authority5
                    text: qsTr("系统管理")
                    width:90
                }
         }

        }

     }
        SaveButton {
            anchors.right:rightrect.right
            anchors.rightMargin: 55
            anchors.top:infolist.bottom
            anchors.topMargin: 15
            onClicked: {
                if (current_index == -1) {
                    add_user();
                } else {
                    save_user();
                }
            }
        }

    }

    MessageDialog{
      id:message_dialog
      standardButtons: StandardButton.Yes | StandardButton.No
      modality: Qt.ApplicationModal
      title: "删除"
      text:"你确定要删除该职工吗？"
      onYes: {
          delete_row = current_index;
          controller.deleteUser(tableModel.get(current_index).var0);
      }
    }
    function active() {
        visible = true;
        refresh_list();
        clear_input_area();
    }

    function refresh_list() {
        controller.getAllUsers();
    }

    function clear_input_area() {
        current_index = -1;
        person_id.text = "";
        person_name.text = "";
        person_tel.text = "";
        person_address.text = ""

        authority1.checked = false;
        authority2.checked = false;
        authority3.checked = false;
        authority4.checked = false;
        authority5.checked = false;
    }

    function show_detail(index) {
        person_id.text = tableModel.get(index).var0;
        person_name.text = tableModel.get(index).var1;
        person_tel.text = tableModel.get(index).var2;
        person_address.text = tableModel.get(index).var3;

        var auth = authorityPaser(tableModel.get(index).var4);
        if(auth[0])
            authority1.checked = true;
        else
            authority1.checked = false;
        if(auth[1])
            authority2.checked = true;
        else
            authority2.checked = false;
        if(auth[2])
            authority3.checked = true;
        else
            authority3.checked = false;
        if(auth[3])
            authority4.checked = true;
        else
            authority4.checked = false;
        if(auth[4])
            authority5.checked = true;
        else
            authority5.checked = false;
    }

    function authorityPaser(level) {
        var authority = [];
        if (level % 2 == 1)
            authority[0] = true;
        level = parseInt(level / 2);
        if (level % 2 == 1)
            authority[1] = true;
        level = parseInt(level / 2);
        if (level % 2 == 1)
            authority[2] = true;
        level = parseInt(level / 2);
        if (level % 2 == 1)
            authority[3] = true;
        level = parseInt(level / 2);
        if (level % 2 == 1)
            authority[4] = true;
        return authority;
    }

    function getAuthorityNum() {
        var num = 0;
        if (authority5.checked)
            num += 1;
        num *=2;
        if (authority4.checked)
            num += 1;
        num *=2;
        if (authority3.checked)
            num += 1;
        num *=2;
        if (authority2.checked)
            num += 1;
        num *=2;
        if (authority1.checked)
            num += 1;
        return num;
    }

    function save_user() {
        controller.saveUser([tableModel.get(current_index).var0,person_name.text,
                             person_tel.text,person_address.text,
                             getAuthorityNum()]);
    }

    function add_user() {
        controller.addUser([person_name.text,person_tel.text,
                            person_address.text,getAuthorityNum()]);
    }

    Connections {
        target: controller
        onAllUsers: {
            tableModel.clear();

            for (var i = 0; i <theclassmodel.rowCount(); i++) {
                tableModel.append({"var0":theclassmodel.rowColData(i,0), "var1":theclassmodel.rowColData(i,1),
                                 "var2":theclassmodel.rowColData(i,2), "var3":theclassmodel.rowColData(i,3),
                                 "var4":theclassmodel.rowColData(i,4)})
            }
            current_index = -1;
        }
    }

    Connections {
        target: controller
        onUserSaved:{
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
        onUserDeleted:{
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
        onUserAdded:{
            if(ok){
                color_true.running = true;
                refresh_list();
            } else {
                color_false.running = true;
            }
        }
    }
}

