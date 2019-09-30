//
//  PostsViewModel.swift
//  DayGoodies
//
//  Created by troquer on 9/29/19.
//  Copyright © 2019 zourz. All rights reserved.
//

import UIKit
import Alamofire
import CoreData

class PostsViewModel {
    
    var mainView: PostsView?
    
    func savePost(title:String, content:String) -> Void {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let postsEntity = NSEntityDescription.entity(forEntityName: "Posts", in: context)
        let newPost = NSManagedObject(entity: postsEntity!, insertInto: context)
        newPost.setValue(title, forKey: "title")
        newPost.setValue(content, forKey: "body")
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
    }
    
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
    
    func loadPosts() {
        AF.request(APIRouter.posts).responseDecodable(of: [Post].self) { response in
            switch response.result {
            case .success:
                self.mainView?.arPosts = response.value ?? []
                
            case let .failure(error):
                print(error)
            }
        }
    }
    
    func clearPosts() {
        mainView?.arPosts = []
    }
}
