//
//  HomeCollectionViewCell.swift
//  O4S
//
//  Created by Keertika on 06/02/21.
//  Copyright © 2021 keertika. All rights reserved.
//

import UIKit



protocol MediaFile {
    var links:Links { get set }
}

class HomeCollectionViewCell: MediaCell {
    @IBOutlet weak var failedLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    private var dataTask: URLSessionDataTask?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.failedLabel.isHidden = true
    }
    
    func configureCell(urlString:String,session: URLSession){
        configure(urlString:urlString,session: session, success: {[weak self] (downloadedImage) in
            self?.imageView.image = downloadedImage
        }){[weak self] in
            DispatchQueue.main.async {
                self?.failedLabel.isHidden = false
            }
        }
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.failedLabel.isHidden = true
        imageView.image = UIImage()

    }
}
