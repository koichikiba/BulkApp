import UIKit

class ArticleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var createdAtLabel: UILabel! //③
    @IBOutlet weak var categoryLabel: UILabel! //①
    @IBOutlet weak var eventLabel: UILabel! //②
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
