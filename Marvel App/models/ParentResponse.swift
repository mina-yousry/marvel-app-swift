//
//  ParentResponse.swift
//  Marvel App
//
//  Created by Mina  on 3/8/19.
//  Copyright © 2019 ITG. All rights reserved.
//

import Foundation
import ObjectMapper

class ParentResponse : Mappable{
    
    var code : Int?
    var status : String?
    var copyright : String?
    var attributionText : String?
    var attributionHTML : String?
    var etag : String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        code                <- map["code"]
        status              <- map["status"]
        copyright           <- map["copyright"]
        attributionText     <- map["attributionText"]
        attributionHTML     <- map["attributionHTML"]
        etag                <- map["etag"]
    }
}
