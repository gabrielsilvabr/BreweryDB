//
//  CategoryRequest.swift
//  BreweryDB
//
//  Created by Jake Welton on 6/24/16.
//  Copyright © 2016 Jake Welton. All rights reserved.
//

import Foundation

public class CategoryRequest {
    private let requestBuilder = RequestBuilder(endPoint: .Categories)
    private var request: NSURLRequest
    
    public var requestURL: NSURLRequest {
        return request
    }
    
    public init?() {
        guard let url = requestBuilder.buildRequest([BeerRequestParam: String]()) else {
            return nil
        }
        
        request = url
    }
    
    public func loadCategoriesWithCompletionHandler(completionHandler: ((categories: [Category]?)->Void)) {
        NSURLSession.sharedSession().dataTaskWithRequest(requestURL) { data, response, error in
            guard let returnedData = data,
                let response = response as? NSHTTPURLResponse where response.statusCode == 200 else {
                    completionHandler(categories: nil)
                    return
            }
            
            let jsonParser = JSONParser<Category>(rawData: returnedData)
            jsonParser?.extractObjectsWithCompletionHandler(completionHandler)
            
            }.resume()
    }
}

extension CategoryRequest: CustomStringConvertible {
    public var description: String {
        return requestURL.URL?.absoluteString ?? ""
    }
}