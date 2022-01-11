//
//  NetworkManager.swift
//  NewsApp
//
//  Created by Oleksandr Semeniuk on 23.12.2021.
//

import UIKit
import Alamofire
import Kingfisher

enum EndpointUrl: String {
    case mostEmailed = "emailed/30.json"
    case mostShared = "shared/30.json"
    case mostVived = "viewed/30.json"
}

final class NetworkManager {
    
    static let apiKeyValue = "oVuQGkB5jcXT0Qo2MHHi9AuGQRuDB4eX"
    static let apiKey = "api-key"
    let url = "https://api.nytimes.com/svc/mostpopular/v2/"
    
    let parameters: Parameters = [apiKey: apiKeyValue]
    
    public func fetchMostNews(nesType: EndpointUrl, completion: @escaping (Result<News, AFError>) -> Void ) {
        let url = url + nesType.rawValue
        AF.request(url, method: .get, parameters: parameters)
            .validate().responseDecodable (of: News.self) { responce in
                completion(responce.result)
            }
    }
}

