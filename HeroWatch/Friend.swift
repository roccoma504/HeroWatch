//
//  Friend.swift
//  HeroWatch
//
//  Created by Matthew Rocco on 7/31/16.
//  Copyright © 2016 Matthew Rocco. All rights reserved.
//

import UIKit

class Friend: NSObject, NSCoding {
    
    enum ValueKind {
        case Name, Platform, Region
    }
    
    var name : String!
    var platform : String!
    var region : String!

    init (name : String, region : String, platform: String) {
        self.name = name
        self.region = region
        self.platform = platform
    }
    
    // MARK: NSCoding
    
    required convenience init?(coder decoder: NSCoder) {
        guard let name = decoder.decodeObjectForKey("name") as? String,
            let region = decoder.decodeObjectForKey("region") as? String,
            let platform = decoder.decodeObjectForKey("platform") as? String
            else { return nil }
        
        self.init(
            name: name,
            region: region,
            platform: platform
        )
    }
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(self.name, forKey: "name")
        coder.encodeObject(self.region, forKey: "region")
        coder.encodeObject(self.platform, forKey: "platform")
    }
    
    func get (value : ValueKind) -> String {
        switch value {
        case .Name:
            return name
        case .Platform:
            return platform
        case .Region:
            return region
        }
    
    }


}
