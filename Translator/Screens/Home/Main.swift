//
//  ContentView.swift
//  Translator
//
//  Created by truID on 11/03/2025.
//

import SwiftUI

struct Main: View {
    @State private var inputText: String = ""

    @State private var lang1: String = "en"
    @State private var lang2: String = "ur"

    @ObservedObject private var vm = ViewModel()

    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                HStack(alignment: .center) {
                    Text("Translate")
                        .font(.title2)
                }

                Form {
                    Section {
                        Picker("From", selection: $lang1) {
                            ForEach(languages, id: \.code) { (language: Language) in
                                Text(language.name)
                            }
                        }
                        Picker("To", selection: $lang2) {
                            ForEach(languages, id: \.code) { (language: Language) in
                                Text(language.name)
                            }
                        }
                    }
                    .onChange(of: lang1) { new in
                        vm.translate(input: inputText, from: new, to: lang2)
                        print("Lang1:", new)
                    }
                    .onChange(of: lang2) { new in
                        vm.translate(input: inputText, from: lang1, to: new)
                        print("Lang2:", new)
                    }

                    Section {
                        TextField("Enter your text here...", text: $inputText)
                            .multilineTextAlignment(.leading)
                            .font(.title2)
                            .onSubmit {
                                vm.isTranslating = true
                                vm.translate(input: inputText, from: lang1, to: lang2)
                            }

                        if vm.isTranslating {
                            ProgressView()
                                .font(.title2)
                                .foregroundStyle(.primary)
                        } else {
                            Text(vm.translatedText)
                                .font(.title2)
                                .foregroundStyle(.primary)
                        }
                    }
                    .padding(.horizontal)
                }

                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.gray.opacity(0.2))
        }
    }
}

#Preview {
    Main()
}
