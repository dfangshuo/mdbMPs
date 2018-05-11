//
//  NewSocialViewController.swift
//  mdbSocials
//
//  Created by Fang on 2/20/18.
//  Copyright © 2018 fang. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class NewSocialViewController: UIViewController,UITextViewDelegate {
    
    // event entry parameters
    var eventName: UITextField!
    var descrip: UITextView!
    var makeEventButton: UIButton!
    var addImage: UIButton!
    var takePicture: UIButton!
    var datePicker: UIDatePicker!

    // navigation
    var cancel: UIButton!

    // event storage parameters
    var eventCalled: String!
    var dateSelected: String!
    var eventDescribed: String!
    
    // temp date storage
    var tempDate: String!
    var eventImageView: UIImageView!
    let picker = UIImagePickerController()
    
    var postingUser = Users();
//    var URLToGo: String!

    override func viewDidLoad() {
        super.viewDidLoad()
//        print(postingUser.name)
//        print(postingUser.id)
        // Do any additional setup after loading the view.
        setUpView()
        setUpEventView()
        
    }
    
    func setUpView() {
        
        eventName = UITextField(frame: CGRect(x: 40, y: 70, width: view.frame.width - 20, height: 40))
        eventName.placeholder = "New Event"
        eventName.clipsToBounds = true
        eventName.adjustsFontSizeToFitWidth = true
        eventName.font = eventName.font!.withSize(38)
        view.addSubview(eventName)
        
        descrip = UITextView(frame: CGRect(x: 8, y: 500, width: self.view.frame.width-16, height: 100))
        descrip.delegate = self
        descrip.becomeFirstResponder()
        descrip.selectedTextRange = descrip.textRange(from: descrip.beginningOfDocument, to: descrip.beginningOfDocument)
        descrip.layoutIfNeeded()
        descrip.layer.borderColor = UIColor(red: 0.57, green: 0.85, blue: 0.95, alpha: 0.9).cgColor
        descrip.layer.borderWidth = 1.5
        descrip.layer.cornerRadius = 10
        descrip.layer.masksToBounds = true
        descrip.clipsToBounds = true
        descrip.textColor = UIColor.black
        view.addSubview(descrip)
        
        datePicker = UIDatePicker(frame: CGRect(x: 10, y: 350,  width: UIScreen.main.bounds.width - 16, height: 150))
        datePicker.timeZone = NSTimeZone.local
        datePicker.backgroundColor = UIColor.white
        
        // Add an event to call onDidChangeDate function when value is changed.
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        
        // Add DataPicker to the view
        self.view.addSubview(datePicker)
        
        makeEventButton = UIButton(frame: CGRect(x: 10, y: 0.8 * UIScreen.main.bounds.height+25, width: UIScreen.main.bounds.width - 20, height: 45))
        makeEventButton.layoutIfNeeded()
        makeEventButton.setTitle("Make Event", for: .normal)
        makeEventButton.layer.cornerRadius = 10
        makeEventButton.backgroundColor = UIColor(red: 0.57, green: 0.85, blue: 0.95, alpha: 0.9)
        view.addSubview(makeEventButton)
        
        cancel = UIButton(frame:CGRect(x: (view.frame.width - 125)/2, y: 675, width: 125, height: 30))
        cancel.setTitleColor(UIColor(red: 0.57, green: 0.85, blue: 0.95, alpha: 0.9), for: .normal)
        cancel.setTitle("back", for: .normal)
        cancel.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        view.addSubview(cancel)
        
        makeEventButton.addTarget(self, action: #selector(eventMade), for: .touchUpInside)
    }
    
    func setUpEventView() {
        eventImageView = UIImageView(frame: CGRect(x: 40, y: 70, width: UIScreen.main.bounds.width - 85, height: UIScreen.main.bounds.width - 85))
        view.addSubview(eventImageView)

        takePicture = UIButton(frame: CGRect(x:(view.frame.width-75)/2 - 45, y: 170, width: 75, height: 75))
        takePicture.setTitle("Camera", for: .normal)
        takePicture.clipsToBounds = true
        takePicture.addTarget(self, action: #selector(takePic), for: .touchUpInside)
        takePicture.layer.cornerRadius = 10
        takePicture.backgroundColor = UIColor(red: 0.57, green: 0.85, blue: 0.95, alpha: 0.9)
        view.addSubview(takePicture)
        
        addImage = UIButton(frame: CGRect(x:(view.frame.width-75)/2 + 45, y: 170, width: 75, height: 75))
        addImage.setTitle("Roll", for: .normal)
        addImage.clipsToBounds = true
        addImage.addTarget(self, action: #selector(pickImage), for: .touchUpInside)
        addImage.layer.cornerRadius = 10
        addImage.backgroundColor = UIColor.lightGray
        view.addSubview(addImage)
//        view.bringSubview(toFront: addImage)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func eventMade() {
        let postsRef = Database.database().reference().child("Posts")
        let key = postsRef.childByAutoId().key

        if (eventName.text! != "") {
             eventCalled = eventName.text!
            
            // format description data
            if descrip.text == "What in the world is this???" {
                eventDescribed = ""
            } else {
                eventDescribed = descrip.text!
            }
            
            if tempDate == nil {
                throwError(info: "Is this really the time you want?")
            } else {
                dateSelected  = tempDate!
                // Get a reference to the storage service using the default Firebase App
                let storage = Storage.storage()
                // Create a storage reference from our storage service
                let storageRef = storage.reference()
            
                // File located on disk
                //            let data = eventImageView.image!
                if eventImageView.image == nil {
                    APIClient.createNewPost(postsRef: postsRef, key: key, title: self.eventCalled, postText: self.eventDescribed, poster: self.postingUser.name!, imageUrl: "nil", posterId: self.postingUser.id!, num: 1, timePicked: dateSelected)
                } else {
                    let data = UIImageJPEGRepresentation(eventImageView.image!, 1.0)
                    
                    // Create a reference to the file you want to upload
                    let events = storageRef.child(key)
                    let metadata = StorageMetadata()
                    metadata.contentType = "image/jpeg"
                    
                    let uploadTask = events.putData(data!, metadata: nil) { (metadata, error) in
                        guard let metadata = metadata else {
                            return
                        }
                        // Metadata contains file metadata such as size, content-type, and download URL.
                        let downloadURL = metadata.downloadURL()?.absoluteString
                        print(self.dateSelected)
                        APIClient.createNewPost(postsRef: postsRef, key: key, title: self.eventCalled, postText: self.eventDescribed, poster: self.postingUser.name!, imageUrl: downloadURL!, posterId: self.postingUser.id!, num: 1, timePicked: self.dateSelected)
                    }
                }
                
            }
        } else {
            throwError(info: "Please name this event")
        }
        print("Event Made")
        self.dismiss(animated: true, completion: {})
    }
    

    
    @objc func datePickerValueChanged(_ sender: UIDatePicker){
        
        // Create date formatter
        let dateFormatter: DateFormatter = DateFormatter()
        
        // Set date format
        dateFormatter.dateFormat = "MM/dd/yyyy hh:mm a"
        
        // Apply date format
        tempDate = dateFormatter.string(from: sender.date)
        
        print("Selected value \(tempDate!)")
    }

    @objc func goBack() {
        print("Cancelled")
        self.dismiss(animated: true, completion: {})
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "What in the world is this???"
            textView.font = textView.font?.withSize(20)
            textView.textColor = UIColor.lightGray
        }
    }
    
    func throwError(info: String) {
        let alert = UIAlertController(title: "\(info)", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func pickImage(sender: UIButton!) {
            picker.delegate = self
            picker.allowsEditing = false
            picker.sourceType = .photoLibrary
//            picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
            self.present(picker, animated: true, completion: nil)
        }
    
    @objc func takePic() {
        picker.delegate = self
        picker.allowsEditing = false
        picker.sourceType = .camera
        self.present(picker, animated: true, completion: nil)
    }
    

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}


extension NewSocialViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // Delegates
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        addImage.removeFromSuperview()
        takePicture.removeFromSuperview()
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        eventImageView.contentMode = .scaleAspectFit
        eventImageView.image = chosenImage
        dismiss(animated:true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

//extension NewSocialViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//        selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
//    }
//
//}

