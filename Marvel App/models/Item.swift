//
//  Item.swift
//  Marvel App
//
//  Created by Mina  on 3/5/19.
//  Copyright © 2019 ITG. All rights reserved.
//

import Foundation
import ObjectMapper

class Item : Mappable {
    
    var resourceURI : String?
    var name : String?
    var title : String?
    var thumbnail : Thumbnail?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        resourceURI    <- map["resourceURI"]
        name           <- map["name"]
        title          <- map["title"]
        thumbnail      <- map["thumbnail"]
    }
    
    
}
