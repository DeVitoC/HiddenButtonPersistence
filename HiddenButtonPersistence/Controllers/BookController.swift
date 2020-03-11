//  BookController.swift
//  HiddenButtonPersistence
//  Created by Lambda_School_Loaner_259 on 3/10/20.
//  Copyright © 2020 DeVitoC. All rights reserved.

import Foundation

class BookController {
    
    // Properties
    var books: [Book] = []
    static let bookController = BookController()
    
    // CRUD
    func createBook(name: String, numberOfPages: Int) {
        let newBook = Book(name: name, numberOfPages: numberOfPages)
        books.append(newBook)
        saveToPersistentStore()
    }
    
    func indexForBook(named: String) -> Int? {
        for i in 0..<books.count {
            if books[i].name == named {
                return i
            }
        }
        return nil
    }
    
    // MARK: - This method is the primary workhorse of this hiding button. The end result of this function is to initially set up the time/date object in nextReading or to test that time/date object against now to see if time is up and ignore or set nextReading appropriately.
    func updateIsTimeToRead(name: String) {
        guard let index = indexForBook(named: name) else { return }
        guard let nextReading = books[index].nextReading
            else {
                // MARK: - If nextReading is nil, then this means that this has not previously been called, so it will set nextReading to some time after the current date/time. You would change the amount of time in the parameters "byAdding" and "value". byAdding can be .second, .minute, .hour, .day, etc. value can be any Int you set it to. For your app the way you've described it, you would want byAdding to be .day and value to be however many days the user enters. You would need to pass in a variable for the value.
                books[index].nextReading = Calendar.current.date(byAdding: .minute, value: 1, to: Date())
                saveToPersistentStore()
                return }
        // MARK: - If nextReading already had a date/time object in it, then this next if/else will test whether it is before or after the current date. If nextReading is in the future (i.e. nextReading > Date) this will simply return without making any changes since it is not time to do anything yet. Otherwise, it will increment it by whatever amount you tell it if it is recurring (the if block line) or if it is not recurring, it will simply set the date/time object back to nil
        if nextReading <= Date() {
            if books[index].isRecurring {
                books[index].nextReading = Calendar.current.date(byAdding: .minute, value: 1, to: nextReading)
            } else {
                books[index].nextReading = nil
            }
        } else if nextReading > Date() {
            return
        }
        saveToPersistentStore()
    }
    
    func updateBook(name: String, numberOfPages: Int) {
        guard let index = indexForBook(named: name) else { return }
        books[index].numberOfPages = numberOfPages
        saveToPersistentStore()
    }
    
    // MARK: - Not used in my code, since I'm not editing whether the method is recurring or not. For my testing purposes, I am leaving the isRecurring property to false. Mostly, this is because I'm not 100% sure how I want to implement a recurring time with the hiding button.
    func updateIsRecurring(name: String, isRecurring: Bool) {
        guard let index = indexForBook(named: name) else { return }
        books[index].isRecurring = isRecurring
        saveToPersistentStore()
    }
        
    // Persistence
    private var persistentFileURL: URL? {
        let fileManager = FileManager.default
        guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        return documents.appendingPathComponent("books.plist")
    }
    
    func saveToPersistentStore() {
        guard let url = persistentFileURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(books)
            try data.write(to: url)
        } catch {
            print("Error saving books data: \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        
        let fileManager = FileManager.default
        guard let url = persistentFileURL, fileManager.fileExists(atPath: url.path) else {
            return }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            books = try decoder.decode([Book].self, from: data)
        } catch {
            print("error loading books data: \(error)")
        }
    }
}
