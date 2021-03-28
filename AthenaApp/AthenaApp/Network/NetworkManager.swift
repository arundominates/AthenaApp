//
//  NetworkManager.swift
//  AthenaApp
//
//  Created by Arun Satyavan on 26/03/21.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case unknownStatusCode
    case dataFetchError
}

final class NetworkManager {
    
    private let domainUrlString =  "https://api.flickr.com/services/feeds/photos_public.gne?tagmode=any&format=json&nojsoncallback=1?&per_page=20&"
    
    ///Web Service call for fteching photos specific to Album
    func fetchPhotoForAlbum(searchText: String, index: String, completionHandler: @escaping (Result<[Photo],NetworkError>) -> Void) {
        
        let photosEndPoint = "tags=\(searchText)&page=\(index)"
        let fullUrl = domainUrlString + photosEndPoint
        let escapedString = fullUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: escapedString!)!

        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if error != nil {
              completionHandler(.failure(.dataFetchError))
              return
            }
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
                completionHandler(.failure(.unknownStatusCode))
          return
        }

        do {
            let model = try JSONDecoder().decode(Album.self, from: data!)
            completionHandler(.success(model.items))
        } catch let error as NSError {
           print("\(error)")
        }

      })
      task.resume()
    }
    
    
}
