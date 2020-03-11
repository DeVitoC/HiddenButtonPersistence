//  MainTableViewController.swift
//  HiddenButtonPersistence
//  Created by Lambda_School_Loaner_259 on 3/10/20.
//  Copyright © 2020 DeVitoC. All rights reserved.

import UIKit

class MainTableViewController: UITableViewController {
    
    // Properties
    var bookController = BookController.bookController

    // View control
    override func viewDidLoad() {
        super.viewDidLoad()
        // MARK: - You probably recognize this, but calling loadFromPersistentStore at my first viewDidLoad so that I have the data needed for my cells including for the buttons.
        bookController.loadFromPersistentStore()
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // MARK: - Also put this in a viewWillAppear so that viewing the detail View Controller or adding an object will result in the tableView data reloading which triggers each cell to retest if the button should show.
        tableView.reloadData()
    }

    // tableView data
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookController.books.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as? BookTableViewCell else { return UITableViewCell() }
        let book = bookController.books[indexPath.row]
        
        cell.book = book

        return cell
    }

    // Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "NewBookSegue" {
            guard let addBookVC = segue.destination as? DetailsViewController else { return }
            addBookVC.bookController = bookController
        } else if segue.identifier == "BookDetailSegue" {
            guard let bookDetailVC = segue.destination as? DetailsViewController,
                let index = tableView.indexPathForSelectedRow?.row
                else { return }
            bookDetailVC.bookController = bookController
            let book = bookController.books[index]
            bookDetailVC.book = book
        }
    }
}
