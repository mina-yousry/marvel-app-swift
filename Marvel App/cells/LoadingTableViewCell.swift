//
//  LoadingTableViewCell.swift
//  Marvel App
//
//  Created by Mina  on 3/6/19.
//  Copyright © 2019 ITG. All rights reserved.
//

import UIKit

class LoadingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
