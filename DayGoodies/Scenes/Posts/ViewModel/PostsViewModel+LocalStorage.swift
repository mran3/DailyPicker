//
//  PostsViewModel+LocalStorage.swift
//  DayGoodies
//
//  Created by troquer on 9/30/19.
//  Copyright © 2019 zourz. All rights reserved.
//
import UIKit
import CoreData

extension PostsViewModel {
    
    func savePostsOnLocal(postsToSave: [Post]) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        guard let postsEntity = NSEntityDescription.entity(forEntityName: "Posts", in: managedContext) else { return }
        let posts = NSManagedObject(entity: postsEntity, insertInto: managedContext)
        posts.setValue(JSONEncoder().toJsonString(postsToSave), forKeyPath: "content")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func getPostsFromLocal() -> String? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Posts")
        fetchRequest.fetchLimit = 1
        
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                guard let stringContent = data.value(forKey: "content") as? String else { return nil }
                return stringContent
            }
        } catch {
            print("Failed getting local posts")
        }
        return nil
        
    }
    
    private func deleteLocalPosts() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Posts")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        
        do {
            try managedContext.execute(deleteRequest)
            try managedContext.save()
        } catch {
            print ("There was an error deleting posts")
        }
    }
    
}
