//
//  MediaCell.swift
//  O4S
//
//  Created by Keertika on 07/02/21.
//  Copyright © 2021 keertika. All rights reserved.
//

import Foundation
import UIKit

//protocol MediaProtocol{
//   func configureCell(urlString:String,session: URLSession)
//}

class MediaCell:UICollectionViewCell{
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    private var dataTask: URLSessionDataTask?

    override func awakeFromNib() {
        self.activityIndicator.hidesWhenStopped = true

    }
    
    func configure(urlString:String,session: URLSession, success:@escaping (UIImage)->Void,failure:@escaping ()->Void){
        if let cachedImage = Cache.shared.image(forKey: urlString) {
            success(cachedImage)
            return
        }

        if let url = URL(string:urlString) {
             // Create Data Task
            activityIndicator.startAnimating()
            let dataTask = session.dataTask(with: url) {[weak self] (data, response, error) in

                self?.hideActivityIndicator()

                guard let data = data,let downloadedImage = UIImage(data: data) else {
                    failure()
                    return
                }

                // Initialize Image
                Cache.shared.save(image: downloadedImage, forKey: urlString)

                DispatchQueue.main.async {
                    success(downloadedImage)
                }
            }

            // Resume Data Task
            dataTask.resume()

            // Update Data Task
            self.dataTask = dataTask
         }
    }
    
    private func hideActivityIndicator(){
        DispatchQueue.main.async {
        self.activityIndicator.stopAnimating()}
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        dataTask?.cancel()
        dataTask = nil
    }
}

