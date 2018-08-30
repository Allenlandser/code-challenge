//
//  FSApiClient.swift
//  FlickrSearcher
//
//  Created by Liu Yixiang on 8/28/18.
//  Copyright © 2018 Liu Yixiang. All rights reserved.
//

import UIKit

class FSAPIClient: NSObject {
    
    
    static let shared = FSAPIClient()
    
    private let manager: AFHTTPSessionManager
    
    override init() {
        manager = AFHTTPSessionManager()
        manager.responseSerializer = AFJSONResponseSerializer()
    }
    
    public func getFlickrImages(with keyword: String, offset: Int, completion: ((_ data: Any) -> Void)?) {
        manager.get("https://api.flickr.com/services/feeds/photos_public.gne",
                    parameters: ["format": "json", "nojsoncallback": 1, "page": offset, "text": keyword],
                    progress: nil,
                    success: {
                        (task: URLSessionDataTask!, responseObject: Any) in
                        completion?(responseObject)
        }, failure: {
            (operation: URLSessionDataTask!,error: Error) in
            print("Error:" + error.localizedDescription)
        })
    }
}
