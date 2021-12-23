//
//  NewsTableViewCell.swift
//  NewsApp
//
//  Created by Oleksandr Semeniuk on 17.12.2021.
//

import UIKit

final class NewsTableViewCell: UITableViewCell {
        
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
        label.font = .systemFont(ofSize: 20)
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
       
        return label
    }()
    
    private var newsImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false

        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .lightGray
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 8
        clipsToBounds = true
        
        contentView.addSubview(dateView)
        contentView.addSubview(typeView)
        contentView.addSubview(typeLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(newsTitle)
        contentView.addSubview(newsLabel)
        contentView.addSubview(newsImage)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setUpCell(text: String, image: UIImage) {
        
        newsLabel.text = text
        newsImage.image = image
        newsTitle.text = "TITLE"
        dateLabel.text = "Date"
        typeLabel.text = "Type"
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            typeLabel.leftAnchor.constraint(equalTo: typeView.leftAnchor),
            typeLabel.rightAnchor.constraint(equalTo: typeView.rightAnchor),
            typeLabel.topAnchor.constraint(equalTo: typeView.topAnchor),
            typeLabel.bottomAnchor.constraint(equalTo: typeView.bottomAnchor),
        
            dateLabel.leftAnchor.constraint(equalTo: dateView.leftAnchor),
            dateLabel.rightAnchor.constraint(equalTo: dateView.rightAnchor),
            dateLabel.topAnchor.constraint(equalTo: dateView.topAnchor),
            dateLabel.bottomAnchor.constraint(equalTo: dateView.bottomAnchor),
       
            newsImage.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            newsImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            newsImage.widthAnchor.constraint(equalToConstant: 150),
            newsImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        
            newsTitle.leftAnchor.constraint(equalTo: newsImage.rightAnchor),
            newsTitle.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            newsTitle.topAnchor.constraint(equalTo: contentView.topAnchor,
                                          constant: 16),
            newsTitle.heightAnchor.constraint(equalToConstant: 50),
   
            newsLabel.leftAnchor.constraint(equalTo: newsImage.rightAnchor,
                                            constant: 16),
            newsLabel.topAnchor.constraint(equalTo: newsTitle.bottomAnchor),
            newsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                              constant: -16),
            newsLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor,
                                             constant: -16),
       
            typeView.leftAnchor.constraint(equalTo: newsImage.rightAnchor),
            typeView.topAnchor.constraint(equalTo: contentView.topAnchor),
            typeView.widthAnchor.constraint(equalToConstant: 65),
            typeView.heightAnchor.constraint(equalToConstant: 25),

            dateView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            dateView.topAnchor.constraint(equalTo: contentView.topAnchor),
            dateView.widthAnchor.constraint(equalToConstant: 65),
            dateView.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
}

//extension NewsTableViewCell: UITableViewCell{
//
//}
