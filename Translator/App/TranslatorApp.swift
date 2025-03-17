//
//  TranslatorApp.swift
//  Translator
//
//  Created by truID on 11/03/2025.
//

import KeyboardKit
import SwiftUI

@main
struct TranslatorApp: App {
    var body: some Scene {
        WindowGroup {
            KeyboardAppView(for: .keyboard) {
                Main()
            }
        }
    }
}
