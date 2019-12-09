//
//  SentMemeCollectionViewController.swift
//  MemeMe
//
//  Created by Kappa on 2019/11/26.
//  Copyright © 2019 qi. All rights reserved.
//

import UIKit

class SentMemeCollectionViewController: UICollectionViewController {
  
  // MARK: Outlets
  @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
  
  // MARK: Variables and Properties
  
  private let reuseIdentifier = "MemeCollectionViewCell"
  private var memes: [Meme] {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    return appDelegate.memes
  }
  
  // MARK: Life Cycle Methods
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationController!.navigationBar.topItem?.title = "Sent Memes"
    
    let space: CGFloat = CGFloat(Constants.itemSpace)
    let dimension = (self.view.frame.width - (2 * space)) / 3.0
    
    flowLayout.minimumInteritemSpacing = space
    flowLayout.minimumLineSpacing = space
    flowLayout.itemSize = CGSize(width: dimension, height: dimension)
    
    NotificationCenter.default.addObserver(self, selector: #selector(onDidSaveMeme(_:)), name: .didSaveMeme, object: nil)
  }
  
  // MARK:  Collection View Data Source
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return memes.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MemeCollectionViewCell
    
    let meme = memes[indexPath.item]
    cell.memeImageView.image = meme.memedImage
    return cell
  }
  
  // MARK: Collection View Delegate
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let detailController = storyboard!.instantiateViewController(withIdentifier: Constants.StoryboardID.detailViewID) as! MemeDetailViewController
    let meme = memes[indexPath.item]
    detailController.meme = meme
    navigationController!.pushViewController(detailController, animated: true)
  }
  
  // MARK: Class Methods
  
  @objc func onDidSaveMeme(_ notification: Notification) {
    print("onDIdSaveMeme called")
    collectionView.reloadData()
  }
  
  deinit {
    NotificationCenter.default.removeObserver(self, name: .didSaveMeme, object: nil)
  }
}
