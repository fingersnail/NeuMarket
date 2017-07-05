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

        TableView {
            //var0 user_id, var1 user_name, var2 tel,
            //var3 address, var4 isPosition, var5 email, var6 sex

            property string var2;
            property string var3;
            property string var5;
            property bool var6;

            id:tableView
            anchors.fill: parent
            model:tableModel
            headerDelegate:headerDele
            rowDelegate:rowDele
            backgroundVisible:false
            clip: true
            signal signalShowMenu(var id,int x,int y)
            ListModel {
                id:tableModel
            }
            //定义表头格式
            Component{
                id:headerDele
                Rectangle {
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
                    height:signleLineHeight
                    color:styleData.selected?"#450000ff":"#F0F0F0"
                    border.width: 1
                    border.color: "lightsteelblue"
                 }

            }
            //id列样式
            TableViewColumn {
                width: tableView.width*0.1
                role:"c_id"
                title:" "
                delegate:Rectangle {
                    color:"transparent"
                    height:signleLineHeight
                    Text{
                        anchors.centerIn:parent
                        text:styleData.value
                    }
                }
            }
            TableViewColumn {
                width: tableView.width*0.25
                role:"var0"
                title:"员工号"
                delegate:Rectangle {
                    color:"transparent"
                    height:signleLineHeight
                    Text {
                        anchors.centerIn:parent
                        text:styleData.value
                    }
                }
            }
            TableViewColumn {
                width: tableView.width*0.25
                role:"var1"
                title:"姓名"
                delegate:Rectangle {
                    color:"transparent"
                    height:signleLineHeight
                    Text {
                        anchors.centerIn:parent
                        text:styleData.value
                    }
                }
            }
            TableViewColumn {
                role:"var4"
                title: "在职情况"
                width: tableView.width*0.4
                delegate: Rectangle {
                    height:  signleLineHeight
                    color: "transparent"
                    Row {
                        anchors.centerIn: parent
                        spacing: 20
                        ExclusiveGroup {
                            id:position_group
                        }

                        RadioButton{
                            text:"在职"
                            exclusiveGroup: position_group
                            checked: styleData.value ? true :false
                            onClicked: {
                                if (!tableModel.get(styleData.row).var4)
                                    controller.changePositionState(tableModel.get(
                                    styleData.row).var0, true);
                            }
                        }
                        RadioButton{
                            text:"不在职"
                            exclusiveGroup: position_group
                            checked: styleData.value ? false :true
                            onClicked: {
                                if (tableModel.get(styleData.row).var4)
                                    controller.changePositionState(tableModel.get(
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
            id: person_id_row
            Text {
                text: "用户id：  "
                font.pointSize: 14
            }
            Text {
                id: person_id
                width: mainrect.width*0.3
                font.pointSize: 14
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
        Row{
            spacing: 20
            Text {
                text: "性别：    "
                font.pointSize: 14
            }
            ExclusiveGroup{
                id:sex_group
            }

            MyRadioButton{
                id: man_check
                text:"男"
                exclusiveGroup: sex_group
            }
            MyRadioButton{
                id: woman_check
                text:"女"
                exclusiveGroup: sex_group
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
                text: "email：   "
                font.pointSize: 14
            }
            MyTextField {
                id: person_email
                width: mainrect.width*0.3
                }
        }
        Row{
            spacing: 20
            Text {
                text: "在职情况："
                font.pointSize: 14
            }
            ExclusiveGroup{
                id:state_group
                }

            MyRadioButton{
                id: in_check
                text:"在职"
                exclusiveGroup: state_group
                }
            MyRadioButton{
                id: out_check
                text:"不在职"
                exclusiveGroup: state_group
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
                    add_worker();
                } else {
                    save_worker();
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
          controller.deleteWorker(tableModel.get(current_index).var0);
      }
    }

    function active() {
        visible = true;
        refresh_list();
        clear_input_area();
    }

    function refresh_list() {
        controller.listAllWorker();
    }

    function clear_input_area() {
        person_id_row.visible = false;
        current_index = -1;
        person_id.text = "";
        person_name.text = "";
        person_tel.text = "";
        person_address.text = "";
        person_email.text = "";
        in_check.checked = true;
        out_check.checked = false;
    }

    function show_detail(index) {
        person_id_row.visible = true;
        person_id.text = tableModel.get(index).var0;
        person_name.text = tableModel.get(index).var1;
        person_tel.text = tableModel.get(index).var2;
        person_address.text = tableModel.get(index).var3;
        person_email.text = tableModel.get(index).var5;

        if (tableModel.get(index).var4) {
            out_check.checked = false;
            in_check.checked = true;
        }
        else {
            in_check.checked = false;
            out_check.checked = true;
        }

        if (tableModel.get(index).var6) {
            woman_check.checked = false;
            man_check.checked = true;
        }
        else {
            man_check.checked = false;
            woman_check.checked = true;
        }
    }

    function save_worker() {
        controller.saveWorker([tableModel.get(current_index).var0,person_name.text,
                             person_tel.text,person_address.text,
                             in_check.checked, person_email.text,
                              man_check.checked]);
    }

    function add_worker() {
        controller.addWorker([person_name.text,
                            person_tel.text,person_address.text,
                            in_check.checked, person_email.text,
                            man_check.checked]);
    }

    Connections {
        target: controller
        onAllWorkers: {
            tableModel.clear();

            for (var i = 0; i <theclassmodel.rowCount(); i++) {
                tableModel.append({"c_id": i + 1,"var0":theclassmodel.rowColData(i,0), "var1":theclassmodel.rowColData(i,1),
                                 "var2":theclassmodel.rowColData(i,2), "var3":theclassmodel.rowColData(i,3),
                                 "var4":theclassmodel.rowColData(i,4),"var5":theclassmodel.rowColData(i,5),
                                 "var6":theclassmodel.rowColData(i,6)})
            }
            current_index = -1;
        }
    }

    Connections {
        target: controller
        onWorkerSaved:{
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
        onWorkerDeleted:{
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
        onWorkerAdded:{
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
        onPositionChanged: {
            if(ok){
                color_true.running = true;
            } else {
                color_false.running = true;
                refresh_list();
            }
        }
    }
}

