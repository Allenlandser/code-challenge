//
//  ViewController.swift
//  FlickrSearcher
//
//  Created by Liu Yixiang on 8/28/18.
//  Copyright © 2018 Liu Yixiang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private var searchBar: UISearchBar!
    @IBOutlet private var collectionView: UICollectionView!
    
    fileprivate static let columns = 2
    fileprivate static let horizontalMargin = CGFloat(10.0)
    fileprivate static let spacing = CGFloat(10.0)
    
    fileprivate let photoEngineer = FSPhotoEngineer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        
        collectionView.register(FSPhotoCollectionViewCell.self, forCellWithReuseIdentifier: FSPhotoCollectionViewCell.reuseIdentifier())
        
        collectionView.dataSource = photoEngineer
        collectionView.delegate = self
        
        photoEngineer.search(keyword: "", completion: {
            self.collectionView.reloadData()
        })
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == photoEngineer.photoViewModels.count - 1 {
            photoEngineer.queryData()
        }
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let innerWidth = collectionView.bounds.size.width - ViewController.horizontalMargin * 2
        let width = (innerWidth - CGFloat(ViewController.columns - 1) * ViewController.spacing) / CGFloat(2.0)
        let height = width
        return CGSize(width: width, height: height)
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.text = ""
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let keyword = searchBar.text
        searchBar.resignFirstResponder()
        photoEngineer.search(keyword: keyword ?? "", completion: {
            self.collectionView.reloadData()
        })
    }
}
