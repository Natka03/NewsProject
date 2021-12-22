//
//  NewsTableViewCellModel.swift
//  NewsApp
//
//  Created by Oleksandr Semeniuk on 20.12.2021.
//

import Foundation


struct NewsTableViewCellModel: Codable {
   
    let results: [Result]

  //  let results:
    
//    let imageURL: String?
//    let title: String
//    let text: String
}

struct Result: Codable {
    let publishedDate: String
}
