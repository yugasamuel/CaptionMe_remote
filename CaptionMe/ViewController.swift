//
//  ViewController.swift
//  CaptionMe
//
//  Created by Yuga Samuel on 15/09/23.
//

import UIKit

class ViewController: UITableViewController {
    var photos = [Photo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPhoto))
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Photo", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        content.text = photos[indexPath.row].caption
        cell.contentConfiguration = content
        
        return cell
    }
    
    @objc func addPhoto() {
        photos.append(Photo(caption: "dummy", image: "dummy"))
        tableView.reloadData()
    }
    
}

