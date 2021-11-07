//
//  SearchView.swift
//  Messenger
//
//  Created by Shoaib Laghari on 11/6/21.
//

import SwiftUI

struct SearchView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var model: AppStateModel
    @State var text: String = ""
    @State var usernames: [String] = []

    let completion: ((String) -> Void)

    init(completion: @escaping ((String) -> Void)) {
        self.completion = completion
    }
    
    var body: some View {
        VStack {
            TextField("Username...", text: $text)
                .modifier(CustomField())
            
            Button("Search") {
                guard !text.trimmingCharacters(in: .whitespaces).isEmpty else {
                    return
                }
                
                model.searchUsers(queryText: text) { usernames in
                    self.usernames = usernames
                }
            }
            
            List {
                ForEach(usernames, id: \.self) { name in
                    HStack {
                        Image(model.currentUsername == "Matt" ? "photo1" : "photo2")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 45, height: 45)
                            .foregroundColor(Color.green)
                            .clipShape(Circle())

                        Text(name)
                            .font(.system(size: 24))
                        
                        Spacer()
                    }
                    .onTapGesture {
                        presentationMode.wrappedValue.dismiss()
                        completion(name)
                    }
                }
            }
            
            Spacer()
        }
        .navigationTitle("Search")
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView() {_ in}
    }
}
