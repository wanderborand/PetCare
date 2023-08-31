//
//  Message.swift
//  PetPal
//
//  Created by Andrew on 31.05.2023.
//

import Foundation

//Idetifiable Protocol - each message can be unique
//Codable - encodable , decodable
struct Message : Identifiable , Codable{
    var id : String
    var text : String
    var received : Bool
    var timestamp : Date
}
