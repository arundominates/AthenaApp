//
//  DashboardViewModel.swift
//  AthenaApp
//
//  Created by Arun Satyavan on 24/03/21.
//

import Foundation

extension DashboardViewController {
   
    ///To fetch photos from server
    func fetchPhotoDetailsFromServer(searchText: String) {
        NetworkManager().fetchPhotoForAlbum(searchText: searchText, index: String(paging)) { (result) in
              switch result {
                  case .failure(let error):
                      print(error.localizedDescription)
                  break
                      
                  case .success(let contentData):
                   self.photoContent.append(contentsOf: contentData)
                      DispatchQueue.main.async{
                           self.photosCollectionView.reloadData()
                      }
                  break
              }
          }
    }
}
