////
////  PhotoLibraryService.swift
////  GalleryModuleVideo
////
////  Created by mohammad noor uddin on 16/10/23.
////
//
//import Foundation
//import Photos
//import UIKit
//
//class PhotoLibraryService {
//    
//    var authorizationStatus: PHAuthorizationStatus = .notDetermined
//    var videoCachingManager = PHCachingImageManager()
//
////    @Published var videosCount: Int = 0
////    @Published var thumbnails: [UIImage] = []
////    @Published var allFetchedMedia: [Int: Media] = [:]
//    
//    var dataModel: DataModel
//    
//    init(dataModel: DataModel){
//        self.dataModel = dataModel
//    }
//    
//    func requestAuthorization() {
//        PHPhotoLibrary.requestAuthorization { status in
//            self.authorizationStatus = status
//            switch status {
//            case .authorized, .limited:
//                self.fetchVideoAssets()
//            case .denied, .notDetermined, .restricted:
//                print("Error Found!")
//            default:
//                break
//            }
//
//        }
//    }
//    
//    private func fetchVideoAssets() {
//        
//        let predicate = Predicate()
//        
//        
//        
//        //load thumbnails
//        for (_, value) in allFetchedMedia {
//            PHCachingImageManager.default().requestImage(for: value.asset,
//                                                         targetSize: CGSize(width: 100, height: 100),
//                                                         contentMode: .aspectFill,
//                                                         options: nil) { (photo, info) in
//                
//                // When degraded image is provided, the completion handler will be called again.
//                guard !(info?[PHImageResultIsDegradedKey] as? Bool ?? false) else { return }
//                self.thumbnails.append(photo!)
//            
//            }
//        }
//
//     }
//    
//    private func getRecentVideos() {
//        
//        DispatchQueue.main.async {
//            
//            let albums = dataModel.mediaGroupResult.allMedia
//            for album in albums {
//               
//                
//                if  album.assetCollection.localizedTitle == "Recents"{
//                    let imgRqst = dataModel.localImageRequestBuilder.setSelectedAlbum(album.assetCollection).build()
//                    let provider = dataModel.mediaProviderBuilder.build()
//                    dataModel.mediaResult = provider.getImages(localImageRequest: imgRqst, isPaginated: false)
//                }
//            }
//        }
//        
//    }
//}
