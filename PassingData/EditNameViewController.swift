//
//  EditNameViewController.swift
//  PassingData
//
//  Created by Sheldon Lawrence on 7/23/25.
//

import UIKit

class EditNameViewController: UIViewController {
    //these IBOutlets make these elements available to change the value of programmatically once the view is loaded.
    @IBOutlet weak var editNameTextField: UITextField!
    
    @IBOutlet weak var submitButton: UIButton!
    
    //placeHolderText will hold the text passed from ProfileViewController when it is loaded:
    var placeHolderText: String?
    //this is a reference, so it is the actual profile view controller, and operations on it will directly affect the original:
    //use "weak" to avoid a strong reference cycle, which has to do with when dismissing the EditNameViewController, deallocating its resources would require deallocating the referenced profileViewController, which would give us nothing to go back to after the dismiss.
    weak var profileVC: ProfileDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //unwrap placeHolderText and if it has a value, assign it to the placeholder for the text field:
        if let placeHolderText = placeHolderText {
            editNameTextField.placeholder = placeHolderText
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func submitButtonDidTouch(_ sender: Any) {
        // if no profile view contoller passed, or editName textfield is empty, update the name in the profileViewController and dismiss the editName VC
        //create nonoptional versions of the profile view controller and the editNameTextField, or return without processing the submit button.
        guard let profileVC = profileVC, let name=editNameTextField.text else {return}
        profileVC.updateName(name: name)
        dismiss(animated: true)
        
    }
    
    

}
