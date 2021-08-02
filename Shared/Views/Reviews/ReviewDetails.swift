//
//  ReviewDetails.swift
//  AppReview
//
//  Created by Robert Gillett on 8/1/21.
//

import SwiftUI

struct ReviewDetails: View {
    @ObservedObject var vm: ReviewsListViewModel
    var item: Review
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 20) {
                Group {
                VStack(alignment: .leading, spacing: 20) {
                    HStack(alignment: .top) {
                        Text(item.title)
                            .font(.headline)
                        Spacer()
                        Text(item.version)
                            .foregroundColor(.blue)
                    }
                    RatingView(rating: item.rating)
                    if item.reviewTags.count > 0 {
                        ReviewTagsView(tags: item.reviewTags)
                            .fixedSize()
                    }
                    Text(item.body)
                        .font(.subheadline)
    //                    .foregroundColor(.gray)
                        .multilineTextAlignment(.leading)
                        .lineLimit(.none)

                }
                HStack {
                    Text(item.authorName)
                        .font(.caption)
                        .foregroundColor(.gray)
                    Spacer()
                    Text(item._date, style: Text.DateStyle.date)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                }.padding()
                Spacer(minLength: 20)
            }
        }
        .navigationTitle(Text("Apps"))
    }
}

//struct ReviewDetails_Previews: PreviewProvider {
//    static var previews: some View {
//        ReviewDetails()
//    }
//}
