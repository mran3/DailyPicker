//
//  PostListItem.swift
//  DayGoodies
//
//  Created by troquer on 9/30/19.
//  Copyright © 2019 zourz. All rights reserved.
//

import SwiftUI

struct PostListItem: View {
    let post: Post
    var viewModel: PostsViewModel
    
    var body: some View {
        NavigationLink(destination: PostDetailView(post: self.post, viewModel: self.viewModel)) {
            if (post.id < 20 && post.isNew.map { $0 } ?? true) {
                Image("dot_blue")
                    .resizable()
                    .frame(width: 14, height: 14)
            }
            Text(post.title)
            if (post.isFavorite.map { $0 } ?? false) { // post.isFavorite is an Optional, so being inside a SwiftUI view we have to unwrap it this way.
                Image("star")
                    .resizable()
                    .frame(width: 18, height: 18)
            }
        }
    }
}
