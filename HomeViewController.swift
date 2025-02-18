//
//  HomeViewController.swift
//  O4S
//
//  Created by Keertika on 05/02/21.
//  Copyright © 2021 keertika. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    private var imagesViewModel:ImagesViewModel!
 
    private var dataSource : MediaCollectionViewDataSource<HomeCollectionViewCell,ImageFile>!
    private lazy var session: URLSession = {
//        URLCache.shared.memoryCapacity = 512 * 1024 * 1024

        let configuration = URLSessionConfiguration.default
//        configuration.requestCachePolicy = .returnCacheDataElseLoad

        return URLSession(configuration: configuration)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        callViewModelForUIUpdate()
 
    }

    func callViewModelForUIUpdate(){
        self.imagesViewModel = ImagesViewModel()
        self.imagesViewModel.bindImagesViewModelToController = {
            self.updateDataSource()
        }
    }
    
    func updateDataSource(){
           
        self.dataSource = MediaCollectionViewDataSource(cellIdentifier: "HomeCollectionViewCell", items: imagesViewModel.imageData,session:session,configureCell: { (cell, item) in
            cell.configureCell( urlString: item.links.download , session: self.session)
        })

           DispatchQueue.main.async {
               self.collectionView.dataSource = self.dataSource
               self.collectionView.reloadData()
           }
    }
    
}

extension HomeViewController:   UICollectionViewDelegateFlowLayout,UICollectionViewDelegate{
 
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
 
        let padding: CGFloat =  50
        let collectionViewSize = collectionView.frame.size.width - padding

        return CGSize(width: collectionViewSize/2, height: collectionViewSize/2)
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {

        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
 
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
 
 
 

}
