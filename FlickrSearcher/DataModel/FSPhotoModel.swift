//
//  FSPhotoModel.swift
//  FlickrSearcher
//
//  Created by Liu Yixiang on 8/28/18.
//  Copyright © 2018 Liu Yixiang. All rights reserved.
//

import UIKit

public class FSPhotoModel: FSPhotoProtocol {

    private static let kTitleKey = "title"
    private static let kMediaKey = "media"
    private static let kURLKey = "m"
    private static let kPublishedKey = "published"
    
    private(set) var title: String?
    private(set) var url: String?
    private(set)    var publishedDate: String?
    
    init(photoData: Dictionary<String, Any>) {
        self.title = photoData[FSPhotoModel.kTitleKey] as? String
        if let media = photoData[FSPhotoModel.kMediaKey] as? Dictionary<String, Any> {
            self.url = media[FSPhotoModel.kURLKey] as? String
        }
        self.publishedDate = photoData[FSPhotoModel.kPublishedKey] as? String
    }
}
