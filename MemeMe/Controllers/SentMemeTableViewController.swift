//
//  SentMemeTableTableController.swift
//  MemeMe
//
//  Created by Kappa on 2019/11/26.
//  Copyright © 2019 qi. All rights reserved.
//

import UIKit

class SentMemeTableViewController: UITableViewController {
  
  // MARK: Variables and Properties
  
  private let reuseIdentifier = "MemeTableViewCell"
  
  var memes: [Meme]! {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    return appDelegate.memes
  }
  
  // MARK: Life Cycle Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationController!.navigationBar.topItem?.title = Constants.title
    
    tableView.rowHeight = CGFloat(Constants.rowHeight)
    tableView.separatorStyle = .none
    
    NotificationCenter.default.addObserver(self, selector: #selector(onDidSaveMeme(_:)), name: .didSaveMeme, object: nil)
  }

  // MARK: - Table View Data Source
  
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
  
  // MARK: Table View Delegate
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let detailController = storyboard!.instantiateViewController(withIdentifier: Constants.StoryboardID.detailViewID) as! MemeDetailViewController
    let meme = memes[indexPath.row]
    detailController.meme = meme
    navigationController?.pushViewController(detailController, animated: true)
  }
  
  // MARK: Class Methods
  
  @objc func onDidSaveMeme(_ notification: Notification) {
    tableView.reloadData()
  }
  
  deinit {
    NotificationCenter.default.removeObserver(self, name: .didSaveMeme, object: nil)
  }
}
