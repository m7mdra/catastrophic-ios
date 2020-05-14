//
//  ViewController.swift
//  catastrophic
//
//  Created by mega on 3/2/20.
//  Copyright © 2020 mega. All rights reserved.
//

import UIKit

class BreedsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBAction func onRetryClicked(_: Any) {
        sendRequest()
        errorVIew.isHidden = true
    }

    @IBOutlet var breedTableView: UITableView!
    @IBOutlet var progress: UIActivityIndicatorView!
    var breeds = Breed()
    @IBOutlet var errorVIew: UIStackView!
    override func viewDidLoad() {
        super.viewDidLoad()
        breedTableView.dataSource = self
        breedTableView.delegate = self
        navigationItem.title = "Catastrophic"
        progress.hidesWhenStopped = true
        sendRequest()
    }

    private func sendRequest() {
        CatApi.getBreeds { breeds, error in
            
            self.progress.stopAnimating()
            self.errorVIew.isHidden = true
            if error != nil {
                self.errorVIew.isHidden = false
                self.breedTableView.isHidden = false

                return
            } else {
                self.errorVIew.isHidden = true
            }
            self.breeds = breeds
            self.breedTableView.reloadData()
            self.breedTableView.isHidden = false
        }
        progress.startAnimating()
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return breeds.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "breedCell")!
        let breed = breeds[indexPath.row]
        cell.textLabel!.text = "\(breed.name)"
        cell.detailTextLabel!.text = breed.breedDescription
        cell.imageView?.imageFromURL(urlString: "https://www.countryflags.io/\(breed.countryCode)/flat/32.png") {
            cell.setNeedsLayout()
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.isSelected = false
        navigateToDetails(breeds[indexPath.row])
    }

    var selectedBreed: BreedClass!
    func navigateToDetails(_ breed: BreedClass) {
        selectedBreed = breed
        performSegue(withIdentifier: "detailsSegue", sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender _: Any?) {
        let controller = segue.destination as! BreedDetailsViewController
        controller.breed = selectedBreed
    }
}

var cache = NSCache<NSString, UIImage>()
extension UIImageView {
    public func imageFromURL(urlString: String, completion: @escaping () -> Void) {
        if let image = cache.object(forKey: urlString as NSString) {
            self.image = image
        } else {
            let activityIndicator = UIActivityIndicatorView(style: .medium)
            activityIndicator.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
            activityIndicator.startAnimating()
            setNeedsLayout()
            addSubview(activityIndicator)
            URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, _, error) -> Void in
                if error != nil {
                    print(error ?? "No Error")
                    return
                }
                DispatchQueue.main.async {
                    activityIndicator.removeFromSuperview()

                    let image = UIImage(data: data!)
                    if let image = image {
                        completion()
                        cache.setObject(image, forKey: urlString as NSString)
                        self.image = image
                    }
                }

            }).resume()
        }
    }
}
