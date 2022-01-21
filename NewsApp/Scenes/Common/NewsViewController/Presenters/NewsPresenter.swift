//
//  Presenter.swift
//  NewsApp
//
//  Created by Oleksandr Semeniuk on 18.01.2022.
//

import Foundation
import UIKit

protocol NewsPresenterProtocol: AnyObject {
    var model: NewsModel { get }
    
    func fetchNews(_ completion: @escaping () -> Void )
}

final class NewsPresenter: NewsPresenterProtocol {
        
    //MARK: - Properties
    
    var model = NewsModel.init(items: [])
    
    private let networkManager = NetworkManager ()
    private let nesType: EndpointUrl
    
    init( nesType: EndpointUrl) {
        self.nesType = nesType
    }
    
    func fetchNews(_ completion: @escaping () -> Void ) {
        
        networkManager.fetchMostNews(nesType: nesType) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.getModel(data: data)
                completion()

            case .failure(let error):
                print(error)
            }
        }
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
