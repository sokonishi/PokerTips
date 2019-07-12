//
//  EntranceViewController.swift
//  Tips
//
//  Created by 小西壮 on 2019/06/09.
//  Copyright © 2019 小西壮. All rights reserved.
//

import UIKit
import RealmSwift

class EntranceViewController: UIViewController{

    let tipsDatabase = TipsDatabase()
    
    @IBOutlet var playerView: UIView!
    @IBOutlet weak var playerNameTextField: UITextField!
    @IBOutlet weak var betPriceTextField: UITextField!
    
    var playerBox:[String] = []
    var playerBetBox:[Int] = []
    
    var refreshControl = UIRefreshControl()
    @IBOutlet weak var playerTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        playerTableView.delegate = self
        playerTableView.dataSource = self
        playerTableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(EntranceViewController.refresh(sender:)), for: .valueChanged)
        
        tipsDatabase.getAll()
        print(tipsDatabase.database)
//        print(tipsDatabase.database[1]["date"]!)
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func playerPopUpBtn(_ sender: UIButton) {
        
        self.view.addSubview(playerView)
        playerView.center = self.view.center
        playerView.layer.cornerRadius = 5
        playerView.layer.masksToBounds = true
        
    }

    @IBAction func addPlayerBtn(_ sender: UIButton) {
//
//        if playerNameTextField.text == "" {
//            playerBox.append("player\(playerBox.count)")
//        } else {
//            playerBox.append(playerNameTextField.text!)
//        }
//        print(playerBox)
//
//        if betPriceTextField.text == "" {
//            playerBetBox.append(0)
//        } else {
//            playerBetBox.append(Int(betPriceTextField.text!)!)
//        }
//        print(playerBetBox)
        
        if (playerNameTextField.text != "" && betPriceTextField.text != ""){
            tipsDatabase.create(playerName: playerNameTextField.text!, betPrice: Int(betPriceTextField.text!)!)
            
            tipsDatabase.database.removeAll()
            tipsDatabase.getAll()
            
            playerTableView.reloadData()
            
            playerNameTextField.text = ""
            betPriceTextField.text = ""
        }
        
    }
    
    
    @IBAction func resetBtn(_ sender: UIButton) {
        
        tipsDatabase.deleteAll()
        playerTableView.reloadData()
        
    }
    
    @objc func refresh(sender: UIRefreshControl) {
        // ここが引っ張られるたびに呼び出される
        playerTableView.reloadData()
        // 通信終了後、endRefreshingを実行することでロードインジケーター（くるくる）が終了()
        refreshControl.endRefreshing()
    }
    
    @IBAction func season4Btn(_ sender: UIButton) {
    }
    
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        // touchesEndedと同じ処理
        self.touchesEnded(touches, with: event)
    }
}

extension EntranceViewController: UITableViewDelegate,UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return playerBox.count
        return tipsDatabase.database.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerCell", for: indexPath) as? PlayerTableViewCell
        print(tipsDatabase.database[indexPath.row]["betPrice"]!)
        cell?.playerNameLabel!.text = tipsDatabase.database[indexPath.row]["playerName"] as? String
        cell?.betPriceLabel!.text = String(tipsDatabase.database[indexPath.row]["betPrice"]! as! Int)
//        cell?.playerNameLabel?.text = playerBox[indexPath.row]
//        cell?.betPriceLabel!.text = "10000"
        cell?.layoutIfNeeded()
        
        return cell!
    }

}
