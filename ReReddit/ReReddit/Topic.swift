//
//  Topic.swift
//  ReReddit
//
//  Created by nitin muthyala on 26/6/17.
//  Copyright © 2017 Spaceage Labs. All rights reserved.
//

import Foundation

class Topic {
    
    var title:String
    var voteCount = 0
    
    init(title:String) {
        self.title = title
    }
    
    // for test data only
    private init(title:String,voteCount:Int){
        self.title = title
        self.voteCount = voteCount
    }
    
    func up(){
        self.voteCount = voteCount + 1
    }
    
    func down(){
        self.voteCount = voteCount - 1
    }
    
    
    // Placeholder data 
    static func getSampleTopics() -> [Topic]{
        
        let topic1 = Topic(title: "Just switched from Galaxy Tab to 2017 iPad", voteCount: 6)
        let topic2 = Topic(title: "Apple & Tim Cook celebrate #Pride2017 in cities around the world", voteCount: 2)
        let topic3 = Topic(title: "Latest iPhone 8 dummy images further corroborate glass back, in-screen Touch ID", voteCount: 25)
        let topic4 = Topic(title: "Apple has removed 58k apps from the Chinese App Store over the last two weeks, 10x more than normal", voteCount: 25)
        let topic5 = Topic(title: "Nike SNKRS iOS app adds AR features to make exclusive sneaker releases interactive", voteCount: 25)
        
        return [topic1,topic2,topic3,topic4,topic5]
        
    }
}
