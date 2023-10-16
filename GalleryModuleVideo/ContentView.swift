//
//  ContentView.swift
//  GalleryModuleVideo
//
//  Created by mohammad noor uddin on 15/10/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var photoLibrayService = PhotoLibraryService()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
            Text("Hello, world!")
        }
        .padding()
        .onAppear(perform: {
            photoLibrayService.requestAuthorization()
        })
    }
}
