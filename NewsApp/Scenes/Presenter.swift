//
//  Presenter.swift
//  NewsApp
//
//  Created by Oleksandr Semeniuk on 18.01.2022.
//

import Foundation
import UIKit

class Presenter: UIViewController {
    
    //MARK: - Properties
    
    private let networkManager = NetworkManager ()
    private var model = NewsModel.init(items: [])
    private let coreDataManager = CoreDataManager()
     
    //MARK: - Private methods
    
    public func fetchNews(nesType: EndpointUrl, activityIndicator: UIActivityIndicatorView) -> NewsModel {
        if nesType == .mostFavorite {
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
          //  tableView.reloadData()
        } else {
            model = fetchData(nesType: nesType,
                              activityIndicator: activityIndicator)
        }
        return model
    }
    
    public func fetchData(nesType: EndpointUrl, activityIndicator: UIActivityIndicatorView) -> NewsModel {
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
              //  tableView.reloadData()
            case .failure(let error):
                self.showErrorAlertWith(error.localizedDescription)
                activityIndicator.stopAnimating()
                print(error)
            }
        }
        return model
        
    }
    
    public func showErrorAlertWith(_ message: String) {
        let alert = UIAlertController(
            title: "Ups.. Error!",
            message: message,
            preferredStyle: .alert)
        
        alert.addAction(
            UIAlertAction(
                title: "OK",
                style: UIAlertAction.Style.cancel,
                handler: nil
            )
        )
        
        self.present(alert, animated: true, completion: nil)
    }
}
