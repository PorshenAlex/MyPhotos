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
        self.requestPermision()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! AlbumViewController
        vc.album = sender as? Album
    }
}

fileprivate protocol Setup {
    func setupCollectionView()
    func setupDataSource()
}

fileprivate protocol RequestPermission {
    func requestPermision()
}

fileprivate protocol Alerts {
    func showUauthorizedAlert()
}


//MARK: - Setup

extension AlbumsViewController: Setup {
    fileprivate func setupCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(AlbumCollectionViewCell.nib(), forCellWithReuseIdentifier: AlbumCollectionViewCell.reuseIdentifier())
    }
    
    fileprivate func setupDataSource() {
        PhotosService.shared.fetchAlbums {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    fileprivate func setupUauthorized() {
        self.showUauthorizedAlert()
    }
}


//MARK: - RequestPermision

extension AlbumsViewController: RequestPermission {
    fileprivate func requestPermision() {
        PHPhotoLibrary.requestAuthorization { (status) in
            DispatchQueue.main.async {
                guard status == .authorized else { self.setupUauthorized(); return }
                self.setupDataSource()
            }
        }
    }
}


//MARK: - Alerts

extension AlbumsViewController: Alerts {
    internal func showUauthorizedAlert() {
        let alert = UIAlertController(title: "Доступ запрещен", message: "Для работы приложения нужен доступ к фотографиям", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Настройки доступа", style: .default) { (action) in
            UIApplication.shared.openURL(URL(string: UIApplicationOpenSettingsURLString)!)
            exit(0)
        })
        alert.addAction(UIAlertAction(title: "Выход", style: .destructive) { (action) in
            exit(0)
        })
        self.present(alert, animated: true, completion: nil)
    }
}


//MARK: - UICollectionViewDelegateFlowLayout

extension AlbumsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return AlbumCollectionViewCell.size()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let album = PhotosService.shared.album(indexPath.row) else { return }
        self.performSegue(withIdentifier: "showAlbum", sender: album)
    }
}


//MARK: - UICollectionViewDataSource

extension AlbumsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return PhotosService.shared.numberOfAllbums()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AlbumCollectionViewCell.reuseIdentifier(), for: indexPath) as! AlbumCollectionViewCell
        guard let album = PhotosService.shared.album(indexPath.row) else { return cell }
        cell.configure(album)
        return cell
    }
}
