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
    func fetchAlbums(_ completion: () -> Void)
    func numberOfAllbums() -> Int
    func album(_ index: Int) -> Album
}

private var photosService = PhotosService()

final class PhotosService {
    static var shared = photosService
    
    var albums: Album?
}

extension PhotosService: PhotosServiceProtocol {
    func fetchAlbums(_ completion: () -> Void) {
        DispatchQueue.global(qos: .default).async {
            let fetchResult = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .albumRegular, options: nil)
            var albums = [Album]()
            fetchResult.enumerateObjects({ (collection, count, pointer) in
                guard collection.assetCollectionSubtype == .smartAlbumVideos else { return }
                albums.append(Album(collection))
            })
        }
    }
    
    func numberOfAllbums() -> Int {
        
    }
    
    func album(_ index: Int) -> Album {
        
    }
}
