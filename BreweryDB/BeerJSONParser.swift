//
//  BeerJSONParser.swift
//  BreweryDB
//
//  Created by Jake Welton on 30/04/2016.
//  Copyright © 2016 Jake Welton. All rights reserved.
//

import Foundation

typealias JSON = [String: AnyObject]

class BeerJSONParser {
    let rawData: NSData
    let decodedData: JSON
    var currentPage: Int?
    var totalNumberOfPages: Int?
    var totalResults: Int?
    var extractedBeers = [Beer]()
    
    init?(rawData data: NSData) {
        rawData = data
        
        guard let decodedJSON = (try? NSJSONSerialization.JSONObjectWithData(data, options: [])) as? JSON else {
            print("BreweryDB: Invalid data. Unable to decode data into object.")
            return nil
        }
        
        decodedData = decodedJSON
    }
    
    func extractBeersWithCompletionHandler(completionHandler: (([Beer]?)->Void)) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) {
            self.currentPage = self.decodedData["currentPage"] as? Int
            self.totalNumberOfPages = self.decodedData["numberOfPages"] as? Int
            self.totalResults = self.decodedData["totalResults"] as? Int
            
            guard let extractedData = self.decodedData["data"] as? [JSON] else {
                completionHandler(nil)
                return
            }
            
            for rawBeer in extractedData {
                guard let identifier = rawBeer["id"] as? String else {
                    continue
                }
                
                let beer = Beer(identifier: identifier)
                beer.name = rawBeer["name"] as? String
                beer.description = rawBeer["description"] as? String
                beer.originalGravity = rawBeer["originalGravity"] as? String
                beer.abv = rawBeer["abv"] as? String
                beer.ibu = rawBeer["ibu"] as? String
                beer.isOrganic = rawBeer["isOrganic"] as? String == "Y"
                beer.servingTemperature = rawBeer["servingTemperature"] as? String
                beer.servingTemperatureDisplay = rawBeer["servingTemperatureDisplay"] as? String
                beer.status = rawBeer["status"] as? String
                beer.statusDisplay = rawBeer["statusDisplay"] as? String
                
                self.extractedBeers.append(beer)
            }
            
            dispatch_async(dispatch_get_main_queue()) {
                completionHandler(self.extractedBeers)
            }
        }
    }
}