//
//  Message.swift
//  Messenger
//
//  Created by Shoaib Laghari on 11/6/21.
//

import Foundation

enum MessageType: String {
    case sent
    case received
}

struct Message: Hashable {
    let text: String
    let type: MessageType
    let created: Date
}
