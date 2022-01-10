//
//  WebNewsViewController.swift
//  NewsApp
//
//  Created by Oleksandr Semeniuk on 05.01.2022.
//

import UIKit
import WebKit
import CoreData
import SwiftUI

class WebNewsViewController: UIViewController {
    
    let webView = WKWebView()
    let model: WebNewsModel
  //  var news: [SaveNews] = []

    init(model: WebNewsModel) {
        
        self.model = model
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)
        webNews()
    }
    
    func webNews(){
        guard let url = URL(string: model.webUrl) else { return }
        webView.load(URLRequest(url: url))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
        setUpButtonFavorite()
    }
    
    private func setUpButtonFavorite () {
        let favoriteButton = UIBarButtonItem(
            image: UIImage(systemName: "heart.fill"),
            style: .plain,
            target: self,
            action: #selector(action)
        )
        
       // favoriteButton.tintColor = .orange
        navigationItem.rightBarButtonItem = favoriteButton
    }
    
    @objc func action() {
        print("Favorite")
        
         let f = isFavorite(id: model.newsId)
        if f == true{
            saveNews(id: model.newsId, imageUrl: model.imageUrl)
        }
//        saveNews(id: model.newsId, imageUrl: model.imageUrl)
        
    }
    
    private func isFavorite(id: Int) -> Bool {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest : NSFetchRequest<SaveNews> = SaveNews.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "saveId == %@", id)

        do {
               let fetchedResults = try context.fetch(fetchRequest)
               if let aContact = fetchedResults.first {
                 // providerName.text = aContact.providerName
                   
                   return true
               }
           }
           catch {
               print ("fetch task failed", error)
              
           }
        
//        if let savedId = context.existingObject(with: id) {
//            request.predicate = NSPredicate(format: "saveId = %@", id)
//        } else {
//
//        } return false
        return false
    }
    
    private func saveNews(id: Int, imageUrl: String) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        guard let entity = NSEntityDescription.entity(forEntityName: "SaveNews", in: context) else { return }
        
        let newsObject = SaveNews(entity: entity, insertInto: context)
        newsObject.saveId = Int64(id)
        newsObject.saveUrl = imageUrl
        
        do {
         //   news.append(newsObject)
            try context.save()
            
        } catch let error as NSError {
            
            print(error.localizedDescription)
        }
    }
}
