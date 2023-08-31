//
//  AnimalInfoView.swift
//  PetPal
//
//  Created by Andrew on 30.05.2023.
//

import SwiftUI
import WebKit

struct AnimalInfoView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ZStack {
            WebView(urlString: "https://www.nationalgeographic.com/animals/")
            
            VStack {
                Spacer()
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Назад")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Capsule().fill(Color.musicColor))
                }
                .padding()
                .padding(.bottom, 30)
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct WebView: UIViewRepresentable {
    let urlString: String

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        return webView
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
}

struct AnimalInfoView_Previews: PreviewProvider {
    static var previews: some View {
        AnimalInfoView()
    }
}





