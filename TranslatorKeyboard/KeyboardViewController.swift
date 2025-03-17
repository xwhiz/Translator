//
//  KeyboardViewController.swift
//  TranslatorKeyboard
//
//  Created by truID on 14/03/2025.
//

import Combine
import KeyboardKit
import SwiftUI

class KeyboardState: ObservableObject {
    @Published var typedText: String = ""

    func updateText(from proxy: UITextDocumentProxy) {
        DispatchQueue.main.async {
            self.typedText = proxy.documentContextBeforeInput ?? ""
        }
    }
}

/// This keyboard shows you how to set up `KeyboardKit` with
/// a `KeyboardApp` and customize the standard keyboard view.
///
/// This keyboard is very basic, to provide a starting point
/// for trying out the open-source features. You can perform
/// any customizations to the keyboard, state & services and
/// inject any custom views into the keyboard.
///
/// See the `KeyboardPro` keyboard for a more extensive demo,
/// and the `DemoApp.swift` for more info about the demo app.
class KeyboardViewController: KeyboardInputViewController {
    /// This function is called when the controller launches.
    ///
    /// Call `setup(for:)` to set up this controller for the
    /// `.keyboardKitDemo` application.
    override func viewDidLoad() {
        /// 💡 Always call `super.viewDidLoad()`.
        super.viewDidLoad()

        /// ‼️ Set up the keyboard for `.keyboardKitDemo`.
        super.setup(
            for: .init(
                name: "Translator",
                appGroupId: "group.ai.truid",
                locales: .keyboardKitSupported,
                deepLinks: .init(
                    app: "translatorapp://"
                )
                //                autocomplete: .init()
            )
        ) { result in

            switch result {
            case .success(let success):
                print("Success:", success)
            case .failure(let failure):
                print("Failure:", failure)
            }
        }

        /// 💡 Make basic state & service customizations.
        setupDemoServices()
        setupDemoState()
    }

    /// This function is called when the controller needs to
    /// create or update the keyboard view.
    ///
    /// Call `setupKeyboardView(_:)` here to set up a custom
    /// keyboard view or customize the default `KeyboardView`.
    override func viewWillSetupKeyboardView() {
        setupKeyboardView { controller in
            KeyboardView(
                state: controller.state,
                services: controller.services,
                buttonContent: { $0.view },
                buttonView: { $0.view },
                collapsedView: { $0.view },
                emojiKeyboard: { $0.view },
                toolbar: { _ in
                    Keyboard.Toolbar {
                        HStack {
                            Image(systemName: "plus")

                            Spacer()

                            Text(controller.state.keyboardContext.textDocumentProxy.currentWord?.uppercased() ?? "")

                            Spacer()
                            Button {
                                self.extensionContext?.open(URL(string: "translatorapp://")!) { success in
                                    print("Opened main app \(success)")
                                }
                            } label: {
                                Image(systemName: "translate")
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            )
        }
    }
}

private extension KeyboardViewController {
    /// Make demo-specific changes to your keyboard services.
    func setupDemoServices() {
        /// 💡 You can replace any service with a custom service.
        services.autocompleteService = services.autocompleteService
    }

    /// Make demo-specific changes to your keyboard's state.
    func setupDemoState() {
        /// 💡 This enable more locales.
        state.keyboardContext.locales = [.english, .spanish]

        /// 💡 This overrides the standard enabled locales.
        state.keyboardContext.settings.addedLocales = [.init(.english), .init(.swedish)]

        /// 💡 Dock the keyboard to any horizontal edge.
        // state.keyboardContext.settings.keyboardDockEdge = .leading

        /// 💡 Configure the space key's long press behavior and trailing action.
        state.keyboardContext.settings.spaceLongPressBehavior = .moveInputCursor
        // state.keyboardContext.settings.spaceContextMenuLeading = .locale
        state.keyboardContext.settings.spaceContextMenuTrailing = .locale

        /// 💡 Customize keyboard feedback.
        // state.feedbackContext.settings.isAudioFeedbackEnabled = false
        // state.feedbackContext.settings.isHapticFeedbackEnabled = false
    }
}
