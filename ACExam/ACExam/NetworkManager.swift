//
//  NetworkManager.swift
//  ACExam
//
//  Created by martin on 2016/4/29.
//  Copyright © 2016年 Frainbow. All rights reserved.
//

import Foundation
import Firebase
import PKHUD

struct Book {
    var name: String
    var picture: UIImage
    var address: String
    var tel: String
    var website: NSURL
    var description: String
}

class NetworkManager {
    static let sharedInstance = NetworkManager()

    var rootRef: Firebase
    var books = [Book]()

    init() {
        rootRef = Firebase(url:"https://acexam.firebaseio.com/")
    }

    func resetData() {
        books.removeAll()

        books.append(Book(
            name: "蜘蛛網中的女孩",
            picture: UIImage(named: "蜘蛛網中的女孩")!,
            address: "台北市南京東路4段50號6樓之1",
            tel: "+886111111111",
            website: NSURL(string: "http://www.books.com.tw/products/0010709496?loc=P_013_0_101")!,
            description: "讓人上癮的完美小說，全球超過8000萬人追逐。《龍紋身的女孩》最新續集，全美首刷50萬本，上市3個月狂賣350萬本"
        ))

        books.append(Book(
            name: "解憂雜貨店",
            picture: UIImage(named: "解憂雜貨店")!,
            address: "敦化北路120巷50號",
            tel: "+886222222222",
            website: NSURL(string: "http://www.books.com.tw/products/0010594847?loc=P_013_002")!,
            description: "如果有一個地方，可以解決我們所有的煩惱……"
        ))

        books.append(Book(
            name: "文章自在",
            picture: UIImage(named: "文章自在")!,
            address: "台北市重慶南路一段57號11樓之4",
            tel: "+886333333333",
            website: NSURL(string: "http://www.books.com.tw/products/0010710550?loc=P_013_003")!,
            description: "本來文章有法，可是真正讓文章有妙趣、有神采、有特色、有風格的法，非但不能經由考試鑒別；也不能經由應付考試的練習而培養。要以寫文章的抱負和期許來鍛鍊作文"
        ))

        books.append(Book(
            name: "都市傳說10：消失的房間（都市傳說鑰匙圈版）",
            picture: UIImage(named: "消失的房間")!,
            address: "台北市民生東路2段141號8樓",
            tel: "+886444444444",
            website: NSURL(string: "http://www.books.com.tw/products/0010713212?loc=P_013_004")!,
            description: "當門關上，身處的空間頓時與世隔絕，無聲、無息，世界從此不見，只剩四面水泥牆，你已經在消失的房間..."
        ))

        books.append(Book(
            name: "今天：366天，每天打開一道門",
            picture: UIImage(named: "今天")!,
            address: "台北市大安區新生南路二段2號3樓",
            tel: "+886555555555",
            website: NSURL(string: "http://www.books.com.tw/products/0010650343?loc=P_013_005")!,
            description: "不朽的藝術和文學傑作是如何孕育出來的？生活中不可或缺的發明，又是如何誕生？為了爭取民主和自由，前人因而付出多少代價？小人物的善良和勇氣，如何把愛散佈到世界每個角落？小小年紀志氣高，孩子如何親手創造更美好的未來？"
        ))

        saveData()
    }

    func saveData() {
        let booksRef = rootRef.childByAppendingPath("books")
        var books = [[String: String]]()
        
        HUD.show(.Progress)

        for book in self.books {
            let imageData = UIImageJPEGRepresentation(book.picture, 1.0)
            
            books.append([
                "name": book.name,
                "picture": imageData?.base64EncodedStringWithOptions(NSDataBase64EncodingOptions()) ?? "",
                "address": book.address,
                "tel": book.tel,
                "website": book.website.absoluteString,
                "description": book.description
            ])
        }

        booksRef.setValue(books)
        
        HUD.hide()
    }

    func getData(callback: ([Book]) -> Void) {

        let booksRef = rootRef.childByAppendingPath("books")
        
        HUD.show(.Progress)
        
        booksRef.observeSingleEventOfType(.Value, withBlock: { snapshot in

            self.books.removeAll()
            
            if let books = snapshot.value as? NSArray {
                
                for book in books {
                    let imageData = NSData(base64EncodedString: book.objectForKey("picture") as! String, options: NSDataBase64DecodingOptions())
                    
                    self.books.append(Book(
                        name: book.objectForKey("name") as! String,
                        picture: UIImage(data: imageData!)!,
                        address: book.objectForKey("address") as! String,
                        tel: book.objectForKey("tel") as! String,
                        website: NSURL(string: book.objectForKey("website") as! String)!,
                        description: book.objectForKey("description") as! String
                    ))
                }
            }

            HUD.hide()

            callback(self.books)
        })
    }
}
