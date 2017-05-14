//
//  FileCacheTests.swift
//  FileCacheTests
//
//  Created by Weerasooriya, Tulakshana on 5/11/17.
//  Copyright © 2017 Tulakshana. All rights reserved.
//

import XCTest

class FileCacheTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testFileInit() {
        let urlString: NSString = "http://www.mydomain.com/resources/images/sparrow.jpg"
        let file: FCFile = FCFile(url: urlString)
        XCTAssertEqual(urlString, file.urlString)
    }
    
    func testFileSize() {
        let urlString: NSString = "http://www.mydomain.com/resources/images/sparrow.jpg"
        let file: FCFile = FCFile(url: urlString)
        XCTAssertEqual(0.0, file.fileSize())
        
        if let path: String = Bundle.main.path(forResource: "show_me_the_code", ofType: "jpg") {
            do {
                let fileData: NSData = try NSData.init(contentsOfFile: path)
                file.fileData = fileData
                XCTAssertEqual((Float)(fileData.length/1024)/1024, file.fileSize())
            } catch {
                XCTFail(error.localizedDescription)
            }
        }else {
            XCTFail("Failed to get the path for file show_me_the_code.jpg")
        }
    }
}
