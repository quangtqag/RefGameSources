/**
 * Copyright (c) 2017 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import UIKit
import NotificationCenter
import CryptoCurrencyKit

class TodayViewController: CurrencyDataViewController, NCWidgetProviding {
  
  @IBOutlet weak var vibrancyView: UIVisualEffectView!
  var lineWidth: CGFloat = 2.0
  @IBOutlet weak var priceSelectionVibrancyView: UIVisualEffectView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    lineChartView.delegate = self
    lineChartView.dataSource = self
    
    priceLabel.text = "--"
    priceChangeLabel.text = "--"
    
    extensionContext?.widgetLargestAvailableDisplayMode = .expanded
    vibrancyView.effect = UIVibrancyEffect.widgetPrimary()
    priceSelectionVibrancyView.effect = UIVibrancyEffect.widgetSecondary()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    fetchPrices { error in
      if error == nil {
        self.updatePriceLabel()
        self.updatePriceChangeLabel()
        self.updatePriceHistoryLineChart()
      }
    }
  }
  
  func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
    let expanded = activeDisplayMode == .expanded
    preferredContentSize = expanded ? CGSize(width: maxSize.width, height: 200) : maxSize
    toggleLineChart()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    updatePriceHistoryLineChart()
  }
  
  override func lineChartView(_ lineChartView: JBLineChartView!, colorForLineAtLineIndex lineIndex: UInt) -> UIColor! {
    return lineChartView.tintColor
  }
  
  private func toggleLineChart() {
    let expanded = extensionContext!.widgetActiveDisplayMode == .expanded
    if expanded {
      lineWidth = 4.0
      priceOnDayLabel.isHidden = false
    } else {
      lineWidth = 2.0
      priceOnDayLabel.isHidden = true
    }
    priceOnDayLabel.text = ""
  }
  
  override func lineChartView(_ lineChartView: JBLineChartView!, widthForLineAtLineIndex lineIndex: UInt) -> CGFloat {
    return lineWidth
  }
  
  func lineChartView(_ lineChartView: JBLineChartView!, didSelectLineAtIndex lineIndex: UInt, horizontalIndex: UInt) {
    if let prices = prices {
      let price = prices[Int(horizontalIndex)]
      updatePriceOnDayLabel(price)
    }
  }
  
  func didUnselectLineInLineChartView(_ lineChartView: JBLineChartView!) {
    priceOnDayLabel.text = ""
  }

  
  func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
    fetchPrices { error in
      if error == nil {
        self.updatePriceLabel()
        self.updatePriceChangeLabel()
        self.updatePriceHistoryLineChart()
        completionHandler(.newData)
      } else {
        completionHandler(.failed)
      }
    }
  }
  
}

