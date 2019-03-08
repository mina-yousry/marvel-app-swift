//
//  CharacterCollectionResponse.swift
//  Marvel App
//
//  Created by Mina  on 3/8/19.
//  Copyright © 2019 ITG. All rights reserved.
//

import Foundation
import ObjectMapper

class CharacterCollectionResponse : ParentResponse {
    
    var data : CharacterCollectionData?
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        data                <- map["data"]
    }
}
