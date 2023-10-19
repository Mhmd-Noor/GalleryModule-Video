//
//  Media.swift
//  GalleryModuleVideo
//
//  Created by mohammad noor uddin on 19/10/23.
//

import Foundation
import Photos
import UIKit


protocol Media {
    
    var asset: PHAsset { get }
    func loadVideoThumbnails<T: RequestCriteria>(_ loadOptions: T, completion: @escaping (UIImage?) -> Void)
//    func loadImageData<T: RequestCriteria>(_ loadOptions: T, completion: @escaping (UIImage?) -> Void)
    
}
