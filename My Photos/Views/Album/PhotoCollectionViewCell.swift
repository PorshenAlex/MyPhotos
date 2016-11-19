//
//  PhotoCollectionViewCell.swift
//  My Photos
//
//  Created by Alexey Tyurin on 17/11/16.
//  Copyright © 2016 Alexey. All rights reserved.
//

import UIKit
import Photos

class PhotoCollectionViewCell: UICollectionViewCell, Reusable {
    @IBOutlet weak var imageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(_ asset:PHAsset, fullScreen: Bool) {
        self.imageView.contentMode = fullScreen ? .scaleAspectFit : .scaleAspectFill
        PHImageManager.default().requestImage(for: asset,
                                              targetSize: self.imageView.frame.size,
                                              contentMode: .aspectFill,
                                              options: nil) { (image, info) in
                                                self.imageView.image = image
        }
    }
    
    static func smallSize() -> CGSize {
        let scale = UIScreen.main.bounds.width / 4 - 2
        return CGSize(width: scale, height: scale)
    }
}
