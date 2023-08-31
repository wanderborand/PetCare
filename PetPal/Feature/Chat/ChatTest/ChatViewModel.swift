//
//  ChatViewModel.swift
//  PetPal
//
//  Created by Andrew on 31.05.2023.
//
import FirebaseAuth
import Firebase
import Foundation
import Combine

class ChatViewModel: ObservableObject {
    @Published var messages: [ChatMessage] = []
    @Published var newMessageText: String = ""
    @Published var selectedUser: UserSessionDetails?
    
    private var cancellables: Set<AnyCancellable> = []
    private var sessionService: SessionService
    
    init(sessionService: SessionService) {
        self.sessionService = sessionService
        observeMessages()
        addTestMessage()
    }
    
    func sendMessage() {
        guard !newMessageText.isEmpty else { return }
        
        guard let currentUser = Auth.auth().currentUser else {
            // Користувач не аутентифікований
            return
        }
        
        guard let selectedUser = selectedUser else {
            // Користувач не вибрав отримувача повідомлення
            return
        }
        
        let message = ChatMessage(senderName: currentUser.displayName ?? "", text: newMessageText, receiverUid: selectedUser.uid)
        
        ChatServices.shared.sendMessage(message) { [weak self] error in
            if let error = error {
                // Обробити помилку відправки повідомлення
            } else {
                self?.newMessageText = ""
            }
        }
    }
    
    private func observeMessages() {
        ChatServices.shared.observeMessages { [weak self] messages in
            self?.messages = messages
        }
    }
    
    private func addTestMessage() {
        let testMessage = ChatMessage(senderName: "TestUser", text: "Це тестове повідомлення.")
        messages.append(testMessage)
    }
}
