//
//  FavoriteViewController.swift
//  NewsApp
//
//  Created by Oleksandr Semeniuk on 04.01.2022.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    let arr = ["sadwed", "dadeg", "efwfwwfe"]
    var model: NewsModel = .init(items: [])

    init(model: [NewsTableViewCellModel]) {
        
        self.model.items = model
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: "NewsTableViewCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Favorite"
        createTableView()
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

}

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
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

//        let item = model.items[indexPath.row]
//
//        cell.setUpCell(text: item.newsText,
//                       title: item.title,
//                       date: item.date,
//                       type: item.newsSection,
//                       ImageUrl: item.imageURL)
        
       // let cell = "sdadaw"
//        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath)
//
        let arr = arr[indexPath.row]
        cell.textLabel?.text = arr
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        self.someLink = model.items[indexPath.row].url
//        let vc = WebNewsViewController(
//            model: WebNewsModel(
//                webUrl: someLink
//            )
//        )
//        vc.hidesBottomBarWhenPushed = true
//       navigationController?.pushViewController(vc, animated: true)
//
//    }
}

