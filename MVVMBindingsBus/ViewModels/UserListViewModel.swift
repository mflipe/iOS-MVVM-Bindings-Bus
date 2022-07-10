//
//  UserListViewModel.swift
//  MVVMBindingsBus
//
//  Created by MacMini-8G on 10/07/22.
//

import Foundation

struct UserListViewModel {
    
    public var users: [UserModel] = []
    
    public func fetchUserList() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { return }
    
    
    let task = URLSession.shared.dataTask(with: url) { data, _, _ in
        guard let data = data else { return }
        
        let event: UserFetchEvent
        
        do {
            let users = try JSONDecoder().decode([UserModel].self, from: data)
            
            event = UserFetchEvent(identifier: UUID().uuidString,
                                       result:.success(users))
        } catch {
            event = UserFetchEvent(identifier: UUID().uuidString,
                                       result:.failure(error))
        }
        Bus.shared.publish(type: .userFetch, to: event)
    }
    task.resume()
    }
}
