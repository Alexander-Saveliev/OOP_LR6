//
//  HttpUrl.swift
//  LR61
//
//  Created by Marty on 19/05/2018.
//  Copyright © 2018 Marty. All rights reserved.
//

import Foundation

class HttpUrl {
    public private(set) var urlProtocol: Protocol!
    public private(set) var urlPort: Int!
    public private(set) var urlHost = ""
    public private(set) var urlDoc  = ""
    public private(set) var url: URL!
    
    
    init(withUrl strUrl: String) throws {
        func setDoc() {
            let protocolSuffixSize = 3
            let hostSuffixSize     = 1
            
            var portOffset = 0
            if  url.port != nil {
                portOffset += String(urlPort).count + 1
            }
            
            let docOffset = urlProtocol.rawValue.count + protocolSuffixSize +
                urlHost.count + hostSuffixSize + portOffset
            
            if docOffset < strUrl.count {
                let docLowerBound = strUrl.index(strUrl.startIndex, offsetBy: docOffset)
                urlDoc = String(strUrl[docLowerBound..<strUrl.endIndex])
            }
            
            let docSeparator = "/"
            if urlDoc.isEmpty {
                urlDoc = docSeparator
            }
            let firstChar = urlDoc[urlDoc.startIndex]
            urlDoc = (String(firstChar) == docSeparator) ? urlDoc : (docSeparator + urlDoc)
        }
        
        // url
        guard let url = URL(string: strUrl) else {
            throw HttpUrlError.incorrectUrl
        }
        self.url = url
        
        // protocol
        guard let urlProtocol = Protocol(rawValue: (url.scheme ?? "").uppercased()) else {
            throw HttpUrlError.incorrectProtocol(url.scheme ?? "")
        }
        self.urlProtocol = urlProtocol
        
        // port
        let theFirstPortNumber = 1
        let theLastPortNumber  = 65_535
        
        urlPort = url.port ?? urlProtocol.defaultPort()
        
        if urlPort < theFirstPortNumber || urlPort > theLastPortNumber {
            throw HttpUrlError.incorrectPort(urlPort)
        }
        
        // host
        guard let urlHost = url.host, !urlHost.isEmpty else {
            throw HttpUrlError.incorrectHost
        }
        self.urlHost = urlHost
        
        //doc
        setDoc()
    }
    
    init(withHost host: String, document: String, andProtocol protpcol: Protocol) throws {
        // doc
        let docSeparator = "/"
        let firstChar = document[document.startIndex]
        self.urlDoc = (String(firstChar) == docSeparator) ? document : (docSeparator + document)
        
        // protocol
        guard let urlProtocol = Protocol(rawValue: protpcol.rawValue.uppercased()) else {
            throw HttpUrlError.incorrectProtocol(protpcol.rawValue)
        }
        self.urlProtocol = urlProtocol
        self.urlPort     = urlProtocol.defaultPort()
        
        // host
        guard !host.isEmpty else {
            throw HttpUrlError.incorrectHost
        }
        self.urlHost = host
        
        // url
        guard let url = URL(string: self.urlProtocol.rawValue.lowercased() + "://" + self.urlHost + ":" + String(self.urlPort) + self.urlDoc) else {
            throw HttpUrlError.incorrectUrl
        }
        self.url = url
    }
    
    init(withHost host: String, document: String, port: Int, andProtocol protpcol: Protocol) throws {
        // doc
        let docSeparator = "/"
        let firstChar = document[document.startIndex]
        self.urlDoc   = (String(firstChar) == docSeparator) ? document : (docSeparator + document)
        
        // protocol
        guard let urlProtocol = Protocol(rawValue: protpcol.rawValue.uppercased()) else {
            throw HttpUrlError.incorrectProtocol(protpcol.rawValue)
        }
        self.urlProtocol = urlProtocol
        self.urlPort     = urlProtocol.defaultPort()
        
        // port
        let theFirstPortNumber = 1
        let theLastPortNumber  = 65_535
        
        if urlPort < theFirstPortNumber || urlPort > theLastPortNumber {
            throw HttpUrlError.incorrectPort(urlPort)
        }
        self.urlPort = port
        
        // host
        guard !host.isEmpty else {
            throw HttpUrlError.incorrectHost
        }
        self.urlHost = host
        
        // url
        guard let url = URL(string: self.urlProtocol.rawValue.lowercased() + "://" + self.urlHost + ":" + String(self.urlPort) + self.urlDoc) else {
            throw HttpUrlError.incorrectHost
        }
        self.url = url
    }
}
