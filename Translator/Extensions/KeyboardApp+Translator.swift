//
//  KeyboardApp+Translator.swift
//  Translator
//
//  Created by truID on 14/03/2025.
//

import KeyboardKit

extension KeyboardApp {
    /// This `KeyboardApp` value defines the demo app.
    ///
    /// The demo uses a `KeyboardKit.license` file to unlock
    /// KeyboardKit Pro, without having to include a license
    /// key in the app information below. This also lets the
    /// app update its license without also having to update
    /// KeyboardKit version. Note that this file is added to
    /// both the app and the `KeyboardPro` keyboard.
    ///
    /// The App Group ID is only to show you how you can use
    /// a `KeyboardApp` to set up App Group data syncing for
    /// an app and its keyboard. It doesn't work in the demo.
    ///
    /// See `DemoApp.swift` for more info about the demo app.
    static var keyboard: Self {
        .init(
            name: "Translator",
            appGroupId: "group.ai.truid",
            locales: .keyboardKitSupported
        )
    }
}
