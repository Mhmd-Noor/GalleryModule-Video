//
//  DataModel.swift
//  GalleryModuleVideo
//
//  Created by mohammad noor uddin on 19/10/23.
//

import Foundation

class DataModel: ObservableObject{
    
    @Published var allMedia: [Int: Media] = [:]
    @Published var count = 0
    @Published var localVideoRequestCriteriaBuilder = RequestCriteriaBuilder()

}
