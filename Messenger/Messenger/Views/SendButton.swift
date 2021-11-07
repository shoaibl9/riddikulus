//
//  SendButton.swift
//  Messenger
//
//  Created by Shoaib Laghari on 11/6/21.
//

import SwiftUI

struct SendButton: View {
    @EnvironmentObject var model: AppStateModel
    @Binding var text: String
    
    var body: some View {
        Button(action: {
            self.sendMessage()
        }, label: {
            Image(systemName: "paperplane")
                .font(.system(size: 32))
                .aspectRatio(contentMode: .fit)
                .frame(width: 55, height: 55)
                .foregroundColor(Color.white)
                .background(Color.blue)
                .clipShape(Circle())
        })
    }
    
    func sendMessage() {
        guard !text.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        
        model.sendMessage(text)
        
        // clear out text field
        text = ""
    }
}

struct SendButton_Previews: PreviewProvider {
    static var previews: some View {
        SendButton(text: .constant("temp"))
    }
}
