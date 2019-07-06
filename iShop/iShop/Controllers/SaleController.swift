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
    @IBOutlet weak var addButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureInfoTextView()
        
        // Do any additional setup after loading the view.
        
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGR)
        
        
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
        
    }
    
    // MARK: - Navigation
    
    @IBAction func addProductButton(_ sender: Any) {
        
        if addProdInfoText.text.isEmpty || addProdPriceLabel.text!.isEmpty || addProdNameLabel.text!.isEmpty {
            
            print("NO! ❌❌‼️‼️ ")
        } else {
            DispatchQueue.global().async {
                sleep(5)
                
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
                    let name = self.addProdNameLabel.text!
                    let image = "img"
                    let info = self.addProdInfoText.text!
                    let textPrice = self.addProdPriceLabel.text!
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
                
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: .reload, object: nil)
                }
            }
            
        }
                
        
        

    }
    
    func configureInfoTextView() {
        let borderColor = UIColor.lightGray.cgColor.copy(alpha: 0.25)
        
        addProdInfoText.layer.borderWidth = 1
        addProdInfoText.layer.borderColor = borderColor
        addProdInfoText.layer.cornerRadius = 5
    }

}


