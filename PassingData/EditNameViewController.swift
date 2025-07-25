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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //unwrap placeHolderText and if it has a value, assign it to the placeholder for the text field:
        if let placeHolderText = placeHolderText {
            editNameTextField.placeholder = placeHolderText
        }
        // Do any additional setup after loading the view.
    }
    

    

}
