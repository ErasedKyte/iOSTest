//
//  TableViewCell.swift
//  IOS Test
//
//  Created by Temp on 25/02/2025.
//

import UIKit

class TableViewCell: UITableViewCell {
    static var identifier = "TableViewCell"
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var backgroundColorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemCyan
        view.layer.opacity = 0.2
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var cellImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension TableViewCell {
    private func setup(){
        setupConstraints()
    }
    
    private func setupConstraints(){
        addSubview(containerView)
        containerView.addSubview(backgroundColorView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(descriptionLabel)
        containerView.addSubview(cellImage)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 2.5),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2.5),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
                
            backgroundColorView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            backgroundColorView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            backgroundColorView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            backgroundColorView.topAnchor.constraint(equalTo: containerView.topAnchor),
            
            cellImage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            cellImage.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            cellImage.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10),
            cellImage.widthAnchor.constraint(equalToConstant: 50),
            cellImage.heightAnchor.constraint(equalToConstant: 50),

            titleLabel.leadingAnchor.constraint(equalTo: cellImage.trailingAnchor, constant: 10),
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),

            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10)
        ])
        selectionStyle = .none
    }
    
    func setupStrings(with item: Item){
        cellImage.image = UIImage(named: item.imageName)
        titleLabel.text = item.title
        descriptionLabel.text = item.description
    }
}
