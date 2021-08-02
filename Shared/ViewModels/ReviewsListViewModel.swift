//
//  ReviewsListViewModel.swift
//  AppReview (iOS)
//
//  Created by Robert Gillett on 8/1/21.
//

import Foundation
import Combine
import SwiftUICharts
import SwiftUI

class ReviewsListViewModel: ObservableObject {
    @Published var allData: [Review] = [] {
        didSet {
            setPlotData()
        }
    }
    @Published var filteredData: [Review] = []
    @Published var selection: Review?
    @Published var sortBy: ReviewSort = .mostRecent
    @Published var headerModel: ReviewHeaderModel = ReviewHeaderModel([])
    @Published var barDataSet: BarDataSet = BarDataSet(dataPoints: [])
    @Published var pieDataSet: PieDataSet = PieDataSet(dataPoints: [], legendTitle: "Issues")
    var bag = Set<AnyCancellable>()

    var app: AppEntity
    init(_ app: AppEntity) {
        self.app = app
        self.allData = FileReader.load("reviews-" + app.id)
        
        $sortBy
            .receive(on: RunLoop.main)
            .sink { [weak self] sort in
                self?.handleSort(sort)
            }
            .store(in: &bag)
        
        $allData
            .receive(on: RunLoop.main)
            .map({ReviewHeaderModel($0)})
            .assign(to: \.headerModel, on: self)
            .store(in: &bag)
    }
    
    func setPlotData() {
        let tags = Array(self.allData.compactMap({$0.reviewTags}).joined())
        let grouped = Dictionary(grouping: tags, by: {$0}).sorted(by: {$0.value.count > $1.value.count})
        let points = grouped.compactMap({BarChartDataPoint(value: (Double($0.value.count)/Double(tags.count)) * 100, xAxisLabel: $0.key.rawValue, description: $0.key.rawValue, colour: ColourStyle(colour: $0.key.color))})
        let pieDataPoints = grouped.compactMap({PieChartDataPoint(value: Double($0.value.count), description: $0.key.rawValue, date: nil, colour: $0.key.color, label: OverlayType.label(text: $0.key.rawValue, colour: .white, font: Font.caption, rFactor: 0.7))})
        
        pieDataSet = PieDataSet(dataPoints: pieDataPoints, legendTitle: "Issues")
        barDataSet = BarDataSet(dataPoints: points, legendTitle: "Issues")
        
    }
    
    func handleSort(_ sort: ReviewSort) {
        switch sort {
        case .mostHelpful:
            filteredData = allData.sorted(by: {$0.voteCount > $1.voteCount})
        case .mostRecent:
            filteredData = allData.sorted(by: {$0._date > $1._date})
        case .mostCritical:
            filteredData = allData.sorted(by: {$0.rating < $1.rating})
        case .mostFavorable:
            filteredData = allData.sorted(by: {$0.rating > $1.rating})
        }
    }
    
}

enum ReviewSort: String, Identifiable, CaseIterable {
    public var id: String {
        return self.rawValue
    }
    case mostRecent = "Most Recent"
    case mostCritical = "Most Critical"
    case mostFavorable = "Most Favorable"
    case mostHelpful = "Most Helpful"
}
