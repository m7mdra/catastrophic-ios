//
//  BreedDetailsViewController.swift
//  catastrophic
//
//  Created by mega on 3/17/20.
//  Copyright © 2020 mega. All rights reserved.
//

import Foundation
import UIKit
class BreedDetailsViewController: UIViewController {
    var breed: BreedClass!

    @IBOutlet var weightLabel: UILabel!
    @IBOutlet var lifeSpanLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var tempermentLabel: UILabel!
    @IBOutlet var image: UIImageView!
    var shareBarButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        shareBarButton = UIBarButtonItem(barButtonSystemItem: .reply, target: self, action: #selector(onShareClicked))
        shareBarButton.disable()
        weightLabel.text = "\(breed.weight.imperial) lbs \(breed.weight.metric) kgs"
        descriptionLabel.text = breed.breedDescription
        lifeSpanLabel.text = "\(breed.lifeSpan) years"
        tempermentLabel.text = breed.temperament
        navigationItem.title = breed.name
        navigationItem.setRightBarButtonItems([
            UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(onTapp)),
            shareBarButton,
        ], animated: true)
        loadDetails()
    }

    @objc func onTapp() {
        loadDetails()
    }

    @objc func onShareClicked() {
        let shareController = UIActivityViewController(activityItems: [image.image], applicationActivities: [])
        present(shareController, animated: true, completion: nil)
    }

    func loadDetails() {
        CatApi.getBreedImages(breedId: breed.id) { breedImages, error in
            if let error = error {
                print(error)
                return
            }
            self.image.imageFromURL(urlString: breedImages[0].url) {
                self.image.setNeedsLayout()
                self.imageUrl = breedImages[0].url
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.showImageViewer))
                self.shareBarButton.enable()
                self.image.isUserInteractionEnabled = true
                self.image.addGestureRecognizer(tapGesture)
            }
        }
    }

    var imageUrl: String!
    @objc func showImageViewer() {
        performSegue(withIdentifier: "imageViewerSegue", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender _: Any?) {
        if segue.identifier == "imageViewerSegue" {
            let controller = segue.destination as? ImageViewerViewController
            controller?.breedImageUrl = imageUrl
        }
        if segue.identifier == "showMoreImages" {
            let controller = segue.destination as? BreedImagesViewController
            controller?.breed = breed
        }
    }

    @IBAction func onShowMoreImagesClicked(_: Any) {
        performSegue(withIdentifier: "showMoreImages", sender: self)
    }
}

extension UIBarItem {
    func enable() {
        isEnabled = true
    }

    func disable() {
        isEnabled = false
    }
}
