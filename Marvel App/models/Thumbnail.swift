//
//  Thumbnail.swift
//  Marvel App
//
//  Created by Mina  on 3/5/19.
//  Copyright © 2019 ITG. All rights reserved.
//

import Foundation
import ObjectMapper

class Thumbnail : Mappable {

    var path : String?
    var thumbnailExtension : String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        path                  <- map["path"]
        thumbnailExtension    <- map["extension"]
    }
    
}
