import QtQuick 2.0
import "QChart.js" as Charts

Rectangle {
    Rectangle {
      id: refresh_button;
      anchors.top:  parent.top;
      anchors.topMargin: 10;
      anchors.right: parent.right;
      anchors.rightMargin: 10;
      width: 100;
      height: 32;
      color: "#2d91ea";
      radius: 8;

      Text {
        anchors.centerIn: parent;
        color: "#ffffff";
        text: "刷新";
        font.bold: true;
      }

      MouseArea {
        anchors.fill: parent;
        onPressed: {
          refresh_button.color = "#1785e6"
        }
        onReleased: {
          refresh_button.color = "#2d91ea"
          controller.getRepertoryStatistic();
        }
      }
    }

    Chart {
      id: chart_bar;
      width: parent.width;
      height: parent.height - refresh_button.height - 10;
      x: 0
      y: parent.height - height
      chartAnimated: true;
      chartAnimationEasing: Easing.InOutElastic;
      chartAnimationDuration: 1000;
      chartData: chartBarData;
      chartType: Charts.ChartType.BAR;
    }

    property var chartBarData: {
          "labels": ["食品","饮品","日常用品","文具","体育用品","服饰","其它"],
        "datasets": [{
              "fillColor": "rgba(151,187,205,0.5)",
            "strokeColor": "rgba(151,187,205,1)",
                   "data": [28,48,40,19,96,27,100]
        }]
    }

//    property var chartPolarData : [{
//        value: 30,
//        color: "#D97041"
//     }, {
//        value: 90,
//        color: "#C7604C"
//     }, {
//        value: 24,
//        color: "#21323D"
//     }, {
//        value: 58,
//        color: "#9D9B7F"
//     }, {
//        value: 82,
//        color: "#7D4F6D"
//     }, {
//        value: 83,
//        color: "#584A5E"
//    }]

//    property var chartLineData : {
//          "labels": ["食品","饮品","日常用品","文具","体育用品","服饰","其它"],
//        "datasets": [{
//                  "fillColor": "rgba(151,187,205,0.5)",
//                  "strokeColor": "rgba(151,187,205,1)",
//                  "pointColor": "rgba(151,187,205,1)",
//                  "pointStrokeColor": "#fff",
//                  "data": [65,59,90,81,56,55,80]
//        }]
//    }

    function refresh_bar_chart(cat, amount) {
        for (var i in cat) {
            chartBarData.labels[i] = cat[i];
            chartBarData.datasets[0].data[i] = amount[i];
        }
        chart_bar.repaint();
    }


    Connections {
        target: controller;
        onRepertoryStatistic: {refresh_bar_chart(cat, amount)}
    }

    function active() {
        visible = true;
        controller.getRepertoryStatistic();
    }
}

