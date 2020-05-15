//
//  ViewController.swift
//  catastrophic
//
//  Created by mega on 5/14/20.
//  Copyright © 2020 mega. All rights reserved.
//

import UIKit
class RandomImageCollectionCell : UICollectionViewCell{
    @IBOutlet var image:UIImageView!
    override func prepareForReuse() {
        super.prepareForReuse()

        image.image = nil
    }
}
class RandomImagesViewController: UIViewController ,
    UICollectionViewDelegate,
    UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout{



    
    @IBOutlet weak var progress: UIActivityIndicatorView!
    @IBOutlet weak var errorStack: UIStackView!
    @IBOutlet weak var randomCollectionView: UICollectionView!
    var page = 0
    var breedList = [BreedElement]();
    override func viewDidLoad() {
        super.viewDidLoad()

        randomCollectionView.delegate = self
        randomCollectionView.dataSource = self
        progress.hidesWhenStopped = true
        progress.startAnimating()
        CatApi.getBreedImages( limit: 20, page: 0) { (breeds, error) in
            self.page = 1
            self.progress.stopAnimating()
            self.breedList = breeds
            self.randomCollectionView.reloadData()
        }
    }
    @IBAction func onRetryClick(_ sender: Any) {
    }

    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        print(indexPaths)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  4
        let collectionViewSize = collectionView.frame.size.width - padding

        return CGSize(width: (UIScreen.main.bounds.width/2)-4, height: 200)
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return breedList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! RandomImageCollectionCell
        let breedImage = breedList[indexPath.row]
        cell.image.imageFromURL(urlString: breedImage.url) {
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
           return UIEdgeInsets(top: 0, left: 2, bottom: 0, right: 2)
       }

}
