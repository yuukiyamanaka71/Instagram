//
//  PostTableViewCell.swift
//  Instagram
//
//  Created by 山中祐樹 on 2018/11/26.
//  Copyright © 2018 山中祐樹. All rights reserved.
//

import UIKit
import SVProgressHUD
import Firebase
import FirebaseAuth
import FirebaseDatabase

class PostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var commentField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setPostData(_ postData: PostData) {
        self.postImageView.image = postData.image
        
        //キャプション内容の表示
        self.captionLabel.text = "\(postData.name!) : \(postData.caption!)"
        captionLabel.sizeToFit()
        
        //コメント内容の表示
        var text = ""
        for comment in postData.comments  {
            text += comment
        }
        self.commentLabel.text = text
        commentLabel.sizeToFit()
        
        
        //いいね数の表示
        let likeNumber = postData.likes.count
        likeLabel.text = "\(likeNumber)"
        
        //日付表示
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        let dateString = formatter.string(from: postData.date!)
        self.dateLabel.text = dateString
        
        //いいね画像の画像表紙切り替え（exist⇄none）
        if postData.isLiked {
            let buttonImage = UIImage(named: "like_exist")
            self.likeButton.setImage(buttonImage, for: .normal)
        }else{
            let buttonImage = UIImage(named: "like_none")
            self.likeButton.setImage(buttonImage, for: .normal)
        }
        
        //コメントボタンがタップされたら入力したコメント内容を消す
        commentField.text = nil
        
    }
    
}
