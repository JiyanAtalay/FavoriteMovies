//
//  AddView.swift
//  FavoriteMovies
//
//  Created by Mehmet Jiyan Atalay on 16.07.2024.
//

import SwiftUI
import SwiftData

struct AddView: View {
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject var dataModel: DataModel
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField(text: $dataModel.text) {
                    Text("Movie name or imdb ID")
                }
                .frame(width: 200,height: 35)
                .border(Color.black)
                
                HStack {
                    GroupBox {
                        Button(action: {
                            Task {
                                if validateInput(type: "title") {
                                    dataModel.type = "title"
                                    dismiss()
                                }
                            }
                        }, label: {
                            Text("Find by Name")
                        })
                    }
                    
                    GroupBox {
                        Button(action: {
                            Task {
                                if validateInput(type: "id") {
                                    dataModel.type = "id"
                                    dismiss()
                                }
                            }
                        }, label: {
                            Text("Find by imdbID")
                        })
                    }
                    
                }
                .padding()
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Invalid Input"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                }
            }
        }
    }
    // tt3896198
    
    private func validateInput(type : String) -> Bool {
        guard !dataModel.text.isEmpty else {
            alertMessage = "Movie id cannot be empty."
            showAlert = true
            return false
        }
        
        if type == "id" {
            guard dataModel.text.count > 8 else {
                alertMessage = "Movie id must be at least 9 characters."
                showAlert = true
                return false
            }
        }
        
        return true
    }
}

class DataModel: ObservableObject {
    @Published var text: String = ""
    @Published var type: String = ""
}

#Preview {
    NavigationStack {
        AddView(dataModel: DataModel())
    }.modelContainer(for: [Item.self])
}
