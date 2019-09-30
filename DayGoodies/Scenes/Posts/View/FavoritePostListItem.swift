//
//  FavoritePostListItem.swift
//  DayGoodies
//
//  Created by troquer on 9/30/19.
//  Copyright © 2019 zourz. All rights reserved.
//

import SwiftUI

struct FavoritePostListItem: View {
    let post: Post
    var viewModel: PostsViewModel
    
    var body: some View {
        NavigationLink(destination: PostDetailView(post: self.post, viewModel: self.viewModel)) {
            Text(post.title)
        }
    }
}
