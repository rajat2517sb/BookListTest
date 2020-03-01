//
//  collectionViewCell.swift
//  BookList
//
//  Created by Rajat Babhulgaonkar on 01/03/20.
//  Copyright © 2020 Rajat Babhulgaonkar. All rights reserved.
//

import Foundation
import UIKit


class BookListCollectionViewCell: UICollectionViewCell {
    public lazy var bookImage:UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    public lazy var authorName : UILabel = {
        let label = UILabel()
        label.text = "ABC"
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(bookImage)
        self.contentView.addSubview(authorName)
        
        self.authorName.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 5).isActive = true
        self.authorName.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: 5).isActive = true
        self.bookImage.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10).isActive = true
        self.authorName.heightAnchor.constraint(equalToConstant: 20).isActive = true

        
        self.bookImage.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 5).isActive = true
        self.bookImage.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: 5).isActive = true
        self.bookImage.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5).isActive = true
        self.bookImage.bottomAnchor.constraint(equalTo: authorName.topAnchor, constant:  -5).isActive = true
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
