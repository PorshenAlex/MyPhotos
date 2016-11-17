//
//  AlbumCollectionViewCell.swift
//  My Photos
//
//  Created by Alexey Tyurin on 17/11/16.
//  Copyright © 2016 Alexey. All rights reserved.
//

import UIKit

class AlbumCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
