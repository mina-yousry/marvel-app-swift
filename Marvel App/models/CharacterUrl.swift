//
//  CharacterUrl.swift
//  Marvel App
//
//  Created by Mina  on 3/5/19.
//  Copyright © 2019 ITG. All rights reserved.
//

import Foundation
import ObjectMapper

class CharacterUrl : Mappable {
    var type : String?
    var url : String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        type    <- map["type"]
        url     <- map["url"]
    }
}
