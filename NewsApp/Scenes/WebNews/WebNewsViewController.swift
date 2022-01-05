//
//  WebNewsViewController.swift
//  NewsApp
//
//  Created by Oleksandr Semeniuk on 05.01.2022.
//

import UIKit
import WebKit

class WebNewsViewController: UIViewController {
    
    var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)
        
    }
    
    func webNews(url: String){
        guard let url = URL(string: url) else { return }
        webView.load(URLRequest(url: url))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }
}
