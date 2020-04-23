//
//  ToDo_Tests.swift
//  ToDo!Tests
//
//  Created by Alec Tenefrancia on 4/21/20.
//  Copyright © 2020 Alec Tenefrancia. All rights reserved.
//

import XCTest
@testable import ToDo_

class ToDo_Tests: XCTestCase {

    //MARK: Task Class Tests
    
    // Confirm that the Meal initializer returns a Meal object when passed valid parameters.
    func testMealInitializationSucceeds() {
        // Zero rating
        let zeroRatingMeal = Task(name: "Zero", photo: nil)
        XCTAssertNotNil(zeroRatingMeal)
    }

}
