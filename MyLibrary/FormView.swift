//
//  FormView.swift
//  MyLibrary
//
//  Created by Nicoly Figueredo on 03/07/23.
//

import SwiftUI

struct FormView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    @State var name: String = ""
    @State var author: String = ""
    @State var publish: String = ""
    @State var status: Status = .new
    @State var borrowed: Bool = false

    var body: some View {
        VStack {
            VStack {
                TextField("Informe o nome", text: self.$name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Informe o autor", text: self.$author)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Informe a editora", text: self.$publish)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            Picker("Status", selection: self.$status) {
                Text("Novo").tag(Status.new)
                Text("Lendo").tag(Status.reading)
                Text("Concluído").tag(Status.concluded)
            }
            Toggle("Emprestado", isOn: self.$borrowed)
            Spacer()
        }
        .padding()
        .navigationTitle("Novo livro")
        .toolbar {
            ToolbarItem() {
                Button("Adicionar") {
                    print(self.status)
                    addItem()
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }
    
    private func addItem() {
        withAnimation {
            let newItem = Book(context: viewContext)
            newItem.name = self.name
            newItem.author = self.author
            newItem.publish = self.publish
            newItem.status = self.status.rawValue
            newItem.borrowed = self.borrowed

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}


struct FormView_Previews: PreviewProvider {
    static var previews: some View {
        FormView()
    }
}
