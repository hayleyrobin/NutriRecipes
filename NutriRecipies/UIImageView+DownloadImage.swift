//
//  UIImageView+DownloadImage.swift
//  NutriRecipies
//
//  Created by Hayley Robinson on 11/29/21.
//

import UIKit

// downloads the image and automatically displays it via the image view on the table view cell with just one line of code!
extension UIImageView {
  func loadImage(url: URL) -> URLSessionDownloadTask {
    let session = URLSession.shared
    let downloadTask = session.downloadTask(with: url) {
      [weak self] url, _, error in

      if error == nil, let url = url,
        let data = try? Data(contentsOf: url),
        let image = UIImage(data: data) {

        DispatchQueue.main.async {
          if let weakSelf = self {
            weakSelf.image = image
          }
        }
      }
    }
    downloadTask.resume()
    return downloadTask
  }
}

