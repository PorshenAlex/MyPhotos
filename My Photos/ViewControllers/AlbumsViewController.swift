//
//  AlbumsViewController.swift
//  My Photos
//
//  Created by Alexey Tyurin on 17/11/16.
//  Copyright © 2016 Alexey. All rights reserved.
//

import UIKit
import Photos

class AlbumsViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupCollectionView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    }
}

fileprivate protocol Setup {
    func setupCollectionView()
    func setupDataSource()
}

fileprivate protocol RequestPermission {
    func requestPermision()
}


//MARK: - Setup

extension AlbumsViewController: Setup {
    fileprivate func setupCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(AlbumCollectionViewCell.nib(), forCellWithReuseIdentifier: AlbumCollectionViewCell.reuseIdentifier())
    }
    
    fileprivate func setupDataSource() {
        `
    }
}


//MARK: - RequestPermision

extension AlbumsViewController: RequestPermission {
    fileprivate func requestPermision() {
        PHPhotoLibrary.requestAuthorization { (status) in
            DispatchQueue.main.async {
                guard status == .authorized else { return }
                self.setupDataSource()
            }
        }
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension AlbumsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 130, height: 175)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showAlbum", sender: nil)
    }
}


//MARK: - UICollectionViewDataSource

extension AlbumsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AlbumCollectionViewCell.reuseIdentifier(), for: indexPath)
        return cell
    }
}
