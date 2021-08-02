//
//  ReviewTagsView.swift
//  AppReview
//
//  Created by Robert Gillett on 8/1/21.
//

import SwiftUI

struct ReviewTagsView: View {
    var tags: [ReviewTag]
    @State var rows = [GridItem(.flexible(minimum: 8, maximum: 20))]
    var body: some View {
        LazyHGrid(rows: rows, alignment: .firstTextBaseline, spacing: nil, pinnedViews: [], content: {
            ForEach(tags, id: \.self) { item in
                Text(item.rawValue)
                    .font(.caption2)
                    .lineLimit(1)
                    .foregroundColor(.white)
                    .padding(.horizontal)
                    .padding(.vertical, 4)
                    .background(item.color)
                    .clipShape(Capsule())
            }
        })
    }
}

struct ReviewTagsView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewTagsView(tags: [ReviewTag.Login, .Buggy, .RemoteStart, .Unlock, .Location, .Slow])
    }
}
