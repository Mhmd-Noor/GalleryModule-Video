//
//  MediaGroupCollector.swift
//  GalleryModuleVideo
//
//  Created by mohammad noor uddin on 23/10/23.
//

import Foundation

class MediaGroupCollector<M : Media, R: Any> {
    
    func getMediaCategoryData(_ request: R, _ isPaginated: Bool) -> MediaResult<M> {
        return MediaResult()
    }
}
