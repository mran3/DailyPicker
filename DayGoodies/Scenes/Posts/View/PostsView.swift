//
//  ContentView.swift
//  DayGoodies
//
//  Created by troquer on 9/29/19.
//  Copyright © 2019 zourz. All rights reserved.
//

import SwiftUI
import Alamofire


struct PostsView: View {
    @State private var selectorIndex = 0
    @State var arPosts: [Post] = []
    @State var readPosts: [Int] = []
    @State var favoritePosts: [Int] = []
    @State var postToShow: [Post] = []
    var viewModel = PostsViewModel()
    
    var body: some View {
      NavigationView {
        VStack {
        Picker("Numbers", selection: $selectorIndex) {
            Text("Posts").tag(0)
            Text("Favorites").tag(1)
        }
        .pickerStyle(SegmentedPickerStyle())
        
        
        List {
            ForEach(arPosts) { post in
                if self.selectorIndex == 1 && self.favoritePosts.contains(post.id) {
                    NavigationLink(destination: PostDetailView(post: post, viewModel: self.viewModel)) {
                        if (post.id < 20){
                            Image("dot_blue")
                            .resizable()
                            .frame(width: 14, height: 14)
                        }
                        
                        Text(post.title)
                        
                        Image("star")
                        .resizable()
                        .frame(width: 18, height: 18)
                        
                    }
                    
                    self.postToShow = self.arPosts.filter{ self.favoritePosts.contains($0.id) }
                } else if self.selectorIndex == 0 {
                    NavigationLink(destination: PostDetailView(post: post, viewModel: self.viewModel)) {
                        if (post.id < 20){
                            Image("dot_blue")
                            .resizable()
                            .frame(width: 14, height: 14)
                        }
                        
                        Text(post.title)
                        
                        if (self.favoritePosts.contains(post.id)) {
                            Image("star")
                            .resizable()
                            .frame(width: 18, height: 18)
                        }
                    }
                }
                
                
            }.onDelete(perform: deletePost)
            
        }.navigationBarTitle(Text("Posts"))
        }
        .onAppear(perform: {
            self.loadPosts()
            self.viewModel.mainView = self
        })
        }
    }

    private func deletePost(at offsets: IndexSet) {
        arPosts.remove(atOffsets: offsets)
    }
    
    private func loadPosts() {
        AF.request(APIRouter.posts).responseDecodable(of: [Post].self) { response in
            switch response.result {
                case .success:
                    self.arPosts = response.value ?? []
                    
                     
                case let .failure(error):
                    print(error)
            }
        }
    }

}


struct Posts_Previews: PreviewProvider {
    static var previews: some View {
        PostsView()
    }
}
