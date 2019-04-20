//
//  CollectionViewController.swift
//  FinChat
//
//  Created by Roman Nordshtrem on 15/04/2019.
//  Copyright © 2019 Роман Нордштрем. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet var collectionView: UICollectionView!
    
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    private var paths = [String]()
    private var images = [UIImage?]()
//    var networkManager: NetworkManagerProtocol
//    var parser: ParserManagerProtocol
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        
//        networkManager = NetworkManager()
//        parser = ParserManager()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 24
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as? CollectionViewCell
        cell?.backgroundColor = UIColor.green
        return cell!
    }
    
}
