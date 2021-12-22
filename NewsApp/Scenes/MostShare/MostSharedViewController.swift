//
//  MostSharedViewController.swift
//  NewsApp
//
//  Created by Oleksandr Semeniuk on 15.12.2021.
//

import UIKit

final class MostSharedViewController: UIViewController {

//    var mostSharedTableView = UITableView()
   private var array = ["Stas", "Masha", "Kirill", "Nata"]
    
    @IBOutlet private weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Most Shared"
        
        createTableView()
        setUpButtonFavorite()
    }

    private func createTableView() {
//        mostSharedTableView = UITableView(frame: view.bounds, style: .plain)
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: "NewsTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
      //  tableView.backgroundColor = .gray
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
       
        return array.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "NewsTableViewCell",
            for: indexPath
        ) as? NewsTableViewCell else {
            return UITableViewCell()
        }
        let image: UIImage = UIImage(named: "News")!
        cell.setUpCell(text: array[indexPath.row], image: image)
       
        return cell
    }
}

