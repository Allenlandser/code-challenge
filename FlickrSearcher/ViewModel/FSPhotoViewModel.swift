//
//  FSPhotoViewModel.swift
//  FlickrSearcher
//
//  Created by Liu Yixiang on 8/28/18.
//  Copyright © 2018 Liu Yixiang. All rights reserved.
//

import UIKit

class FSPhotoViewModel {
    private(set) var title: String
    private(set) var url: URL?
    private(set) var publishedDate: String
    
    init(photoModel: FSPhotoModel) {
        self.title = photoModel.title ?? ""
        
        let urlString = photoModel.url ?? ""
        self.url = URL(string: urlString)
        
        if let date = FSPhotoViewModel.dateFormatter().date(from: photoModel.publishedDate ?? "") {
            self.publishedDate = FSPhotoViewModel.decodeDateFormatter().string(from: date)
        } else {
            self.publishedDate = ""
        }
    }
    
    private static func dateFormatter() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFormatter
    }
    
    private static func decodeDateFormatter() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }
}
