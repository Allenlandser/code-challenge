//
//  FSPhotoEngineer.swift
//  FlickrSearcher
//
//  Created by Liu Yixiang on 8/28/18.
//  Copyright © 2018 Liu Yixiang. All rights reserved.
//

import UIKit

public class FSPhotoEngineer: NSObject {
    private var photos: [FSPhotoModel]
    fileprivate(set) var photoViewModels: [FSPhotoViewModel]
    private var keyword: String
    private var offset: Int
    private var completionBlock: (() -> Void)?
    private let pageSize = 1
    
    override init() {
        photos = []
        photoViewModels = []
        keyword = ""
        offset = 0
    }
    
    public func search(keyword: String, completion: (() -> Void)?) {
        self.keyword = keyword
        self.offset = 0
        self.photos.removeAll()
        self.photoViewModels.removeAll()
        self.completionBlock = completion
        self.queryData()
    }
    
    public func queryData() {
        FSAPIClient.shared.getFlickrImages(with: self.keyword,
                                           offset: self.offset, completion: { (data: Any) in
                                            guard let data = data as? Dictionary<String, Any>,
                                                let itemsData = data["items"],
                                                let photosData = itemsData as? Array<Any> else { return }
                                            let tmpPhotos = photosData.flatMap({ (photoData: Any) -> FSPhotoModel? in
                                                guard let photoDataDictionary = photoData as? Dictionary<String, Any> else { return nil }
                                                let photoModel = FSPhotoModel.init(photoData: photoDataDictionary)
                                                return photoModel
                                            }).flatMap( { $0 })
                                            
                                            let tmpViewModels = tmpPhotos.flatMap( {(model: FSPhotoModel) -> FSPhotoViewModel in
                                                return FSPhotoViewModel.init(photoModel: model)
                                            })
                                            
                                            self.photos.append(contentsOf: tmpPhotos)
                                            self.photoViewModels.append(contentsOf: tmpViewModels)
                                            
                                            self.offset += self.pageSize
                                            
                                            self.completionBlock?()
        })
    }
}

extension FSPhotoEngineer: UICollectionViewDataSource {
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoViewModels.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FSPhotoCollectionViewCell.reuseIdentifier(), for: indexPath)
        
        if let cell = cell as? FSPhotoCollectionViewCell {
            cell.configure(photoViewModels[indexPath.row])
        }
        
        return cell
    }
}
