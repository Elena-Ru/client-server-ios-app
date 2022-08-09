//
//  NewsViewController.swift
//  VKontakte
//
//  Created by Елена Русских on 02.07.2022.
//

import UIKit

class NewsViewController: UIViewController {


    @IBOutlet weak var newsTable: UITableView!
    
    var news = [
        News(photo: UIImage(named: "friend6.jpeg")!, text: "reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda." ),
        News(photo: UIImage(named: "friend4.jpeg")!, text: "VASYA")
    ]
    
 
     
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.newsTable.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsCell")
        self.newsTable.dataSource = self
        self.newsTable.delegate = self
        
    }
}

extension NewsViewController: UITableViewDelegate,
                              UITableViewDataSource,
                              UITextViewDelegate{
    
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return news.count
   }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsTableViewCell
        let newsItem  = news[indexPath.item]
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
            let newsItem = news[indexPath.item]
            destinationVC.title = "Запись"
            destinationVC.newsItem = newsItem
            newsTable.reloadData()
        }
    }
    
}



