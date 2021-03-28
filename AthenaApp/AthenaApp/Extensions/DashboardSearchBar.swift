//
//  DashboardSearchBar.swift
//  AthenaApp
//
//  Created by Arun Satyavan on 28/03/21.
//

import UIKit

// MARK: UITextFieldDelegate
extension DashboardViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text {
            paging = 1
            ImageDownloadManager.shared.cancelAll()
            photoContent.removeAll()
            photosCollectionView.reloadData()
            searchString = searchText
            fetchPhotoDetailsFromServer(searchText: searchText)
        }
    }

}
