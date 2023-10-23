//
//  ContentView.swift
//  GalleryModuleVideo
//
//  Created by mohammad noor uddin on 15/10/23.
//

import SwiftUI
import Photos
import AVKit

struct ContentView: View {
    
    @StateObject var dataModel = DataModel()
    @State var authorizationStatus: PHAuthorizationStatus = .notDetermined
    var videoCachingManager = PHCachingImageManager()
    @State var thumbnails: [UIImage] = []
    
    var body: some View {
        ScrollView([.vertical]){
            VStack {
                
                Text("Fetched Videos: \(dataModel.count)")
                    .padding(10)
                    .background(Color.gray)
                
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 10) {
                    ForEach(thumbnails, id: \.self){ image in
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    }
                }
                
            }
        }
        .onAppear(perform: {
            self.requestAuthorization()
        })
    }
    
    func requestAuthorization() {
        PHPhotoLibrary.requestAuthorization { status in
            self.authorizationStatus = status
            switch status {
            case .authorized, .limited:
                DispatchQueue.main.async {
                    self.getRecentVideos()
                }
                self.getCategoryVideo()
            case .denied, .notDetermined, .restricted:
                print("Error Found!")
            default:
                break
            }

        }
    }
    
    private func fetchVideoAssets() {
        
        //load thumbnails
        for asset in dataModel.mediaResult.allMedia {
            asset.loadVideoData(loadOptions: LocalVideoRequest()) { image in
                self.thumbnails.append(image!)
            }
        }

     }
    
    private func getRecentVideos() {
        
        DispatchQueue.main.async {
            
            let albums = dataModel.mediaGroupResult.allMedia
            print("My Albums are here",albums.count)
            for album in albums {
                if  album.assetCollection.localizedTitle == "Recents"{
                    let videoRequestOptions =  dataModel.localVideoRequestBuilder.setSelectedAlbum(album.assetCollection).build()
                    let provider = dataModel.mediaProviderBuilder.build()
                    dataModel.mediaResult = provider.getVideos(localVideoRequest: videoRequestOptions,
                                                               isPaginated: false)
                }
            }
            dataModel.count = dataModel.mediaResult.allMedia.count
            self.fetchVideoAssets()
        }
    }
    
    func getCategoryVideo(){
            
            // ImageCategory Request Builder
            let localVideoGroupRequest = dataModel
                .localVideoGroupRequestBuilder
                .setSortDescriptors(.byCreationDateAscending)
                .build()
            
            let provider = dataModel.mediaProviderBuilder.build()

            DispatchQueue.main.async {
                dataModel.mediaGroupResult = provider.getVideoGroups(localVideoGroupRequest: localVideoGroupRequest,
                                                                     isPaginated: false)
            }
         
        }
    
    
}
