//
//  SettingViewController.swift
//  Instagram
//
//  Created by 山中祐樹 on 2018/11/21.
//  Copyright © 2018 山中祐樹. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import SVProgressHUD
import ESTabBarController

class SettingViewController: UIViewController {
    
    @IBOutlet weak var displayNameTextField: UITextField!
    
    //表示名を変更するボタンの処理
    @IBAction func handleChangeButton(_ sender: Any) {
        if let displayName = displayNameTextField.text {
            
            //表示名を入力されていない時はHUDを表示しない
            if displayName.isEmpty {
                SVProgressHUD.showError(withStatus: "変更する表示名を入力して下さい")
                return
            }
            //表示名を設定する
            let user = Auth.auth().currentUser
            if let user = user {
                let changeRequest = user.createProfileChangeRequest()
                changeRequest.displayName = displayName
                changeRequest.commitChanges { error in
                    if let error = error {
                        SVProgressHUD.showError(withStatus: "表示名の変更に失敗しました")
                        print("DEBUG_PRINT: " + error.localizedDescription)
                        return
                    }
                    print("DEBUG_PRINT: [displayName = \(user.displayName!)]の設定に成功しました")
                    SVProgressHUD.showSuccess(withStatus: "表示名を変更しました")
                }
            }
        }
        
        //キーボードを閉じる
        self.view.endEditing(true)
    }
    
    //ログアウトするボタンの処理
    @IBAction func handleLogoutButton(_ sender: Any) {
        try! Auth.auth().signOut()
        
        //ログイン画面を表示する
        let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "Login")
        self.present(loginViewController!, animated: true, completion: nil)
        
        //ログイン画面から戻ってきた時のためにホーム画面（index = 0）を選択している状態にしておく
        let tabBarcontroller = parent as! ESTabBarController
        tabBarcontroller.setSelectedIndex(0, animated: false)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //表示名を取得してテキストフィールドに設定する
        let user = Auth.auth().currentUser
        if let user = user {
            displayNameTextField.text = user.displayName
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard(){
        //背景をタップするとキーボードを閉じる
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
