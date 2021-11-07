//
//  AppStateModel.swift
//  Messenger
//
//  Created by Shoaib Laghari on 11/6/21.
//

import Foundation
import SwiftUI

import FirebaseAuth
import FirebaseFirestore

class AppStateModel: ObservableObject {
    @AppStorage("currentUsername") var currentUsername: String = ""
    @AppStorage("currentEmail") var currentEmail: String = ""
    
    @Published var showingSignIn: Bool
    @Published var conversations: [String] = []
    @Published var messages: [Message] = []
    
    let database = Firestore.firestore()
    let auth = Auth.auth()
    
    var otherUsername = ""
    var riddikulusIsOn: Bool = false
    var riddikulusCount: Int = 0
    
    var conversationListener: ListenerRegistration?
    var chatListener: ListenerRegistration?
    
    init() {
        self.showingSignIn = Auth.auth().currentUser == nil
    }
}

// search

extension AppStateModel {
    func searchUsers(queryText: String, completion: @escaping ([String]) -> Void) {
        database.collection("users").getDocuments{ snapshot, error in
            guard let usernames = snapshot?.documents.compactMap({ $0.documentID }), error == nil else {
                completion([])
                return
            }
            
            let filtered = usernames.filter({
                $0.lowercased().hasPrefix(queryText.lowercased())
            })
            completion(filtered)
        }
    }
}

// get conversations

extension AppStateModel {
    func getConversations() {
        // listen for conversations
        conversationListener = database
            .collection("users")
            .document(currentUsername)
            .collection("chats")
            .addSnapshotListener{ [weak self] snapshot, error in
                guard let usernames = snapshot?.documents.compactMap({ $0.documentID }), error ==  nil else {
                    return
                }
                
                // things that update the UI (e.g. published properties) need to be done on main thread to not block other events in event queue
                DispatchQueue.main.async {
                    self?.conversations = usernames
                }
            }
    }
}

// get chat and send messages

extension AppStateModel {
    func observeChat() {
        createConversation()
        
        // listen for chat messages in given conversation
        chatListener = database
            .collection("users")
            .document(currentUsername)
            .collection("chats")
            .document(otherUsername)
            .collection("messages")
            .addSnapshotListener{ [weak self] snapshot, error in
                guard let objects = snapshot?.documents.compactMap({ $0.data() }), error ==  nil else {
                    return
                }
                
                let messages: [Message] = objects.compactMap({
                    guard let date = ISO8601DateFormatter().date(from: $0["created"] as? String ?? "") else {
                        return nil
                    }
                    
                    return Message(
                        text: $0["text"] as? String ?? "",
                        type: $0["sender"] as? String == self?.currentUsername ? .sent : .received,
                        created: date
                    )
                })
                .sorted(by: { first, second in
                    return first.created < second.created
                })
                
                DispatchQueue.main.async {
                    self?.messages = messages
                }
            }
    }
    
    func sendMessage(_ text: String) {
        let newMessageId = UUID().uuidString
        
        var tempText = text
        
        if (riddikulusIsOn) {
            tempText = riddikulus(tempText)
        }
        
        let data = [
            "text": tempText,
            "sender": currentUsername,
            "created": ISO8601DateFormatter().string(from: Date())
        ]
        
        database
            .collection("users")
            .document(currentUsername)
            .collection("chats")
            .document(otherUsername)
            .collection("messages")
            .document(newMessageId)
            .setData(data)
        
        database
            .collection("users")
            .document(currentUsername)
            .collection("chats")
            .document(otherUsername)
            .collection("messages")
            .document(newMessageId)
        
        database
            .collection("users")
            .document(otherUsername)
            .collection("chats")
            .document(currentUsername)
            .collection("messages")
            .document(newMessageId)
            .setData(data)
    }
    
    func createConversation() {
        database
            .collection("users")
            .document(currentUsername)
            .collection("chats")
            .document(otherUsername)
            .setData([
                "created": true
            ])
        
        database
            .collection("users")
            .document(otherUsername)
            .collection("chats")
            .document(currentUsername)
            .setData([
                "created": true
            ])
    }
    
    func riddikulus(_ text: String) -> String {
        if riddikulusCount == 0 {
            return text.uppercased()
        } else if riddikulusCount == 1 {
            return "IMPORTANT: " + text + "!!!!!!!!"
        } else {
            return "🤪😵‍💫🤡 " + text + " 😭😢😭😪😭"
        }
    }
}

// sign in and sign up

extension AppStateModel {
    func signIn(_ username: String, _ password: String) {
        // get email from database
        database.collection("users").document(username).getDocument { [weak self] snapshot, error in
            guard let email = snapshot?.data()?["email"] as? String, error == nil else {
                return
            }
            
            // try to sign in
            self?.auth.signIn(withEmail: email, password: password, completion: { result, error in
                guard error == nil, result != nil else {
                    return
                }
                
                DispatchQueue.main.async {
                    self?.currentEmail = email
                    self?.currentUsername = username
                    self?.showingSignIn = false
                }
            })
        }
        
    }
    
    func signUp (_ email: String, _ username: String, _ password: String) {
        // create an account
        auth.createUser(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil else {
                return
            }
            
            // insert username into database
            let data = [
                "email": email,
                "username": username
            ]
            
            self?.database
                .collection("users")
                .document(username)
                .setData(data) { error in
                    guard error == nil else {
                        return
                    }
                    
                    DispatchQueue.main.async {
                        self?.currentUsername = username
                        self?.currentEmail = email
                        self?.showingSignIn = false
                    }
                }
        }
    }
    
    func signOut() {
        do {
            try auth.signOut()
            self.showingSignIn = true
        } catch {
            print(error)
        }
    }
}
