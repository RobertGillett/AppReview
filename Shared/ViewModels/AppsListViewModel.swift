//
//  AppsListViewModel.swift
//  AppReview (iOS)
//
//  Created by Robert Gillett on 8/1/21.
//

import Foundation
import Combine


class AppsListViewModel: ObservableObject {
    @Published var data: [AppEntity] = []
    @Published var competitorData: [AppEntity] = []

    @Published var selection: AppEntity?
    
    init() {
        self.data = FileReader.load("apps")
        self.competitorData = FileReader.load("competitors")

    }
}
