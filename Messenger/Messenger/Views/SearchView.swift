//
//  SearchView.swift
//  Messenger
//
//  Created by Shoaib Laghari on 11/6/21.
//

import SwiftUI

struct SearchView: View {
    @State var text: String = ""
    let usernames = ["Julia"]
    
//    IN PROGRESS

//    let completion: ((String) -> Void)
//
//    init(completion: @escaping ((String) -> Void)) {
//        self.completion = completion
//    }
    
    var body: some View {
        VStack {
            TextField("Username...", text: $text)
                .modifier(CustomField())
            
            Button("Search") {
                
            }
            
            List {
                ForEach(usernames, id: \.self) { name in
                    HStack {
                        Circle()
                            .frame(width: 55, height: 55)
                            .foregroundColor(Color.green)
                        
                        Text(name)
                            .font(.system(size: 24))
                        
                        Spacer()
                    }
//                    .onTapGesture {
//                        completion(name)
//                    }
                }
            }
            
            Spacer()
        }
        .navigationTitle("Search")
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
