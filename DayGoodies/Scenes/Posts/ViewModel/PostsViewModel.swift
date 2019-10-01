//
//  PostsViewModel.swift
//  DayGoodies
//
//  Created by troquer on 9/29/19.
//  Copyright © 2019 zourz. All rights reserved.
//

import UIKit
import Alamofire

class PostsViewModel {
    
    var mainView: PostsView?
    
//    func savePost(title:String, content:String) -> Void {
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let context = appDelegate.persistentContainer.viewContext
//        let postsEntity = NSEntityDescription.entity(forEntityName: "Posts", in: context)
//        let newPost = NSManagedObject(entity: postsEntity!, insertInto: context)
//        newPost.setValue(title, forKey: "title")
//        newPost.setValue(content, forKey: "body")
//        do {
//            try context.save()
//        } catch {
//            print("Failed saving")
//        }
//    }
    
    func favoritePost(post: Post) -> Void {
        var favPost = post
        favPost.isFavorite = true
        if let row = mainView?.arPosts.firstIndex(where: {$0.id == post.id}) {
            mainView?.arPosts[row] = favPost
        }
    }
    
    func readPost(post: Post) -> Void {
        var readPost = post
        readPost.isNew = false
        if let row = mainView?.arPosts.firstIndex(where: {$0.id == post.id}) {
            mainView?.arPosts[row] = readPost
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
                    self.mainView?.arPosts = loadedPosts
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
                self.mainView?.arPosts = loadedPosts
            }
            catch {
            }
            
        }
        
    }
    
    func clearPosts() {
        mainView?.arPosts = []
    }
    
    
    
}
