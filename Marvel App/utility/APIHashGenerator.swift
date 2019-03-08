//
//  APIHashGenerator.swift
//  Marvel App
//
//  Created by Mina  on 3/5/19.
//  Copyright © 2019 ITG. All rights reserved.
//

import Foundation
import CryptoSwift

class APIHashGenerator {
    
    private func generateHash() -> String {
        var hash = ""
        hash = self.createTimeStamp() + API_SECRET_KEY + API_PUBLIC_KEY
        hash = hash.md5()
        return hash
    }
    
    private func createTimeStamp() -> String {
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        dateFormatter.dateFormat = "yyyy-MM-ddHH:mm:s"
        let nowString = dateFormatter.string(from: now)
        return nowString
    }
    
    func getApiHash() -> String {
        let apiHash = "&ts=" + self.createTimeStamp() + "&hash=" + self.generateHash()
        return apiHash
    }
}
