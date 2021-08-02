//
//  IssuesBarChart.swift
//  AppReview
//
//  Created by Robert Gillett on 8/1/21.
//

import SwiftUI
import SwiftUICharts

struct IssuesBarChart: View {
    let dataSet: BarDataSet
    var data: BarChartData
    init(dataSet: BarDataSet) {
        self.dataSet = dataSet
        let metadata   = ChartMetadata(title: "App Issues", subtitle: "% of reviews")
        
        let gridStyle  = GridStyle(numberOfLines: dataSet.dataPoints.count - 1,
                                   lineColour   : Color(.gray).opacity(0.25),
                                   lineWidth    : 1)
        let chartStyle = BarChartStyle(infoBoxPlacement   : .header,
                                       markerType         : .bottomLeading(),
                                       xAxisGridStyle     : gridStyle,
                                       xAxisLabelPosition : .bottom,
                                       xAxisLabelsFrom    : .dataPoint(rotation: .degrees(-90)),
                                       xAxisTitle         : "",
                                       yAxisGridStyle     : gridStyle,
                                       yAxisLabelPosition : .leading,
                                       yAxisNumberOfLabels: 5,
                                       yAxisTitle         : "% of reviews",
                                       baseline           : .zero,
                                       topLine            : .maximumValue)
       data = BarChartData(dataSets  : dataSet,
                            metadata  : metadata,
                            xAxisLabels: ["One", "Two", "Three"],
                            barStyle  : BarStyle(barWidth: 0.5,
                                                 cornerRadius: CornerRadius(top: 4, bottom: 0),
                                                 colourFrom: .dataPoints,
                                                 colour: ColourStyle(colour: .blue)),
                            chartStyle: chartStyle)
    }
    var body: some View {
        BarChart(chartData: data)
            .touchOverlay(chartData: data, minDistance: 10)
//            .averageLine(chartData: data,
//                         strokeStyle: StrokeStyle(lineWidth: 3, dash: [5,10]))
//            .xAxisPOI(chartData: data,
//                      markerName: "Bob",
//                      markerValue: 6,
//                      dataPointCount: data.dataSets.dataPoints.count)
            .xAxisGrid(chartData: data)
            .yAxisGrid(chartData: data)
            .xAxisLabels(chartData: data)
            .yAxisLabels(chartData: data, colourIndicator: .custom(colour: ColourStyle(colour: .clear), size: 12))
//            .extraYAxisLabels(chartData: data, colourIndicator: .style(size: 12))
            .headerBox(chartData: data)
            .id(data.id)
            .frame(minWidth: 150, maxWidth: 900, minHeight: 150, idealHeight: 500, maxHeight: 600, alignment: .center)
            .padding(.horizontal)
    }
}

struct IssuesBarChart_Previews: PreviewProvider {
    static var previews: some View {
        IssuesBarChart(dataSet: BarDataSet(dataPoints: [BarChartDataPoint(value: 20.0)]))
    }
}
