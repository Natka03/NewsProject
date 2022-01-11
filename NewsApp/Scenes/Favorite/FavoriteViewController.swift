//
//  FavoriteViewController.swift
//  NewsApp
//
//  Created by Oleksandr Semeniuk on 04.01.2022.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    var news: [SaveNews] = []
    private let coreDataManager = CoreDataManager()
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: "NewsTableViewCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    //MARK: - LifeCycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        news = coreDataManager.fetchReguest(model: news)
        
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Favorite"
        createTableView()
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

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
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

