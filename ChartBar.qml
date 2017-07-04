import QtQuick 2.0

Item {

       property variant selectedWidthBar: []//selectedWidthBar
       property int selectedHeight: 60
       property int listViewWidth: 0
       property variant modelSomeData
       property variant arrayName: []

       height: 320
       width: listViewWidth

       ListView {
           id: listView
           height: parent.height
           width: listViewWidth
           clip: true
           model: modelSomeData
           delegate: listViewDelegate
       }

       Component {//每一行作为一个独立的ListView又供显示内容 重用
           id: listViewDelegate

           ChartTitleBar {
               height: selectedHeight
               arrayTitle: filterArray(index)
               selectedWidth: selectedWidthBar

           }
       }

       //----------------------------------------------------------------------------------------------------------

       Component.onCompleted: {
           var i
           if (selectedWidthBar.length !== 0) {
               var wid, i, filterString
               for (i = 0; i < selectedWidthBar.length; i++) {
                   listViewWidth += (count(i) * selectedWidthBar[i][1])
               }
           }
       }

       function filterArray(index) { //modelSomeData.name = modelSomeData["name"]
           var arrayTemp = [], i
           for (i = 0; i < arrayName.length; i++) {
                   arrayTemp[i] = listView.model.get(index-1)[String(arrayName[i])] //!!! note: index-1; not: index
           }

           return arrayTemp


       }


       function stringToInt(value) {
           return Number(value)
       }

       function count(i) {
           return (stringToInt(selectedWidthBar[i][0].substring(selectedWidthBar[i][0].indexOf('-')+1, selectedWidthBar[i][0].length)) -
                   stringToInt(selectedWidthBar[i][0].substring(0, selectedWidthBar[i][0].indexOf('-'))) + 1)
       }
}

//使用var array = []这样的变量，array[0] = 1; array[1] = 2。这样是对的因为类型是var，这是只能在js里面操作，然后这样赋值arrayName = array
