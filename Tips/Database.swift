//
//  Database.swift
//  Tips
//
//  Created by 小西壮 on 2019/06/09.
//  Copyright © 2019 小西壮. All rights reserved.
//

import Foundation
import RealmSwift

class TipsDatabase:Object{
    
    @objc dynamic var id = Int()
    @objc dynamic var playerName = String()
    @objc dynamic var betPrice = Int()
    @objc dynamic var date = String()
    
    var database = [NSDictionary]()
    
    //新規登録
    func create(playerName: String,betPrice: Int) {
        //データベース接続
        let realm = try! Realm()
        
        //データの書き込み
        try! realm.write{

            let tipsDatabase = TipsDatabase()

            let now = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy/MM/dd"
            
            tipsDatabase.id = (realm.objects(TipsDatabase.self).max(ofProperty: "id") as Int? ?? 0) + 1
            
            tipsDatabase.playerName = playerName
            tipsDatabase.betPrice = betPrice
            tipsDatabase.date = formatter.string(from: now as Date)
            
            realm.add(tipsDatabase)
            
        }
    }
    
    //取得
    func getAll() {
        let realm = try! Realm()

        //データベースから情報取得
        let database = realm.objects(TipsDatabase.self)

        //配列に入れる
        for value in database {
            let data = ["id": value.id, "playerName": value.playerName,"betPrice":value.betPrice, "date": value.date] as NSDictionary

            self.database.append(data)
        }
    }
    
    func deleteAll(){
        let realm = try! Realm()
        
        let database = realm.objects(TipsDatabase.self)
        
        try! realm.write{
            
            realm.delete(database)
            
        }
        
    }
//
//    //特定のデータのみ取得
//    //-> Todoみたいな戻り値がある時は受け取る側でletで定義してあげる
//    func getDate(id: Int) -> TipsDatabase {
//
//        //DB接続
//        let realm = try! Realm()
//
//        //データを取得
//        let todo = realm.objects(TipsDatabase.self).filter("id = \(id)").first
//
//        //取得したデータを返す
//        return todo!
//    }
//
    //更新
    func update(id: Int,betPrice: Int) {
        
        let realm = try! Realm()

        let database = realm.objects(TipsDatabase.self).filter("id = \(id)").first

        //更新する時
        try! realm.write {
            database!.betPrice = betPrice
        }

    }
//
//    //削除
//    func delete(id: Int) {
//        //DBに接続
//        let realm = try! Realm()
//
//        //削除するデータを取得
//        //.filter("id = 1").firstで条件を絞る.firstは１こ目を取ってくる、実際は無くていい
//        let todo = realm.objects(TipsDatabase.self).filter("id = \(id)").first
//
//        //取得したデータを削除する
//        try! realm.write {
//            realm.delete(todo!)
//        }
//    }
    
}
