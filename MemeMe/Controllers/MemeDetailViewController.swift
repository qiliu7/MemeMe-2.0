//
//  MemeDetailViewController.swift
//  MemeMe
//
//  Created by Kappa on 2019/12/7.
//  Copyright © 2019 qi. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {

  var meme: Meme!
  
  @IBOutlet weak var memeImageView: UIImageView!
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    memeImageView.image = meme.memedImage
  }
}
