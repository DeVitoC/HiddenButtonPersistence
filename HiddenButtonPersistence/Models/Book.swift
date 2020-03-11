//  Book.swift
//  HiddenButtonPersistence
//  Created by Lambda_School_Loaner_259 on 3/10/20.
//  Copyright © 2020 DeVitoC. All rights reserved.


import Foundation

struct Book: Codable {
    var name: String
    var numberOfPages: Int
    
    // MARK: - var isRecurring would be a way to track whether the timer is recurring (true) or one time (false)
    var isRecurring: Bool
    // MARK: - var nextReading holds the Date object that acts as your timer.
    var nextReading: Date?
    
    // MARK: -  Using a custom init so that I can manually set isRecurring and nextReading since I don't need either of those set at the creation of the object. You could instead make those part of the information you collect from the user, which would mean you could forgoe the init and simply pass in the values from the user.
    init(name: String, numberOfPages: Int) {
        self.name = name
        self.numberOfPages = numberOfPages
        self.isRecurring = false
        self.nextReading = nil
    }
}
