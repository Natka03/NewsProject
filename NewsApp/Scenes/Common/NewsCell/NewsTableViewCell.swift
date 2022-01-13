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
        view.layer.cornerRadius = Constant.cornerRadius
        view.clipsToBounds = true
        
        return view
    }()
    
    private var dateView: UIView = {
        let date = UIView()
        date.backgroundColor = .yellow
        date.layer.cornerRadius = Constant.cornerRadius
        date.layer.maskedCorners = .layerMinXMaxYCorner
        date.translatesAutoresizingMaskIntoConstraints = false
        
        return date
    }()
    
    private var typeView: UIView = {
        let type = UIView()
        type.backgroundColor = .orange
        type.translatesAutoresizingMaskIntoConstraints = false
        type.layer.cornerRadius = Constant.cornerRadius
        type.layer.maskedCorners = .layerMaxXMaxYCorner
        
        return type
    }()
    
    private var newsTitle: UILabel = {
        let label = UILabel()
        label.textColor = .red
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
        
        contentView.backgroundColor = .cyan
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
        setUpImage(ImageUrl: ImageUrl)
        newsLabel.text = text
        newsTitle.text = title
        dateLabel.text = date
        typeLabel.text = type
    }
    
    private func setUpImage(ImageUrl: String) {
        let url = URL(string: ImageUrl) ?? URL(fileURLWithPath: "")
        let image = UIImageView()
        let imagePlaceholder: UIImage = UIImage(named: "News") ?? UIImage()

        image.kf.setImage(
            with: url,
            placeholder: imagePlaceholder)
        
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
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: Constant.containerInsets.top
            ),
            containerView.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: Constant.containerInsets.bottom
            ),
            containerView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: Constant.containerInsets.left
            ),
            containerView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: Constant.containerInsets.right),
            
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
            newsImage.widthAnchor.constraint(equalToConstant: Constant.newsImageWidth),
            newsImage.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            
            newsTitle.leftAnchor.constraint(
                equalTo: newsImage.rightAnchor,
                constant: Constant.newsTitleInsets.left
            ),
            newsTitle.rightAnchor.constraint(
                equalTo: containerView.rightAnchor,
                constant: Constant.newsTitleInsets.right
            ),
            newsTitle.topAnchor.constraint(equalTo: typeView.bottomAnchor),
            newsTitle.heightAnchor.constraint(equalToConstant: Constant.newsTitleHeight),
            
            newsLabel.leftAnchor.constraint(
                equalTo: newsImage.rightAnchor,
                constant: Constant.newsLabelInsets.left
            ),
            newsLabel.topAnchor.constraint(equalTo: newsTitle.bottomAnchor),
            newsLabel.bottomAnchor.constraint(
                equalTo: containerView.bottomAnchor,
                constant: Constant.newsLabelInsets.bottom
            ),
            newsLabel.rightAnchor.constraint(
                equalTo: containerView.rightAnchor,
                constant: Constant.newsLabelInsets.right
            ),
            
            typeView.leftAnchor.constraint(equalTo: newsImage.rightAnchor),
            typeView.topAnchor.constraint(equalTo: containerView.topAnchor),
            typeView.widthAnchor.constraint(equalToConstant: Constant.typeViewSize.width),
            typeView.heightAnchor.constraint(equalToConstant: Constant.typeViewSize.height),
            
            dateView.rightAnchor.constraint(equalTo: containerView.rightAnchor),
            dateView.topAnchor.constraint(equalTo: containerView.topAnchor),
            dateView.widthAnchor.constraint(equalToConstant: Constant.dateViewSize.width),
            dateView.heightAnchor.constraint(equalToConstant: Constant.dateViewSize.height)
        ])
    }
}

// MARK: - Constants

extension NewsTableViewCell {
    private enum Constant {
        static let containerInsets = UIEdgeInsets(top: 8.0, left: 8.0, bottom: -8.0, right: -8.0)
        static let newsLabelInsets = UIEdgeInsets(top: .zero, left: 16, bottom: -16, right: -16)
        static let newsTitleInsets = UIEdgeInsets(top: .zero, left: 5, bottom: .zero, right: -5)
        static let newsTitleHeight: CGFloat = 35
        static let newsImageWidth: CGFloat = 150
        static let typeViewSize = CGSize(width: 100, height: 25)
        static let dateViewSize = CGSize(width: 75.0, height: 25.0)
        static let cornerRadius: CGFloat = 8
    }
}
