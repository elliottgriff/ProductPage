//
//  ViewController.swift
//  ProductPage
//
//  Created by elliott on 4/12/22.
//

import UIKit
import Kingfisher

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ProductManagerDelegate {
    

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cart: UIButton!
    @IBOutlet weak var clearCart: UIButton!
    var badge = UILabel()
    
    var productManager = ProductManager()
    let cartViewController = CartViewController()
    
    var products: [String:Product]!
    var productKeys = [String]()
    var addedKeys = [String]()
    
    var cartCount = 0
    var rowCount: Int!
    
    var cartShowing = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        productManager.delegate = self
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        let nib = UINib(nibName: "ProductTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "ProductTableViewCell")
        productManager.fetchData()
        customizeCell()
        makeCartButton()
        makeClearButton()
        setBadge()
    }
    
    func makeCartButton() {
        cart.addTarget(self, action: #selector(cartPressed), for: .touchUpInside)
    }
    
    @objc func cartPressed() {
        print("cart pressed")
        if cartShowing {
            cartViewController.dismiss(animated: true)
            cartViewController.view.removeFromSuperview()
            cartShowing = false
            cart.layer.borderWidth = 0
            tableView.isUserInteractionEnabled = true
            cart.tintColor = .white
            print("cart true")
        } else {
            addCartVC()
            cart.tintColor = .red
            print("cart false")
        }
    }
    
    func addCartVC() {
        addChild(cartViewController)
        view.addSubview(cartViewController.view)
        cartViewController.didMove(toParent: self)
        cartShowing = true
        
        cartViewController.view.translatesAutoresizingMaskIntoConstraints = false
        cartViewController.view.topAnchor.constraint(equalTo: cart.bottomAnchor,
                                                        constant: 10).isActive = true
        cartViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                         constant: 20).isActive = true
        cartViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                          constant: -20).isActive = true
        cartViewController.view.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        let buttonPadding:CGFloat = 10
        var xOffset:CGFloat = 10
        
        for (index, element) in addedKeys.enumerated() {
            
            print(index, ":", element)
            
            let image = UIImageView()
            if let imageUrl = products[element]?.image_url {
                image.kf.setImage(with: imageUrl)
            }
            image.backgroundColor = .orange
            image.frame = CGRect(x: xOffset, y: CGFloat(buttonPadding), width: 150, height: (180))
            xOffset = xOffset + CGFloat(buttonPadding) + image.frame.size.width
            cartViewController.scrollView.addSubview(image)
        }
        cartViewController.scrollView.contentSize = CGSize(width: xOffset, height: cartViewController.scrollView.frame.height)
        tableView.isUserInteractionEnabled = false

    }
    
    func makeClearButton() {
        clearCart.addTarget(self, action: #selector(clearPressed), for: .touchUpInside)
    }
    
    @objc func clearPressed() {
        cart.isEnabled = false
        cartCount = 0
        badge.text = String(cartCount)
        addedKeys.removeAll()
        print(cartCount)
    }

    func didUpdateData(data: [String : Product]) {
        self.products = data
        for n in data {
            productKeys.append(n.key)
        }
        DispatchQueue.main.async {
            self.rowCount = self.productKeys.count
            self.tableView.reloadData()
        }
    }
    
    func customizeCell() {
        tableView.layer.cornerRadius = 5
        tableView.rowHeight = 200
    }
    
    func setBadge() {
        badge = UILabel(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        badge.translatesAutoresizingMaskIntoConstraints = false
        badge.layer.cornerRadius = badge.bounds.size.height / 2
        badge.textAlignment = .center
        badge.layer.masksToBounds = true
        badge.textColor = .white
        badge.font = badge.font.withSize(12)
        badge.backgroundColor = .red
        badge.text = String(0)
        cart.addSubview(badge)
        NSLayoutConstraint.activate([
            badge.leftAnchor.constraint(equalTo: cart.leftAnchor, constant: 0),
            badge.topAnchor.constraint(equalTo: cart.topAnchor, constant: 35),
            badge.widthAnchor.constraint(equalToConstant: 20),
            badge.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell", for: indexPath) as! ProductTableViewCell
        let nameRow = productKeys[indexPath.row]
        cell.name.text = products[nameRow]?.name
        if let imageUrl = products[nameRow]?.image_url {
            cell.productImage.kf.setImage(with: imageUrl)
        }
        if let price: Int = products[nameRow]?.retail_price {
            cell.price.text = "$\(String(price))"
        }
        cell.backgroundColor = .white
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let nameRow = self.productKeys[indexPath.row]
        
        let alert = UIAlertController(title: "Add to Cart?", message: products[nameRow]?.name, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            self.cart.isEnabled = true
            self.cartCount += 1
            self.badge.text = String(self.cartCount)
            self.addedKeys.append(self.products[nameRow]!.id)
            print("added keys \(self.addedKeys)")
            print(self.cartCount)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if rowCount != nil {
            return rowCount
        } else {
            return 0
        }
    }
    
}
