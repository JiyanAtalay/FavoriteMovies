//
//  WebService.swift
//  FavoriteMovies
//
//  Created by Mehmet Jiyan Atalay on 16.07.2024.
//

import Foundation

class WebService {
    func downloadMovie(url:URL) async throws -> MovieModel{
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let movie = try JSONDecoder().decode(MovieModel.self, from: data)
            
            return movie
        } catch _ as DecodingError {
            throw MovieError.decodingError
        } catch {
            throw MovieError.networkError(error)
        }
    }
}

enum MovieError: Error {
    case decodingError
    case networkError(Error)
}
