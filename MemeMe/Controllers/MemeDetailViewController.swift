//
//  MemeDetailViewController.swift
//  MemeMe
//
//  Created by Kappa on 2019/12/7.
//  Copyright © 2019 qi. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {
  
  // MARK: Outlets
  
  @IBOutlet weak var memeImageView: UIImageView!
  
  // MARK: Variables and Properties
  
  var meme: Meme!

  // MARK: Life Cycle Methods
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    memeImageView.image = meme.memedImage
  }
}
