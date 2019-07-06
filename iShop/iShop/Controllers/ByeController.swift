//
//  ByeController.swift
//  iShop
//
//  Created by Igor on 04/07/2019.
//  Copyright © 2019 Igorlab. All rights reserved.
//

import UIKit

extension Notification.Name {
    static let reload = Notification.Name("reload")
}

class ByeController: UITableViewController {
    
    var productList2 = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        readFromJSON()
//        updater()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData), name: .reload, object: nil)

    }
    
    @objc func reloadData(_ notification : Notification) {
        readFromJSON()
        tableView.reloadData()
    }
    
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return productList2.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductByeCell.reuseID, for: indexPath) as? ProductByeCell else { fatalError("Cell cannot be dequeued") }

        // Configure the cell...
        
        cell.productImageView.image = UIImage(named: productList2[indexPath.row].image)
        cell.nameProductLabel.text = String(productList2[indexPath.row].name)
        cell.priceLabel.text = String(productList2[indexPath.row].price)

        return cell
    }
    

    func readFromJSON() {
        let jsonPath = Bundle.main.path(forResource: "ProductDB2", ofType: "json")
        print(jsonPath!)
        let url = URL(fileURLWithPath: jsonPath!)
        print("\(url)  🔗")
        let data = try! Data(contentsOf: url)
        print("\(data)  📊")
        let obj = try! JSONSerialization.jsonObject(with: data, options: .mutableContainers)
        print("\(obj)  📦")
        
        if let products = (obj as! NSObject).value(forKey: "products") {
            print(products)
        }
        
        do {
            let db = try JSONDecoder().decode(JSONDB.self, from: data)
            productList2 = db.products
            print("\(db)  🎈")
        } catch {
            print("error 🎈")
        }
        
        print(productList2)
    }
    
    func updater() {
//        let timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { timer in
//            self.readFromJSON()
//            self.tableView.reloadData()
//            print("Timer: \(timer) - fired! \(Date.self))")
//        }

        let timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { timer in
            self.readFromJSON()
            self.tableView.reloadData()
            print("Timer: \(timer) - working! \(Date().description))")
        }

    }
    
}


