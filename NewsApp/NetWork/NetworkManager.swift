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
    static let apiKeyValue = "oVuQGkB5jcXT0Qo2MHHi9AuGQRuDB4eX"
    static let apiKey = "api-key"
    let url = "https://api.nytimes.com/svc/mostpopular/v2/"
    
    let parameters: Parameters = [apiKey: apiKeyValue]
    
//    public func fetchImage(){
//        let strURL1:String = "https://www.planwallpaper.com/static/images/9-credit-1.jpg"
//        AF.request(strURL1).responseData(completionHandler: { response in
//            debugPrint(response)
//
//            debugPrint(response.result)
//
//            if let image1 = response.result.value {
//            let image = UIImage(data: image1)
//        }
//
//    }
    
    public func fetchMostNews(nesType: EndpointUrl, completion: @escaping (Result<News, AFError>) -> Void ) {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd"
        let url = url + nesType.rawValue
        AF.request(url, method: .get, parameters: parameters)
          .validate().responseDecodable (of: News.self) { responce in
              completion(responce.result)
        }
    }
}

