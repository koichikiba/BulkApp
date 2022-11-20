
import UIKit

struct ViewCustomize {
    func addBoundsTextView(textView: UITextView) -> UITextView {
        textView.layer.borderColor =  UIColor.placeholderText.cgColor
        textView.layer.borderWidth = 0.5
        textView.layer.cornerRadius = 5.0
        textView.layer.masksToBounds = true
        return textView
    }
}
