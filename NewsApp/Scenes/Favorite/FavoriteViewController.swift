//
//  FavoriteViewController.swift
//  NewsApp
//
//  Created by Oleksandr Semeniuk on 04.01.2022.
//

import UIKit
import CoreData

class FavoriteViewController: UIViewController {
    
    let arr = ["sadwed", "dadeg", "efwfwwfe"]
    var news: [SaveNews] = []

    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: "NewsTableViewCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchReguest: NSFetchRequest<SaveNews> = SaveNews.fetchRequest()
        
        do {
            news = try context.fetch(fetchReguest)
        } catch let error as NSError {
            
            print(error.localizedDescription)
        }
        self.tableView.reloadData()

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Favorite"
        createTableView()
        setUpButtonFavorite()
    }
    
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
    
    private func setUpButtonFavorite () {
        let favoriteButton = UIBarButtonItem(
            image: UIImage(systemName: "heart.fill"),
            style: .plain,
            target: self,
            action: #selector(action)
        )
        
       // favoriteButton.tintColor = .orange
        navigationItem.rightBarButtonItem = favoriteButton
    }
    
    @objc func action() {
        print("Favorite")
        
       // saveNews(id: model.newsId, imageUrl: model.imageUrl)
        deleteNews()
    }
    
    private func deleteNews() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchReguest: NSFetchRequest<SaveNews> = SaveNews.fetchRequest()

        if let news = try? context.fetch(fetchReguest) {
            for new in news {
                context.delete(new)
            }
        }
        
        do {
         //   news.append(newsObject)
            try context.save()
            
        } catch let error as NSError {
            
            print(error.localizedDescription)
        }
        self.tableView.reloadData()

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

        cell.setUpCell(text: String(item.saveId),
                       title: "TITLE",
                       date: "DATE",
                       type: "TYPE",
                       ImageUrl: item.saveUrl ?? "")
       
        return cell
    }
}

