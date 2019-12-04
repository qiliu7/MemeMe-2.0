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
  var memes: [Meme] {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    return appDelegate.memes
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let space: CGFloat = ITEM_SPACE
    let dimension = (self.view.frame.width - (2 * space)) / 3.0
    
    flowLayout.minimumInteritemSpacing = space
    flowLayout.minimumLineSpacing = space
    flowLayout.itemSize = CGSize(width: dimension, height: dimension)
    print(dimension)
    print(view.frame.width)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    collectionView.reloadData()
    print(memes.count)
  }
  
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using [segue destinationViewController].
   // Pass the selected object to the new view controller.
   }
   */
  
  
  
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
  
  // MARK: UICollectionViewDelegate
  
  /*
   // Uncomment this method to specify if the specified item should be highlighted during tracking
   override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
   return true
   }
   */
  
  /*
   // Uncomment this method to specify if the specified item should be selected
   override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
   return true
   }
   */
  
  /*
   // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
   override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
   return false
   }
   
   override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
   return false
   }
   
   override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
   
   }
   */
  
}
