//
//  ContentView.swift
//  Messenger
//
//  Created by Shoaib Laghari on 11/6/21.
//

import SwiftUI

struct ConversationListView: View {
    let usernames = ["Joe", "Jill", "Bob"]
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                ForEach(usernames, id: \.self) { name in
                    NavigationLink(destination: ChatView(otherUsername: name), label: {
                        HStack {
                            Circle()
                                .frame(width: 65, height: 65)
                                .foregroundColor(Color.pink)
                            Text(name)
                                .bold()
                                .font(.system(size: 32))
                                .foregroundColor(Color(.label))
                            Spacer()
                        }
                        .padding()
                    })
                }
            }
            .navigationTitle("Conversations")
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading, content: {
                    Button("Sign out") {
                        self.signOut()
                    }
                })
                
                ToolbarItem(placement: .navigationBarTrailing, content: {
                    NavigationLink(destination: {
                        SearchView()
                    }, label: {
                        Image(systemName: "magnifyingglass")
                    })
                })
            }
        }
    }
    
    func signOut() {
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ConversationListView()
    }
}
