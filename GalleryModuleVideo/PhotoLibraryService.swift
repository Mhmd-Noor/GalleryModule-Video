//
//  PhotoLibraryService.swift
//  GalleryModuleVideo
//
//  Created by mohammad noor uddin on 16/10/23.
//

import Foundation
import Photos
import UIKit

class PhotoLibraryService: ObservableObject {
    
    var authorizationStatus: PHAuthorizationStatus = .notDetermined
    var videoCachingManager = PHCachingImageManager()

    @Published var videosCount: Int = 0
    @Published var thumbnails: [UIImage] = []
    @Published var allFetchedMedia: [Int: Media] = [:]
    @Published var localVideoRequestCriteriaBuilder = RequestCriteriaBuilder()
    
    func requestAuthorization() {
        PHPhotoLibrary.requestAuthorization { status in
            DispatchQueue.main.async {
                self.authorizationStatus = status
                switch status {
                case .authorized, .limited:
                    self.fetchVideoAssets()
                case .denied, .notDetermined, .restricted:
                    print("Error Found!")
                default:
                    break
                }
            }
        }
    }
    
    private func fetchVideoAssets() {
        
//        let fetchOptions = PHFetchOptions()
////        fetchOptions.fetchLimit = 3
//        
//        // Specify the duration range in seconds
//        let minDuration = NSNumber(value: 0)
//        let maxDuration = NSNumber(value: 10)
//
//        // Use %@ as the placeholder for the arguments
//        fetchOptions.predicate = NSPredicate(format: "duration >= %@ AND duration <= %@", minDuration, maxDuration)
////        fetchOptions.predicate = NSPredicate(format: "duration >= %i AND duration <= %i", argumentArray: [60,120])
//        
//        let videoFetchResult = PHAsset.fetchAssets(with: .video, options: nil)
//        self.videosCount = videoFetchResult.count
//        print("Total Videos",videoFetchResult.count)
        
        let predicate = Predicate()
        predicate.makePredicateLogic(key: .mediaType, comparator: .equal , specifier: .objectSpecifier)
        predicate.addArgument(PHAssetMediaType.video.rawValue)
        
        
        allFetchedMedia = localVideoRequestCriteriaBuilder
          .setFetchLimit(2)
          .setPredicate(predicate)
          .setSortDescriptors(.byCreationDateAscending)
          .build()
        
        self.videosCount = allFetchedMedia.count
        
        print("all media: ",allFetchedMedia)
        
        //load thumbnails
        for (_, value) in allFetchedMedia {
            PHCachingImageManager.default().requestImage(for: value.asset,
                                                         targetSize: CGSize(width: 100, height: 100),
                                                         contentMode: .aspectFill,
                                                         options: nil) { (photo, info) in
                
                // When degraded image is provided, the completion handler will be called again.
                guard !(info?[PHImageResultIsDegradedKey] as? Bool ?? false) else { return }
                self.thumbnails.append(photo!)
            
            }
        }

     }
}
