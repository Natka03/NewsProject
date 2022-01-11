//
//  NewsTableViewCell.swift
//  NewsApp
//
//  Created by Oleksandr Semeniuk on 17.12.2021.
//

import UIKit
import Kingfisher

final class NewsTableViewCell: UITableViewCell {
    
    private var containerView: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        
        return view
    }()
    
    private var dateView: UIView = {
        let date = UIView()
        date.backgroundColor = .yellow
        date.layer.cornerRadius = 5
        date.layer.maskedCorners = .layerMinXMaxYCorner
        date.translatesAutoresizingMaskIntoConstraints = false
        
        return date
    }()
    
    private var typeView: UIView = {
        let type = UIView()
        type.backgroundColor = .orange
        type.translatesAutoresizingMaskIntoConstraints = false
        type.layer.cornerRadius = 5
        type.layer.maskedCorners = .layerMaxXMaxYCorner
        
        return type
    }()
    
    private var newsTitle: UILabel = {
        let label = UILabel()
        label.textColor = .systemRed
        label.font = .systemFont(ofSize: 17)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0

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
        label.font = .systemFont(ofSize: 12)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private var newsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        
        return label
    }()
    
    private var newsImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(containerView)
        
        containerView.addSubview(dateView)
        containerView.addSubview(typeView)
        containerView.addSubview(typeLabel)
        containerView.addSubview(dateLabel)
        containerView.addSubview(newsTitle)
        containerView.addSubview(newsLabel)
        containerView.addSubview(newsImage)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setUpCell(text: String, title: String, date: String, type: String, ImageUrl: String) {
        let url = URL(string: ImageUrl) ?? URL(fileURLWithPath: "")
        let image = UIImageView()
        let imagePlaceholder: UIImage = UIImage(named: "News")!
        image.kf.setImage(
            with: url,
            placeholder: imagePlaceholder )
        let resource = ImageResource(downloadURL: url)
                
        KingfisherManager.shared.retrieveImage(with: resource, options: nil, progressBlock: nil) { result in
            switch result {
            case .success(let value):
                self.newsImage.image = value.image
                print("Image: \(value.image). Got from: \(value.cacheType)")
            case .failure(let error):
                print("Error: \(error)")
            }
        }
        newsLabel.text = text
        newsTitle.text = title
        dateLabel.text = date
        typeLabel.text = type
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor,
                                               constant: 8.0),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                                  constant: -8.0),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            typeLabel.leftAnchor.constraint(equalTo: typeView.leftAnchor),
            typeLabel.rightAnchor.constraint(equalTo: typeView.rightAnchor),
            typeLabel.topAnchor.constraint(equalTo: typeView.topAnchor),
            typeLabel.bottomAnchor.constraint(equalTo: typeView.bottomAnchor),
            
            dateLabel.leftAnchor.constraint(equalTo: dateView.leftAnchor),
            dateLabel.rightAnchor.constraint(equalTo: dateView.rightAnchor),
            dateLabel.topAnchor.constraint(equalTo: dateView.topAnchor),
            dateLabel.bottomAnchor.constraint(equalTo: dateView.bottomAnchor),
            
            newsImage.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            newsImage.topAnchor.constraint(equalTo: containerView.topAnchor),
            newsImage.widthAnchor.constraint(equalToConstant: 150),
            newsImage.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            
            newsTitle.leftAnchor.constraint(equalTo: newsImage.rightAnchor,
                                           constant: 5),
            newsTitle.rightAnchor.constraint(equalTo: containerView.rightAnchor,
                                            constant: -5),
            newsTitle.topAnchor.constraint(equalTo: typeView.bottomAnchor),
            newsTitle.heightAnchor.constraint(equalToConstant: 35),
            
            newsLabel.leftAnchor.constraint(equalTo: newsImage.rightAnchor,
                                            constant: 16),
            newsLabel.topAnchor.constraint(equalTo: newsTitle.bottomAnchor),
            newsLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor,
                                              constant: -16),
            newsLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor,
                                             constant: -16),
            
            typeView.leftAnchor.constraint(equalTo: newsImage.rightAnchor),
            typeView.topAnchor.constraint(equalTo: containerView.topAnchor),
            typeView.widthAnchor.constraint(equalToConstant: 100),
            typeView.heightAnchor.constraint(equalToConstant: 25),
            
            dateView.rightAnchor.constraint(equalTo: containerView.rightAnchor),
            dateView.topAnchor.constraint(equalTo: containerView.topAnchor),
            dateView.widthAnchor.constraint(equalToConstant: 75),
            dateView.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
}
