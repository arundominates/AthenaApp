//
//  DownloadManager.swift
//  AthenaApp
//
//  Created by Arun Satyavan on 27/03/21.
//

import UIKit

typealias ImageDownloadHandler = (_ image: UIImage?, _ url: URL, _ indexPath: IndexPath?, _ error: Error?) -> Void

final class ImageDownloadManager {
    private var completionHandler: ImageDownloadHandler?
    lazy var imageDownloadQueue: OperationQueue = {
        var queue = OperationQueue()
        queue.name = "com.AthenaApp.imageDownloadqueue"
        queue.qualityOfService = .userInteractive
        return queue
    }()
    private let imageCache = NSCache<NSString, UIImage>()
    static let shared = ImageDownloadManager()
    private init () {
        //Cache Management
        self.imageCache.countLimit = 40
    }
    
    func downloadImage(_ image: Photo, indexPath: IndexPath?, size: String = "m", handler: @escaping ImageDownloadHandler) {
        self.completionHandler = handler
        let url = URL(string: image.media.m)!
        
        //check for the cached image for url
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            print("Get image from cache \(url)")
           self.completionHandler?(cachedImage, url, indexPath, nil)
        } else {
             /* check if there is a download task that is currently downloading the same image. */
            if let operations = (imageDownloadQueue.operations as? [Downloader])?.filter({$0.imageUrl.absoluteString == url.absoluteString && $0.isFinished == false && $0.isExecuting == true }), let operation = operations.first {
                operation.queuePriority = .veryHigh
            }else {
                /* create a new task to download the image.  */
                print("Get image from server \(url)")
                let operation = Downloader(url: url, indexPath: indexPath)
                if indexPath == nil {
                    operation.queuePriority = .high
                }
                operation.downloadHandler = { (image, url, indexPath, error) in
                    if let newImage = image {
                        self.imageCache.setObject(newImage, forKey: url.absoluteString as NSString)
                    }
                    self.completionHandler?(image, url, indexPath, error)
                }
                imageDownloadQueue.addOperation(operation)
            }
        }
    }
    
    ///To Cancel download operations
    func cancelImageDownloadTaskfor (_ photo: Photo) {
        guard let url = URL(string: photo.media.m)  else {
            return
        }
        if let operations = (imageDownloadQueue.operations as? [Downloader])?.filter({$0.imageUrl.absoluteString == url.absoluteString && $0.isFinished == false && $0.isExecuting == true }), let operation = operations.first {
            print("Cancel Download for \(url)")
            operation.cancel()
        }
    }
    
    func cancelAll() {
        imageDownloadQueue.cancelAllOperations()
    }
    
}

