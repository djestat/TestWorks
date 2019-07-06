//
//  SaleController.swift
//  iShop
//
//  Created by Igor on 04/07/2019.
//  Copyright © 2019 Igorlab. All rights reserved.
//

import UIKit

class SaleController: UIViewController {
    
    @IBOutlet weak var addProdNameLabel: UITextField!
    @IBOutlet weak var addProdInfoText: UITextView!
    @IBOutlet weak var addProdPriceLabel: UITextField!
    
    var backgroundColor = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        addProdInfoText.bounces = true
        
        
        // Do any additional setup after loading the view.
        
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGR)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func addProductButton(_ sender: Any) {
        
        if addProdInfoText.text.isEmpty || addProdPriceLabel.text!.isEmpty || addProdNameLabel.text!.isEmpty {
            print("NO! ❌❌‼️‼️ ")
        }
                
        DispatchQueue.global().async {
            sleep(5)
            
            if self.backgroundColor == 0 {
                DispatchQueue.main.async {
                    self.view.backgroundColor = .green
                }
                
                self.backgroundColor = 1
            } else {
                DispatchQueue.main.async {
                    self.view.backgroundColor = .white
                }
                self.backgroundColor = 0
            }
        }
        
        var lastID = 0
        var newJSONDB: JSONDB
        
        let jsonPath = Bundle.main.path(forResource: "ProductDB2", ofType: "json")
        let url = URL(fileURLWithPath: jsonPath!)
        let data = try! Data(contentsOf: url)
        
        do {
            let db = try JSONDecoder().decode(JSONDB.self, from: data)
            let count = db.products.count
            lastID = db.products[count - 1].id
            newJSONDB = db
            print("\(db)  🎈")
            
            let id = lastID + 1
            let name = addProdNameLabel.text!
            let image = "img"
            let info = addProdInfoText.text!
            let textPrice = addProdPriceLabel.text!
            let price = Int(textPrice) ?? 0
            
            let newProduct = Product(id: id, name: name, image: image, info: info, price: price)
            print(newProduct)
            newJSONDB.products.append(newProduct)
            print(newJSONDB.products)
            
            let encoder = JSONEncoder()
            do {
                let jsonData = try! encoder.encode(newJSONDB)
                let jsonString = String(data: jsonData, encoding: .utf8)
                print("\(jsonData) : \(String(describing: jsonString))")
                try jsonData.write(to: url)
            } catch {
                print("Failed to write JSON data: \(error.localizedDescription)")
            }
            
        } catch {
            print("error 🎈")
        }
        
    }
    

}
