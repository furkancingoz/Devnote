//
//  HideKeyboardExtension.swift
//  Devnote
//
//  Created by Furkan Cingöz on 26.11.2023.
//

import Foundation
import SwiftUI

#if canImport(UIKit)
extension View {
  func hideKeyboard() {
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
  }
}
#endif
