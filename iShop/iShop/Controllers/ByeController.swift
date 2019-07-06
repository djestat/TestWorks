//
//  ByeController.swift
//  iShop
//
//  Created by Igor on 04/07/2019.
//  Copyright © 2019 Igorlab. All rights reserved.
//

import UIKit

class ByeController: UITableViewController {
    
    var productList2 = [Product]()
    
    public var productList = [
        Product(id: 1, name: "Prod 1", image: "img", info: "Product is good", price: 123),
        Product(id: 2, name: "Prod 2", image: "img", info: "Product is good", price: 23),
        Product(id: 3, name: "Prod 3", image: "img", info: "Product is good", price: 45),
        Product(id: 4, name: "Prod 4", image: "img", info: "Product is good", price: 44),
        Product(id: 5, name: "Prod 5", image: "img", info: "Product is good", price: 456),
        Product(id: 6, name: "Prod 6", image: "img", info: "Product is good", price: 5657),
        Product(id: 7, name: "Prod 7", image: "img", info: "Product is good", price: 4535),
        Product(id: 8, name: "Prod 8", image: "img", info: "Product is good", price: 124677)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        readFromJSON()
        
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
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
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
    /*
    func updater() {
        let timer = Timer.init(timeInterval: 5, repeats: true) { timer in
//            timer.invalidate()
            print("Autoupdate!")
        }
        DispatchQueue.global().async {
            Timer.init(timeInterval: 1, repeats: true, block: { timer in
                print(timer.fireDate)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            })
        }
    }*/
}
