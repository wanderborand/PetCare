//
//  ChatView.swift
//  PetPal
//
//  Created by Andrew on 31.05.2023.
//
import SwiftUI
import OpenAISwift

final class ViewModel: ObservableObject {
    private var client: OpenAISwift?
    
    func setup() {
        client = OpenAISwift(authToken: "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")
    }
    
    func send(text: String, completion: @escaping (String) -> Void) {
        client?.sendCompletion(with: text,
                               maxTokens: 500,
                               completionHandler: { result in
            switch result {
            case .success(let model):
                let output = model.choices?.first?.text ?? ""
                completion(output)
            case .failure(let error):
                print("Error: \(error)")
                completion("")
            }
        })
    }
}

struct ChatView: View {
    @ObservedObject var viewModel = ViewModel()
    @State var text = ""
    @State var messages = [String]()
    
    var body: some View {
        VStack() {
            HStack {
                Text("PetPal Chat")
                    .font(.largeTitle)
                    .bold()
                Image(systemName: "bubble.left.fill")
                    .font(.system(size: 25))
                    .foregroundColor(.blue)
            }
            HStack {
                Text("SimpleHelp".localized)
                    .foregroundColor(.gray.opacity(0.5))
            }
            ScrollView {
                
                ForEach(messages, id: \.self) { message in
                    if message.contains("[USER]") {
                        let newMessage = message.replacingOccurrences(of: "[USER]", with: "")
                        HStack{
                            Spacer()
                            Text(newMessage)
                                .padding()
                                .foregroundColor(.white)
                                .background(.blue.opacity(0.8))
                                .cornerRadius(10)
                                .padding(.horizontal, 16)
                                .padding(.bottom, 10)
                        }
                    }  else {
                        HStack{
                            Text(message)
                                .padding()
                                .background(.gray.opacity(0.15))
                                .cornerRadius(10)
                                .padding(.horizontal, 16)
                                .padding(.bottom, 10)
                            Spacer()
                        }
                    }
                }
            }
                        
            HStack {
                TextField("TypeHere".localized, text: $text)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                    .onSubmit {
                        sendMessage()
                    }
                
                Button{
                    sendMessage()
                } label: {
                    Image(systemName: "paperplane.fill")
                }
                .font(.system(size: 26))
                .padding(.horizontal, 10)
            }
            .padding()
        }
        .padding()
        .padding(.bottom, 80)
        .onAppear {
            viewModel.setup()
        }
    }
    
    func sendMessage() {
        guard !text.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        withAnimation {
            messages.append("[USER]" + text)
        }
        
        viewModel.send(text: text) { response in
            DispatchQueue.main.async {
                withAnimation{
                    messages.append(response)
                    text = ""
                }
            }
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
