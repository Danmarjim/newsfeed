//
//  NFFeed.swift
//  newsfeed
//
//  Created by Daniel Martin Jimenez on 6/4/17.
//  Copyright © 2017 Daniel Martin Jimenez. All rights reserved.
//

import Foundation
import FirebaseDatabase
import SwiftyJSON

struct NFFeed {
    
    let id: String
    let index: Int
    var people: [NFPeople] = Array()
    let picture: String
    var tags: [String] = Array()
    let text: String
    let thumbnail: String
    let title: String
    
    init(snapshot: FIRDataSnapshot) {
        let json = JSON(snapshot.value as! [String: AnyObject])
        id = json["_id"].string!
        index = json["index"].int!
        
        for i in 0...json["people"].count - 1 {
            let person = NFPeople(name: json["people"][i]["name"].string!, photo: json["people"][i]["photo"].string!)
            people.append(person)
        }
        
        picture = json["picture"].string!
        tags = json["tags"].arrayValue.map({$0.stringValue})
        text = json["text"].string!
        thumbnail = json["thumbnail"].string!
        title = json["title"].string!
    }
}
