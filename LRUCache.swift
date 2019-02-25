//
//  main.swift
//  ett
//
//  Created by Jacob Jiang on 2/25/19.
//  Copyright © 2019 Jacob Jiang. All rights reserved.
//

import Foundation

print("Hello, World!")


class LRUCache<KeyType:Hashable,Element> {
    
    var maxSize:Int = 0
    var currentSize:Int = 0
    public init() {}
    private var mem:[KeyType:ListNode<KeyType,Element>]  = [:]
    var first:ListNode<KeyType,Element>?
    var last:ListNode<KeyType,Element>?

    public func set(value:Element,forKey key:KeyType) {
        
        remove(key: key)
        add(value: value, key: key)
    }
    
    private func add(value:Element, key:KeyType) {
        if currentSize >= maxSize {
            remove(key: first!.key)
        }
        
        let newNode = ListNode(key: key, value: value)
        if first == nil {
            first = newNode
            last = newNode
        }
        else
        {
            last?.next = newNode
            newNode.prev = last
            last = newNode
        }
        mem[key] = newNode
        currentSize += 1
    }
    
    public func get(key:KeyType) -> Element? {
        let existed = mem[key]
        if existed != nil {
            let keyTmp = existed?.key
            let valueTmp = existed?.value
            remove(key: key)
            add(value: valueTmp!, key: keyTmp!)
        }
        return nil
    }
    
    private func remove(key:KeyType) {
        let existedValue = mem[key]
        if existedValue != nil {
            if existedValue === first {
                let second = first?.next
                existedValue?.remove()
                mem[key] = nil
                currentSize -= 1
                first = second
            }
            else if existedValue === last {
                let prev = last?.prev
                existedValue?.remove()
                mem[key] = nil
                currentSize -= 1
                last = prev
            }
            else
            {
                existedValue?.remove()
                mem[key] = nil
                currentSize -= 1
            }
        }
    }
    
}


class ListNode<KeyType:Hashable,Element> {
    var prev:ListNode?
    var next:ListNode?
    var value:Element?
    var key:KeyType
    public init(key:KeyType,value:Element) {
        self.value = value
        self.key = key
    }
    
    public func remove() {
        self.prev?.next = self.next
        self.next?.prev = self.prev
    }
}

var cache = LRUCache<String,Int>()
cache.maxSize = 5
cache.set(value: 1, forKey: "1")
cache.set(value: 2, forKey: "2")
cache.set(value: 3, forKey: "3")
cache.set(value: 4, forKey: "4")
cache.set(value: 5, forKey: "5")
cache.set(value: 6, forKey: "6")
cache.get(key: "2")

