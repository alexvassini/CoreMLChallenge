// MARK: UIColor

import UIKit

extension UIColor {
  
  convenience init(hex: Int) {
    self.init(hex: hex, alpha: 1)
  }
  
  // Usage: UIColor(hex: 0xFC0ACE, alpha: 0.25)
  convenience init(hex: Int, alpha: Double) {
    self.init(
      red: CGFloat((hex >> 16) & 0xff) / 255,
      green: CGFloat((hex >> 8) & 0xff) / 255,
      blue: CGFloat(hex & 0xff) / 255,
      alpha: CGFloat(alpha))
  }
  
  convenience init(r: Float, g: Float, b: Float, a: Float) {
    //    self.init(colorLiteralRed: r/255, green: g/255, blue: b/255, alpha: a)
    self.init(red: CGFloat(r/255), green: CGFloat(g/255), blue: CGFloat(b/255), alpha: CGFloat(a))
  }
  
}
