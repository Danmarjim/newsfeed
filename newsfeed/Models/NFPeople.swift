//
//  NFPeople.swift
//  newsfeed
//
//  Created by Daniel Martin Jimenez on 6/4/17.
//  Copyright © 2017 Daniel Martin Jimenez. All rights reserved.
//

import Foundation
import FirebaseDatabase
import SwiftyJSON

class NFPeople {
    
    let name: String
    let photo: String
    
    init(name: String, photo: String) {
        self.name = name
        self.photo = photo
    }
}
