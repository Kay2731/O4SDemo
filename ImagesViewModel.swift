//
//  ImagesViewModel.swift
//  O4S
//
//  Created by Keertika on 06/02/21.
//  Copyright © 2021 keertika. All rights reserved.
//

import Foundation



class ImagesViewModel{
    private var service:Service!
    private(set) var imageData:[ImageFile]!{
        didSet{
            bindImagesViewModelToController()
        }
    }
    
    var bindImagesViewModelToController:(()->()) = {}
    
     init(){
       service = Service()
        getImagesData()
    }
    
    
    func getImagesData(){
        self.service.request(ImageFile.self,urlString:"http://pastebin.com/raw/wgkJgazE")
        {(response) in
            
            switch response{
            case .success(let images):
                self.imageData = images
            case .failure(let error):
                print(error)
            }
           
        }
    }
    
}
