//
//  NewsPresenter.swift
//  NewsApp
//
//  Created by Oleksandr Semeniuk on 20.01.2022.
//

import Foundation

final class FavoritePresenter: NewsPresenterProtocol {
    
    var model = NewsModel.init(items: [])
  
    private let coreDataManager = CoreDataManager()
    private let nesType: EndpointUrl
    
    init( nesType: EndpointUrl) {
        self.nesType = nesType
    }
    
    func fetchNews(_ completion: @escaping () -> Void ) {
        
        var news: [SaveNews] = []
        news = coreDataManager.fetchSavedNews(model: news)
        getModel(news: news)
        completion()
    }
}

extension FavoritePresenter {
    
    func getModel(news: [SaveNews]) {
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
