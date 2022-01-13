//
//  FavoriteViewController.swift
//  NewsApp
//
//  Created by Oleksandr Semeniuk on 04.01.2022.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    //MARK: - Properties

    var news: [SaveNews] = []
    private let coreDataManager = CoreDataManager()
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(NewsTableViewCell.self,
                           forCellReuseIdentifier: String(describing: NewsTableViewCell.self))
        tableView.translatesAutoresizingMaskIntoConstraints = false

        return tableView
    }()
    
    //MARK: - LifeCycle
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = Constsnt.navBarTitle
        createTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        news = coreDataManager.fetchReguestSaveNews(model: news)
        
        self.tableView.reloadData()
    }
    
    //MARK: - private methods

    private func createTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    } 
}

//MARK: - TableViewDelegate, TableViewDataSource

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
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
        
        let item = news[indexPath.row]
        
        cell.setUpCell(text: item.savedText ?? "",
                       title: item.savedTitle ?? "",
                       date: item.savedDate ?? "",
                       type: item.savedSection ?? "",
                       ImageUrl: item.savedImage ?? "")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = news[indexPath.row]
        
        let vc = WebNewsViewController(
            model: WebNewsModel(
                webUrl: item.saveUrl ?? "",
                newsId: Int(item.saveId),
                imageUrl: item.savedImage ?? "",
                title: item.savedTitle ?? "",
                date: item.savedDate ?? "",
                newsSection: item.savedSection ?? "",
                newsText: item.savedText ?? ""
            )
        )
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Constants

extension FavoriteViewController {
    private enum Constsnt {
       static let navBarTitle = "Favorite"
        static let tableViewHeightForRowAt: CGFloat = 200
    }
}

