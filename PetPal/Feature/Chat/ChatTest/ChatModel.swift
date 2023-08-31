//
//  ChatModel.swift
//  PetPal
//
//  Created by Andrew on 31.05.2023.
//

import Foundation

struct ChatMessage {
    let senderName: String
    let text: String
    
    init(senderName: String, text: String) {
        self.senderName = senderName
        self.text = text
    }
    
    init?(dictionary: [String: Any]) {
        guard let senderName = dictionary["senderName"] as? String,
              let text = dictionary["text"] as? String else {
            return nil
        }
        self.senderName = senderName
        self.text = text
    }
    
    func toDictionary() -> [String: Any] {
        return [
            "senderName": senderName,
            "text": text
        ]
    }
}

