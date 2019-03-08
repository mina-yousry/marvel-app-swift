//
//  ThumbnailUrlGenerator.swift
//  Marvel App
//
//  Created by Mina  on 3/7/19.
//  Copyright © 2019 ITG. All rights reserved.
//

import Foundation

class ThumbnailUrlGenerator {
    
    private static var thumbnailUrlGenerator : ThumbnailUrlGenerator?
    private static let serialQueue = DispatchQueue(label: "thumbnailUrlGeneratorQueue")
    private init(){}
    
    static func sharedInstance() -> ThumbnailUrlGenerator{
        if self.thumbnailUrlGenerator == nil{
            self.serialQueue.sync {
                if self.thumbnailUrlGenerator == nil{
                    self.thumbnailUrlGenerator = ThumbnailUrlGenerator()
                }
            }
        }
        return self.thumbnailUrlGenerator!
    }
    
    func generateThumbnailUrl(fromThumbnail thumbnail:Thumbnail?, withSizeKey key:String) -> String {
        var url = ""
        let path = thumbnail?.path
        let thumbnailExtension = thumbnail?.thumbnailExtension
        url = "\(path ?? "")/\(key).\(thumbnailExtension ?? "")"
        return url 
    }
}
