import UIKit

class ViewController: UIViewController  {
    
    var demoArray:[PostModel] = []

    @IBOutlet weak var tableView:UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibFile = UINib(nibName:"PostTableViewCell", bundle: nil)
        self.tableView.register(nibFile,forCellReuseIdentifier:"PostTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
        }

    override func viewWillAppear(_ animated: Bool) {
        let urlString = "https://jsonplaceholder.typicode.com/posts"
        
        guard let url = URL(string:urlString) else{
            print("URL is Invalid")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let session = URLSession(configuration: .default)
        
        let dataTask = session.dataTask(with: request){ data,response,error in
            print("Error Received from URL is:\(error)")
            print("Data Received from URL is:\(data)")
            guard let data = data else{
            return
    }
            guard let jsonObject = try? JSONSerialization.jsonObject(with: data) as?[[String:Any]] else{
                     return
            }
            for dictionary in jsonObject{
                let postId = dictionary["id"]as!Int
                let postTitle = dictionary["title"]as!String
                let postBody = dictionary["body"]as!String
    
          let demo = PostModel(id: postId,title:postTitle,body:postBody )
                self.demoArray.append(demo)
    
                DispatchQueue.main.sync {
                    self.tableView.reloadData()
                }
          print("ID is:\(postId) \nTitle is:\(postTitle) \nBody:\(postBody)\n\n\n")
    
            }
        }
        dataTask.resume()
    }
}
    extension ViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        demoArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as? PostTableViewCell else{
            return UITableViewCell()
    }
        cell.idLabel.text = String(demoArray[indexPath.row].id)
        cell.titleLabel.numberOfLines = 0
        
        cell.titleLabel.preferredMaxLayoutWidth = 700
        
        cell.titleLabel.lineBreakMode = .byWordWrapping
        
        cell.titleLabel.sizeToFit()
        cell.titleLabel.text = demoArray[indexPath.row].title
        
        cell.bodyLabel.numberOfLines = 0
        
        cell.bodyLabel.preferredMaxLayoutWidth = 700
        
        cell.bodyLabel.lineBreakMode = .byWordWrapping
        
        cell.bodyLabel.sizeToFit()
        cell.bodyLabel.text = demoArray[indexPath.row].body
        
        return cell
    }
}
extension ViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        130
    }
}

