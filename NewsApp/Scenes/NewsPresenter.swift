//
//  NewsPresenter.swift
//  NewsApp
//
//  Created by Oleksandr Semeniuk on 20.01.2022.
//

import Foundation

class NewsPresenter {
    
    private var model = NewsModel.init(items: [])
    private let coreDataManager = CoreDataManager()
   
    private func fetchFavoriteNews() {
        var news: [SaveNews] = []
        news = coreDataManager.fetchSavedNews(model: news)
        
        let items: [NewsTableViewCellModel] = news.compactMap { item in
            return NewsTableViewCellModel(
                imageURL: item.image ?? "",
                title: item.title ?? "",
                date: item.date ?? "",
                newsSection: item.section ?? "",
                newsText: item.text ?? "",
                url: item.url ?? "",
                id: Int(item.id)
            )
        }
        
        self.model = NewsModel(items: items)
    }
    
}
