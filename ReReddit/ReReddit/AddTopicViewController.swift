//
//  AddTopicViewController.swift
//  ReReddit
//
//  Created by nitin muthyala on 26/6/17.
//  Copyright © 2017 Spaceage Labs. All rights reserved.
//

import UIKit

class AddTopicViewController: UIViewController {
    
    var delegate : AddTopicDelegate?
    static let MAX_LENGTH = 255
    
    // MARK:- UI Elements
    
    var navBar = UINavigationBar()
    
    var topicTextField : UITextView = {
        let textField = UITextView()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = UIColor.white
        textField.layer.borderWidth = 0.4
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.cornerRadius = 5
        return textField
    }()
    
    var submitBtn : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Submit", for: .normal)
        button.layer.cornerRadius = 5.0
        button.backgroundColor = ViewUtil.getSecondaryColor()
        button.setTitleColor(UIColor.white, for: .normal)
        return button
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK:- ViewController methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.applyBackground()
        setupNavBar()
        setupTextField()
        setupButton()
        // Do any additional setup after loading the view.
    }
    
    
    // MARK:- setup methods
    func setupNavBar(){
        self.navBar.customSetup(title: "Add Topic", view: self.view)
        self.view.addSubview(navBar)
        let addButton = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(close))
        navBar.topItem?.rightBarButtonItem = addButton
    }
    
    func setupTextField(){
        self.view.addSubview(topicTextField)
        
        // Constraints. Pin 3 sides and set height
        self.topicTextField.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20).isActive = true
        self.topicTextField.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20).isActive = true
        self.topicTextField.topAnchor.constraint(equalTo: self.navBar.bottomAnchor, constant: 20).isActive = true
        let heightConstraint = NSLayoutConstraint(item: topicTextField, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 170)
        topicTextField.addConstraint(heightConstraint)
    }
    
    func setupButton(){
        self.view.addSubview(submitBtn)
        submitBtn.topAnchor.constraint(equalTo: self.topicTextField.bottomAnchor, constant: 20).isActive = true
        submitBtn.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20).isActive = true
        let widthConstraint = NSLayoutConstraint(item: submitBtn, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 80)
        submitBtn.addConstraint(widthConstraint)
        submitBtn.addTarget(self, action: #selector(didClickSubmit), for: .touchUpInside)
        
    }
    
    
    
    func close(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func didClickSubmit(){
        guard let topicTitle = self.topicTextField.text else{
            return
        }
        
        guard let delegate = self.delegate else{
            return
        }
        
        let trimmedString = topicTitle.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmedString.characters.count > 0 && trimmedString.characters.count <= AddTopicViewController.MAX_LENGTH {
            delegate.didAddTopic(topic: Topic(title: trimmedString))
            close()
            return
        }
        if trimmedString.characters.count > AddTopicViewController.MAX_LENGTH {
            ViewUtil.popAlertView(vc: self, title: "Invalid Topic", message: "Your topic lenght must not exceed 255 characters", option: "ok")
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

// Add topic Delegate

protocol AddTopicDelegate {
    func didAddTopic(topic:Topic)
}
