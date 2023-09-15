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
        
        let path = FileManager.documentsDirectory.appending(path: photo.image)
        content.image = UIImage(contentsOfFile: path.path())
        
        cell.contentConfiguration = content
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
            vc.photoImageName = photos[indexPath.row].image
            
            navigationController?.pushViewController(vc, animated: true)
        }
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
        let imagePath = FileManager.documentsDirectory.appending(path: imageName)

        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }
        
        let photo = Photo(caption: "", image: imageName)
        photos.append(photo)
        
        
//        save()
        dismiss(animated: true)
        showAlert(photo: photo)
    }
    
    func showAlert(photo: Photo) {
        let ac = UIAlertController(title: "Add photo caption", message: nil, preferredStyle: .alert)
        
        ac.addTextField()
        
        ac.addAction(UIAlertAction(title: "Submit", style: .default) { [weak self, weak ac] _ in
            guard let caption = ac?.textFields?[0].text else { return }
            photo.caption = caption
            self?.tableView.reloadData()
        })
        
        present(ac, animated: true)
    }
}

