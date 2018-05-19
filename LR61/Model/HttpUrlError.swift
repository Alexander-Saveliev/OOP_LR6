//
//  HttpUrlError.swift
//  LR61
//
//  Created by Marty on 19/05/2018.
//  Copyright © 2018 Marty. All rights reserved.
//

enum HttpUrlError: Error, Equatable {
    case incorrectUrl
    case incorrectPort(Int)
    case incorrectProtocol(String)
    case incorrectHost
}

