//
//  DetailViewController.swift
//  CaptionMe
//
//  Created by Yuga Samuel on 15/09/23.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var photoImageView: UIImageView!
    var photoImageName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadPhotoImage()
    }
    
    func loadPhotoImage() {
        let imagePath = FileManager.documentsDirectory.appending(path: photoImageName)
        photoImageView.image = UIImage(contentsOfFile: imagePath.path())
    }
    
}
