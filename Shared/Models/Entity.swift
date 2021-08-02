//
//  Entity.swift
//  AppReview (iOS)
//
//  Created by Robert Gillett on 8/1/21.
//

import Foundation

protocol Entity: Codable, Hashable, Identifiable {
    var id: String {get set}
}
