//
//  PostsViewModel.swift
//  DayGoodies
//
//  Created by troquer on 9/29/19.
//  Copyright © 2019 zourz. All rights reserved.
//

import Foundation
import UIKit
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
    
    func favoritePost(with id:Int) -> Void {
        mainView?.favoritePosts.append(id)
    }
}
