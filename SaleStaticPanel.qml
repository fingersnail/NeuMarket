import QtQuick 2.0
import "QChart.js"        as Charts
//import "QChartGallery.js" as ChartsData
import QtQml 2.2
import neuintership.market.ControlLayer 1.0


Rectangle {
    property bool is_total_sale: true
    property date from_data;
    property date end_data;

    NumberAnimation {
        id: right_slide
        target: slide_window
        property: "x"
        from: 0
        to: switch_button.width / 2
        duration: 200
        //easing.type: Easing.OutBack
    }
    NumberAnimation {
        id: left_slide
        target: slide_window
        property: "x"
        from: switch_button.width / 2
        to: 0
        duration: 200
        //easing.type: Easing.OutBack
    }
    //切换
    Rectangle {
      id: switch_button;
      x: 10
      y: 10
      width: 200;
      height: 32;
      color: 'transparent'

      Rectangle {
          x: 0
          y: 0
          width: parent.width/2;
          height: parent.height;
          id: slide_window
          color: "#2d91ea"
      }
      Rectangle {
          x: 0
          y: 0
          width: parent.width/2;
          height: parent.height;
          color: 'transparent'
          Text {
            anchors.centerIn: parent;
            color: "black";
            text: "总销售额";
          }
          MouseArea {
              anchors.fill: parent
              onClicked: {
                  if (!is_total_sale) {
                      left_slide.running = true;
                      is_total_sale = true;
                      date_picker_row.visible = false;
                      switch_to_total();
                  }
              }
          }
      }
      Rectangle {
          x: parent.width/2
          y: 0
          width: parent.width/2;
          height: parent.height;
          color: 'transparent'
          Text {
            anchors.centerIn: parent;
            color: "black";
            text: "分类统计";
          }
          MouseArea {
              anchors.fill: parent
              onClicked: {
                  if (is_total_sale) {
                      right_slide.running = true;
                      is_total_sale = false;
                      date_picker_row.visible = true;
                      switch_to_catagory();
                  }

              }
          }
      }

    }


  // 刷新按钮
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
        if (is_total_sale)
            controller.getSaleStatistic();
        else
            controller.getSaleCatagoryStatistic(from_data, end_data);
      }
    }
  }

  Row {
      id: date_picker_row
      x: 250
      y: 10
      z: 1
      spacing: 14
      visible: false

      Text {
          anchors.verticalCenter: parent.verticalCenter
          text: "开始:"
          font.pointSize: 12
      }
      DatePicker {
          height: 32;
          width: 180
          font.pointSize: 12
          dateValue: (new Date()).toLocaleString(Qt.locale(), "yyyy-MM-dd")
          onDateValueChanged: {from_data = dateValue}
      }
      Text {
          anchors.verticalCenter: parent.verticalCenter
          text: "结束:"
          font.pointSize: 12
      }
      DatePicker {
          height: 32;
          width: 180
          font.pointSize: 12
          dateValue: (new Date()).toLocaleString(Qt.locale(), "yyyy-MM-dd")
          onDateValueChanged: end_data = dateValue
      }
  }
  Chart {
    id: chart_line;
    width: parent.width;
    height: parent.height - refresh_button.height - 10;
    x: 0
    y: parent.height - height
    chartAnimated: true;
    chartAnimationEasing: Easing.InOutElastic;
    chartAnimationDuration: 1000;
    chartData: chartLineData;
    chartType: Charts.ChartType.LINE;
  }

  Chart {
    id: chart_radar;
    width: parent.width;
    height: parent.height - refresh_button.height - 10;
    x: 0
    y: parent.height - height
    chartAnimated: true;
    chartAnimationEasing: Easing.InOutElastic;
    chartAnimationDuration: 1000;
    chartData: chartRadarData;
    chartType: Charts.ChartType.RADAR;
    visible: false;
  }
  property var chartLineData : {
        "labels": ["一月","二月","三月","四月","五月","六月"],
      "datasets": [{
                 "fillColor": "rgba(151,187,205,0.5)",
               "strokeColor": "rgba(151,187,205,1)",
                "pointColor": "rgba(151,187,205,1)",
          "pointStrokeColor": "#ffffff",
                      "data": [28,48,40,19,96,27]
      }]
  }

      property var chartRadarData : {
            "labels": ["食品","饮品","日常用品","文具","体育用品","服饰","其它"],
          "datasets": [{
                    "fillColor": "rgba(151,187,205,0.5)",
                    "strokeColor": "rgba(151,187,205,1)",
                    "pointColor": "rgba(151,187,205,1)",
                    "pointStrokeColor": "#fff",
                    "data": [65,59,9,81,56,55,800]
          }]
      }


  function switch_to_total() {
      chart_line.visible = true;
      chart_radar.visible = false;
      controller.getSaleStatistic();
  }

  function switch_to_catagory() {
      chart_line.visible = false;
      chart_radar.visible = true;
      controller.getSaleCatagoryStatistic(from_data, end_data);
  }

  function refresh_line_chart(month, amount) {
      chartLineData.labels = [];
      chartLineData.datasets[0].data = [];
      for (var i in month) {
          chartLineData.labels[i] = month[i];
          chartLineData.datasets[0].data[i] = amount[i];
      }
      chart_line.repaint();
  }
  function refresh_radar_chart(cat, amount) {
      chartRadarData.labels = [];
      chartRadarData.datasets[0].data = [];
      for (var i in cat) {
          chartRadarData.labels[i] = cat[i];
          chartRadarData.datasets[0].data[i] = amount[i];
      }
      chart_radar.repaint();
  }

  Connections {
      target: controller;
      onSaleStatistic: {refresh_line_chart(month, amount)}
  }

  Connections {
      target: controller;
      onSaleCatagoryStatistic: {refresh_radar_chart(cat, amount)}
  }

  function active() {
      visible = true;
      if (is_total_sale)
          controller.getSaleStatistic();
      else
          controller.getSaleCatagoryStatistic(from_data, end_data);
  }
}
//  Grid {
//    id: layout;
//    x: 0;
//    y: refresh_button.height;
//    width: parent.width;
//    height: parent.height - refresh_button.height;
//    columns: 1;
//    spacing: chart_spacing;



//    Chart {
//      id: chart_polar;
//      width: chart_width;
//      height: chart_height;
//      chartAnimated: true;
//      chartAnimationEasing: Easing.InBounce;
//      chartAnimationDuration: 2000;
//      chartData: ChartsData.ChartPolarData;
//      chartType: Charts.ChartType.POLAR;
//    }

//    Chart {
//      id: chart_radar;
//      width: chart_width;
//      height: chart_height;
//      chartAnimated: true;
//      chartAnimationEasing: Easing.OutBounce;
//      chartAnimationDuration: 2000;
//      chartData: ChartsData.ChartRadarData;
//      chartType: Charts.ChartType.RADAR;
//    }

//    Chart {
//      id: chart_pie;
//      width: chart_width;
//      height: chart_height;
//      chartAnimated: true;
//      chartAnimationEasing: Easing.Linear;
//      chartAnimationDuration: 2000;
//      chartData: ChartsData.ChartPieData;
//      chartType: Charts.ChartType.PIE;
//    }

//    Chart {
//      id: chart_bar;
//      width: chart_width;
//      height: chart_height;
//      chartAnimated: true;
//      chartAnimationEasing: Easing.OutBounce;
//      chartAnimationDuration: 2000;
//      chartData: ChartsData.ChartBarData;
//      chartType: Charts.ChartType.BAR;
//    }

//    Chart {
//      id: chart_doughnut;
//      width: chart_width;
//      height: chart_height;
//      chartAnimated: true;
//      chartAnimationEasing: Easing.OutElastic;
//      chartAnimationDuration: 2000;
//      chartData: ChartsData.ChartDoughnutData;
//      chartType: Charts.ChartType.DOUGHNUT;
//    }
//  }
//}

