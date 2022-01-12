//
//  NetworkManager.swift
//  NewsApp
//
//  Created by Oleksandr Semeniuk on 23.12.2021.
//

import UIKit
import Alamofire

enum EndpointUrl: String {
    case mostEmailed = "emailed/30.json"
    case mostShared = "shared/30.json"
    case mostVived = "viewed/30.json"
}

final class NetworkManager {
    
    private let parameters: Parameters = [Constsnt.apiKey: Constsnt.apiKeyValue]
    
    public func fetchMostNews(nesType: EndpointUrl, completion: @escaping (Result<News, AFError>) -> Void ) {
        let url = Constsnt.url + nesType.rawValue
        AF.request(url, method: .get, parameters: parameters)
            .validate().responseDecodable (of: News.self) { responce in
                completion(responce.result)
            }
    }
}

// MARK: - Constants

extension NetworkManager {
    private enum Constsnt {
        static let apiKeyValue = "oVuQGkB5jcXT0Qo2MHHi9AuGQRuDB4eX"
        static let apiKey = "api-key"
        static let url = "https://api.nytimes.com/svc/mostpopular/v2/"
        
    }
}
