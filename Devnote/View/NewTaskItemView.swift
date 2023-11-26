//
//  NewTaskItemView.swift
//  Devnote
//
//  Created by Furkan Cingöz on 26.11.2023.
//

import SwiftUI

struct NewTaskItemView: View {
  @Environment(\.managedObjectContext) private var viewContext
  @State private var task: String =  ""

  private var isButtonDisabled: Bool {
    task.isEmpty
  }
  //func
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
    var body: some View {
      VStack{
        Spacer()
        VStack(spacing: 16) {
          TextField("New Task", text: $task)
            .foregroundColor(.pink)
            .font(.system(size: 24,weight: .bold, design: .rounded))
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
              .font(.system(size: 24,weight: .bold, design: .rounded))
            Spacer()
          }
          .disabled(isButtonDisabled)
          .padding()
          .foregroundColor(.white)
          .background(isButtonDisabled ? Color.blue : Color.pink)
          .cornerRadius(15)
        }//:VSTACK
        .padding(.horizontal)
        .padding(.vertical,20)
        .background(
          Color.white
        )
        .cornerRadius(16)
        .shadow(color: Color(red: 0, green: 0, blue: 0,opacity: 0.64),radius : 24)
        .frame(maxWidth: 640)
      }// VSTACK
      .padding()
    }
}

#Preview {
    NewTaskItemView()
    .background(Color.gray.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/))
}