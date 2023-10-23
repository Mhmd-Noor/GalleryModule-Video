//
//  DataModel.swift
//  GalleryModuleVideo
//
//  Created by mohammad noor uddin on 19/10/23.
//

import Foundation

class DataModel: ObservableObject{
    
    @Published var count = 0
    @Published var localVideoRequestBuilder = LocalVideoRequestBuilder()
    @Published var mediaResult = MediaResult<LocalVideoMedia>()
    @Published var mediaGroupResult = MediaResult<LocalVideoGroupMedia>()
    @Published var mediaProviderBuilder = LocalMediaProviderBuilder()
    @Published var localVideoGroupRequestBuilder = LocalVidoeGroupRequestBuilder()

}
