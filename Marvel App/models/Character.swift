//
//  Character.swift
//  Marvel App
//
//  Created by Mina  on 3/5/19.
//  Copyright © 2019 ITG. All rights reserved.
//

import Foundation
import ObjectMapper

class Character : Mappable  {
    
    var id : Int?
    var name : String?
    var description : String?
    var modified : String?
    var thumbnail : Thumbnail?
    var resourceURI : String?
    var comics : CharacterCollection?
    var series : CharacterCollection?
    var stories : CharacterCollection?
    var events : CharacterCollection?
    var urls : [CharacterUrl]?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id              <- map["id"]
        name            <- map["name"]
        description     <- map["description"]
        modified        <- map["modified"]
        thumbnail       <- map["thumbnail"]
        resourceURI     <- map["resourceURI"]
        comics          <- map["comics"]
        series          <- map["series"]
        stories         <- map["stories"]
        events          <- map["events"]
        urls            <- map["urls"]
    }
    
}
