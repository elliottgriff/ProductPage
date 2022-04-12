//
//  CartViewController.swift
//  ProductPage
//
//  Created by elliott on 4/12/22.
//

import UIKit

class CartViewController: UIViewController {
    
    var scrollView = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 2
        view.layer.borderColor = CGColor(red: 255, green: 255, blue: 255, alpha: 1)
        createScrollView()
    }
    
    func createScrollView() {
        
        scrollView = UIScrollView()
        view.addSubview(scrollView)
        scrollView.layer.cornerRadius = 10
        scrollView.layer.borderWidth = 2
        scrollView.layer.borderColor = CGColor(red: 255, green: 255, blue: 255, alpha: 1)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        scrollView.backgroundColor = .lightGray
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
}
