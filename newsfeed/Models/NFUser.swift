//
//  NFUser.swift
//  newsfeed
//
//  Created by Daniel Martin Jimenez on 4/4/17.
//  Copyright © 2017 Daniel Martin Jimenez. All rights reserved.
//

import Foundation
import FirebaseAuth

struct NFUser {
    
    let uid: String
    let email: String
    
    init(authData: FIRUser) {
        uid = authData.uid
        email = authData.email!
    }
    
    init(uid: String, email: String) {
        self.uid = uid
        self.email = email
    }
}
