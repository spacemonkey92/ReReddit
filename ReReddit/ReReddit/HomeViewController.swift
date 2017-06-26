//
//  ViewController.swift
//  ReReddit
//
//  Created by nitin muthyala on 25/6/17.
//  Copyright © 2017 Spaceage Labs. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController , AddTopicDelegate {

    
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
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    // MARK:- ViewController Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Sample data
        self.topics = Topic.getSampleTopics()
        filterTopics()
        
        // Setups
        self.view.applyBackground()
        setupNavBar()
        setupTableView()
    }
    

    
    
    
    // MARK:- View Setup Methods
    
    func setupNavBar(){
        self.navBar.customSetup(title: "Topics", view: self.view)
        self.view.addSubview(navBar)
        let addButton = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(didClickAdd))
        navBar.topItem?.rightBarButtonItem = addButton
    }
    
    func didClickAdd(){
        let addTopicVC = AddTopicViewController()
        addTopicVC.delegate = self
        self.present(addTopicVC, animated: true, completion: nil)
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
    
    
    func filterTopics(){
        // Sort
        let sortedTopics = topics.sorted(by: {
            $0.voteCount > $1.voteCount
        })
        
        let top20  = sortedTopics.count > 20 ? sortedTopics[0 ..< 20] : sortedTopics[0 ..< sortedTopics.count]
        self.topics = Array(top20)
    }
    
    // MARK:- Add Topic Delegates
    func didAddTopic(topic: Topic) {
        self.topics.append(topic)
        rearrange()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


extension HomeViewController : UITableViewDelegate, UITableViewDataSource , ButtonCellDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : TopicCell = tableView.dequeueReusableCell(withIdentifier: "TopicCell")  as! TopicCell
        if cell.buttonDelegate == nil {
            cell.buttonDelegate = self
        }
        let topic = topics[indexPath.row]
        cell.topicLabel.numberOfLines = 0
        cell.topicLabel.text = topic.title
        cell.countLabel.text = topic.voteCount >= 0 ?   "+\(topic.voteCount)" : "\(topic.voteCount)"
        cell.backgroundColor = UIColor.clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // Dynamic cell height 
        let topic = self.topics[indexPath.row]
        return ViewUtil.getCellHeightFor(title: topic.title, view: self.view)
    }
    
    
    // MARK:- Voting Methods
    
    
    
    /// Update the vote count of a perticular topic
    /// Update the view
    ///
    /// - Parameters:
    ///   - cell: cell
    ///   - action: true = up , false : down
    func didClick(cell: TopicCell, action: Bool) {
        
        guard let path = self.topicsTableView.indexPath(for: cell) else {
            return
        }
        let position = path.row
        
        
        if action{
            // Up
            self.topics[position].up()
            let abovePositoin = position - 1
            if abovePositoin < 0 {
                updateAt(path: path)
                return // its already on top
            }
            if topics[abovePositoin].voteCount < topics[position].voteCount {
                rearrange()
                return
            }else{
                updateAt(path: path)
                return
            }
        }else{
            
            // Down voted
            self.topics[position].down()
            let nextPositoin = position + 1
            if nextPositoin >= topics.count {
                updateAt(path: path)
                return // its already at the bottom
            }
            if topics[nextPositoin].voteCount > topics[position].voteCount {
                rearrange()
                return
            }else{
                updateAt(path: path)
                return
            }
        }
    }
    
    
    
    /// Re arrange the topics and reload the data table
    func rearrange(){
        filterTopics()
        topicsTableView.reloadData()
        return
    }
    
    // Update the table at path
    func updateAt(path:IndexPath){
        topicsTableView.beginUpdates()
        topicsTableView.reloadRows(at: [path], with: UITableViewRowAnimation.none)
        topicsTableView.endUpdates()
    }
    
    
    
}

