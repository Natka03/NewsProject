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
    case mostFavorite = ""
}

final class NetworkManager {
    
    private let parameters: Parameters = [Constant.apiKey: Constant.apiKeyValue]
    
    public func fetchMostNews(nesType: EndpointUrl, completion: @escaping (Result<Response, AFError>) -> Void ) {
        let url = Constant.url + nesType.rawValue
        AF.request(url, method: .get, parameters: parameters)
            .validate().responseDecodable (of: Response.self) { responce in
                completion(responce.result)
            }
    }
}

// MARK: - Constants

extension NetworkManager {
    private enum Constant {
        static let apiKeyValue = "oVuQGkB5jcXT0Qo2MHHi9AuGQRuDB4eX"
        static let apiKey = "api-key"
        static let url = "https://api.nytimes.com/svc/mostpopular/v2/"
    }
}
