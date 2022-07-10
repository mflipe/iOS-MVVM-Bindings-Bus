//
//  Bus.swift
//  MVVMBindingsBus
//
//  Created by MacMini-8G on 10/07/22.
//

import Foundation

final class Bus {
    static let shared = Bus()
    
    private init() {}
    
    enum EventType {
        case userFetch
    }
    
    struct Subcriptions {
        let type: EventType
        let queue: DispatchQueue
        let block: ((Event<[UserModel]>) -> Void)
    }
    
    private var subscriptions = [Subcriptions]()
    
    // Subscriptions
    func subscribe(
        _ event: EventType,
        block: @escaping((Event<[UserModel]>) -> Void)
    ){
        let new = Subcriptions(type: event, queue: .global(), block: block)
        subscriptions.append(new)
    }
    
    func subscribeOnMain(
        _ event: EventType,
        block: @escaping((Event<[UserModel]>) -> Void)
    ){
        let new = Subcriptions(type: event, queue: .main, block: block)
        subscriptions.append(new)
    }
    
    // Publications
    func publish(
        type: EventType,
        to event: UserFetchEvent
    ) {
        let subscribers = subscriptions.filter({ $0.type == type })
        subscribers.forEach( { subscriber in
            subscriber.queue.async {
                subscriber.block(event)
            }
        })
    }
    
}
