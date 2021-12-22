//
//  NewsTableViewCell.swift
//  NewsApp
//
//  Created by Oleksandr Semeniuk on 17.12.2021.
//

import UIKit

final class NewsTableViewCell: UITableViewCell {
        //multi
    private var dateView: UIView = {
        let date = UIView()
        date.backgroundColor = .green
        date.layer.cornerRadius = 5
        date.layer.maskedCorners = .layerMinXMaxYCorner
        date.translatesAutoresizingMaskIntoConstraints = false
        
        return date
    }()
    
    private var typeView: UIView = {
        let type = UIView()
        type.backgroundColor = .white
        type.translatesAutoresizingMaskIntoConstraints = false
        type.layer.cornerRadius = 5
        type.layer.maskedCorners = .layerMaxXMaxYCorner

        return type
    }()
    
    private var newsTitle: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.font = .systemFont(ofSize: 25)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private var typeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 15)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
    private var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 15)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private var newsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        //label.layer.cornerRadius = 3

        return label
    }()
    private var newsImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
       // image.layer.cornerRadius = 8

        return image
    }()
    
    func setUpCell(text: String, image: UIImage) {
        backgroundColor = .lightGray
        
        contentView.addSubview(dateView)
        contentView.addSubview(typeView)
        contentView.addSubview(typeLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(newsTitle)
        contentView.addSubview(newsLabel)
        contentView.addSubview(newsImage)
        
        NSLayoutConstraint.activate([
            typeLabel.leftAnchor.constraint(equalTo: typeView.leftAnchor),
            typeLabel.rightAnchor.constraint(equalTo: typeView.rightAnchor),
            typeLabel.topAnchor.constraint(equalTo: typeView.topAnchor),
            typeLabel.bottomAnchor.constraint(equalTo: typeView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            dateLabel.leftAnchor.constraint(equalTo: dateView.leftAnchor),
            dateLabel.rightAnchor.constraint(equalTo: dateView.rightAnchor),
            dateLabel.topAnchor.constraint(equalTo: dateView.topAnchor),
            dateLabel.bottomAnchor.constraint(equalTo: dateView.bottomAnchor)
        ])

        NSLayoutConstraint.activate([
            newsImage.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            newsImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            newsImage.widthAnchor.constraint(equalToConstant: 150),
            newsImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            newsTitle.leftAnchor.constraint(equalTo: newsImage.rightAnchor),
            newsTitle.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            newsTitle.topAnchor.constraint(equalTo: contentView.topAnchor),
            newsTitle.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            newsLabel.leftAnchor.constraint(equalTo: newsImage.rightAnchor),
            newsLabel.topAnchor.constraint(equalTo: newsTitle.bottomAnchor),
            newsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            newsLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            typeView.leftAnchor.constraint(equalTo: newsImage.rightAnchor),
            typeView.topAnchor.constraint(equalTo: contentView.topAnchor),
            typeView.widthAnchor.constraint(equalToConstant: 75),
            typeView.heightAnchor.constraint(equalToConstant: 25),
//        ])
        
//        NSLayoutConstraint.activate([
            dateView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            dateView.topAnchor.constraint(equalTo: contentView.topAnchor),
            dateView.widthAnchor.constraint(equalToConstant: 75),
            dateView.heightAnchor.constraint(equalToConstant: 25)
        ])
       
        newsLabel.text = text
        newsImage.image = image
        newsTitle.text = "TITLE"
        dateLabel.text = "Date"
        typeLabel.text = "Type"
        self.layer.cornerRadius = 10
    }
}
