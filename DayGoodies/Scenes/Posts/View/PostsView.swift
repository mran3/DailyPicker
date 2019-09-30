//
//  ContentView.swift
//  DayGoodies
//
//  Created by troquer on 9/29/19.
//  Copyright © 2019 zourz. All rights reserved.
//

import SwiftUI

struct PostsView: View {
    @State private var selectorIndex = 0
    @State var arPosts: [Post] = []
    @State var readPosts: [Int] = []
    @State var favoritePosts: [Int] = []
    var viewModel = PostsViewModel()
    
    var body: some View {
        VStack {
            NavigationView {
                VStack {
                    Picker("Numbers", selection: $selectorIndex) {
                        Text("Posts").tag(0)
                        Text("Favorites").tag(1)
                    }.pickerStyle(SegmentedPickerStyle())
                    
                    List {
                        ForEach(arPosts) { post in
                            if(self.selectorIndex == 0) {
                                PostListItem(post: post, viewModel: self.viewModel)
                            } else if (self.selectorIndex == 1 && (post.isFavorite.map { $0 } ?? false)) {
                                FavoritePostListItem(post: post, viewModel: self.viewModel)
                            } else {
                                EmptyView()
                            }
                        }.onDelete(perform: deletePost)
                    }
                    
                    Button(action: self.clearPosts) {
                        Spacer()
                        Text("Erase Posts").foregroundColor(Color.white).padding()
                        Spacer()
                    }.background(Color.red)
                }.navigationBarTitle(Text("Posts"))
                .navigationBarItems(trailing:
                    Button(action: self.viewModel.loadPosts) {
                        Text("Reload")
                })
            }
        }
    }
    
    init() {
        self.viewModel.loadPosts()
        self.viewModel.mainView = self
    }
    
    private func clearPosts() {
        self.viewModel.clearPosts()
    }
    private func deletePost(at offsets: IndexSet) {
        arPosts.remove(atOffsets: offsets)
    }

}



struct Posts_Previews: PreviewProvider {
    static var previews: some View {
        PostsView()
    }
}
