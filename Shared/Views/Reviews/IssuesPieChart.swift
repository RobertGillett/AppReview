//
//  IssuesPieChart.swift
//  AppReview
//
//  Created by Robert Gillett on 8/1/21.
//

import SwiftUI
import SwiftUICharts

struct IssuesPieChart: View {
    var dataSet: PieDataSet
    let data : PieChartData
    init(dataSet: PieDataSet) {
        self.dataSet = dataSet
        let metaData =  ChartMetadata(title: "Issues", subtitle: "% of reports")
        self.data = PieChartData(dataSets: dataSet, metadata: metaData)
    }
    var body: some View {
        VStack {
            PieChart(chartData: data)
                .touchOverlay(chartData: data, minDistance: 10)
                .headerBox(chartData: data)
                .legends(chartData: data, columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())])
                .frame(minWidth: 150, maxWidth: 900, minHeight: 150, idealHeight: 500, maxHeight: 600, alignment: .center)
                .id(data.id)
                .padding(.horizontal)
        }
    }
}
