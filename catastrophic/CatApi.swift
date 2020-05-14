//
//  CatApi.swift
//  catastrophic
//
//  Created by mega on 3/28/20.
//  Copyright © 2020 mega. All rights reserved.
//

import Foundation

class CatApi {
    fileprivate static let BASE_URL = "https://api.thecatapi.com/v1/"
    class func getBreeds(completion: @escaping ([BreedClass], Error?) -> Void) {
        let url = URL(string: "\(CatApi.BASE_URL)breeds")!
        URLSession(configuration: .default, delegate: .none, delegateQueue: .main).dataTask(with: url) { data, _, error in

            if let error = error {
                completion([], error)
                return
            }

            do {
                let breeds = try JSONDecoder().decode(Breed.self, from: data!)
                completion(breeds, nil)
            } catch {
                completion([], error)
            }
        }.resume()
    }

    class func getBreedImages(breedId: String, limit: Int = 0, page: Int = 0, completion: @escaping ([BreedElement], Error?) -> Void) {
        let url = URL(string: "\(CatApi.BASE_URL)images/search?breed_ids=\(breedId)&include_breeds=false&limit=\(limit)&page=\(page)&mime_types=png,jpg")!

        print(url)
        URLSession(configuration: .default, delegate: .none, delegateQueue: .main).dataTask(with: url) { data, _, error in
            if let error = error {
                completion([], error)
                return
            }
            do {
                let breedDetails = try JSONDecoder().decode(BreedDetails.self, from: data!)
                completion(breedDetails, nil)

            } catch {
                completion([], error)
            }
        }.resume()
    }
}
