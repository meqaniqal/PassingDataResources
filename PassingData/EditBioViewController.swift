//
//  EditProfileViewController.swift
//  PassingData
//
//  Created by Sheldon Lawrence on 7/24/25.
//

import UIKit

class EditBioViewController: UIViewController {

    //text view that adds custom behavior to its editing events and default text/text color to simulate the placeholder behavior that an ordinary textfield has:
    @IBOutlet weak var bioTextView: UITextView!
    @IBOutlet weak var editBioSubmitButton: UIButton!
    //this will be empty if nothing is sent as a placeholder, and will later be assigned a default placeholder if empty:
    var placeholderText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //assignment of "self" is necessary so the delegate functions associated with the bioTextView will be attached to it now and triggered later.
        bioTextView.delegate = self
        //add border to distinguish the TextView from the surrounding background.
        bioTextView.layer.borderWidth=0.5
        bioTextView.layer.borderColor=UIColor.lightGray.cgColor
        //set up text as placeholder text only if it is the default bio assigned initially when running the app:
        if placeholderText.isEmpty || placeholderText == defaultBioName {
               bioTextView.text = "Edit bio here..."
               bioTextView.textColor = .lightGray
           } else {
               bioTextView.text = placeholderText
               bioTextView.textColor = .black
           }
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //rounding of the textView border is better to do here, I think so size changes will trigger a redraw.
        editBioSubmitButton.layer.cornerRadius = 8
        bioTextView.layer.cornerRadius = 8
    }
    
    @IBAction func submitButtonDidtouch(_ sender: Any) {
        //unwrap bioTextView text and set to "" if nil
        var bio = bioTextView.text ?? ""

        
        // Reset bio to default if all its characters amount to an empty entry:
        if bio.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            //set messagecenter message and global bio string back to default ("My first Bio")
            bio = defaultBioName
            currentBio = defaultBioName
        }
        
        
        //sending back data via notification center...first unwrap the bio textField text, but do nothing if the textField is empty.
//        guard let bio = editBioTextField.text else {return}
      
        
       
        //Set up a dict that will contain the data to be posted to notification center. Type "Any" would allow sending values of more than one possible type via the dictionary, in case you wanted to send data of various types in addition to this single item.
        let userInfo: [String:Any ] = ["bio":bio]
        //Here we post the notification. First param "name" we set up globally to be provided here and in views we want to access the same  userInfo in, parameter "object" can be used to limit communication to being with a particular view controller, which in this case would likely be the ProfileViewCopntroller, which could be specified here and in the profile view controller via object: ProfileViewController.self. Although userInfo is meant to be used for passing the data, "object" can also be used for this purpose by assigning the object here, but setting object to nil in the profileviewcontroller. You can test from within the selector function in the profileviewcontroller if that object has been received. Here, though, we are not using the object to pass information or limit where we can receive from, so we just assign nil to object.
        NotificationCenter.default.post(name: updateBioNotificationKey, object: nil, userInfo: userInfo)
        
        dismiss(animated: true)
    }
    
    

}

//here we create an extension to simulate the behavior of gray placeholder text that disappears when editing:
extension EditBioViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        //when user clicks in the textView to edit, and there is gray text in the textView, meaning it is a placeholder, erase the text and change text color to black so the user will type in something that is not a placeholder.
        if textView.textColor == .lightGray {
            textView.text=nil
            textView.textColor = .black
            
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        //set text to gray placeholder after editing only if it is empty or is the initial value of the bio upon first run.
        if textView.text.isEmpty || currentBio=="My first Bio" {
            textView.textColor = .lightGray
            textView.text = "Edit bio here..."
            
        }
    }
}
