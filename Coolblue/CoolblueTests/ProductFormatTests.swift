//
//  CoolblueTests.swift
//  CoolblueTests
//
//  Created by Paulo Correa on 30/12/2021.
//

import XCTest
@testable import ProductSearch
@testable import Coolblue

class ProductFormatTests: XCTestCase {

    var product: Product!

    override func setUp() {
        super.setUp()

        let reviewSummary = ReviewSummary(average: 9.7,
                                          count: 100)
        let reviewInformation = ReviewInformation(reviews: [],
                                                  summary: reviewSummary)
        product = Product(id: 0,
                          name: "iPad",
                          reviewInformation: reviewInformation,
                          USPs: ["USPS", "USPS"],
                          availabilityState: 2,
                          salesPriceIncVat: 90.0,
                          imageUrl: URL(string: "https://image.coolblue.nl/300x750/products/856583")!,
                          nextDayDelivery: true,
                          coolbluesChoiceInformationTitle: nil,
                          promoIcon: nil,
                          listPriceIncVat: 80,
                          listPriceExVat: 79)
    }

    override func tearDown() {
        product = nil
        super.tearDown()
    }

    func testProductName() {
        XCTAssertEqual(product.name, "iPad")
    }

    func testProductReviewDescription() {
        XCTAssertEqual(product.reviewDescription, "★ 9.7 | 100 Reviews")
    }

    func testUspsDescription() {
        XCTAssertEqual(product.uspsDescription, "• USPS\n• USPS")
    }

    func testPriceCurrency() {
        XCTAssertEqual(product.priceToCurrency, "90.00")
    }
}
