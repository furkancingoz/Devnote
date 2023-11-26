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
  @State var task = ""
  private var isButtonDisabled: Bool {
    task.isEmpty
  }


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
      newItem.task = task
      newItem.completion = false
      newItem.id = UUID()


      do {
        try viewContext.save()
      } catch {
        let nsError = error as NSError
        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
      }
      task = ""
      hideKeyboard()
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
        VStack {
          VStack(spacing: 10) {
            TextField("New Task", text: $task)
              .padding()
              .background(
                Color(UIColor.systemGray6)
              )
              .cornerRadius(15)

            Button {
              addItem()
            } label: {
              Spacer()
              Text("Save")
              Spacer()
            }
            .disabled(isButtonDisabled)
            .padding()
            .font(.headline)
            .foregroundColor(.white)
            .background(isButtonDisabled ? Color.gray : Color.pink)
            .cornerRadius(15)
          }//:VSTACK
          .padding()


          List {
            ForEach(items) { item in
              VStack(alignment:.leading) {
                Text(item.task ?? "")
                  .font(.headline)
                  .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                Text("Item at \(item.timestamp!, formatter: itemFormatter)")
                  .font(.footnote)
                  .foregroundColor(.gray)
              }// list item

            }.onDelete(perform: deleteItems)
            //: List
          }//: vstack
          .navigationTitle("Daily Task")
          .navigationBarTitleDisplayMode(.large)
          .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
              EditButton()
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
