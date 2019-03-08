//
//  ErrorResponse.swift
//  Marvel App
//
//  Created by Mina  on 3/6/19.
//  Copyright © 2019 ITG. All rights reserved.
//

import Foundation
import ObjectMapper

class ErrorResponse : Mappable  {
    
    var code : String?
    var message : String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        code        <- map["code"]
        message     <- map["message"]
    }
    
}
