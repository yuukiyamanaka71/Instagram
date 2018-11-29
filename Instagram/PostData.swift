//
//  PostData.swift
//  Instagram
//
//  Created by 山中祐樹 on 2018/11/26.
//  Copyright © 2018 山中祐樹. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class PostData: NSObject {
    //投稿のID（保存する際に作られたユニークなID）
    var id: String?
    //画像(UIImageに変換済み)
    var image: UIImage?
    //画像(Base64のまま)
    var imageString: String?
    //投稿者名
    var name: String?
    //キャプション
    var caption: String?
    //日付
    var date: Date?
    //いいねをした人のIDの配列
    var likes: [String] = []
    //自分がいいねしたかどうかのフラグ
    var isLiked: Bool = false
    //コメント用の配列
    var comments: [String] = []
    
    init(snapshot: DataSnapshot, myId: String) {
        self.id = snapshot.key
        
        let valueDictionary = snapshot.value as! [String: Any]
        
        imageString = valueDictionary["image"] as? String
        image = UIImage(data: Data(base64Encoded: imageString!, options: .ignoreUnknownCharacters)!)
        
        self.name = valueDictionary["name"] as? String
        self.caption = valueDictionary["caption"] as? String
        let time = valueDictionary["time"] as? String
        self.date = Date(timeIntervalSinceReferenceDate: TimeInterval(time!)!)
        if let likes = valueDictionary["likes"] as? [String] {
            self.likes = likes
        }
        
        for likeId in self.likes {
            if likeId == myId {
                self.isLiked = true
                break
            }
        }
        
        if let comments = valueDictionary["comments"] as? [String] {
            self.comments = comments
        }
        
    }
}
