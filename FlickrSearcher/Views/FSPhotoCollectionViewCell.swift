//
//  FSPhotoCollectionViewCell.swift
//  FlickrSearcher
//
//  Created by Liu Yixiang on 8/28/18.
//  Copyright © 2018 Liu Yixiang. All rights reserved.
//

import UIKit

class FSPhotoCollectionViewCell: UICollectionViewCell {

    @IBOutlet var containerView: UIView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var publishDateLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        Bundle.main.loadNibNamed("FSPhotoCollectionViewCell", owner: self, options: nil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
//        imageView.sd_cancelCurrentImageLoad()
    }
    
    private func setup() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        self.contentView.addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            ])
    }
    
    public func configure(_ viewModel: FSPhotoViewModel) {
        if let url = viewModel.url {
            imageView.sd_setImage(with: url)
        }
        titleLabel.text = viewModel.title
        publishDateLabel.text = viewModel.publishedDate
    }
    
    static func reuseIdentifier() -> String {
        return NSStringFromClass(self)
    }
}
