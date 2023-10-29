//
//  PixaBayModel.swift
//  GalleryModuleVideo
//
//  Created by mohammad noor uddin on 29/10/23.
//

import Foundation


struct Root: Codable {
    let total, totalHits: Int
    let hits: [Hit]
}

struct Hit: Codable {
    let id: Int
    let pageURL: String
    let type, tags: String
    let duration: Int
    let picture_id: String
    let videos: Videos
    let views, downloads, likes, comments: Int
    let user_id: Int
    let user, userImageURL: String
}

struct Videos: Codable {
    let large, medium, small, tiny: VideoDetail
}

struct VideoDetail: Codable {
    let url: String
    let width, height, size: Int
}
