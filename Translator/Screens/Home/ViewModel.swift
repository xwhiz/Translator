//
//  ViewModel.swift
//  Translator
//
//  Created by truID on 11/03/2025.
//

import Foundation

extension Main {
    class ViewModel: ObservableObject {
        var task: URLSessionDownloadTask?
        var translationQueue = DispatchQueue(label: "com.translate.translationQueue")

        @Published var translatedText = ""

        func translate(input: String, from lang1: String, to lang2: String) {
            if input.isEmpty {
                translatedText = ""
                return
            }

            if let t = task {
                t.cancel()
                task = nil
            }

            guard let escapedStr = input.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) else {
                print("Unable to escape the given string.")
                return
            }
            let lastPart = lang1 + "&tl=" + lang2 + "&q=" + escapedStr
            let urlStr = "https://clients5.google.com/translate_a/t?client=dict-chrome-ex&sl=" + lastPart
            guard let url = URL(string: urlStr) else {
                print("Unable to create url from \(urlStr)")
                return
            }

            task = URLSession.shared.downloadTask(with: url) { localURL, _, _ in
                if let localURL, let string = try? String(contentsOf: localURL) {
                    let index = string.firstIndex(of: "\"")
                    let index2 = string.index(after: index!)
                    let subst = string.substring(from: index2)
                    let indexf = subst.firstIndex(of: "\"")
                    let result = subst.substring(to: indexf!)

                    print("Result:", result)

                    DispatchQueue.main.async {
                        self.translatedText = result
                    }
                }
            }
            task?.resume()
        }
    }
}
