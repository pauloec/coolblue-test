//
//  ProductSearchBundle.swift
//  ProductSearch
//
//  Created by Paulo Correa on 27/12/2021.
//

import Foundation

public enum ProductSearchFramework {
    public static let useResourceBundles = true
    public static let bundleName = "ProductSearch.bundle"
}

private class GetBundle {}

extension Bundle {
    public class func ProductSearchResourceBundle() -> Bundle {
        let framework = Bundle(for: GetBundle.self)
        guard ProductSearchFramework.useResourceBundles else {
            return framework
        }
        guard let resourceBundleURL = framework.url(
            forResource: ProductSearchFramework.bundleName,
            withExtension: nil)
        else {
            fatalError("\(ProductSearchFramework.bundleName) not found!")
        }
        guard let resourceBundle = Bundle(url: resourceBundleURL) else {
            fatalError("Cannot access \(ProductSearchFramework.bundleName)")
        }
        return resourceBundle
    }
}

extension UIImage {
    class func image(named: String) -> UIImage {
        return UIImage(named: named, in: Bundle.ProductSearchResourceBundle(), compatibleWith: nil) ?? UIImage()
    }
}
