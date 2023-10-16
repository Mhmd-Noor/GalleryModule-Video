//
//  PhotoLibraryService.swift
//  GalleryModuleVideo
//
//  Created by mohammad noor uddin on 16/10/23.
//

import Foundation
import Photos

enum AuthorizationError: Error {
    case restrictedAccess
}

class PhotoLibraryService: ObservableObject {
    
    var authorizationStatus: PHAuthorizationStatus = .notDetermined
    var videoCachingManager = PHCachingImageManager()
    
    var videoAssets: [AVURLAsset] = []
    
    func requestAuthorization(handleError: ((AuthorizationError?) -> Void)? = nil) {
        PHPhotoLibrary.requestAuthorization { status in
            DispatchQueue.main.async {
                self.authorizationStatus = status
                switch status {
                case .authorized, .limited:
                    self.fetchVideoAssets()
                case .denied, .notDetermined, .restricted:
                    handleError?(.restrictedAccess)
                    print("Error Found!")
                default:
                    break
                }
            }
        }
    }
    
    private func fetchVideoAssets() {

        let fetchOptions = PHFetchOptions()
//        fetchOptions.fetchLimit = 3
        
        // Specify the duration range in seconds
        let minDuration = NSNumber(value: 0)
        let maxDuration = NSNumber(value: 10)

        // Use %@ as the placeholder for the arguments
        fetchOptions.predicate = NSPredicate(format: "duration >= %@ AND duration <= %@", minDuration, maxDuration)
//        fetchOptions.predicate = NSPredicate(format: "duration >= %i AND duration <= %i", argumentArray: [60,120])
        
        
        let videoFetchResult = PHAsset.fetchAssets(with: .video, options: fetchOptions)
        print("Fetched Videos : ",videoFetchResult.count)
        
     }
}
