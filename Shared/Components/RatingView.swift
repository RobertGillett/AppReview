//
//  RatingView.swift
//  AppReview
//
//  Created by Robert Gillett on 8/1/21.
//

import SwiftUI

struct RatingView: View {
    var rating: Int = 4
    var body: some View {
        HStack(spacing: 2.0) {
            StarRating(filled: rating >= 1)
            StarRating(filled: rating >= 2)
            StarRating(filled: rating >= 3)
            StarRating(filled: rating >= 4)
            StarRating(filled: rating >= 5)

        }
    }
}

struct StarRating: View {
    var filled: Bool
    var body: some View {
        Image(systemName: filled ? "star.fill": "star.fill")
            .foregroundColor(filled ? .orange.opacity(0.8) : .gray.opacity(0.2))
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView()
    }
}
