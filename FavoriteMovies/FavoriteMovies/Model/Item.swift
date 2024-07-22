//
//  Item.swift
//  FavoriteMovies
//
//  Created by Mehmet Jiyan Atalay on 16.07.2024.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    var imdbID : String
    
    init(timestamp: Date, imdbID: String) {
        self.timestamp = timestamp
        self.imdbID = imdbID
    }
}
