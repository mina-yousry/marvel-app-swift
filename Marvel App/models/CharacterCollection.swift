//
//  CharacterCollection.swift
//  Marvel App
//
//  Created by Mina  on 3/5/19.
//  Copyright © 2019 ITG. All rights reserved.
//

import Foundation
import ObjectMapper

class CharacterCollection : Mappable {
    
    var available : Int?
    var collectionURI : String?
    var items : [Item]?
    var returned : Int?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        available        <- map["available"]
        collectionURI    <- map["collectionURI"]
        items            <- map["items"]
        returned         <- map["returned"]
    }
}
