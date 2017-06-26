//
//  ViewController.swift
//  ReReddit
//
//  Created by nitin muthyala on 25/6/17.
//  Copyright © 2017 Spaceage Labs. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    var topics:[Topic] = []
    
    // MARK:- UI Elements
    
    var topicsTableView : UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    var navBar : UINavigationBar = {
        let navbar = UINavigationBar()
        return navbar
    }()
    
    
    // MARK:- ViewController Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Sample data
        filterTopics(topics: Topic.getSampleTopics())
        
        // Setups
        self.view.applyBackground()
        setupNavBar()
        setupTableView()
    }
    
    
    
    // MARK:- View Setup Methods
    
    func setupNavBar(){
        self.navBar.customSetup(title: "Topics", view: self.view)
        self.view.addSubview(navBar);
    }
    
    func setupTableView(){
        
        self.topicsTableView.backgroundColor = UIColor.clear
        self.topicsTableView.tableFooterView = UIView()
        
        self.view.addSubview(topicsTableView)
        
        // Constraints. Pin all four sides
        self.topicsTableView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        self.topicsTableView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
        self.topicsTableView.topAnchor.constraint(equalTo: self.navBar.bottomAnchor, constant: 0).isActive = true
        self.topicsTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        
        // Register Cell
        self.topicsTableView.register(UINib.init(nibName: "TopicCell", bundle: nil), forCellReuseIdentifier: "TopicCell")
        self.topicsTableView.separatorStyle = .none
        
        // Set Data source
        self.topicsTableView.dataSource = self
        self.topicsTableView.delegate = self
        
    }
    
    
    func filterTopics(topics:[Topic]){
        
        // Sort
        let sortedTopics = topics.sorted(by: {
            $0.voteCount > $1.voteCount
        })
        
        let top20  = sortedTopics.count > 20 ? sortedTopics[0 ..< 20] : sortedTopics[0 ..< sortedTopics.count]
        self.topics = Array(top20)
        
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}


extension HomeViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : TopicCell = tableView.dequeueReusableCell(withIdentifier: "TopicCell")  as! TopicCell
        let topic = topics[indexPath.row]
        
        cell.topicLabel.text = topic.title
        cell.countLabel.text = topic.voteCount >= 0 ?   "+ \(topic.voteCount)" : "- \(topic.voteCount)"
        cell.backgroundColor = UIColor.clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    
}

