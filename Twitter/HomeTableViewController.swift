//
//  HomeTableViewController.swift
//  Twitter
//
//  Created by Sophia Lui on 4/27/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {

    // local container: array of dictionary
    var tweetArray = [NSDictionary]()
    var numOfTweets: Int!
    
    let myRefreshControl = UIRefreshControl()
    
    @IBAction func onLogout(_ sender: Any) {
        // API Folder >> Call twitter api to logout
        TwitterAPICaller.client?.logout()
        
        // Transition back to login screen
        self.dismiss(animated: true, completion:nil)
        
        UserDefaults.standard.set(false, forKey: "userLoggedIn")
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier:"tweetCell", for: indexPath) as! TweetCellTableViewCell
        
        let user = tweetArray[indexPath.row]["user"] as! NSDictionary
        let withAt = "@"+(user["screen_name"] as? String)!
        cell.userScreenNameLabel.text = withAt
        cell.userNameLabel.text = user["name"] as? String
        cell.tweetContent.text = tweetArray[indexPath.row]["text"] as? String
        
        let imageURL = URL(string: (user["profile_image_url_https"]) as! String)
        let data = try? Data(contentsOf: imageURL!)
        if let imageData = data {
            cell.profileimageView.image = UIImage(data:imageData)
        }
        
        return cell
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // action for logout button, click on it and maintains the action <logged out>
        // done loading, call loadTweet
        loadTweets()
        myRefreshControl.addTarget(self, action: #selector(loadTweets), for: .valueChanged)
        tableView.refreshControl = myRefreshControl

    }
    
    @objc func loadTweets(){
        
        numOfTweets = 20
        
        let homeURL = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        let myParams = ["count":numOfTweets]
        
        // call API
        TwitterAPICaller.client?.getDictionariesRequest(url: homeURL, parameters: myParams as [String : Any], success: { (tweets:[NSDictionary]) in             self.tweetArray.removeAll()

            // store tweets in tweetArray
            
            for tweet in tweets {
                self.tweetArray.append(tweet)
            }
            
            self.tableView.reloadData()
            self.myRefreshControl.endRefreshing()
            
        }, failure: { (Error) in
            print("could not retreive tweetssss")
            print(Error.localizedDescription)
        })
        
    }
    
    func loadMoreTweets(){
        let homeURL = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        numOfTweets = numOfTweets + 20
        let myParams = ["counts": numOfTweets]
        
        TwitterAPICaller.client?.getDictionariesRequest(url: homeURL, parameters: myParams as [String : Any], success: { (tweets:[NSDictionary]) in
            // store tweets in tweetArray
            self.tweetArray.removeAll()
            
            for tweet in tweets {
                self.tweetArray.append(tweet)
            }
            
            self.tableView.reloadData()
            
        }, failure: { (Error) in
            print("could not retreive tweets")
        })
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath){
        
        if indexPath.row + 1 == tweetArray.count{
            loadMoreTweets()
        }
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tweetArray.count
    }

}
