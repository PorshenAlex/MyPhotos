//
//  PhotoViewController.swift
//  My Photos
//
//  Created by Alexey Tyurin on 17/11/16.
//  Copyright © 2016 Alexey. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    var album: Album?
    var selectedIndexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setupPage()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

fileprivate protocol Setup {
    func setupCollectionView()
    func setupPage()
}

extension PhotoViewController: Setup {
    internal func setupCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(PhotoCollectionViewCell.nib(), forCellWithReuseIdentifier: PhotoCollectionViewCell.reuseIdentifier())
    }
    
    internal func setupPage() {
        self.collectionView.setNeedsLayout()
        self.collectionView.layoutIfNeeded()
        self.collectionView.scrollToItem(at: self.selectedIndexPath!, at: .left, animated: false)
    }
}


//MARK: - UICollectionViewDelegateFlowLayout

extension PhotoViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.view.bounds.size
    }
}


//MARK: - UICollectionViewDataSource

extension PhotoViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard self.album != nil else { return 0 }
        return self.album!.numberOfProtos()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.reuseIdentifier(), for: indexPath) as! PhotoCollectionViewCell
        guard let asset = self.album!.asset(indexPath.row) else { return cell }
        cell.configure(asset, fullScreen: true)
        return cell
    }
}
