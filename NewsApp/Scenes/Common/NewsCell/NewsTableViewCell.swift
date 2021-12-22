//
//  NewsTableViewCell.swift
//  NewsApp
//
//  Created by Oleksandr Semeniuk on 17.12.2021.
//

import UIKit

final class NewsTableViewCell: UITableViewCell {
        
    private var newsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    private var newsImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false

        return image
    }()
    
    func setUpCell(text: String, image: UIImage) {
        backgroundColor = .blue
        
        contentView.addSubview(newsLabel)
        contentView.addSubview(newsImage)

        NSLayoutConstraint.activate([
            newsImage.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            newsImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            newsImage.widthAnchor.constraint(equalToConstant: 150),
            newsImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            newsLabel.leftAnchor.constraint(equalTo: newsImage.rightAnchor),
            newsLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            newsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            newsLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor)
        ])
       // var im = UIImage(named: image)
        newsLabel.text = text
        newsImage.image = image
    }
}
