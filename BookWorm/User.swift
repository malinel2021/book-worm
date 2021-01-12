//
//  User.swift
//  BookWorm
//
//  Created by Malin Leven on 6/1/2021.
//  Copyright © 2021 Malin Leven. All rights reserved.
//

import Foundation


class User
{
    var username = Constants.EMPTY
    
    init()
    {
        username = Constants.EMPTY
    }
    
    init(username: String)
    {
        self.username = username
    }
    
    func getUsername() -> String
    {
        return username
    }
}





