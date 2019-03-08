//
//  CharacterCollectionViewCell.swift
//  Marvel App
//
//  Created by Mina  on 3/7/19.
//  Copyright © 2019 ITG. All rights reserved.
//

import UIKit
import Kingfisher

class CharacterCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var characterName: UILabel!
    
    var item : Item?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setviews() {
        if let _ = self.item {
            let thumbnail = self.item?.thumbnail
            let thumbnailUrlGenerator = ModelsFactory.sharedInstance().getThumbnailUrlGeneratorInstance()
            let urlString = thumbnailUrlGenerator.generateThumbnailUrl(fromThumbnail: thumbnail, withSizeKey: PORTRAIT_SIZE_KEY)
            let url = URL(string : urlString)
            self.characterImage.kf.setImage(with: url)
            self.characterName.text = self.item?.title
        }
    }

}
