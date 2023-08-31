//
//  ChatTest.swift
//  PetPal
//
//  Created by Andrew on 31.05.2023.
//

import SwiftUI

extension ChatMessage: Identifiable {
    var id: UUID {
        UUID()
    }
}

struct ChatTestView: View {
    @ObservedObject var chatViewModel: ChatViewModel
    
    var body: some View {
        VStack {
            List(chatViewModel.messages) { message in
                Text("\(message.senderName): \(message.text)")
            }
            
            HStack {
                TextField("Введіть повідомлення", text: $chatViewModel.newMessageText)
                Button("Відправити", action: chatViewModel.sendMessage)
            }
        }
        .padding(.bottom, 120)
    }
}

struct ChatTestView_Previews: PreviewProvider {
    static var previews: some View {
        let chatViewModel = ChatViewModel()
        ChatTestView(chatViewModel: chatViewModel)
    }
}

