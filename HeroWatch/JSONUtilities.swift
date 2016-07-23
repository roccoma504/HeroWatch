//
//  JSONUtilities.swift
//  HeroWatch
//
//  Created by Matthew Rocco on 7/19/16.
//  Copyright © 2016 Matthew Rocco. All rights reserved.
//

import UIKit

class JSONUtilities {
    
    static func retrieve(url : NSURL, completion: (json: [String : AnyObject]!, error: NSError?) ->()){
        var retrievedData : [String : AnyObject]!
        
        let request = NSMutableURLRequest(URL: url)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { data, response, error in
        
            if error != nil {
                let error = NSError(domain: "Failed to retrieve data. Please check your connection.", code: 400, userInfo: nil)
                completion(json: retrievedData, error: error);

            }
            else {
                do {
                    retrievedData = try NSJSONSerialization.JSONObjectWithData(data!,options: []) as! [String : AnyObject]
                    if retrievedData ["error"] != nil {
                        let error = NSError(domain: retrievedData ["error"] as! String, code: 100, userInfo: nil)
                        completion(json: [:], error: error);
                    }
                }
                catch {
                    let error = NSError(domain: "Failed to retrieve data.", code: 101, userInfo: nil)
                    completion(json: [:], error: error);
                }
            }
            completion(json: retrievedData, error: error);
        }
        task.resume()
    }
}
