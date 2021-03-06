//
//  RequestBuilder.swift
//  BreweryDB
//
//  Created by Jake Welton on 1/30/16.
//  Copyright © 2016 Jake Welton. All rights reserved.
//

import Foundation

public enum RequestEndPoint: String {
    case Beers = "beers"
    case Breweries = "breweries"
}

public extension NSURL {
    func URLByAppendingPathComponent(endPoint: RequestEndPoint) -> NSURL {
        return URLByAppendingPathComponent(endPoint.rawValue)
    }
}

public class RequestBuilder {
    let apiKeyQueryItem = NSURLQueryItem(name: "key", value: BreweryDBApiKey)
    let endPoint: RequestEndPoint
    
    public init(endPoint: RequestEndPoint) {
        self.endPoint = endPoint
    }
    
    public func buildRequest<T : RawRepresentable where T.RawValue == String>(requestParams: [T: String], orderParam: String? = nil) -> NSURLRequest? {
        guard let _ = BreweryDBApiKey else {
            print("BreweryDB: No Brewery API key set. Please set a valid API key before attempting to perform a request.")
            return nil
        }
        
        let baseURL = BreweryDBBaseURL.URLByAppendingPathComponent(endPoint)
        
        let components = NSURLComponents(URL: baseURL, resolvingAgainstBaseURL: false)
        components?.queryItems = [apiKeyQueryItem]
        
        for param in requestParams {
            let queryItem = NSURLQueryItem(name: param.0.rawValue, value: param.1)
            components?.queryItems?.append(queryItem)
        }
        
        if let orderParam = orderParam {
            let queryItem = NSURLQueryItem(name: "order", value: orderParam)
            components?.queryItems?.append(queryItem)
        }
        
        guard let url = components?.URL else{
            return nil
        }
        
        return NSURLRequest(URL: url)
    }
}