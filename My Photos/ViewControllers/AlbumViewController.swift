//
//  AlbumViewController.swift
//  My Photos
//
//  Created by Alexey Tyurin on 17/11/16.
//  Copyright © 2016 Alexey. All rights reserved.
//

import UIKit

class AlbumViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    var album: Album?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupCollectionView()
        self.setupTitle()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! PhotoViewController
        vc.album = self.album
        vc.selectedIndexPath = sender as? IndexPath
    }

}

fileprivate protocol Setup {
    func setupCollectionView()
    func setupTitle()
}


//MARK: - Setup

extension AlbumViewController: Setup {
    internal func setupCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(PhotoCollectionViewCell.nib(), forCellWithReuseIdentifier: PhotoCollectionViewCell.reuseIdentifier())
    }
    
    internal func setupTitle() {
        self.navigationItem.title = album?.title()
    }
}


//MARK: - UICollectionViewDelegateFlowLayout

extension AlbumViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return PhotoCollectionViewCell.smallSize()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showPhoto", sender: indexPath)
    }
}


//MARK: - UICollectionViewDataSource

extension AlbumViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard self.album != nil else { return 0 }
        return self.album!.numberOfProtos()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.reuseIdentifier(), for: indexPath) as! PhotoCollectionViewCell
        guard let asset = self.album!.asset(indexPath.row) else { return cell }
        cell.configure(asset, fullScreen: false)
        return cell
    }
}
