//
//  ViewController.swift
//  Snippets
//
//  Created by Jak Tiano on 8/7/16.
//  Copyright © 2016 PacktPub. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var data: [SnippetData] = [SnippetData]()
    let imagePicker = UIImagePickerController()
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }


    @IBAction func createNewSnippet(_ sender: AnyObject) {
        
        let alert = UIAlertController(title: "Select a snippet type", message: nil, preferredStyle: .actionSheet)
        let textAction = UIAlertAction(title: "Text", style: .default) { (alert: UIAlertAction!) -> Void in
            self.createNewTextSnippet()
        }
        let photoAction = UIAlertAction(title: "Photo", style: .default) { (alert: UIAlertAction!) -> Void in
            self.createNewPhotoSnippet()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(textAction)
        alert.addAction(photoAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion:nil)
    }
    
    func createNewTextSnippet () {
        guard let textEntryVC = storyboard?.instantiateViewController(withIdentifier: "textSnippetEntry") as? TextSnippetEntryViewController else {
            print("TextSnippetEntryViewController could not be instantiated from storyboard")
            return
        }
        
        textEntryVC.modalTransitionStyle = .coverVertical
        textEntryVC.saveText = { ( text: String ) in
            let newTextSnippet = TextData(text: text, creationDate: Date())
            self.data.append(newTextSnippet)
        }

        present(textEntryVC,animated:true, completion:nil)
    }

    func createNewPhotoSnippet () {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            print ("Camera is not available")
            return
        }
        
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .camera
        
        present(imagePicker, animated: true, completion: nil)
    }

}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let image = info[UIImagePickerControllerEditedImage] as? UIImage else {
            print("Image could not be found")
            return
        }
        
        let newPhotoSnippet = PhotoData(photo: image, creationDate: Date())
        self.data.append(newPhotoSnippet)
        
        dismiss(animated: true, completion: nil)
    }
}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell

        let sortedData = data.reversed() as [SnippetData]
        let snippetData = sortedData[indexPath.row]

        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy hh:mm a"
        let dateString = formatter.string(from: snippetData.date)
        
        switch snippetData.type
        {
        case .text:
            cell = tableView.dequeueReusableCell(withIdentifier: "textSnippetCell", for: indexPath)
            (cell as! TextSnippetCell).label.text = (snippetData as! TextData).textData
            (cell as! TextSnippetCell).date.text = dateString

        case .photo:
            cell = tableView.dequeueReusableCell(withIdentifier: "photoSnippetCell", for: indexPath)
            (cell as! PhotoSnippetCell).photo.image = (snippetData as! PhotoData).photoData
            (cell as! PhotoSnippetCell).date.text = dateString
        }
        
        return cell
    }
}
