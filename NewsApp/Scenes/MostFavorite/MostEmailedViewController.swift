//
//  MostFavoriteViewController.swift
//  NewsApp
//
//  Created by Oleksandr Semeniuk on 15.12.2021.
//

import UIKit

final class MostEmailedViewController: UIViewController {
    
    private var array = ["Stas", "Masha Masha Masha Masha MashaMasha Masha Masha Masha MashaMasha Masha Masha Masha MashaMasha Masha Masha Masha MashaMasha Masha Masha Masha MashaMasha Masha Masha Masha MashaMasha Masha Masha Masha MashaMasha Masha Masha Masha MashaMasha Masha Masha Masha MashaMasha Masha Masha Masha MashaMasha Masha Masha Masha MashaMasha Masha Masha Masha MashaMasha Masha Masha Masha MashaMasha Masha Masha Masha MashaMasha Masha Masha Masha MashaMasha Masha Masha Masha Masha", "Kirill", "Nata"]
    let typeText = UIView()
    let url = "emailed/{30}"
    var it = [Welcome] ()
   // items = Welcome.data.byline
let networkManager = NetworkManager()
    
    @IBOutlet private weak var tableView: UITableView! 
    
    override func viewDidLoad() {
        super.viewDidLoad()
      //  self.it.append()
       // self.items = data.byline
        //self.tableView.reloadData()
        navigationItem.title = "Most Emailed"
        createTableView()
        setUpButtonFavorite()
        networkManager.req()
    }
   
    private func createTableView() {
        guard let tableView = tableView else { return }
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: "NewsTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
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
    
//    func fetchMostEmailed(urlM: String) -> Model: Codable{
//       
//        
//    }
}

extension MostEmailedViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
           return self.array.count
       }
       
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return 1
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
        
        let image: UIImage = UIImage(named: "News")!
        cell.setUpCell(text: array[indexPath.section],
                       image: image,
                       title: "TITLE",
                       date: "Date",
                       type: "Type")
        
        return cell
    }
}
