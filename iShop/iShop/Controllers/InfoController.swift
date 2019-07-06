//
//  InfoController.swift
//  iShop
//
//  Created by Igor on 06/07/2019.
//  Copyright © 2019 Igorlab. All rights reserved.
//

import UIKit

class InfoController: UIViewController {

    public var infoProduct: Product?
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var infoLabel: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureView()
    }
    

    func configureView() {
        
        idLabel.text = String(infoProduct!.id)
        imageView.image = UIImage(named: infoProduct!.image)
        nameLabel.text = infoProduct!.name
        infoLabel.text = infoProduct!.info
        priceLabel.text = String(infoProduct!.price)
        
    }
    
    // MARK: - Navigation

    @IBAction func bueButton(_ sender: Any) {
        
        DispatchQueue.global().async {
            sleep(3)
            print("\(self.infoProduct!.name) приобретен!")
        
            DispatchQueue.main.async {
                let image = self.makeImageView()
                self.view.addSubview(image)
                
                let conX = image.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
                let conButtom = image.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: image.frame.height * 2)
                let conWidth = image.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.6, constant: -50.0)
                let conHeight = image.heightAnchor.constraint(equalTo: image.widthAnchor)
                
                NSLayoutConstraint.activate([conX, conButtom, conWidth, conHeight])
                
                self.view.layoutIfNeeded()
                
                UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 10.0, animations: {
                    conButtom.constant = -image.frame.height / 2
                    conWidth.constant = 0.0
                    self.view.layoutIfNeeded()
                })
                
                UIView.transition(with: image, duration: 2, options: [.curveEaseIn, .transitionCrossDissolve], animations: { image.isHidden = false }, completion: { (_) in
                    image.removeFromSuperview()
                })
            }
            
        }
        
        
    }
    
    func makeImageView() -> UIImageView {
        let image = UIImageView(image: UIImage(named: "img"))
        image.backgroundColor = UIColor(white: 0, alpha: 0.5)
        image.layer.cornerRadius = 5
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }
    
    //MARK: - Save to PDF
    
    func doPDF(from view: UIView) {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let file = path.appendingPathComponent("file.pdf")
        print("Path to file: \(file)")
        
        let pdfRenderer = UIGraphicsPDFRenderer(bounds: view.bounds)
        
        do {
            try pdfRenderer.writePDF(to: file, withActions: { context in
                context.beginPage()
                view.layer.render(in: context.cgContext)
                sharePDF()
            })
        } catch {
            print("Error: \(error.localizedDescription)")
        }
        
    }
    
    func sharePDF() {
        
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let file = path.appendingPathComponent("file.pdf")
       
        print(file)
        
        let activityViewConroller = UIActivityViewController(activityItems: [file], applicationActivities: nil)
        present(activityViewConroller, animated: true, completion: nil)
        
    }
    
    @IBAction func saveData(_ sender: Any) {
        doPDF(from: view)
    }
    
}
