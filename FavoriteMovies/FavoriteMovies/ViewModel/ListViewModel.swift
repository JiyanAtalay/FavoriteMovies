//
//  ListViewModel.swift
//  FavoriteMovies
//
//  Created by Mehmet Jiyan Atalay on 16.07.2024.
//

import Foundation

@MainActor
class ListViewModel : ObservableObject {
    @Published var movie : MovieViewModel?
    @Published var movies = [MovieViewModel]()
    
    let webservice = WebService()
    
    func downloadMovie(url: URL) async {
        do {
            let data = try await webservice.downloadMovie(url: url)
            
            DispatchQueue.main.async {
                self.movie = MovieViewModel(movie: data)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func downloadMovies(ids: [Item]) async {
        self.movies = []
        
        for id in ids {
            do {
                let data = try await webservice.downloadMovie(url: Urls.moviebyId(id: id.imdbID))
                
                DispatchQueue.main.async {
                    self.movies.append(MovieViewModel(movie: data))
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

struct MovieViewModel : Identifiable{
    let id = UUID()
    let movie : MovieModel
    
    var title : String {
        movie.title
    }
    
    var year : String {
        movie.year
    }
    
    var released : String {
        movie.released
    }
    
    var runTime : String {
        movie.runtime
    }
    
    var genre : String {
        movie.genre
    }
    
    var director : String {
        movie.director
    }
    
    var actors : String {
        movie.actors
    }
    
    var plot : String {
        movie.plot
    }
    
    var poster : String {
        movie.poster
    }
    
    var ratings : String {
        movie.ratings[0].value
    }
    
    var imdbID : String {
        movie.imdbID
    }
    
    var response : String {
        movie.response
    }
}
