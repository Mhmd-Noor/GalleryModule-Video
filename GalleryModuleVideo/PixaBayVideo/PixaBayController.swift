//
//  Controller.swift
//  GalleryModuleVideo
//
//  Created by mohammad noor uddin on 29/10/23.
//

import Foundation

class PixaBayController {
    
    let pixaBayAPI = PixaBayAPI()
    
    init() {
        self.pixaBayAPI.searchForVideos() { result in
            switch result {
            case .success(let data):
                // Process data
                print("PixaBay Video Data Count: ",data.hits.count, data.hits)
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
}
