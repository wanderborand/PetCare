//
//  ChatServices.swift
//  PetPal
//
//  Created by Andrew on 31.05.2023.
//

import Foundation
import FirebaseDatabase

class ChatServices {
    static let shared = ChatServices()
    private let databaseRef = Database.database().reference()
    
    func sendMessage(_ message: ChatMessage, completion: @escaping (Error?) -> Void) {
        let messageRef = databaseRef.child("messages").childByAutoId()
        messageRef.setValue(message.toDictionary()) { error, _ in
            completion(error)
        }
    }
    
    func observeMessages(completion: @escaping ([ChatMessage]) -> Void) {
        databaseRef.child("messages").observe(.value) { snapshot in
            var messages: [ChatMessage] = []
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                   let messageDict = snapshot.value as? [String: Any],
                   let message = ChatMessage(dictionary: messageDict) {
                    messages.append(message)
                }
            }
            completion(messages)
        }
    }
}

