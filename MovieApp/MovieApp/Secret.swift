//
//  Secret.swift
//  MovieApp
//
//  Created by TakHyun Jung on 2022/02/13.
//

import Foundation

enum Secrets {
    static let clientID = Secrets.environmentVariable(named: "Client_ID") ?? ""
    static let clientSecret = Secrets.environmentVariable(named: "Client_Secret") ?? ""

    private static func environmentVariable(named: String) -> String? {
        return ProcessInfo.processInfo.environment[named]
    }
}
