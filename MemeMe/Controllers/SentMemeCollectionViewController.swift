//
//  SentMemeCollectionViewController.swift
//  MemeMe
//
//  Created by Kappa on 2019/11/26.
//  Copyright © 2019 qi. All rights reserved.
//

import UIKit

class SentMemeCollectionViewController: UICollectionViewController {
  
  @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
  
  private let ITEM_SPACE: CGFloat = 3.0
  private let reuseIdentifier = "MemeCollectionViewCell"
  private let memeDetailControllerIdentifier = "MemeDetailViewController"
  var memes: [Meme] {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    return appDelegate.memes
  }
  
  deinit {
    NotificationCenter.default.removeObserver(self, name: .didSaveMeme, object: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationController!.navigationBar.topItem?.title = "Sent Memes"
    
    let space: CGFloat = ITEM_SPACE
    let dimension = (self.view.frame.width - (2 * space)) / 3.0
    
    flowLayout.minimumInteritemSpacing = space
    flowLayout.minimumLineSpacing = space
    flowLayout.itemSize = CGSize(width: dimension, height: dimension)
    
    NotificationCenter.default.addObserver(self, selector: #selector(onDidSaveMeme(_:)), name: .didSaveMeme, object: nil)
  }
  
  // MARK: UICollectionViewDataSource
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return memes.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MemeCollectionViewCell
    
    let meme = memes[indexPath.item]
    cell.memeImageView.image = meme.memedImage
    return cell
  }
  
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let detailController = storyboard!.instantiateViewController(withIdentifier: memeDetailControllerIdentifier) as! MemeDetailViewController
    let meme = memes[indexPath.item]
    detailController.meme = meme
    navigationController!.pushViewController(detailController, animated: true)
  }
  
 @objc func onDidSaveMeme(_ notification: Notification) {
   print("onDIdSaveMeme called")
  collectionView.reloadData()
 }
  
}
