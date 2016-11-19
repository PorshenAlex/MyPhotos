//
//  Album.swift
//  My Photos
//
//  Created by Alexey Tyurin on 19/11/16.
//  Copyright © 2016 Alexey. All rights reserved.
//

import Foundation
import Photos

protocol AlbumRepresentation {
    func title() -> String
    func numberOfProtos() -> Int
    func lastAsset() -> PHAsset? 
}

final class Album {
    var collection:PHAssetCollection
    var photos:PHFetchResult<PHAsset>?
    
    init(_ collection:PHAssetCollection) {
        self.collection = collection
        self.fitchPhotos()
    }
}

fileprivate protocol Photos {
    func fitchPhotos()
}


//MARK: - Photos

extension Album: Photos {
    internal func fitchPhotos() {
        self.photos = PHAsset.fetchAssets(in: self.collection, options: nil)
    }
}

//MARK: - AlbumRepresentation

extension Album: AlbumRepresentation {
    internal func title() -> String {
        return self.collection.localizedTitle!
    }
    
    internal func numberOfProtos() -> Int {
        guard self.photos != nil else { return 0 }
        return self.photos!.count
    }
    
    internal func lastAsset() -> PHAsset? {
        guard self.photos != nil else { return nil }
        guard self.photos!.lastObject != nil else { return nil }
        return self.photos!.lastObject! as PHAsset
    }
}

