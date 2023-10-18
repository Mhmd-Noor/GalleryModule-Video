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
    
    @ObservedObject var photoLibrayService: PhotoLibraryService
    
    var body: some View {
        ScrollView([.vertical]){
            VStack {
                
                Text("Fetched Videos: \(photoLibrayService.videosCount)")
                    .padding(10)
                    .background(Color.gray)
                
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 10) {
                    ForEach(photoLibrayService.thumbnails, id: \.self) { image in
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    }
                }
                
            }
        }
        .onAppear(perform: {
            photoLibrayService.requestAuthorization()
        })
    }
}
