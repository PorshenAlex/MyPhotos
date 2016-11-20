//
//  PhotosService.swift
//  My Photos
//
//  Created by Alexey Tyurin on 19/11/16.
//  Copyright © 2016 Alexey. All rights reserved.
//

import Foundation
import Photos

protocol PhotosServiceProtocol {
    func fetchAlbums(_ completion: @escaping () -> Void)
    func numberOfAllbums() -> Int
    func album(_ index: Int) -> Album?
}

private var photosService = PhotosService()

final class PhotosService {
    static let shared = photosService
    
    var albums: [Album]?
}

extension PhotosService: PhotosServiceProtocol {
    func fetchAlbums(_ completion: @escaping () -> Void) {
        DispatchQueue.global(qos: .default).async {
            let fetchResult = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .albumRegular, options: nil)
            var albums = [Album]()
            fetchResult.enumerateObjects({ (collection, count, pointer) in
                guard collection.assetCollectionSubtype != .smartAlbumVideos &&
                    collection.assetCollectionSubtype != .smartAlbumSlomoVideos &&
                    collection.assetCollectionSubtype != .smartAlbumTimelapses else { return }
                albums.append(Album(collection))
            })
            self.albums = albums
            completion()
        }
    }
    
    func numberOfAllbums() -> Int {
        guard self.albums != nil else { return 0 }
        return self.albums!.count
    }
    
    func album(_ index: Int) -> Album? {
        guard self.albums != nil else { return nil }
        guard self.albums!.count > index else { return nil }
        return self.albums![index]
    }
}
