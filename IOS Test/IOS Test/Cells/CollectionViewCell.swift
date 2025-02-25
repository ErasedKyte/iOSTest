//
//  CollectionViewCell.swift
//  IOS Test
//
//  Created by Temp on 25/02/2025.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    static var identifier = "CollectionViewCell"
    
    private lazy var mainImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CollectionViewCell {
    private func setup(){
        setupConstraints()
    }
    private func setupConstraints(){
        addSubview(mainImage)
        NSLayoutConstraint.activate([
            mainImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainImage.topAnchor.constraint(equalTo: topAnchor),
            mainImage.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    func configureImage(with image: String){
        mainImage.image = UIImage(named: image)
    }
}
