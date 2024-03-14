//
//  UIImage+Extension.swift
//  AsyncImageLoadInTableViewCell
//
//  Created by Avnish Kumar on 13/03/24.
//

import UIKit

extension UIImageView {
    
    func load(string: String?) -> UUID? {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.tintColor = .blue
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        activityIndicator.startAnimating()
        return ImageDownloader.shared.downloadImage(string: string) { image in
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
    
    func cancelDownloading(uuid: UUID?) {
        if let uuid {
            ImageDownloader.shared.cancelTask(uuid: uuid)
        }
    }
}
