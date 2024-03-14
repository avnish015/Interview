//
//  ImageDownloader.swift
//  AsyncImageLoadInTableViewCell
//
//  Created by Nishant Kumar on 14/03/24.
//

import UIKit

class ImageDownloader {
    
    static let shared = ImageDownloader()
    
    private var cache: NSCache<NSURL, UIImage> = NSCache()
    private var runningTasks: [UUID: URLSessionDataTask] = [:]
    
    func downloadImage(string: String?, completionHandler: @escaping (UIImage?) -> Void) -> UUID? {
        
        guard let string, let url = URL(string: string) else {
            completionHandler(nil)
            return nil
        }
        
        if let image = cache.object(forKey: url as NSURL) {
            completionHandler(image)
            return nil
        }
        
        let uuid = UUID()
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data, let image = UIImage(data: data) {
                self.cache.setObject(image, forKey: url as NSURL)
                completionHandler(image)
            } else {
                guard (error as? NSError)?.code == NSURLErrorCancelled else {
                    return
                }
                completionHandler(nil)
            }
        }
        task.resume()
        self.runningTasks[uuid] = task
        return uuid
    }
    
    func cancelTask(uuid: UUID) {
        self.runningTasks[uuid]?.cancel()
        self.runningTasks.removeValue(forKey: uuid)
    }
}
