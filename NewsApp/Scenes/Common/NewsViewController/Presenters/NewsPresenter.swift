//
//  Presenter.swift
//  NewsApp
//
//  Created by Oleksandr Semeniuk on 18.01.2022.
//

import Foundation
import UIKit

protocol NewsPresenterProtocol: AnyObject {
    func fetchNews() -> NewsModel
}

final class NewsPresenter: NewsPresenterProtocol {
    
    //    weak var view: (NewsPresenterProtocol & UIViewController)?
    
    //MARK: - Properties
    
    private let networkManager = NetworkManager ()
    private var model = NewsModel.init(items: [])
    private let nesType: EndpointUrl
    
    init( nesType: EndpointUrl) {
        self.nesType = nesType
    }
    
    func fetchNews() -> NewsModel {
        
        guard nesType != .mostFavorite else { return NewsModel.init(items: []) }
        // activityIndicator.startAnimating()
        networkManager.fetchMostNews(nesType: nesType) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.getModel(data: data)
            case .failure(let error):
                //  activityIndicator.stopAnimating()
                print(error)
            }
        }
        return model
    }
    
    func getModel(data: Response) {
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
    }
}
