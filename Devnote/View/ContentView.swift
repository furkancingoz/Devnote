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
  @State private var showNewTaskItem: Bool = false


  //MARK FETCHING DATA
  @Environment(\.managedObjectContext) private var viewContext

  @FetchRequest(
    sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
    animation: .default)
  private var items: FetchedResults<Item>

  //MARK: - FUNCTION


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
      ZStack {
        //MARK: - MAIN VIEW
        VStack {
          //MARK: - HEADER
          Spacer(minLength: 80)
          //MARK: - NEW TASK BUTTON
          Button {
            showNewTaskItem = true
          } label: {
          Image(systemName: "plus.circle")
              .font(.system(size: 30,weight: .semibold, design: .rounded))
            Text("New Task")
              .font(.system(size: 24,weight: .bold,design: .rounded))
              .foregroundColor(.white)
              .padding(.horizontal,20)
              .padding(.vertical,15)
              .background(
LinearGradient(gradient: Gradient(colors: [Color.blue, Color.pink]), startPoint: .leading, endPoint: .trailing))
              .clipShape(Capsule())
          }

          //MARK: - TASKS
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
          }
          .listStyle(InsetGroupedListStyle())
          .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.3),radius: 12)
          .padding(.vertical,0)
          .frame(maxWidth: 640)
        }
        //MARK: - NEW TASK ITEM
      }     //: ZSTACK
      .onAppear() {
        UITableView.appearance().backgroundColor = UIColor.clear
      }
      .navigationTitle("Daily Task").navigationBarTitleDisplayMode(.large)
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          EditButton()
        }
      }//: toolbar
      .background(
        BackgroundImageView()
      )
      .background(
        backgroundGradient.ignoresSafeArea(.all)
      )
    }//:Navigation
    .navigationViewStyle(StackNavigationViewStyle())
  }
}


//MARK: - PREVIEW
#Preview {
  ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
