//
//  AppDetails.swift
//  AppReview
//
//  Created by Robert Gillett on 8/1/21.
//

import SwiftUI
import SwiftUICharts

struct AppDetails: View {
    @StateObject var reviewsVM: ReviewsListViewModel
    
    init(_ app: AppEntity) {
        _reviewsVM = StateObject(wrappedValue: ReviewsListViewModel(app))
    }
    var body: some View {
//        IssuesBarChart(dataSet: reviewsVM.barDataSet)
        ScrollView(.vertical, showsIndicators: false, content: {
            VStack {

                appHeader
                    .padding()
                Divider()
                HStack {
                    Text("Ratings & Reviews")
                        .font(.system(.title3, design: .rounded))
                        .bold()
                    Spacer()
                    NavigationLink(
                        destination: ReviewsList(vm: reviewsVM),
                        label: {
                            Text("See All")
                                .bold()
                        })
                }.padding(.horizontal)
                ReviewsHeader(model: reviewsVM.headerModel)
                    .padding(.horizontal)
                    .padding(.vertical, 12)
                Divider()
                if reviewsVM.barDataSet.dataPoints.count > 0 {
                IssuesBarChart(dataSet: reviewsVM.barDataSet)
                    .padding(.vertical)
                }
            }
        })
        .navigationBarTitleDisplayMode(.inline)
    }
    var appHeader: some View {
        HStack {
            Image(reviewsVM.app.id)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 80, height: 80)
                .cornerRadius(12)
            VStack(alignment: .leading) {
                Text(reviewsVM.app.name.capitalized)
                    .font(.title)
                    .bold()
            }
            Spacer()
        }
    }
}

struct AppDetails_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AppDetails(FileReader.benzApps.first!)
        }
    }
}
