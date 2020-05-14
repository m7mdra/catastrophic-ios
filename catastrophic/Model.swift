//
//  Model.swift
//  catastrophic
//
//  Created by mega on 3/17/20.
//  Copyright © 2020 mega. All rights reserved.
//

import Foundation

struct BreedElement: Codable,Hashable,Equatable {
    let id: String
    let url: String
    let width: Int
    let height: Int

    enum CodingKeys: String, CodingKey {
        case id
        case url
        case width
        case height
    }
    

}

// MARK: - BreedClass

struct BreedClass: Codable {
    let weight: Weight
    let id: String
    let name: String
    let temperament: String
    let origin: String
    let countryCodes: String
    let countryCode: String
    let breedDescription: String
    let lifeSpan: String
    let indoor: Int
    let lap: Int?
    let altNames: String?
    let adaptability: Int
    let affectionLevel: Int
    let childFriendly: Int
    let dogFriendly: Int
    let energyLevel: Int
    let grooming: Int
    let healthIssues: Int
    let intelligence: Int
    let sheddingLevel: Int
    let socialNeeds: Int
    let strangerFriendly: Int
    let vocalisation: Int
    let experimental: Int
    let hairless: Int
    let natural: Int
    let rare: Int
    let rex: Int
    let suppressedTail: Int
    let shortLegs: Int
    let wikipediaUrl: String?
    let hypoallergenic: Int

    enum CodingKeys: String, CodingKey {
        case weight
        case id
        case name
        case temperament
        case origin
        case countryCodes = "country_codes"
        case countryCode = "country_code"
        case breedDescription = "description"
        case lifeSpan = "life_span"
        case indoor
        case lap
        case altNames = "alt_names"
        case adaptability
        case affectionLevel = "affection_level"
        case childFriendly = "child_friendly"
        case dogFriendly = "dog_friendly"
        case energyLevel = "energy_level"
        case grooming
        case healthIssues = "health_issues"
        case intelligence
        case sheddingLevel = "shedding_level"
        case socialNeeds = "social_needs"
        case strangerFriendly = "stranger_friendly"
        case vocalisation
        case experimental
        case hairless
        case natural
        case rare
        case rex
        case suppressedTail = "suppressed_tail"
        case shortLegs = "short_legs"
        case wikipediaUrl = "wikipedia_url"
        case hypoallergenic
    }
}

// MARK: - Weight

struct Weight: Codable {
    let imperial: String
    let metric: String

    enum CodingKeys: String, CodingKey {
        case imperial
        case metric
    }
}

typealias Breed = [BreedClass]
typealias BreedDetails = [BreedElement]
