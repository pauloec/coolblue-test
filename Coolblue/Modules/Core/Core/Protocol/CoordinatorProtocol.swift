//
//  CoordinatorProtocol.swift
//  Core
//
//  Created by Paulo Correa on 11/12/2021.
//

import UIKit

public protocol CoordinatorProtocol {
    /// UINavigationController that manages the flow inside modules
    var navigationController: UINavigationController { get set }

    /// Module flow initializer
    func start()
}
