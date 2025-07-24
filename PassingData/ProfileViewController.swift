//
//  ViewController.swift
//  PassingData
//
//  Created by Sheldon Lawrence on 7/23/25.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

//    @IBAction func GoToEditNameTapped(_ sender: Any) {
//        performSegue(withIdentifier: "EditNameSegue", sender: nil)
//    }
    //tried changing the storyboardID when clicking the buttons was crashing the app...changed storyboardID to same name as custom class name. That did not get things working. Custom class name (after clicking the square icon above a storyboard item must match the file class it corresponds to for the storyboard items to be connected to the code.
    // After changing the Custom class name, if I had connected the buttons with IBActions, the circle is empty next to the functions below. But they were still connected to the old class names before I changed them. So I needed to select the button, click the connections tab in the inspector, and delete those connections. Then I could drag from the hollow circles from the functions below to the buttons to reconnect them.
   
   
    @IBAction func EditNameButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "EditNameSegue", sender: nil)
    }

    @IBAction func EditBioButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "EditBioSegue", sender: nil)
    }
    
}

