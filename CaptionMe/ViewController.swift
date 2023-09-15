//
//  ViewController.swift
//  CaptionMe
//
//  Created by Yuga Samuel on 15/09/23.
//

import UIKit

class ViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var photos = [Photo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPhoto))
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Photo", for: indexPath) as? PhotoCell else {
            fatalError("Unable to dequeue Photo")
        }
        
        let photo = photos[indexPath.item]
        
        var content = cell.defaultContentConfiguration()
        content.text = photo.caption
        
        let path = getDocumentsDirectory().appending(path: photo.image)
        content.image = UIImage(contentsOfFile: path.path())
        
        cell.contentConfiguration = content
        
        return cell
    }
    
    @objc func addPhoto() {
        let picker = UIImagePickerController()
        /*
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        }
        */
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }

        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)

        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }
        
        let photo = Photo(caption: "N/A", image: imageName)
        photos.append(photo)
        tableView.reloadData()
        
//        save()
        dismiss(animated: true)
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

