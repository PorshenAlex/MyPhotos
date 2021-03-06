//
//  AlbumCollectionViewCell.swift
//  My Photos
//
//  Created by Alexey Tyurin on 17/11/16.
//  Copyright © 2016 Alexey. All rights reserved.
//

import UIKit
import Photos

private let aspectRation: CGFloat = 35/26

class AlbumCollectionViewCell: UICollectionViewCell, Reusable {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.setupImageView()
    }
    
    override func prepareForReuse() {
        self.imageView.image = nil
    }
    
    func configure(_ album:AlbumRepresentation) {
        self.titleLabel.text = album.title()
        self.countLabel.text = "\(album.numberOfProtos())"
        guard let asset = album.lastAsset() else { return }
        weak var weakSelf = self
        PHImageManager.default().requestImage(for: asset,
                                              targetSize: self.imageView.frame.size,
                                              contentMode: .aspectFill,
                                              options: nil) { (image, info) in
                                                weakSelf?.imageView.image = image
        }
    }
    
    static func size() -> CGSize {
        let width = UIScreen.main.bounds.width / 2 - 20
        return CGSize(width: width, height: width * aspectRation)
    }
}

fileprivate protocol Setup {
    func setupImageView()
}


//MARK: - Setup

extension AlbumCollectionViewCell: Setup {
    internal func setupImageView() {
        self.imageView.layer.cornerRadius = 3
        self.imageView.clipsToBounds = true
    }
}
