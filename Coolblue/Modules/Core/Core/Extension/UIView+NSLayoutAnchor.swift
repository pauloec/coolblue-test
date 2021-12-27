//
//  UIView+NSLayoutAnchor.swift
//  Core
//
//  Created by Paulo Correa on 11/12/2021.
//

import UIKit

extension UIView {
    /// UIKit Autolayout Helper
    ///
    /// - Parameters:
    ///   - top: Top anchor ** Defaults to nil **
    ///   - leading: Leading anchor ** Defaults to nil **
    ///   - bottom: Bottom anchor ** Defaults to nil **
    ///   - trailing: Trailing anchor ** Defaults to nil **
    ///   - centerY: Center Y anchor ** Defaults to nil **
    ///   - centerX: Center X anchor ** Defaults to nil **
    ///   - padding: Padding Size ** Defaults to zero **
    ///   - size: Size for height and width ** Defaults to zero **
    ///   - topPriority: Top anchor priority ** Defaults to high **
    ///   - bottomPriority: Bottom anchor priority ** Defaults to high **
    ///   - leadingPriority: Leading anchor priority ** Defaults to high **
    ///   - trailingPriority: Trailing anchor priority ** Defaults to high **
    ///   - centerYPriority: Center Y anchor priority ** Defaults to high **
    ///   - centerXPriority: Center X anchor priority ** Defaults to high **
    ///   - widthPriority: Width priority ** Defaults to high **
    ///   - heightPriority: Height priority ** Defaults to high **
    public func anchor(top: NSLayoutYAxisAnchor? = nil,
                       leading: NSLayoutXAxisAnchor? = nil,
                       bottom: NSLayoutYAxisAnchor? = nil,
                       trailing: NSLayoutXAxisAnchor? = nil,
                       centerY: NSLayoutYAxisAnchor? = nil,
                       centerX: NSLayoutXAxisAnchor? = nil,
                       padding: UIEdgeInsets = .zero,
                       size: CGSize = .zero,
                       topPriority: UILayoutPriority = .defaultHigh,
                       bottomPriority: UILayoutPriority = .defaultHigh,
                       leadingPriority: UILayoutPriority = .defaultHigh,
                       trailingPriority: UILayoutPriority = .defaultHigh,
                       centerYPriority: UILayoutPriority = .defaultHigh,
                       centerXPriority: UILayoutPriority = .defaultHigh,
                       widthPriority: UILayoutPriority = .defaultHigh,
                       heightPriority: UILayoutPriority = .defaultHigh) {
        translatesAutoresizingMaskIntoConstraints = false

        if let top = top {
            let topAnchor = topAnchor.constraint(equalTo: top, constant: padding.top)
            topAnchor.isActive = true
            topAnchor.priority = topPriority
        }

        if let leading = leading {
            let leadingAnchor = leadingAnchor.constraint(equalTo: leading, constant: padding.left)
            leadingAnchor.isActive = true
            leadingAnchor.priority = leadingPriority
        }

        if let bottom = bottom {
            let bottomAnchor = bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom)
            bottomAnchor.isActive = true
            bottomAnchor.priority = bottomPriority
        }

        if let trailing = trailing {
            let trailingAnchor = trailingAnchor.constraint(equalTo: trailing, constant: -padding.right)
            trailingAnchor.isActive = true
            trailingAnchor.priority = trailingPriority
        }

        if let centerY = centerY {
            let centerYAnchor = centerYAnchor.constraint(equalTo: centerY)
            centerYAnchor.isActive = true
            centerYAnchor.priority = centerYPriority
        }

        if let centerX = centerX {
            let centerXAnchor = centerXAnchor.constraint(equalTo: centerX)
            centerXAnchor.isActive = true
            centerXAnchor.priority = centerXPriority
        }

        if size.width != 0 {
            let widthAnchor = widthAnchor.constraint(equalToConstant: size.width)
            widthAnchor.isActive = true
            widthAnchor.priority = widthPriority
        }

        if size.height != 0 {
            let heightAnchor = heightAnchor.constraint(equalToConstant: size.height)
            heightAnchor.isActive = true
            heightAnchor.priority = heightPriority
        }
    }

    /// Convenient Method to full screen
    public func anchorSuperview() {
        anchor(top: superview?.safeAreaLayoutGuide.topAnchor,
               leading: superview?.safeAreaLayoutGuide.leadingAnchor,
               bottom: superview?.safeAreaLayoutGuide.bottomAnchor,
               trailing: superview?.safeAreaLayoutGuide.trailingAnchor)
    }
}
