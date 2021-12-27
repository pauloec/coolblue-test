//
//  Product.swift
//  ProductSearch
//
//  Created by Paulo Correa on 27/12/2021.
//

struct Product: Codable {
    let id: Int
    let name: String
    let reviewInformation: ReviewInformation
    let USPs: [String]
    let availabilityState: Int
    let salesPriceIncVat: Double
    let image: URL
    let nextDayDelivery: Bool
    let coolbluesChoiceInformationTitle: String?
    let promoIcon: PromoIcon?
    let listPriceIncVat: Int?
    let listPriceExVat: Double?

    enum CodingKeys: String, CodingKey {
        case id = "productId"
        case name = "productName"
        case image = "productImage"
        case USPs = "USPs"
        case reviewInformation, availabilityState, salesPriceIncVat,
             coolbluesChoiceInformationTitle, promoIcon, nextDayDelivery,
             listPriceIncVat, listPriceExVat
    }
}

struct ReviewInformation: Codable {
    let reviews: [String]
    let summary: ReviewSummary

    enum CodingKeys: String, CodingKey {
        case summary = "reviewSummary"
        case reviews
    }
}

struct ReviewSummary: Codable {
    let average: Double
    let count: Int

    enum CodingKeys: String, CodingKey {
        case average = "reviewAverage"
        case count = "reviewCount"
    }
}

struct PromoIcon: Codable {
    let text: String
    let type: PromoType
}

enum PromoType: String, Codable {
    case actionPrice = "action-price"
    case coolbluesChoice = "coolblues-choice"
}
