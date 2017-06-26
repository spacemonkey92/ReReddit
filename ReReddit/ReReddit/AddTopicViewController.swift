//
//  AddTopicViewController.swift
//  ReReddit
//
//  Created by nitin muthyala on 26/6/17.
//  Copyright © 2017 Spaceage Labs. All rights reserved.
//

import UIKit

class AddTopicViewController: UIViewController {

    // MARK:- UI Elements
    
    var navBar = UINavigationBar()
    
    var topicTextField : UITextField = {
        let textField = UITextField()
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.applyBackground()
        setupNavBar()
        // Do any additional setup after loading the view.
    }
    
    func setupNavBar(){
        self.navBar.customSetup(title: "Add Topic", view: self.view)
        self.view.addSubview(navBar)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
