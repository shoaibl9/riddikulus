//
//  ChatView.swift
//  Messenger
//
//  Created by Shoaib Laghari on 11/6/21.
//

import SwiftUI

struct CustomField: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .padding()
            .background(Color(.secondarySystemBackground))
            .cornerRadius(7)
    }
}

struct ChatView: View {
    @State var message: String = ""
    @EnvironmentObject var model: AppStateModel
    let otherUsername: String
    
    init(otherUsername: String) {
        self.otherUsername = otherUsername
    }
    
    var body: some View {
        VStack {
            ScrollView(.vertical) {
                ForEach(model.messages, id: \.self) { message in
                    ChatRow(text: message.text, type: message.type)
                        .padding(3)
                }
            }
            
            // Field, send button
            HStack {
                TextField("Message...", text: $message)
                    .modifier(CustomField())
                
                SendButton(text: $message)
                Button(action: {
                    model.riddikulusIsOn.toggle()
                    model.riddikulusCount += 1
                }, label: {
                    Image(systemName: "wand.and.rays")
                        .font(Font.system(.largeTitle))
                        .frame(width: 55, height: 55)
                })
            }
            .padding()
        }
        .navigationBarTitle(otherUsername, displayMode: .inline)
        .onAppear{
            model.otherUsername = otherUsername
            model.observeChat()
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(otherUsername: "Samantha")
    }
}
