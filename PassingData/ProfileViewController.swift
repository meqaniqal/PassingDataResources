//
//  ViewController.swift
//  PassingData
//
//  Created by Sheldon Lawrence on 7/23/25.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    //this is so we can round the corners of the button we are using to separate the Edit name and edit bio buttons.
    @IBOutlet weak var separatorView: UIButton!
    var currentName="Anonymous"
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
   
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //turn the square between the edit name and edit bio buttons into a circle.
    
        separatorView.layer.cornerRadius=separatorView.frame.height/2
        // this is necessary to make the custom rounding visible
        separatorView.layer.masksToBounds = true
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // check if segue is being asked for is the "EditNameSegue"
        if segue.identifier == "EditNameSegue" {
            //cast the UIViewController that is segue.destination to our custom class EditNameViewController so that we can access its pre-load variables, such as the placeHolderText variable.
            let destinationVC=segue.destination as! EditNameViewController
            destinationVC.placeHolderText=currentName
            
        }
    }

    //tried changing the storyboardID when clicking the buttons was crashing the app...changed storyboardID to same name as custom class name. That did not get things working. Custom class name (after clicking the square icon above a storyboard item must match the file class it corresponds to for the storyboard items to be connected to the code.
    // After changing the Custom class name, if I had connected the buttons with IBActions, the circle is empty next to the functions below. But they were still connected to the old class names before I changed them. So I needed to select the button, click the connections tab in the inspector, and delete those connections. Then I could drag from the hollow circles from the functions below to the buttons to reconnect them.
   
   
    @IBAction func EditNameButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "EditNameSegue", sender: nil)
    }

    @IBAction func EditBioButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "EditBioSegue", sender: nil)
    }
    
}

