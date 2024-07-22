//
//  Urls.swift
//  FavoriteMovies
//
//  Created by Mehmet Jiyan Atalay on 17.07.2024.
//

import Foundation

struct Urls {
    static func moviebyId(id : String) -> URL {
        return URL(string: "http://www.omdbapi.com/?i=\(id)&apikey=?")!
    }
    
    static func movieByTitle(title: String) -> URL {
        return URL(string: "https://www.omdbapi.com/?t=\(title)&apikey=?")!
    }
}
