//
//  LocalVideoGroupRequest.swift
//  GalleryModuleVideo
//
//  Created by mohammad noor uddin on 23/10/23.
//

import Foundation


class LocalVidoeGroupRequest {
 
    var predicate = Predicate()
    var sortDescriptors : [NSSortDescriptor] = []
}

class LocalVidoeGroupRequestBuilder {
    private var localVidoeGroupRequest = LocalVidoeGroupRequest()

    func setPredicate(_ predicate: Predicate) -> Self {
        localVidoeGroupRequest.predicate = predicate
        return self
    }
    func setSortDescriptors(_ sortDescriptors: Sort... ) -> Self {
        for sort in sortDescriptors {
            localVidoeGroupRequest.sortDescriptors.append(sort.sortDescriptor)
        }
        return self
    }
    
    func build() -> LocalVidoeGroupRequest {
        return self.localVidoeGroupRequest
    }
}
