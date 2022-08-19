//
//  NewsViewController.swift
//  VKontakte
//
//  Created by Елена Русских on 02.07.2022.
//

import UIKit

class NewsViewController: UIViewController {
    
    let session = Session.shared
    let apiManager = APIManager()

    var newsList = [NewsItem]() // для запроса групп

    @IBOutlet weak var newsTable: UITableView!
    
 
     
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.newsTable.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsCell")
        self.newsTable.dataSource = self
        self.newsTable.delegate = self
        
        apiManager.getNews(token: session.token, id: session.userID){ [weak self] items  in
            self?.newsList = items
            
            self?.newsTable.reloadData()
        }
    }
}

extension NewsViewController: UITableViewDelegate,
                              UITableViewDataSource,
                              UITextViewDelegate{
    
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return newsList.count
   }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsTableViewCell
        let newsItem  = newsList[indexPath.item]
        cell.newsPhoto.contentMode = .scaleAspectFill
        cell.prepareForReuse()
        cell.configure(newsItem: newsItem, cellIndex: indexPath.item)
     
        return cell
        
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "ShowNewsItem", sender: nil)
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowNewsItem",
           let destinationVC = segue.destination as? NewsItemViewController,
           let indexPath = newsTable.indexPathForSelectedRow {
            let newsItem = newsList[indexPath.item]
            destinationVC.title = "Запись"
            destinationVC.newsItem = newsItem
            newsTable.reloadData()
        }
    }
    
}



