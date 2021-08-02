//
//  FileReader.swift
//  AppReview (iOS)
//
//  Created by Robert Gillett on 8/1/21.
//

import Foundation


class FileReader {
    static var benzApps: [AppEntity] {
        return self.load("apps")
    }
    
    static var previewReviews: [Review] {
        return self.load("reviews-1397873833")
    }
    static func load<T: Decodable>(_ filename: String) -> T {
        let data: Data
        
        guard let file = Bundle.main.url(forResource: filename, withExtension: "json")
            else {
                fatalError("Couldn't find \(filename) in main bundle.")
        }
        
        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }
        
        do {
            let decoder = JSONDecoder()
//            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
        }
    }
}
