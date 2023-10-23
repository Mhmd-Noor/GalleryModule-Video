//
//  Video.swift
//  GalleryModuleVideo
//
//  Created by mohammad noor uddin on 23/10/23.
//

import Foundation
import UIKit

class Video<R: Any>: Media {
    
    // Override the func
    func loadVideoData(loadOptions: R, completion: @escaping (UIImage?) -> Void) { }
    
}
