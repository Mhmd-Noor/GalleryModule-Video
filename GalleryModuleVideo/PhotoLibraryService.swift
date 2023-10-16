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
    @Published var results = PHFetchResultCollection(fetchResult: .init())
    
    func requestAuthorization(handleError: ((AuthorizationError?) -> Void)? = nil) {
        PHPhotoLibrary.requestAuthorization { status in
           // DispatchQueue.main.async {
                self.authorizationStatus = status
                switch status {
                case .authorized, .limited:
                    self.fetchVideos()
                case .denied, .notDetermined, .restricted:
                    handleError?(.restrictedAccess)
                default:
                    break
                }
           // }
        }
    }
    
    private func fetchVideos() {
        videoCachingManager.allowsCachingHighQualityImages = false
        
        // assign options to fetch videos based
        let fetchOptions = PHFetchOptions()
        fetchOptions.includeHiddenAssets = false
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        
        DispatchQueue.main.async {
            self.results.fetchResult = PHAsset.fetchAssets(with: .video, options: fetchOptions)
            print(self.results.fetchResult)
        }
    }
}
