//
//  MostViewedViewController.swift
//  NewsApp
//
//  Created by Oleksandr Semeniuk on 17.12.2021.
//

import UIKit

class MostViewedViewController: UIViewController {
    
    //MARK: - Properties
    
    private let networkManager = NetworkManager()
    private var model: NewsModel = .init(items: [])
   
    // MARK: - View
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(NewsTableViewCell.self,
                           forCellReuseIdentifier: String(describing: NewsTableViewCell.self))
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        
        return tableView
    }()
    
    private var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.color = .blue
        activityIndicator.hidesWhenStopped = true
        
        return activityIndicator
    }()
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = Constant.navBarTitle
        fetchData()
        createTableView()
        createActivityIndicator()
    }
    
    //MARK: - Private methods
    
    private func fetchData() {
        activityIndicator.startAnimating()
        networkManager.fetchMostNews(nesType: .mostVived) { [weak self] result in
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
                self.activityIndicator.stopAnimating()
                self.tableView.reloadData()
            case .failure(let error):
                self.showErrorAlertWith(error.localizedDescription)
                self.activityIndicator.stopAnimating()
                print(error)
            }
        }
    }
    
    private func createTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func createActivityIndicator() {
        view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func showErrorAlertWith(_ message: String) {
        let alert = UIAlertController(
            title: "Ups.. Error!",
            message: message,
            preferredStyle: .alert)
        
        alert.addAction(
            UIAlertAction(
                title: "OK",
                style: UIAlertAction.Style.cancel,
                handler: nil
            )
        )
        
        self.present(alert, animated: true, completion: nil)
    }
}

//MARK: - TableViewDelegate, TableViewDataSource

extension MostViewedViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.items.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constant.tableViewHeightForRowAt
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: NewsTableViewCell.self),
            for: indexPath
        ) as? NewsTableViewCell else {
            return UITableViewCell()
        }
        
        let item = model.items[indexPath.row]
        
        cell.setUpCell(model: item)
        
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

extension MostViewedViewController {
    private enum Constant {
        static let navBarTitle = "Most Viewed"
        static let tableViewHeightForRowAt: CGFloat = 200
    }
}

