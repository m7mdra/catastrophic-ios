//
//  ImageViewerViewController.swift
//  catastrophic
//
//  Created by mega on 3/24/20.
//  Copyright © 2020 mega. All rights reserved.
//

import Foundation
import UIKit
class ImageViewerViewController: UIViewController {
    @IBOutlet var breedImage: UIImageView!
    var breedImageUrl: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        breedImage.imageFromURL(urlString: breedImageUrl, completion: {})
    }
}
