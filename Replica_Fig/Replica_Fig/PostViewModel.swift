//
//  PostViewModel.swift
//  Replica_Fig
//
//  Created by ATLAS Checkout Laptop on 10/20/23.
//

import Foundation
import Combine

class PostViewModel: ObservableObject {
    @Published var likes: [Bool]
    
    init() {
        // Assuming the number of posts is 3 (based on your example).
        // You might want to make this dynamic based on the actual post count.
        self.likes = Array(repeating: false, count: 3)
        
        // Load initial likes state from UserDefaults
        for i in 0..<likes.count {
            let key = "post_\(i)_isLiked"
            if let isLiked = UserDefaults.standard.value(forKey: key) as? Bool {
                likes[i] = isLiked
            }
        }
    }
    
    func toggleLike(at index: Int) {
        likes[index].toggle()
        
        // Store the new state in UserDefaults
        let key = "post_\(index)_isLiked"
        UserDefaults.standard.set(likes[index], forKey: key)
    }
}




