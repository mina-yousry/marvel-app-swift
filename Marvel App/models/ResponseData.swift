//
//  ResponseData.swift
//  Marvel App
//
//  Created by Mina  on 3/5/19.
//  Copyright © 2019 ITG. All rights reserved.
//

import Foundation
import  ObjectMapper

class ResponseData : Mappable {
    var offset : Int?
    var limit : Int?
    var total : Int?
    var count : Int?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
         offset     <- map["offset"]
         limit      <- map["limit"]
         total      <- map["total"]
         count      <- map["count"]
    }
}
