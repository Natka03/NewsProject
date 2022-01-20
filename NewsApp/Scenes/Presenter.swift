//
//  Presenter.swift
//  NewsApp
//
//  Created by Oleksandr Semeniuk on 18.01.2022.
//

import Foundation
import UIKit

class Presenter {
    
    //MARK: - Properties
    
    private let networkManager = NetworkManager ()
    private var model = NewsModel.init(items: [])
    private let coreDataManager = CoreDataManager()
     
    //MARK: - Public methods
    
    public func fetchNews(nesType: EndpointUrl, activityIndicator: UIActivityIndicatorView) -> NewsModel {
        if nesType == .mostFavorite {
            fetchFavoriteNews()
        } else {
            fetchMostNews(nesType: nesType,
                      activityIndicator: activityIndicator)
        }
        return model
    }
  
    //MARK: - Public methods

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
    
    private func fetchMostNews(nesType: EndpointUrl, activityIndicator: UIActivityIndicatorView)  {
        activityIndicator.startAnimating()
        networkManager.fetchMostNews(nesType: nesType) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                let items: [NewsTableViewCellModel] = data.data.compactMap { item in
                    return NewsTableViewCellModel(
                        imageURL: item.media.first?.mediaMetadata.first?.urlImage ?? "" ,
                        title: item.title,
                        date: item.publishedDate,
                        newsSection: item.section,
                        newsText: item.abstract,
                        url: item.url,
                        id: item.id
                    )
                }
                
                self.model = NewsModel(items: items)
                
                activityIndicator.stopAnimating()
            case .failure(let error):
                activityIndicator.stopAnimating()
                print(error)
            }
        }
    }
}
