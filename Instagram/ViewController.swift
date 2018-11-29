//
//  ViewController.swift
//  Instagram
//
//  Created by 山中祐樹 on 2018/11/21.
//  Copyright © 2018 山中祐樹. All rights reserved.
//
//先頭でFirebaseをimportしておく
import Firebase
import FirebaseAuth
import UIKit
//エラーが出る場合は一度ビルドする
import ESTabBarController

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //importしたESTabBarControllerをviewDidLoadで呼び出す為のメソッドちょい下に書いてある
        setupTab()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Firebaseを使う、ログインする準備
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //currentUserがnilならログインしていない
        if Auth.auth().currentUser == nil {
            //ログインしていない時の処理
            let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "Login")
            self.present(loginViewController!, animated: true, completion: nil)
        }
    }
    
    func setupTab() {
        //①画像のファイル名を指定してESTabBarControllerを作成する
        let tabBarController: ESTabBarController! = ESTabBarController(tabIconNames: ["home", "camera", "setting"])
        
        //②背景色、選択時の色を設定する
        tabBarController.selectedColor = UIColor(red: 1.0, green: 0.44, blue: 0.11, alpha: 1)
        tabBarController.buttonsBackgroundColor = UIColor(red: 0.96, green: 0.91, blue: 0.87, alpha: 1)
        //選択時に動くやつの高さ
        tabBarController.selectionIndicatorHeight = 3
        
        //③作成したESTabBarControllerを親のViewController(=self)に追加する
        //addChildViewController(_:)メソッドとdidMove(toParentViewController:)メソッドはセットで使う
        addChildViewController(tabBarController)
        //追加する時に行う処理をaddとdidMoveの間に書く
        let tabBarView = tabBarController.view!
        tabBarView.translatesAutoresizingMaskIntoConstraints = false
        //子のViewControllerを追加し、
        view.addSubview(tabBarView)
        //親のSafeArea全体に子のViewを表示するように制約を設定
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            tabBarView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            tabBarView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            tabBarView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            tabBarView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            ])
        tabBarController.didMove(toParentViewController: self)
        
        //④タブをタップした時に表示するViewControllerを設定する
        //最初に決めたストーリーボードIDを使用している
        let homeViewController = storyboard?.instantiateViewController(withIdentifier: "Home")
        let settingViewController = storyboard?.instantiateViewController(withIdentifier: "Setting")
        
        tabBarController.setView(homeViewController, at: 0)
        tabBarController.setView(settingViewController, at: 2)
        
        //真ん中のタブはボタンとして扱う
        tabBarController.highlightButton(at: 1)
        tabBarController.setAction({
            //ボタンが押されたらImageViewControllerをモーダルで表示する
            let imageViewController = self.storyboard?.instantiateViewController(withIdentifier: "ImageSelect")
            self.present(imageViewController!, animated: true, completion: nil)
            }, at: 1)
        
        
        
    }


}

