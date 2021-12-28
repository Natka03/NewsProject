//
//  NetworkManager.swift
//  NewsApp
//
//  Created by Oleksandr Semeniuk on 23.12.2021.
//

import UIKit
import Alamofire

enum Endpoint: String {
    case mostEmailed = "/emailed/30.json"
    
}

final class NetworkManager {
    
    let url = "https://api.nytimes.com/svc/mostpopular/v2/" + Endpoint.mostEmailed.rawValue
  //  let headers: HTTPHeaders = ["authorization" : "oVuQGkB5jcXT0Qo2MHHi9AuGQRuDB4eX"]
    let parameters: Parameters = ["api-key": "oVuQGkB5jcXT0Qo2MHHi9AuGQRuDB4eX"]


    func fetchNews(nesType: Endpoint) -> String {
        AF.request(url, method: .get, parameters: parameters)
          .validate().responseDecodable (of: Welcome.self){ responseJSON in
              
              switch responseJSON.result {
              case .success(let value):
                  print(value)
              case .failure(let error):
                  print(error)
              }
          }
        return
        //  .responseDecodable(of: Welcome.self) { response in
       //     guard let data = response.value else { return }
         //     print(data.data)
//              if let dictionary = result.value as? Dictionary<String, AnyObject>{
//              let result = response.result
//              switch result {
//              case .success(let data): break
//                //Parse data
//              case .failure(let afError): break
//                //Handle error
//              }
//              }
//              let res: Result <responseJSON.result.value, responseJSON.result.error
//>
            //  return res
        //  }
    }
}
