//
//  UrlTableViewCell.swift
//  Marvel App
//
//  Created by Mina  on 3/7/19.
//  Copyright © 2019 ITG. All rights reserved.
//

import UIKit

class UrlTableViewCell: UITableViewCell {

    @IBOutlet weak var cellTitleLbl: UILabel!
    
    var url : CharacterUrl?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setViews(){
        if let _ = self.url {
            self.cellTitleLbl.text = self.url?.type
        }
    }
    
    
    
}
