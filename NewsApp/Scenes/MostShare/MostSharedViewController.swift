//
//  MostSharedViewController.swift
//  NewsApp
//
//  Created by Oleksandr Semeniuk on 15.12.2021.
//

import UIKit
import SwiftUI
import Kingfisher

final class MostSharedViewController: UIViewController {

    let networkManager = NetworkManager()
    var model: NewsModel = .init(items: [])
    
    @IBOutlet private weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Most Shared"
        fetchData()
        createTableView()
        setUpButtonFavorite()
    }
    
    //MARK: - private methods
    
    private func fetchData() {
        networkManager.fetchMostNews(nesType: .mostShared) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                let items: [NewsTableViewCellModel] = data.data.compactMap { item in
                    return NewsTableViewCellModel(
                        imageURL: item.media.first?.mediaMetadata.first?.urlImage ?? "" ,
                        title: item.title,
                        date: item.publishedDate,
                        newsSection: item.section,
                        newsText: item.abstract
                    )
                }
                
                self.model = NewsModel(items: items)
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }

    private func createTableView() {
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: "NewsTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
    }
    
    func setUpButtonFavorite () {
        let favoriteButton = UIBarButtonItem(
            image: UIImage(systemName: "heart.fill"),
            style: .plain,
            target: self,
            action: #selector(action)
        )
         navigationItem.rightBarButtonItem = favoriteButton
    }
    
    @objc func action() {
        print("Favorite")
    }
}

extension MostSharedViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.items.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "NewsTableViewCell",
            for: indexPath
        ) as? NewsTableViewCell else {
            return UITableViewCell()
        }
        
        let item = model.items[indexPath.row]
        
//        let url = URL(string: item.imageURL)
//        let image = UIImageView()
//        image.kf.setImage(with: url)
        
//        let image: UIImage = UIImage(named: "News")!
        cell.setUpCell(text: item.newsText,
                       title: item.title,
                       date: item.date,
                       type: item.newsSection,
                       ImageUrl: item.imageURL)
        
        return cell
    }
}

