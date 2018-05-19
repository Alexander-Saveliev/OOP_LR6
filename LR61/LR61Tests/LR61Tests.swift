//
//  LR61Tests.swift
//  LR61Tests
//
//  Created by Marty on 19/05/2018.
//  Copyright © 2018 Marty. All rights reserved.
//

import XCTest
@testable import LR61

class LR61Tests: XCTestCase {
    
    func testUrlWithStringApple() {
        let parsedUrl = try? HttpUrl(withUrl: "https://developer.apple.com")
        XCTAssertNotNil(parsedUrl)
        XCTAssertEqual(parsedUrl?.urlProtocol, Protocol.HTTPS)
        XCTAssertEqual(parsedUrl?.urlHost, "developer.apple.com")
        XCTAssertEqual(parsedUrl?.urlPort, 443)
        XCTAssertEqual(parsedUrl?.urlDoc, "/")
        XCTAssertEqual(parsedUrl?.url.absoluteString, "https://developer.apple.com")
    }
    
    func testUrlWithStringGibson() {
        let parsedUrl = try? HttpUrl(withUrl: "https://www.muztorg.ru/product/A071576")
        XCTAssertNotNil(parsedUrl)
        XCTAssertEqual(parsedUrl?.urlProtocol, Protocol.HTTPS)
        XCTAssertEqual(parsedUrl?.urlHost, "www.muztorg.ru")
        XCTAssertEqual(parsedUrl?.urlPort, 443)
        XCTAssertEqual(parsedUrl?.urlDoc, "/product/A071576")
        XCTAssertEqual(parsedUrl?.url.absoluteString, "https://www.muztorg.ru/product/A071576")
    }
    
    func testUrlWithStringGibsonWithPort() {
        let parsedUrl = try? HttpUrl(withUrl: "https://www.muztorg.ru:2018/product/A071576")
        XCTAssertNotNil(parsedUrl)
        XCTAssertEqual(parsedUrl?.urlProtocol, Protocol.HTTPS)
        XCTAssertEqual(parsedUrl?.urlHost, "www.muztorg.ru")
        XCTAssertEqual(parsedUrl?.urlPort, 2018)
        XCTAssertEqual(parsedUrl?.urlDoc, "/product/A071576")
        XCTAssertEqual(parsedUrl?.url.absoluteString, "https://www.muztorg.ru:2018/product/A071576")
    }
    
    func testUrlWithStringGibsonWithEmptyDoc() {
        let parsedUrl = try? HttpUrl(withUrl: "https://www.muztorg.ru:2018")
        XCTAssertNotNil(parsedUrl)
        XCTAssertEqual(parsedUrl?.urlProtocol, Protocol.HTTPS)
        XCTAssertEqual(parsedUrl?.urlHost, "www.muztorg.ru")
        XCTAssertEqual(parsedUrl?.urlPort, 2018)
        XCTAssertEqual(parsedUrl?.urlDoc, "/")
        XCTAssertEqual(parsedUrl?.url.absoluteString, "https://www.muztorg.ru:2018")
    }
    
    func testUrlWithStringGibsonWithEmptyDocWithoutPort() {
        let parsedUrl = try? HttpUrl(withUrl: "https://www.muztorg.ru")
        XCTAssertNotNil(parsedUrl)
        XCTAssertEqual(parsedUrl?.urlProtocol, Protocol.HTTPS)
        XCTAssertEqual(parsedUrl?.urlHost, "www.muztorg.ru")
        XCTAssertEqual(parsedUrl?.urlPort, 443)
        XCTAssertEqual(parsedUrl?.urlDoc, "/")
        XCTAssertEqual(parsedUrl?.url.absoluteString, "https://www.muztorg.ru")
    }
    
    func testUrlWithParamsApple() {
        let urlProtocol = Protocol.HTTPS
        let host = "www.muztorg.ru"
        let port = 2727
        let doc  = "/product/A071576"
        
        let parsedUrl = try? HttpUrl(withHost: host, document: doc, port: port, andProtocol: urlProtocol)
        XCTAssertNotNil(parsedUrl)
        XCTAssertEqual(parsedUrl?.url.absoluteString, "https://www.muztorg.ru:2727/product/A071576")
    }
    
    func testUrlWithParamsAppleWithoutPort() {
        let urlProtocol = Protocol.HTTPS
        let host = "www.muztorg.ru"
        let doc  = "/product/A071576"
        
        let parsedUrl = try? HttpUrl(withHost: host, document: doc, andProtocol: urlProtocol)
        XCTAssertNotNil(parsedUrl)
        XCTAssertEqual(parsedUrl?.url.absoluteString, "https://www.muztorg.ru:443/product/A071576")
    }
    
    func testIncorrectProtocol() {
        XCTAssertThrowsError(try HttpUrl(withUrl: "htps://www.muztorg.ru/product/A071576"), "err") { (error) in
            XCTAssertNotNil(error as? HttpUrlError)
            XCTAssertEqual(error as! HttpUrlError, HttpUrlError.incorrectProtocol("htps"))
        }
    }
    
    func testIncorrectPort() {
        XCTAssertThrowsError(try HttpUrl(withUrl: "https://www.muztorg.ru:999999999/product/A071576"), "err") { (error) in
            XCTAssertNotNil(error as? HttpUrlError)
            XCTAssertEqual(error as! HttpUrlError, HttpUrlError.incorrectPort(999999999))
        }
    }
    
    func testIncorrectUrlEmpty() {
        XCTAssertThrowsError(try HttpUrl(withUrl: ""), "err") { (error) in
            XCTAssertNotNil(error as? HttpUrlError)
            XCTAssertEqual(error as! HttpUrlError, HttpUrlError.incorrectUrl)
        }
    }
    
    func testIncorrectUrl() {
        XCTAssertThrowsError(try HttpUrl(withUrl: "perfectUrl"), "err") { (error) in
            XCTAssertNotNil(error as? HttpUrlError)
            XCTAssertEqual(error as! HttpUrlError, HttpUrlError.incorrectProtocol(""))
        }
    }
    
    func testIncorrectHost() {
        XCTAssertThrowsError(try HttpUrl(withUrl: "https://"), "err") { (error) in
            XCTAssertNotNil(error as? HttpUrlError)
            XCTAssertEqual(error as! HttpUrlError, HttpUrlError.incorrectHost)
        }
    }
    
    func testIncorrectHostAsParameter() {
        let urlProtocol = Protocol.HTTPS
        let host = ""
        let port = 2727
        let doc  = "/product/A071576"
        
        XCTAssertThrowsError(try HttpUrl(withHost: host, document: doc, port: port, andProtocol: urlProtocol), "err") { (error) in
            XCTAssertNotNil(error as? HttpUrlError)
            XCTAssertEqual(error as! HttpUrlError, HttpUrlError.incorrectHost)
        }
    }
    
    func testIncorrectHostAsParameterWithoutPort() {
        let urlProtocol = Protocol.HTTPS
        let host = ""
        let doc  = "/product/A071576"
        
        XCTAssertThrowsError(try HttpUrl(withHost: host, document: doc, andProtocol: urlProtocol), "err") { (error) in
            XCTAssertNotNil(error as? HttpUrlError)
            XCTAssertEqual(error as! HttpUrlError, HttpUrlError.incorrectHost)
        }
    }
}
