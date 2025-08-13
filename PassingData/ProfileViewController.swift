//
//  ViewController.swift
//  PassingData
//
//  Created by Sheldon Lawrence on 7/23/25.
//

import UIKit

//This protocol will make everything in the ProfileViewController that we don't need access to private, using a protocol that conforms to "AnyObject," so it can work with classes:
protocol ProfileDelegate: AnyObject {
    func updateName(name:String)
}
var defaultBioName="My first Bio"
var currentBio=defaultBioName
//define this globally here to keep code neater when using this key in this view and in the EditBioViewcontroller:
let updateBioNotificationKey=Notification.Name("com.mekkanix-productions.PassingData.updateBioKey")

//now, so that we can pass the ProfileViewController as a ProfileDelegate, we could add this to the conformances. We could do this by adding to the list of conformances here, like this:
//  class ProfileViewController: UIViewController, ProfileDelegate {
// but it may be preferable to add it via an extension instead, which we have added after the class.
class ProfileViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    //this is used to round the corners of the button we are using to horizontally separate the Edit name and edit bio buttons.
    @IBOutlet weak var separatorView: UIButton!
    var currentName="Anonymous"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //set up the Notification Center to receive data sent to it from the EditBioViewController:
        //first param is the observer, which is the ProfileViewController, so this can be specified as "self." So The ProfileViewController will be observing for a notification which will be passed to updateBio(_:)
        //the selector parameter is a function to be called to receive the notification data.
        //updateBio(_:) means "something" is supposed to be passed, which will be the notification.
        NotificationCenter.default.addObserver(self, selector: #selector(updateBio(_:)), name: updateBioNotificationKey, object: nil)
        
    }
    
    //@objc is required for a selector function
    @objc func updateBio(_ notification: Notification) {
        //unwrap the userinfo from the received notification if present, get the "bio" key from it as a string if it exists, then update the currentBio and display it in the bioLabel in the profileViewController.
        if let userInfo=notification.userInfo, let bio=userInfo["bio"] as? String {
            currentBio=bio
            bioLabel.text=bio
        }
    }
   
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //turn the square between the edit name and edit bio buttons into a dot.
        separatorView.layer.cornerRadius=separatorView.frame.height/2
        // this is necessary in my case to make the custom rounding visible
        separatorView.layer.masksToBounds = true
        
    }
   
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // check which segue being asked for:
        if segue.identifier == "EditNameSegue" {
            //Segue.destination is of type UIViewController. Cast it to our custom class EditNameViewController so that we can access its placeHolderText variable.
            let destinationVC=segue.destination as! EditNameViewController
            destinationVC.placeHolderText=currentName
            //here we will pass all that is in the current profileViewController as self to the reference to it (profileVC) in the EditNameViewController held in destinationVC, so the EditNameViewController we are segueing to will have access to the updateName function from this custom profile view controller:
            destinationVC.profileVC=self
            
        }
    }


   
   
    @IBAction func EditNameButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "EditNameSegue", sender: nil)
    }

    @IBAction func EditBioButtonTapped(_ sender: Any) {
        //instead of using segue to bring up the EditBio view as we would with:
//        performSegue(withIdentifier: "EditBioSegue", sender: nil)
        // here, we bring up the EditBio view manually.
        //first, get the main storyboard:
        let mainStoryboard=UIStoryboard(name: "Main", bundle: nil)
        //use the main storyboard to instantiate an EditBioViewController..must be cast as an EditBioViewController to be usable as one:
        let editBioVC=mainStoryboard.instantiateViewController(withIdentifier: "EditBioViewController") as! EditBioViewController
        //If default or empty value for global currentBio, empty the placeholder text so the editBio view will supply the correct initial placeholder text.
        if currentBio.isEmpty || currentBio == defaultBioName {
             editBioVC.placeholderText = ""
         //otherwise, editBio view will display currentBio.
         } else {
            editBioVC.placeholderText = currentBio
         }
        //show the edit bio view:
        present(editBioVC,animated: true)
    }
    
}
//Extending ProfileViewController to conform to ProfileDelegate,and define a function here that will be all that is accessible to other views when passing a profileViewController. Everything in this extension that we want access to be limited to would otherwise be in the main ProfileViewController class. Having set this extension up, we can instead of passing the ProfileViewController to another viewController, which would give access to everything in the class, we can pass the ProfileDelegate, which will in this case give the other viewController it is passed to access to only the updateName function.
extension ProfileViewController: ProfileDelegate {
    //this function is for getting the name back from the EditNameViewController:
    func updateName(name: String){
        nameLabel.text=name
        currentName=name
        
    }
}
