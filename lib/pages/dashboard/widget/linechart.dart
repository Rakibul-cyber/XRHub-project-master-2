import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class EndPointsAxisTimeSeriesChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  EndPointsAxisTimeSeriesChart(this.seriesList, {this.animate});

  factory EndPointsAxisTimeSeriesChart.withSampleData() {
    return EndPointsAxisTimeSeriesChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return charts.LineChart(seriesList,
        behaviors: [
          new charts.ChartTitle('Months 2022',
              behaviorPosition: charts.BehaviorPosition.bottom,
              //titleStyleSpec: chartsCommon.TextStyleSpec(fontSize: 11),
              titleOutsideJustification:
                  charts.OutsideJustification.middleDrawArea),
          new charts.ChartTitle('Clients',
              behaviorPosition: charts.BehaviorPosition.start,
              //titleStyleSpec: chartsCommon.TextStyleSpec(fontSize: 11),
              titleOutsideJustification:
                  charts.OutsideJustification.middleDrawArea)
        ],
        animate: animate,
        customSeriesRenderers: [
          charts.LineRendererConfig(
              // ID used to link series to this renderer.
              customRendererId: 'customArea',
              includeArea: true,
              stacked: true),
        ]);
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<LinearSales, int>> _createSampleData() {
    final myFakeDesktopData = [
      LinearSales(0, 0),
      LinearSales(1, 2),
      LinearSales(2, 5),
      LinearSales(3, 4),
      LinearSales(4, 6),
      LinearSales(5, 2),
      LinearSales(6, 8),
      LinearSales(7, 10),
    ];

    return [
      charts.Series<LinearSales, int>(
        displayName: "Clients per Month",
        id: 'Desktop',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (LinearSales sales, _) => sales.client,
        measureFn: (LinearSales sales, _) => sales.month,
        data: myFakeDesktopData,
      )
        // Configure our custom bar target renderer for this series.
        ..setAttribute(charts.rendererIdKey, 'customArea'),
    ];
  }
}

/// Sample linear data type.
class LinearSales {
  final int client;
  final int month;

  LinearSales(this.client, this.month);
}
