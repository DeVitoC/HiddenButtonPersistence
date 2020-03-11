//  DetailsViewController.swift
//  HiddenButtonPersistence
//  Created by Lambda_School_Loaner_259 on 3/10/20.
//  Copyright © 2020 DeVitoC. All rights reserved.

import UIKit

class DetailsViewController: UIViewController {
    
    // Properties
    var bookController: BookController?
    var book: Book?
    
    // IBOutlets
    @IBOutlet var bookNameTextField: UITextField!
    @IBOutlet var numberOfPagesTextField: UITextField!
    
    
    // IBAction
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let bookName = bookNameTextField.text,
            !bookName.isEmpty,
            let numberOfPagesString = numberOfPagesTextField.text,
            !numberOfPagesString.isEmpty,
            let numberOfPages = Int(numberOfPagesString)
            else { return }
        if book != nil {
            bookController?.updateBook(name: bookName, numberOfPages: numberOfPages)
        } else {
            bookController?.createBook(name: bookName, numberOfPages: numberOfPages)
        }
        navigationController?.popToRootViewController(animated: true)
    }
    
    // View control
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let book = book {
            bookNameTextField.text = book.name
            numberOfPagesTextField.text = "\(book.numberOfPages)"
        }
    }
    

}
