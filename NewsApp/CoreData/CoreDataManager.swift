//
//  CoreDataManager.swift
//  NewsApp
//
//  Created by Oleksandr Semeniuk on 11.01.2022.
//

import UIKit
import CoreData

final class CoreDataManager {
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate //подумать над форс анврапом
    private let context: NSManagedObjectContext
    
    init() {
        self.context = appDelegate.persistentContainer.viewContext
    }
    
    public func isFavorite(id: Int) -> Bool {
        
        var isFavorite: Bool = false
        
        do {
            let fetchRequest : NSFetchRequest<SaveNews> = SaveNews.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "saveId == %ld", id)
            
            let fetchedResults = try context.fetch(fetchRequest)
            
            if let _ = fetchedResults.first {
                isFavorite = true
            }
        }
        catch {
            isFavorite = false
            print ("fetch task failed", error)
        }
        //может ли функция выдать ретерн раньше ду кетч блока?
        return isFavorite
    }
    
    public func saveNews(model: WebNewsModel) {
        
        guard let entity = NSEntityDescription.entity(forEntityName: "SaveNews", in: context) else { return }
        
        let newsObject = SaveNews(entity: entity, insertInto: context)
        
        newsObject.saveId = Int64(model.newsId)
        newsObject.saveUrl = model.webUrl
        newsObject.savedDate = model.date
        newsObject.savedText = model.newsText
        newsObject.savedImage = model.imageUrl
        newsObject.savedTitle = model.title
        newsObject.savedSection = model.newsSection
        
        do {
            try context.save()
            
        } catch let error as NSError {
            
            print(error.localizedDescription)
        }
    }
    
    public func deleteNews(id: Int) {
        
        let fetchRequest : NSFetchRequest<SaveNews> = SaveNews.fetchRequest()

        fetchRequest.predicate = NSPredicate(format: "saveId == %ld", id)

        do {
            
            let fetchedResults = try context.fetch(fetchRequest)
            
            if let _ = fetchedResults.first {
                context.delete(fetchedResults[0])
            }
        }catch let error as NSError {
            
            print(error.localizedDescription)
        }
       
        do {
            try context.save()
            
        } catch let error as NSError {
            
            print(error.localizedDescription)
        }
    }
    
    public func fetchReguest(model: [SaveNews] ) -> [SaveNews] {
        
        let fetchReguest: NSFetchRequest<SaveNews> = SaveNews.fetchRequest()
        var modelNews = model
        do {
            modelNews = try context.fetch(fetchReguest)
            
        } catch let error as NSError {
            
            print(error.localizedDescription)
        }
        return modelNews
    }
}
