//
//  BackgroundImageView.swift
//  Devnote
//
//  Created by Furkan Cingöz on 26.11.2023.
//

import SwiftUI

struct BackgroundImageView: View {
  var body: some View {
    Image("rocket")
      .antialiased(true)
      .resizable()
      .scaledToFill()
      .ignoresSafeArea(.all)
  }
}
