//
//  ViewController.swift
//  Tips
//
//  Created by 小西壮 on 2019/05/26.
//  Copyright © 2019 小西壮. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var numberOfTips = 0
    var totalPrice = 0
    
    // タッチしたビューの中心とタッチした場所の座標のズレを保持する変数
    var gapX:CGFloat = 0.0  // x座標
    var gapY:CGFloat = 0.0  // y座標

    @IBOutlet weak var priceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func Button25(_ sender: UIButton) {
    
        let tipsImage = UIImageView(image: UIImage(named: "Tips_$25"))
        // おじさんの初期位置を調整
        tipsImage.frame = CGRect(x: 150, y: 400 - 7*numberOfTips, width: 100, height: 100)
//        // ユーザーの操作を有効にする
        tipsImage.isUserInteractionEnabled = true
        // タッチしたものがおじさんかどうかを判別する用のタグ
        tipsImage.tag = 1
        // ビューに追加
        view.addSubview(tipsImage)
        
        numberOfTips += 1
        totalPrice += 25

        priceLabel.text = String(totalPrice)
        
    }
    
    @IBAction func Button50(_ sender: UIButton) {
        
        let tipsImage = UIImageView(image: UIImage(named: "Tips_$50.png"))
        // おじさんの初期位置を調整
        tipsImage.frame = CGRect(x: 150, y: 400 - 7*numberOfTips, width: 100, height: 100)
//        // ユーザーの操作を有効にする
        tipsImage.isUserInteractionEnabled = true
        // タッチしたものがおじさんかどうかを判別する用のタグ
        tipsImage.tag = 1
        // ビューに追加
        view.addSubview(tipsImage)
        
        numberOfTips += 1
        
        totalPrice += 50

        priceLabel.text = String(totalPrice)
        
    }
    
    @IBAction func Button100(_ sender: UIButton) {
        
        let tipsImage = UIImageView(image: UIImage(named: "Tips_$100.png"))
        // おじさんの初期位置を調整
        tipsImage.frame = CGRect(x: 150, y: 400 - 7*numberOfTips, width: 100, height: 100)
//        // ユーザーの操作を有効にする
        tipsImage.isUserInteractionEnabled = true
        // タッチしたものがおじさんかどうかを判別する用のタグ
        tipsImage.tag = 1
        // ビューに追加
        view.addSubview(tipsImage)
        
        numberOfTips += 1
        
        totalPrice +=  100

        priceLabel.text = String(totalPrice)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 最初にタッチした指のみ取得
        if let touch = touches.first {
            // タッチしたビューをviewプロパティで取得する
            if let touchedView = touch.view {
                // tagでおじさんかそうでないかを判断する
                if touchedView.tag == 1 {
                    // タッチした場所とタッチしたビューの中心座標がどうずれているか？
                    gapX = touch.location(in: view).x - touchedView.center.x
                    gapY = touch.location(in: view).y - touchedView.center.y
                    // 例えば、タッチしたビューの中心のxが50、タッチした場所のxが60→中心から10ずれ
                    // この場合、指を100に持って行ったらビューの中心は90にしたい
                    // ビューの中心90 = 持って行った場所100 - ずれ10
                    touchedView.center = CGPoint(x: touch.location(in: view).x - gapX, y: touch.location(in: view).y - gapY)
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        // touchesBeganと同じ処理だが、gapXとgapYはタッチ中で同じものを使い続ける
        // 最初にタッチした指のみ取得
        if let touch = touches.first {
            // タッチしたビューをviewプロパティで取得する
            if let touchedView = touch.view {
                // tagでおじさんかそうでないかを判断する
                if touchedView.tag == 1 {
                    // gapX,gapYの取得は行わない
                    touchedView.center = CGPoint(x: touch.location(in: view).x - gapX, y: touch.location(in: view).y - gapY)
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // gapXとgapYの初期化
        gapX = 0.0
        gapY = 0.0
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        // touchesEndedと同じ処理
        self.touchesEnded(touches, with: event)
    }
    
}

