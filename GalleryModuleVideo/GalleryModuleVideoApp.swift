//
//  GalleryModuleVideoApp.swift
//  GalleryModuleVideo
//
//  Created by mohammad noor uddin on 15/10/23.
//

import SwiftUI

@main
struct GalleryModuleVideoApp: App {
    
    @StateObject var photoLibrayService = PhotoLibraryService()
    
    var body: some Scene {
        WindowGroup {
            ContentView(photoLibrayService: photoLibrayService)
        }
    }
}
