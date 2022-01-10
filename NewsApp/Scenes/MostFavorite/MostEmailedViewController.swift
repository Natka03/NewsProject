//
//  MostFavoriteViewController.swift
//  NewsApp
//
//  Created by Oleksandr Semeniuk on 15.12.2021.
//

import UIKit
import Kingfisher
import CoreData

final class MostEmailedViewController: UIViewController {
    
    let networkManager = NetworkManager()
    var model: NewsModel = .init(items: [])
    var someLink: String = ""
    var id: Int = 0
   // var news: [SaveNews] = []
    
    @IBOutlet private weak var tableView: UITableView!
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Most Emailed"
        fetchData()
        createTableView()
        
    }
    
    //MARK: - private methods
    
    private func fetchData() {
        networkManager.fetchMostNews(nesType: .mostEmailed) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                let items: [NewsTableViewCellModel] = data.data.compactMap { item in
                    return NewsTableViewCellModel(
                        imageURL: item.media.first?.mediaMetadata.first?.urlImage ?? "",
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
        guard let tableView = tableView else { return }
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: "NewsTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
    }
    
    private func saveNews(id: Int){
        
    }
}

extension MostEmailedViewController: UITableViewDelegate, UITableViewDataSource {
    
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
        
        
        cell.setUpCell(text: item.newsText,
                       title: item.title,
                       date: item.date,
                       type: item.newsSection,
                       ImageUrl: item.imageURL)

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
//        self.someLink = model.items[indexPath.row].url
//        self.id = model.items[indexPath.row].id
        let item = model.items[indexPath.row]

        
        let vc = WebNewsViewController(
            model: WebNewsModel(
                webUrl: item.url,
                newsId: item.id,
                imageUrl: item.imageURL
            )
        )
        vc.hidesBottomBarWhenPushed = true
       navigationController?.pushViewController(vc, animated: true)
        
    }
    
}
