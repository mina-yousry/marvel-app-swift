//
//  ParentClient.swift
//  Marvel App
//
//  Created by Mina  on 3/5/19.
//  Copyright © 2019 ITG. All rights reserved.
//

import Foundation
import Alamofire

class  ParentClient {
    
    private static var client : ParentClient?
    private static let serialQueue = DispatchQueue(label: "ParentClientQueue")
    private let apiHashGenerator = ModelsFactory.sharedInstance().ApiHashGeneratorInstace()
    private init(){}
    
    static func sharedInstance() -> ParentClient{
        if self.client == nil{
            self.serialQueue.sync {
                if self.client == nil{
                    self.client = ParentClient()
                }
            }
        }
        return self.client!
    }
    
    func fetchData(url: String, method: HTTPMethod, parameters: [String:String]?, onSuccess: @escaping ([String: Any]) -> Void) {
        
        let fullUrl = url + self.apiHashGenerator.getApiHash()
        let apiURL = URL(string: fullUrl)
        
        Alamofire.request(apiURL!, method: method, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            print("Request: \(String(describing: response.request))")
            print("Response: \(String(describing: response.response))")
            print("Result: \(response.result)")
            var json : [String:Any]?
            if let result = response.result.value {
                json = result as? [String: Any]
                //print(response)
            }
            switch response.response?.statusCode {
            case 200?:
                if let _ = json {
                    onSuccess(json!)
                }
            case 409?,401?,405?,403?:
                if let _ = json {
                    let error = ErrorResponse(JSON: json!)
                    AlertViewer().showAlertViewAboveAnyController(msg: error?.message ?? "default error")
                }
            default:
                AlertViewer().showAlertViewAboveAnyController(msg: "Sorry, We encountered an error.Please, Try again in a few moment")
            }
        }
    }
}
