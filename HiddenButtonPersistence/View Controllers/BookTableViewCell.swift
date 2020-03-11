//  BookTableViewCell.swift
//  HiddenButtonPersistence
//  Created by Lambda_School_Loaner_259 on 3/10/20.
//  Copyright © 2020 DeVitoC. All rights reserved.

import UIKit

class BookTableViewCell: UITableViewCell {

    // Properties
    var book: Book? {
        didSet {
            updateViews()
        }
    }
    
    let bookController = BookController.bookController
    
    
    // IBOutlets
    @IBOutlet var bookLabel: UILabel!
    @IBOutlet var timeToReadButton: UIButton!
    
    
    // MARK: - Here's the call to make the button disappear. The call is to a method in the Controller, so that's where the majority of the action actually happens.
    @IBAction func timeToReadButtonTapped(_ sender: Any) {
        guard let book = book else { return }
        timeToReadButton.isHidden = true
        bookController.updateIsTimeToRead(name: book.name)
    }
    
    // MARK: - This function is unused in my code. If you managed to set up a timer, this would be the basic format of the function the timer should call at it's end.
    @objc func updateTimeToReadButton(timer: Timer) {
        guard let book = book else { return }
        timeToReadButton.isHidden = false
        bookController.updateIsTimeToRead(name: book.name)
    }
    
    // View Control
    func updateViews() {
        guard let book = book else { return }
        bookLabel.text = book.name
        
        // MARK: - Unwrap the Date object from the book in this cell. If it exists, move on the the if statement, otherwise, there's nothing else to do in this updateViews method at this time.
        guard let nextReading = book.nextReading else { return }
        // MARK: - This if - else block tests whether the Date object saved in this book (if it passed the guard let) is greater than the current date - Date() - or else less than or equal to the current date. If it is greater than the current date, it will hide the button, as the time has not yet come to show the button. If it is equal to or less than the current time, then it shows the button since the time has come (i.e. effectively works as a timer ending)
        if nextReading > Date() {
            timeToReadButton.isHidden = true
        } else {
            timeToReadButton.isHidden = false
        }
    }
}
