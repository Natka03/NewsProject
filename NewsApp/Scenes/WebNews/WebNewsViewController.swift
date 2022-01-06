//
//  WebNewsViewController.swift
//  NewsApp
//
//  Created by Oleksandr Semeniuk on 05.01.2022.
//

import UIKit
import WebKit

class WebNewsViewController: UIViewController {
    
    let webView = WKWebView()
    let model: WebNewsModel

    init(model: WebNewsModel) {
        
        self.model = model
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)
        webNews()
    }
    
    func webNews(){
        guard let url = URL(string: model.webUrl) else { return }
        webView.load(URLRequest(url: url))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
        setUpButtonFavorite()
    }
    
    private func setUpButtonFavorite () {
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
