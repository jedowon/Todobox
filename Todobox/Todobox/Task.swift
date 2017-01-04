//
//  Task.swift
//  Todobox
//
//  Created by sunrin software10 on 2016. 12. 19..
//  Copyright © 2016년 sunrin software10. All rights reserved.
//

struct Task{
    var title: String
    var memo: String?
    var done: Bool
    
    init(title: String, memo: String? = nil, done: Bool = false) {
        self.title = title
        self.memo = memo
        self.done = false
    }
    
    //?를 붙여서 실패할 수 있는(nil을 반환할수 있는) 생성자
    init?(dictionary: [String: Any]) {
        if let title = dictionary["title"] as? String,
            let done = dictionary["done"] as? Bool {
            self.init(
                title: title,
                memo: dictionary["memo"] as? String,
                done: done
            )
        } else {
          return nil
        }
    }
}
