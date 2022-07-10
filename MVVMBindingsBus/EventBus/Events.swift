//
//  Events.swift
//  MVVMBindingsBus
//
//  Created by MacMini-8G on 10/07/22.
//

import Foundation

class Event<T> {
    let identifier: String
    let result: Result<T, Error>?
    
    init(identifier: String,
         result: Result<T, Error>?
    ) {
        self.identifier = identifier
        self.result = result
    }
}

// Sub-class of Events

class UserFetchEvent: Event<[UserModel]> {
    let created = Data()
    
}


// Models


