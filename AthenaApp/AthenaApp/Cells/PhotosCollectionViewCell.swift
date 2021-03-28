//
//  PhotosCollectionViewCell.swift
//  AthenaApp
//
//  Created by Arun Satyavan on 26/03/21.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imgvPhoto: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.borderWidth = 1.0;
        self.layer.borderColor = UIColor.black.cgColor
    }

}
