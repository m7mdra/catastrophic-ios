//
//  BreedImagesViewController.swift
//  catastrophic
//
//  Created by mega on 3/28/20.
//  Copyright © 2020 mega. All rights reserved.
//

import Foundation
import UIKit

class BreedImagesViewController: UIViewController,
    UICollectionViewDelegate,
    UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout{
        var lastSelectedIndexPath:IndexPath?
    
    var breed: BreedClass!
    var breedImages = [BreedElement]()
    @IBOutlet  var imageCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = breed.name
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        
        CatApi.getBreedImages(breedId: breed.id, limit: 20, page: 0) { images, _ in
            self.breedImages = images
            self.imageCollectionView.reloadData()
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0.0, right: 0.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    @objc func showImageViewer() {
           performSegue(withIdentifier: "imageViewerFromCollectionSegue", sender: self)
       }

       override func prepare(for segue: UIStoryboardSegue, sender _: Any?) {
           if segue.identifier == "imageViewerFromCollectionSegue" {
               let controller = segue.destination as? ImageViewerViewController
               controller?.breedImageUrl = imageUrl
           }
          
       }
var imageUrl=""
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        imageUrl = breedImages[indexPath.row].url
        showImageViewer()
        return
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellHeight = (collectionView.bounds.size.height ) / 3 // 3 count of rows to show
        let cellWidth = (collectionView.bounds.size.width ) / 2 // 2 count of colomn to show
        return CGSize(width: CGFloat(cellWidth), height: CGFloat(cellHeight))
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return breedImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "breedCell", for:    indexPath) as! BreedImageCell
        
        cell.breedImage.imageFromURL(urlString: breedImages[indexPath.row].url) {
            cell.setNeedsLayout()
        }
        
        return cell
    }
}

class BreedImageCell: UICollectionViewCell {
    @IBOutlet var breedImage: UIImageView!
}
