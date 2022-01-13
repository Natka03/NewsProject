//
//  WebNewsViewController.swift
//  NewsApp
//
//  Created by Oleksandr Semeniuk on 05.01.2022.
//

import UIKit
import WebKit

class WebNewsViewController: UIViewController {
    
    private let coreDataManager: CoreDataManager
    
    private let webView = WKWebView()
    private let model: WebNewsModel
    
    //MARK: - Initциализешн
    init(model: WebNewsModel) {
        self.coreDataManager = CoreDataManager()
        self.model = model
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)
        webNews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
        setUpButtonFavorite()
    }
    
    //MARK: - Private methods
    
    private func webNews() {
        guard let url = URL(string: model.webUrl) else { return }
        webView.load(URLRequest(url: url))
    }
    
    private func massageDelete() {
        let alert = UIAlertController(title: "Delete this article from saved",
                                      message: "",
                                      preferredStyle: .alert)
        
        alert.addAction(
            UIAlertAction(
                title: "OK",
                style: UIAlertAction.Style.destructive,
                handler: { [weak self] action in
                    guard let self = self else { return }
                    self.coreDataManager.deleteNewsWith(self.model.newsId)
                    self.navigationItem.rightBarButtonItem?.tintColor = .black
                }
            )
        )
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    private func setUpButtonFavorite() {
        let isFavorite = coreDataManager.isFavorite(id: model.newsId)
        
        let favoriteButton = UIBarButtonItem(
            image: UIImage(systemName: "heart.fill"),
            style: .plain,
            target: self,
            action: #selector(didTapFavoriteButton)
        )
        
        favoriteButton.tintColor = isFavorite ? .red : .black
        
        navigationItem.rightBarButtonItem = favoriteButton
    }
    
    private func handleFavorites() {
        let isFavorite = coreDataManager.isFavorite(id: model.newsId)
        
        if isFavorite {
            massageDelete()
        } else {
            coreDataManager.saveNews(model: model)
            navigationItem.rightBarButtonItem?.tintColor = .red
        }
    }
    
    //MARK: - Actions
    
    @objc func didTapFavoriteButton() {
        handleFavorites()
    }
}
