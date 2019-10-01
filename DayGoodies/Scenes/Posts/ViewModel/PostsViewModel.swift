//
//  PostsViewModel.swift
//  DayGoodies
//
//  Created by troquer on 9/29/19.
//  Copyright © 2019 zourz. All rights reserved.
//

import UIKit
import Alamofire
import Combine

class PostsViewModel: ObservableObject {
    
    @Published var arPosts: [Post] = []
    
    var mainView: PostsView?
    
    func favoritePost(post: Post) -> Void {
        var favPost = post
        favPost.isFavorite = true
        if let row = self.arPosts.firstIndex(where: {$0.id == post.id}) {
            self.arPosts[row] = favPost
        }
    }
    
    func readPost(post: Post) -> Void {
        var readPost = post
        readPost.isNew = false
        if let row = self.arPosts.firstIndex(where: {$0.id == post.id}) {
            self.arPosts[row] = readPost
        }
    }
    
    func loadPosts(fetchFromRemote:Bool = true) {
        if fetchFromRemote {
            AF.request(APIRouter.posts).responseDecodable(of: [Post].self) { response in
                switch response.result {
                case .success:
                    guard let loadedPosts = response.value else {
                        return
                    }
                    self.arPosts = loadedPosts
                    self.savePostsOnLocal(postsToSave: loadedPosts)
                case let .failure(error):
                    print(error)
                }
            }
        } else {
            guard let savedPostsString = getPostsFromLocal() else {
                loadPosts()
                return
            }
            guard let savedPostData = savedPostsString.data(using: .utf8) else { loadPosts()
                return
            }

            do {
                // Decode data to object
                let jsonDecoder = JSONDecoder()
                let loadedPosts = try jsonDecoder.decode([Post].self, from: savedPostData)
                self.arPosts = loadedPosts            }
            catch {
                print("Error decoding to Json")
            }
            
        }
    }
    
    func clearPosts() {
        arPosts = []
    }
    
}
