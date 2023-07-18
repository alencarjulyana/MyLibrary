//
//  ListView.swift
//  MyLibrary
//
//  Created by Nicoly Figueredo on 03/07/23.
//

import SwiftUI
import CoreData

struct ListView: View {
    var book: Book
    var body: some View {
        HStack {
            VStack (alignment: .leading) {
                Text("Nome do livro: \(book.name!)")
                Text("Autor: \(book.author!)")
                Text("Editora:  \(book.publish!)")
                Text("Emprestado: \(book.borrowed ? "Sim" : "Não")")
                Text("Status: \(book.status!.description)")
            }
        }
        .padding(.bottom, 6)
        .padding(.top, 6)
        .padding()
    }
}



