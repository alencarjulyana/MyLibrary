//
//  ContentView.swift
//  MyLibrary
//
//  Created by Nicoly Figueredo on 03/07/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
        @Environment(\.presentationMode) var presentationMode

        @FetchRequest(
            sortDescriptors: [NSSortDescriptor(keyPath: \Book.name, ascending: true)],
            animation: .default)
        private var books: FetchedResults<Book>

        var body: some View {
            NavigationView {
                ZStack {
                    top
                    listagem
                }
            }
        }
    }

    extension ContentView {
        var top: some View {
            ZStack {
                Color.green
                    .opacity(0.4)
                    .edgesIgnoringSafeArea(.top)
                Color.white
            }
        }
    }

    extension ContentView {
        var listagem: some View {
            VStack {
                List {
                    ForEach(self.books) { book in
                        ListView(book: book)
                    }
                    .onDelete(perform: self.deleteItems)
                }
                .padding(.top)
                .navigationTitle("Minha biblioteca")
                .toolbar {
                    ToolbarItem() {
                        NavigationLink(destination: FormView()) {
                            Image(systemName: "plus")
                        }
                    }
                    ToolbarItem() {
                        EditButton()
                    }
                }
            }
        }
        
        private func deleteItems(offsets: IndexSet) {
            withAnimation {
                offsets.map { books[$0] }.forEach(viewContext.delete)

                do {
                    try viewContext.save()
                } catch {
                    let nsError = error as NSError
                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                }
            }
        }
    }

    private let itemFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .medium
        return formatter
    }()

    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
}
