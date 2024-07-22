//
//  DetailsView.swift
//  FavoriteMovies
//
//  Created by Mehmet Jiyan Atalay on 17.07.2024.
//

import SwiftUI

struct DetailsView: View {
    
    var movie : MovieViewModel
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    HStack {
                        AsyncImage(url: URL(string: movie.poster)) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle())
                                    .frame(width: 50, height: 50)
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxWidth: .infinity, maxHeight: 400, alignment: .top)
                                    .padding()
                            case .failure(_):
                                Image(systemName: "xmark.circle")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                            @unknown default:
                                // Handle unknown future cases
                                Image(systemName: "questionmark.circle")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                            }
                        }
                    }
                    VStack {
                        GroupBox {
                            Text(movie.title)
                                .bold()
                                .font(.title2)
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
                            
                        
                        GroupBox {
                            HStack {
                                Text(movie.year)
                                Spacer()
                                Text(movie.genre)
                            }
                        }
                        
                        GroupBox {
                            HStack {
                                Text(movie.runTime)
                                Spacer()
                                Text(movie.director)
                                
                            }
                        }
                        
                        GroupBox {
                            Text(movie.plot)
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
                        
                        GroupBox {
                            Text(movie.actors)
                                .font(.title3)
                                .padding(.horizontal, 5)
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    DetailsView(movie: MovieViewModel(movie: MovieModel(title: "Guardians of the Galaxy Vol. 2", year: "2017", rated: "PG-13", released: "05 May 2017", runtime: "136 min", genre: "Action, Adventure, Comedy", director: "James Gunn", writer: "James Gunn, Dan Abnett, Andy Lanning", actors: "Chris Pratt, Zoe Saldana, Dave Bautista", plot: "The Guardians struggle to keep together as a team while dealing with their personal family issues, notably Star-Lord's encounter with his father, the ambitious celestial being Ego.", language: "English", country: "United States", awards: "Nominated for 1 Oscar. 15 wins & 60 nominations total", poster: "https://m.media-amazon.com/images/M/MV5BNjM0NTc0NzItM2FlYS00YzEwLWE0YmUtNTA2ZWIzODc2OTgxXkEyXkFqcGdeQXVyNTgwNzIyNzg@._V1_SX300.jpg", ratings: [Rating(source: "Internet Movie Database", value: "7.6/10"), Rating(source: "Rotten Tomatoes", value: "85%"), Rating(source: "Metacritic", value: "67/100")], metascore: "67", imdbRating: "7.6", imdbVotes: "764,992", imdbID: "tt3896198", type: "movie", dvd: "N/A", boxOffice: "$389,813,101", production: "N/A", website: "N/A", response: "True")))
}
