//
//  UIImage+Extension.swift
//  AsyncImageLoadInTableViewCell
//
//  Created by Avnish Kumar on 13/03/24.
//

import UIKit

class ImageDownloader {
    
    static let shared = ImageDownloader()
    
    var cache: NSCache<NSURL, UIImage> = NSCache()
    
    func downloadImage(string: String?, completionHandler: @escaping (UIImage?) -> Void) {
        
        guard let string, let url = URL(string: string) else {
            completionHandler(nil)
            return
        }
        
        if let image = cache.object(forKey: url as NSURL) {
            completionHandler(image)
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data, let image = UIImage(data: data) {
                self.cache.setObject(image, forKey: url as NSURL)
                completionHandler(image)
            } else {
                completionHandler(nil)
            }
        }
        .resume()
    }
}

extension UIImageView {
    
    func load(string: String?) {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.tintColor = .blue
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        activityIndicator.startAnimating()
        ImageDownloader.shared.downloadImage(string: string) { image in
            DispatchQueue.main.async {
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
                if let image {
                    self.image = image
                } else {
                    self.image = UIImage(systemName: "person")
                }
            }
        }
    }
}
