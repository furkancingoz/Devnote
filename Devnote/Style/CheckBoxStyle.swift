//
//  CheckBoxStyle.swift
//  Devnote
//
//  Created by Furkan Cingöz on 26.11.2023.
//

import SwiftUI

struct CheckBoxStyle: ToggleStyle {
  func makeBody(configuration: Configuration) -> some View {
    return HStack{
      Image(systemName: configuration.isOn ? "checkmark.circle.fill"  : "circle")
        .foregroundColor(configuration.isOn ? .pink : .primary)
        .font(.system(size: 30,weight: .semibold, design: .rounded))
        .onTapGesture {
          configuration.isOn.toggle()
        }

      configuration.label
    }
  }
}

#Preview {
  Toggle("place holer label", isOn: .constant(false))
    .toggleStyle(CheckBoxStyle())
    .padding()
    .previewLayout(.sizeThatFits)
}
