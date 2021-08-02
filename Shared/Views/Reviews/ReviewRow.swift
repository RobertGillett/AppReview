//
//  ReviewRow.swift
//  AppReview
//
//  Created by Robert Gillett on 8/1/21.
//

import SwiftUI

struct ReviewRow: View {
    var item: Review
    
    init(_ item: Review) {
        self.item = item
    }
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack(alignment: .leading, spacing: 12.0) {
                HStack(spacing: 8.0) {
                    Text(item.title)
                        .font(.headline)
                        .lineLimit(1)
                    Spacer()
                    Text(item.version)
                        .foregroundColor(.blue)
                }
                RatingView(rating: item.rating)
                Text(item.body)
                    .font(.subheadline)
//                    .foregroundColor(.gray)
                    .multilineTextAlignment(.leading)
                    .lineLimit(5)

            }
            if item.reviewTags.count > 0 {
                ReviewTagsView(tags: item.reviewTags)
                    .fixedSize()
            }

            HStack {
                Spacer()
                Text(item._date, style: Text.DateStyle.date)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
    }
}

struct ReviewRow_Previews: PreviewProvider {
    static var previews: some View {
        ReviewRow(FileReader.previewReviews.last!)
    }
}
