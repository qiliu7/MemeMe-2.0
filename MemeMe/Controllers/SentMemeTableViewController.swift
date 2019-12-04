//
//  SentMemeTableTableController.swift
//  MemeMe
//
//  Created by Kappa on 2019/11/26.
//  Copyright © 2019 qi. All rights reserved.
//

import UIKit

class SentMemeTableViewController: UITableViewController {
  
  private let reuseIdentifier = "MemeTableViewCell"
  let ROW_HEIGHT = 150.0
  
  var memes: [Meme]! {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    return appDelegate.memes
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.rowHeight = CGFloat(ROW_HEIGHT)
    tableView.separatorStyle = .none
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    // TODO: - has to be reloaded when share is done in the editor view.
    tableView.reloadData()
  }
  // MARK: - Table view data source
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    print("num called")
    return memes.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    print("cellForRow called")
    let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! MemeTableViewCell
    let meme = memes[indexPath.row]
    cell.memeImageView.image = meme.memedImage
    cell.memeCaption.text = meme.topText + " " + meme.bottomText
    
    return cell
  }
}
