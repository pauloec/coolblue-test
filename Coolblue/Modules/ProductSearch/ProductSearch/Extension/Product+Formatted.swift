//
//  Product+Formatted.swift
//  ProductSearch
//
//  Created by Paulo Correa on 30/12/2564 BE.
//

import Foundation

extension Product {
    var reviewDescription: String {
        return "★ \(self.reviewInformation.summary.average) | \(self.reviewInformation.summary.count) Reviews"
    }

    var uspsDescription: String {
        return "• " + self.USPs.joined(separator: "\n• ")
    }

    var priceToCurrency: String {
        return String(format: "%.2f", self.salesPriceIncVat)
    }
}
