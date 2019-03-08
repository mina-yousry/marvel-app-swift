//
//  CharactersHomeTableViewCell.swift
//  Marvel App
//
//  Created by Mina  on 3/6/19.
//  Copyright © 2019 ITG. All rights reserved.
//

import UIKit
import Kingfisher

class CharactersHomeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellBackgroundImage: UIImageView!
    @IBOutlet weak var cellTitleLbl: UILabel!
    
    var character : Character?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCellViews() {
        if let _ = self.character{
            let thumbnailUrlGenerator = ModelsFactory.sharedInstance().getThumbnailUrlGeneratorInstance()
            let urlString = thumbnailUrlGenerator.generateThumbnailUrl(fromThumbnail: self.character?.thumbnail, withSizeKey: SQUARE_SIZE_KEY)
            let url = URL(string : urlString)
            self.cellBackgroundImage.kf.setImage(with: url)
            self.cellTitleLbl.text = self.character?.name
        }
    }
    
}
