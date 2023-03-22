//
//  CustomError.swift
//  MyTutor
//
//  Created by Charissa Wang on 3/12/23.
//

import Foundation

enum CustomError: Error {
    case invalidPassword
    case invalidEmail
    case passwordNotMatch
    case unexpected(code: Int)
}

extension CustomError {
    var isFatal: Bool {
        if case CustomError.unexpected = self { return true }
        else { return false }
    }
}

extension CustomError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .invalidPassword:
            return "Password has to 8 - 15 long, it has to have uppercase letter!"
        case .invalidEmail:
            return "Email is not valid!"
        case .passwordNotMatch:
            return "Password is not matched"
        case .unexpected(_):
            return "An unexpected error occurred."
        }
    }
}

extension CustomError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidPassword:
            return NSLocalizedString(
                "Password has to 8 - 15 long, it has to have uppercase letter!",
                comment: "Invalid Password"
            )
        case .invalidEmail:
            return NSLocalizedString(
                "Email is not valid!",
                comment: "Invalid Email")
        case .passwordNotMatch:
            return NSLocalizedString(
                "Password is not matched!",
                comment: "Password no match")
        case .unexpected(_):
            return NSLocalizedString(
                "An unexpected error occurred.",
                comment: "Unexpected Error"
            )
        }
    }
}
