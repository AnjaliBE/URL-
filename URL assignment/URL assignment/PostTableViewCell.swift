import UIKit

class PostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var idLabel:UILabel!
    @IBOutlet weak var titleLabel:UILabel!
    @IBOutlet weak var bodyLabel:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
   }
    
}
