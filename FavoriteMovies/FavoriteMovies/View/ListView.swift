//
//  ContentView.swift
//  FavoriteMovies
//
//  Created by Mehmet Jiyan Atalay on 16.07.2024.
//

import SwiftUI
import SwiftData

struct ListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    
    @State private var showAddView = false
    
    @StateObject var dataModel = DataModel()
    
    @ObservedObject var viewModel = ListViewModel()

    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.movies) { movie in
                    NavigationLink {
                        DetailsView(movie: movie)
                        
                    } label: {
                        Text(movie.title)
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem {
                    Button(action: {
                        showAddView = true
                    }, label: {
                        Label("Add Item", systemImage: "plus")
                    })
                }
            }
            .navigationTitle("Favorite Movies")
        }
        .sheet(isPresented: $showAddView, onDismiss: handleAddViewDismiss){
            AddView(dataModel: dataModel)
        }
        .task {
            await viewModel.downloadMovies(ids: items)
        }
        
    }
    
    private func handleAddViewDismiss() {
        Task {
            showAddView = false
            if dataModel.type == "id" {
                await viewModel.downloadMovie(url: Urls.moviebyId(id: dataModel.text))
            } else if dataModel.type == "title" {
                await viewModel.downloadMovie(url: Urls.movieByTitle(title: dataModel.text))
            }
            
            if let movie = viewModel.movie {
                viewModel.movies.append(movie)
                modelContext.insert(Item(timestamp: Date(), imdbID: movie.imdbID))
            }
            do {
                try modelContext.save()
            } catch {
                print(error.localizedDescription)
            }
            
            dataModel.text = ""
            
            
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
            
            do {
                try modelContext.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

#Preview {
    NavigationStack {
        ListView()
    }.modelContainer(for: [Item.self])
}
