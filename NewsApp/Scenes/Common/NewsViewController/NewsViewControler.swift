//
//  NewsViewControler.swift
//  NewsApp
//
//  Created by Oleksandr Semeniuk on 19.01.2022.
//

import Foundation
import UIKit

enum NavBarTitle: String {
    case mostEmailed = "Most Emailed"
    case mostShared = "Most Shared"
    case mostVived = "Most Viewed"
    case mostFavorite = "Favorite"
}

final class NewsViewControler: UIViewController {
    
    var presenter: NewsPresenterProtocol
    private let refreshControl = UIRefreshControl()
    private let navBarTitle: NavBarTitle
    
    //MARK: - Initialization
    
    init(somePresenter: NewsPresenterProtocol, navBarTitle: NavBarTitle) {
        self.navBarTitle = navBarTitle
        self.presenter = somePresenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(NewsTableViewCell.self,
                           forCellReuseIdentifier: String(describing: NewsTableViewCell.self))
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        
        return tableView
    }()
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = navBarTitle.rawValue
       
        createTableView()
        tableView.reloadData()
        createRefreshControl()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter.fetchNews() { [weak self]  in
            guard let self = self else { return }
                self.tableView.reloadData()
        }
    }
    
    //MARK: - Private methods
    
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
    
    private func createRefreshControl() {
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    //MARK: - Actions
    
    @objc func refresh(_ sender: AnyObject) {
        tableView.reloadData()
        refreshControl.endRefreshing()
    }
}

//MARK: - TableViewDelegate, TableViewDataSource

extension NewsViewControler: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.model.items.count
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
        
        let item = presenter.model.items[indexPath.row]
        
        cell.setUpCell(model: item)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = presenter.model.items[indexPath.row]
        
        let vc = WebNewsViewController(model: item)
        
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Constants

extension NewsViewControler {
    private enum Constant {
        static let tableViewHeightForRowAt: CGFloat = 200
    }
}

