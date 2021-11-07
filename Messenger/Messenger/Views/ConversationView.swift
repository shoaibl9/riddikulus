//
//  ContentView.swift
//  Messenger
//
//  Created by Shoaib Laghari on 11/6/21.
//

import SwiftUI

struct ConversationListView: View {
    @EnvironmentObject var model: AppStateModel
    @State var otherUsername: String = ""
    @State var showChat = false
    @State var showSearch = false
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                ForEach(model.conversations, id: \.self) { name in
                    NavigationLink(destination: ChatView(otherUsername: name), label: {
                        HStack {
                            Image(model.currentUsername == "Matt" ? "photo1" : "photo2")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 65, height: 65)
                                .foregroundColor(Color.pink)
                                .clipShape(Circle())
                            Text(name)
                                .bold()
                                .font(.system(size: 32))
                                .foregroundColor(Color(.label))
                            Spacer()
                        }
                        .padding()
                    })
                }
                
                if !otherUsername.isEmpty {
                    NavigationLink("", destination: ChatView(otherUsername: otherUsername), isActive: $showChat)
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
                    NavigationLink(
                        destination: SearchView { name in
                            self.showSearch = false
                            DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                                self.showChat = true
                                self.otherUsername = name
                            }
                        },
                        isActive: $showSearch,
                        label: {
                        Image(systemName: "magnifyingglass")
                    })
                })
            }
            .fullScreenCover(isPresented: $model.showingSignIn) {
                SignInView()
            }
            .onAppear{
                guard model.auth.currentUser != nil else {
                    return
                }
                
                model.getConversations()
            }
        }
    }
    
    func signOut() {
        model.signOut()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ConversationListView()
            .environmentObject(AppStateModel())
    }
}
