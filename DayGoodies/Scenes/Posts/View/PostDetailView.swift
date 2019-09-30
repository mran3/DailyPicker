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
        NavigationView {
            VStack(alignment: .leading) {
                Text(post.body)
                Spacer()
                Text("User").bold()
                Text("Name")
                Text("Email")
                Text("Phone")
                Text("Website")
                Spacer()
            }
        }
        .navigationBarTitle(Text("Description"))
        .navigationBarItems(trailing:
            Button(action: self.addToFavorites) {
                Text("Favorite")
        })
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Added to favorites"), message: Text("You can find this post on your favorites"), dismissButton: .default(Text("Got it!")))
        }
    
        
    }
    
    private func addToFavorites() {
        self.showingAlert = true
        self.viewModel?.favoritePost(with: self.post.id)
    }
}

struct PostDetail_Previews: PreviewProvider {
    static var previews: some View {
        PostDetailView(post: Post(userId: 1, id: 1, title: "Test title", body: "Test body"))
    }
}

