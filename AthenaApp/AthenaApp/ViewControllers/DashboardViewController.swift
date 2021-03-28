//
//  DashboardViewController.swift
//  AthenaApp
//
//  Created by Arun Satyavan on 24/03/21.
//

import UIKit

class DashboardViewController: UIViewController {

    @IBOutlet weak var photosCollectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var searchString = "animals"
    var paging = 1
    let pagingMaxCount = 5
    
    var photoContent = [Photo]()
    
    override func viewDidLoad() {
        setupView()
        fetchPhotoDetailsFromServer(searchText: searchString)
    }

    private func setupView()
    {
        searchBar.delegate                 = self
        searchBar.text                     = searchString
        searchBar.placeholder              = "Type here to serach"
        photosCollectionView.dataSource     = self
        photosCollectionView.delegate       = self
        photosCollectionView.register(UINib(nibName: "PhotosCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "photos")
    }
    

}
