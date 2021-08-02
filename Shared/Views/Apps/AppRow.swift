//
//  AppRow.swift
//  AppReview (iOS)
//
//  Created by Robert Gillett on 8/1/21.
//

import SwiftUI

struct AppRow: View {
    var item: AppEntity
    init(_ app: AppEntity) {
        self.item = app
    }
    var body: some View {
        HStack {
            Image(item.id)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 50, height: 50)
                .cornerRadius(10)
            VStack {
                Text(item.name)
                    .font(.headline)
            }
        }
    }
}

struct AppRow_Previews: PreviewProvider {
    static var previews: some View {
        AppRow(FileReader.benzApps.first!)
    }
}
