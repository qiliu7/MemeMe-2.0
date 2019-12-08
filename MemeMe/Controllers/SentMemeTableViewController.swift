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
  private let memeDetailControllerIdentifier = "MemeDetailViewController"
  let ROW_HEIGHT = 150.0
  
  var memes: [Meme]! {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    return appDelegate.memes
  }
  
  deinit {
    NotificationCenter.default.removeObserver(self, name: .didSaveMeme, object: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.rowHeight = CGFloat(ROW_HEIGHT)
    tableView.separatorStyle = .none
    
    NotificationCenter.default.addObserver(self, selector: #selector(onDidSaveMeme(_:)), name: .didSaveMeme, object: nil)
  }

  // MARK: - Table view data source
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let detailController = storyboard!.instantiateViewController(withIdentifier: memeDetailControllerIdentifier) as! MemeDetailViewController
    let meme = memes[indexPath.row]
    detailController.meme = meme
    navigationController?.pushViewController(detailController, animated: true)
  }
  
  @objc func onDidSaveMeme(_ notification: Notification) {
    tableView.reloadData()
  }
}
