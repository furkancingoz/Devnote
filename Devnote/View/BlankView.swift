//
//  BlankView.swift
//  Devnote
//
//  Created by Furkan Cingöz on 26.11.2023.
//

import SwiftUI

struct BlankView: View {
    var body: some View {
      VStack{
        Spacer()
      }
      .frame(minWidth: 0,maxWidth: .infinity,minHeight: 0,maxHeight: .infinity,alignment: .center)
      .background(Color.black)
      .opacity(0.5)
      .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    BlankView()
}
