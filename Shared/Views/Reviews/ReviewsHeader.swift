//
//  ReviewsHeader.swift
//  AppReview
//
//  Created by Robert Gillett on 8/1/21.
//

import SwiftUI

struct ReviewsHeader: View {
    var model: ReviewHeaderModel
    var body: some View {
        HStack {
            VStack {
                Text(model.averageLabel)
                    .font(.system(size: 60, weight: Font.Weight.heavy, design: Font.Design.rounded))
                Text("out of 5")
                    .font(.caption)
                    .bold()
                    .foregroundColor(.gray)
            }
            .frame(width: 120, height: 100)
//            HStack(spacing: 8.0) {
                VStack(alignment: .trailing) {
                    ReviewHeaderStar(num: 5, progress: model.fiveStar)
                    ReviewHeaderStar(num: 4, progress: model.fourStar)
                    ReviewHeaderStar(num: 3, progress: model.threeStar)
                    ReviewHeaderStar(num: 2, progress: model.twoStar)
                    ReviewHeaderStar(num: 1, progress: model.oneStar)
                    
                    HStack {
                        Spacer()
                        Text(model.reviewCountLabel)
                            .font(.caption)
                            .bold()
                            .foregroundColor(.gray)
                    }
            }
                .frame(height: 100)
        }
    }
}

struct ReviewHeaderStar: View {
    var num: Int = 5
    var progress: CGFloat
    var body: some View {
        HStack {
            HStack(spacing: 2.0) {
                Spacer()
                ForEach(0..<num) { index in
                        star
                }
                
            }
            .frame(width: 70)
            ProgressView(value: progress)
                .progressViewStyle(LinearProgressViewStyle(tint: .gray))
//            RoundedRectangle(cornerRadius: 12)
//                .frame(height: 6)
//                .foregroundColor(.gray)
        }
    }
    
    var star: some View {
        Image(systemName: "star.fill").font(.system(size: 8))
            .foregroundColor(.gray)
    }
}

import Foundation

struct ReviewHeaderModel {
    var reviewCount: Int
    var fiveStar: CGFloat
    var fourStar: CGFloat
    var threeStar: CGFloat
    var twoStar: CGFloat
    var oneStar: CGFloat
    var averageLabel: String
    var reviewCountLabel: String {
        return "\(reviewCount) Ratings"
    }

    init(_ data: [Review]) {
        reviewCount = data.count
        fiveStar = CGFloat(data.filter({return $0.rating == 5}).count)/CGFloat(reviewCount)
        fourStar = CGFloat(data.filter({return $0.rating == 4}).count)/CGFloat(reviewCount)
        threeStar = CGFloat(data.filter({return $0.rating == 3}).count)/CGFloat(reviewCount)
        twoStar = CGFloat(data.filter({return $0.rating == 2}).count)/CGFloat(reviewCount)
        oneStar = CGFloat(data.filter({return $0.rating == 1}).count)/CGFloat(reviewCount)
        let total = data.compactMap({$0.rating}).reduce(0, +)
        averageLabel = !(reviewCount > 0) ? "0" : String(format: "%.1f", CGFloat(total)/CGFloat(reviewCount))

    }
}

struct ReviewsHeader_Previews: PreviewProvider {
    static var previews: some View {
        ReviewsHeader(model: ReviewHeaderModel([]))
    }
}
