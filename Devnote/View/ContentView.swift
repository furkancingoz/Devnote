//
//  ContentView.swift
//  Devnote
//
//  Created by Furkan Cingöz on 26.11.2023.
//

import SwiftUI
import CoreData

struct ContentView: View {

  //MARK: - PROPERTY


  //MARK FETCHING DATA
  @Environment(\.managedObjectContext) private var viewContext

  @FetchRequest(
    sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
    animation: .default)
  private var items: FetchedResults<Item>

  //MARK: - FUNCTION
  private func addItem() {
    withAnimation {
      let newItem = Item(context: viewContext)
      newItem.timestamp = Date()

      do {
        try viewContext.save()
      } catch {
        let nsError = error as NSError
        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
      }
    }
  }

  private func deleteItems(offsets: IndexSet) {
    withAnimation {
      offsets.map { items[$0] }.forEach(viewContext.delete)

      do {
        try viewContext.save()
      } catch {
        let nsError = error as NSError
        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
      }
    }
  }

  //MARK: - BODY
  var body: some View {
    NavigationView {
      NavigationView {
        List {
          ForEach(items) { item in
            NavigationLink {
              Text("Item at \(item.timestamp!, formatter: itemFormatter)")
            } label: {
              Text(item.timestamp!, formatter: itemFormatter)
            }
          }
          .onDelete(perform: deleteItems)
        }//: List
        .toolbar {
          ToolbarItem(placement: .navigationBarTrailing) {
            EditButton()
          }
          ToolbarItem {
            Button(action: addItem) {
              Label("Add Item", systemImage: "plus")
            }
          }
        }//: toolbar
      }//:Navigation
      Text("Select an item")
    }
  }
}



//MARK: - PREVIEW
#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
