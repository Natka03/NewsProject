//
//  MostFavoriteViewController.swift
//  NewsApp
//
//  Created by Oleksandr Semeniuk on 15.12.2021.
//

import UIKit

final class MostEmailedViewController: UIViewController {
    
    //var mostEmailedTableView = UITableView()
    private var array = ["Stas", "Masha Masha Masha Masha MashaMasha Masha Masha Masha MashaMasha Masha Masha Masha MashaMasha Masha Masha Masha MashaMasha Masha Masha Masha MashaMasha Masha Masha Masha MashaMasha Masha Masha Masha MashaMasha Masha Masha Masha MashaMasha Masha Masha Masha MashaMasha Masha Masha Masha MashaMasha Masha Masha Masha MashaMasha Masha Masha Masha MashaMasha Masha Masha Masha MashaMasha Masha Masha Masha MashaMasha Masha Masha Masha MashaMasha Masha Masha Masha Masha", "Kirill", "Nata"]
    let typeText = UIView()
    
    @IBOutlet private weak var tableView: UITableView! 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Most Emailed"
        createTableView()
        setUpButtonFavorite()

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
}

extension MostEmailedViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
           return self.array.count
       }
       
       // There is just one row in every section
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
        cell.setUpCell(text: array[indexPath.section], image: image)
        
        cell.backgroundColor = .white
                cell.layer.borderColor = UIColor.black.cgColor
                cell.layer.borderWidth = 1
                cell.layer.cornerRadius = 8
                cell.clipsToBounds = true
                
        
        return cell
    }
}
