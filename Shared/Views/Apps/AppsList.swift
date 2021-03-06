//
//  AppsList.swift
//  AppReview (iOS)
//
//  Created by Robert Gillett on 8/1/21.
//

import SwiftUI

struct AppsList: View {
    @StateObject var vm = AppsListViewModel()
    var body: some View {
        List(selection: $vm.selection, content: {
            Section(header: Text("Mercedes Me Apps")) {
                ForEach(vm.data, id: \.id) { item in
                    NavigationLink(
                        destination: AppDetails(item),
                        tag: item,
                        selection: $vm.selection,
                        label: {AppRow(item)})
                }
            }
            
            Section(header: Text("Competitors")) {
                ForEach(vm.competitorData, id: \.id) { item in
                    NavigationLink(
                        destination: AppDetails(item),
                        tag: item,
                        selection: $vm.selection,
                        label: {AppRow(item)})
                }
            }
        })
        .navigationTitle("Apps")
    }
}

struct AppsList_Previews: PreviewProvider {
    static var previews: some View {
        AppsList()
    }
}
