//
//  PostViewController.swift
//  Instagram
//
//  Created by 山中祐樹 on 2018/11/21.
//  Copyright © 2018 山中祐樹. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD
import FirebaseDatabase

class PostViewController: UIViewController {
    var image: UIImage!
    
    @IBOutlet weak var imageView: UIImageView!
    
    //キャプション
    @IBOutlet weak var textField: UITextField!
    
    //投稿ボタンのメソッド
    @IBAction func handlePostButton(_ sender: UIButton) {
        //ImageViewから画像を取得する
        let imageData = UIImageJPEGRepresentation(imageView.image!, 0.5)
        let imageString = imageData!.base64EncodedString(options: .lineLength64Characters)
        
        //postDataに必要な情報を取得しておく
        let time = Date.timeIntervalSinceReferenceDate
        let name = Auth.auth().currentUser?.displayName
        
        //辞書を作成してFirebaseに保存する
        let postRef = Database.database().reference().child(Const.PostPath)
        let postDic = ["caption": textField.text!,"image":imageString, "time": String(time),"name": name!]
        postRef.childByAutoId().setValue(postDic)
        
        //HUDで投稿完了を表示する
        SVProgressHUD.showSuccess(withStatus: "投稿しました")
        
        //全てのモーダルを閉じる
        UIApplication.shared.keyWindow?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    
    //キャンセルボタンのメソッド
    @IBAction func handleCancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //受け取った画像をImageViewに設定する
        imageView.image = image
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
