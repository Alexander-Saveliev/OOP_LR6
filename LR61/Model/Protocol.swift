//
//  Protocol.swift
//  LR61
//
//  Created by Marty on 19/05/2018.
//  Copyright © 2018 Marty. All rights reserved.
//

enum Protocol: String {
    case HTTP
    case HTTPS
    
    func defaultPort() -> Int {
        switch self {
        case .HTTP:
            return 80
        case .HTTPS:
            return 443
        }
    }
}
