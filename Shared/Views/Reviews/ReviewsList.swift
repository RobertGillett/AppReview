//
//  ReviewsList.swift
//  AppReview (iOS)
//
//  Created by Robert Gillett on 8/1/21.
//

import SwiftUI

struct ReviewsList: View {
    @ObservedObject var vm: ReviewsListViewModel
    var body: some View {
        List(selection: $vm.selection, content: {
            ReviewsHeader(model: vm.headerModel)
            Section(header:
                        HStack {
                            Spacer()
                            sortMenu
                        }
            ) {
            ForEach(vm.filteredData, id: \.id) { item in
                NavigationLink(
                    destination: ReviewDetails(vm: vm, item: item),
                    tag: item,
                    selection: $vm.selection,
                    label: {ReviewRow(item).padding(.vertical, 8)})
            }
            }
        })
        .navigationBarTitleDisplayMode(.large)
        .navigationTitle("Ratings & Reviews")

        
//            .resizable()
//            .aspectRatio(contentMode: .fill)
    }
    
    var sortMenu: some View {
        Menu {
            Picker(selection: $vm.sortBy, label: Text("Picker"), content: {
                ForEach(ReviewSort.allCases, id: \.self) { item in
                    Text(item.rawValue).tag(item)
                }
            })
        } label: {
            Text("Sort By \(vm.sortBy.rawValue)")
        }
    }
}

//struct ReviewsList_Previews: PreviewProvider {
//    static var previews: some View {
//        ReviewsList()
//    }
//}
