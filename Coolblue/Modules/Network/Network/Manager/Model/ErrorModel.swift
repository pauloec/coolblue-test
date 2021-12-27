//
//  ErrorModel.swift
//  Network
//
//  Created by Paulo Correa on 11/12/2021.
//

import Foundation
import Core

enum ErrorKey: String {
    case general = "Error_general"
    case parsing = "Error_parsing"
}

public class ErrorModel: Error {
    var messageKey: String
    public var message: String {
        return messageKey
    }

    init(_ messageKey: String) {
        self.messageKey = messageKey
    }
}

extension ErrorModel {
    class func generalError() -> ErrorModel {
        return ErrorModel(ErrorKey.general.rawValue)
    }
}
