//
//  MediaProvider.swift
//  GalleryModuleVideo
//
//  Created by mohammad noor uddin on 19/10/23.
//

import Foundation

protocol MediaProvider{
    
    func getMediaData<T: RequestCriteria>(fetchOptions: T) ->[Int: Media]
    func getCategoryData()
    func getPaginatedMediaData()
    func getPaginatedCategoryData()
}

