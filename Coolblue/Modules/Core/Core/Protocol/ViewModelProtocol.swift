//
//  ViewModelProtocol.swift
//  Core
//
//  Created by Paulo Correa on 11/12/2021.
//

public protocol ViewModelProtocol {
    associatedtype Input
    associatedtype Output

    /// Object used to standardize UX/UI interactions FROM views
    var input: Input { get }

    /// Object used to standardize data status TO views
    var output: Output { get }
}
