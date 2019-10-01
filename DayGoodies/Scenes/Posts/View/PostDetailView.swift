//
//  ContentView.swift
//  DayGoodies
//
//  Created by troquer on 9/29/19.
//  Copyright © 2019 zourz. All rights reserved.
//

import SwiftUI
import Alamofire


struct PostDetailView: View {
    var post: Post
    var viewModel: PostsViewModel?
    @State private var showingAlert = false
    var body: some View {
        Group {
            VStack(alignment: .leading, spacing: 20) {
                    Text(post.body)
                    Spacer()
                    Divider()
                    Spacer()
                    Text("User").bold().font(.system(size: 30)).padding(.bottom, 20)
                    Text("Name: Andres Acevedo")
                    Text("Email: andacecha@yahoo.com")
                    Text("Phone: 123-456-789")
                    Text("Website: twitter.com/mran3")
                        .padding(.bottom, 40)
                    
                }.padding()
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Added to favorites"), message: Text("You can find this post on your favorites"), dismissButton: .default(Text("Got it!")))
            }
        }.navigationBarItems(trailing:
            Button(action: self.addToFavorites) {
                Text("Favorite")
        }).navigationBarTitle(Text(post.body))
        
    .onAppear(perform: {
    self.viewModel?.readPost(post: self.post)
    })
    
}

private func addToFavorites() {
    self.showingAlert = true
    self.viewModel?.favoritePost(post: post)
}
}

struct PostDetail_Previews: PreviewProvider {
    static var previews: some View {
        PostDetailView(post: Post(userId: 1, id: 1, title: "Test title", body: "Test body", isFavorite: true))
    }
}

