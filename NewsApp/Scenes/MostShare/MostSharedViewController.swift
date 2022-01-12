//
//  MostSharedViewController.swift
//  NewsApp
//
//  Created by Oleksandr Semeniuk on 15.12.2021.
//

import UIKit
import SwiftUI

final class MostSharedViewController: UIViewController {
    
    //MARK: - Properties

    let networkManager = NetworkManager()
    var model: NewsModel = .init(items: [])
    
    //MARK: - IBOutlets

    @IBOutlet private weak var tableView: UITableView!

    //MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .cyan
        navigationItem.title = Constsnt.navBarTitle
        fetchData()
        createTableView()
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
                        newsText: item.abstract,
                        url: item.url,
                        id: item.id
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
        tableView.register(NewsTableViewCell.self,
                           forCellReuseIdentifier: String(describing: NewsTableViewCell.self))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
    }
}

//MARK: - TableViewDelegate, TableViewDataSource

extension MostSharedViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.items.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constsnt.tableViewHeightForRowAt
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: NewsTableViewCell.self),
            for: indexPath
        ) as? NewsTableViewCell else {
            return UITableViewCell()
        }
        
        let item = model.items[indexPath.row]
       
        cell.setUpCell(text: item.newsText,
                       title: item.title,
                       date: item.date,
                       type: item.newsSection,
                       ImageUrl: item.imageURL)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = model.items[indexPath.row]

        let vc = WebNewsViewController(
            model: WebNewsModel(
                webUrl: item.url,
                newsId: item.id,
                imageUrl: item.imageURL,
                title: item.title,
                date: item.date,
                newsSection: item.newsSection,
                newsText: item.newsText
            )
        )
        vc.hidesBottomBarWhenPushed = true
       navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Constants

extension MostSharedViewController {
    private enum Constsnt {
       static let navBarTitle = "Most Shared"
        static let tableViewHeightForRowAt: CGFloat = 200
    }
}

