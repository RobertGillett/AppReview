//
//  Review.swift
//  AppReview (iOS)
//
//  Created by Robert Gillett on 8/1/21.
//

import Foundation


struct Review: Entity {
    var id: String
    var version: String
    var authorName: String
    var rating: Int
    var voteCount: Int
    var voteSum: Int
    var title: String
    var body: String
    var platform: String
    var appID: String
    var appName: String
    var date: String
    
    var _date: Date {
        let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.timeZone = TimeZone.autoupdatingCurrent
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return dateFormatter.date(from: date) ?? Date()
    }

    var reviewTags: [ReviewTag] {
        var tags = Set<ReviewTag>()
        
        for tag in ReviewTag.allCases {
//            if tags.contains(tag) {
//                break
//            }
//            else {
                for text in tag.searchText {
                    if self.title.lowercased().contains(text) || self.body.lowercased().contains(text) {
                        tags.insert(tag)
                    }
//                }
            }
        }
        return Array(tags)
    }
    
}

import SwiftUI

enum ReviewTag: String, CaseIterable {
    case Login
    case RemoteStart = "Remote Start"
    case Unlock = "Remote Unlock"
    case Buggy
    case Location
    case Slow
    case Activation
    case Notifications
    case AppleWatch = "Apple Watch"
    case CustomerService = "CustomerService"
    
    var searchText: [String] {
        var query : [String] = []
        switch self {
        case .Login:
            query = ["login", "register", "registration", "log on", "log in", "credentials", "email", "password", "touchID", "faceID"]
        case .RemoteStart:
            query = ["start", "remote start"]
        case .Unlock:
            query = ["unlock", "lock", "locking"]
        case .Buggy:
            query = ["crash", "bug", "buggy", "doesn't work", "does not work", "lags", "unresponsive", "nonresponsive", "freeze", "freezes", "close"]
        case .Location:
            query = ["location", "gps"]
        case .Slow:
            query = ["slow"]
        case .Activation:
            query = ["activate", "activation"]
        case .Notifications:
            query = ["notifications"]
        case .AppleWatch:
            query = ["apple watch"]
        case .CustomerService:
            query = ["customer service"]
        }
        return query
    }
    var color: Color {
        switch self {
        case .Activation:
            return .blue
        case .Login:
            return .orange
        case .RemoteStart:
            return .yellow
        case .Unlock:
            return .red.opacity(0.5)
        case .Buggy:
            return .red
        case .Location:
            return .green
        case .Slow:
            return .purple
        case .Notifications:
            return .green.opacity(0.5)
        case .AppleWatch:
            return .pink
        case .CustomerService:
            return .blue.opacity(0.5)
        }
    }
    
//    func predicate() -> NSPredicate {
//        var p = [NSPredicate]()
//        var query : [String] = []
//        switch self {
//        case .Login:
//            query = ["login"]
//        case .RemoteStart:
//            query = ["remote start"]
//        case .Unlock:
//            query = ["unlock"]
//        case .Crash:
//            query = ["crash"]
//        case .Location:
//            query = ["location"]
//        case .Slow:
//            query = ["slow"]
//
//        }
//
//        for q in query {
////            p.append(NSPredicate(format: "title MATCHES %@", q))
//            p.append(NSPredicate(format: "body LIKE %@", q))
//
//        }
//
//        return NSCompoundPredicate(orPredicateWithSubpredicates: p)
//    }
}
