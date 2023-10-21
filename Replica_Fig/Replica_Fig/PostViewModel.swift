//
//  PostViewModel.swift
//  Replica_Fig
//
//  Created by ATLAS Checkout Laptop on 10/20/23.
//

import Foundation

class PostViewModel: ObservableObject {
    @Published var likes: [Bool] {
        didSet {
            UserDefaults.standard.set(likes, forKey: "likes")
        }
    }
    
    init() {
        if let savedLikes = UserDefaults.standard.array(forKey: "likes") as? [Bool] {
            self.likes = savedLikes
        } else {
            self.likes = [false, false, false]
        }
    }
}

