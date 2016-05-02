//
//  Brewery.swift
//  BreweryDB
//
//  Created by Jake Welton on 29/04/2016.
//  Copyright © 2016 Jake Welton. All rights reserved.
//

import Foundation

class Brewery {
    let identifier: String
    var name: String?
    var established: String?
    var isOrganic: Bool?
    var description: String?
    var website: NSURL?
    var mailingListURL: NSURL?
    var imageURLSet: ImageURLSet?
    
    init(identifier: String) {
        self.identifier = identifier
    }
}

extension Brewery: JSONParserEntity {
    static func mapJSONToObject(rawBrewery: JSON) -> AnyObject? {
        guard let identifier = rawBrewery["id"] as? String else {
            return nil
        }
        
        let brewery = Brewery(identifier: identifier)
        brewery.name = rawBrewery["name"] as? String
        brewery.established = rawBrewery["established"] as? String
        brewery.isOrganic = rawBrewery["isOrganic"] as? String == "Y"
        brewery.description = rawBrewery["description"] as? String
        
        if let websiteURL = rawBrewery["website"] as? String {
            brewery.website = NSURL(string: websiteURL)
        }
        
        if let mailingListURL = rawBrewery["mailingListURL"] as? String {
            brewery.mailingListURL = NSURL(string: mailingListURL)
        }
        
        if let labels = rawBrewery["images"] as? JSON {
            brewery.imageURLSet = ImageURLSet.mapJSONToObject(labels) as? ImageURLSet
        }
        
        return brewery
    }
}