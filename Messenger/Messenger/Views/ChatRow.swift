//
//  ChatRow.swift
//  Messenger
//
//  Created by Shoaib Laghari on 11/6/21.
//

import SwiftUI

struct ChatRow: View {
    let type: MessageType
    let text: String
    
    init(text: String, type: MessageType) {
        self.text = text
        self.type = type
    }
    
    var isSender: Bool {
        return type == .sent
    }
    
    var body: some View {
        HStack {
            if isSender { Spacer() }
            
            if !isSender {
                VStack {
                    Spacer()
                    Circle()
                        .frame(width: 45, height: 45)
                        .foregroundColor(Color.pink)
                }
            }
            
            HStack {
                Text(text)
                    .foregroundColor(isSender ? Color.white : Color(.label))
                    .padding()
            }
            .background(isSender ? Color.blue : Color(.systemGray4))
            .padding(isSender ? .leading : .trailing, isSender ? UIScreen.main.bounds.width/3 : UIScreen.main.bounds.width/5)
            .cornerRadius(6)
            
            if !isSender { Spacer() }
        }
    }
}

struct ChatRow_Previews: PreviewProvider {
    static var previews: some View {
        ChatRow(text: "Hello World", type: .sent)
            .preferredColorScheme(.dark)
        
        ChatRow(text: "Hello World", type: .received)
            .preferredColorScheme(.light)
    }
}
