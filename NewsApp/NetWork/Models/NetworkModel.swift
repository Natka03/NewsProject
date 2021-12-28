//
//  NetworkModel.swift
//  NewsApp
//
//  Created by Oleksandr Semeniuk on 28.12.2021.
//

import UIKit
import Foundation
import Alamofire

struct Welcome: Codable {
    let status: String
    let copyright: String
    let numResults: Int
    let data: [Data]

    enum CodingKeys: String, CodingKey {
        case status, copyright
        case numResults = "num_results"
        case data = "results"
    }
}
struct Data: Codable {
    let publishedDate: String
    let section: String
    let title: String
    
    enum CodingKeys: String, CodingKey {
            case publishedDate = "published_date"
            case section
            case title
        }
}

