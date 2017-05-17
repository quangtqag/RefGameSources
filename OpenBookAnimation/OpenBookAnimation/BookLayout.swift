/*
* Copyright (c) 2015 Razeware LLC
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

private let PageWidth: CGFloat = 362
private let PageHeight: CGFloat = 568

class BookLayout: UICollectionViewFlowLayout {

	var numberOfItems = 0
 
	override func prepare() {
		super.prepare()
		collectionView?.decelerationRate = UIScrollViewDecelerationRateFast
		numberOfItems = collectionView!.numberOfItems(inSection: 0)
		collectionView?.isPagingEnabled = true
	}
	
	override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
		return true
	}
	
	override var collectionViewContentSize : CGSize {
		return CGSize(width: (CGFloat(numberOfItems / 2)) * collectionView!.bounds.width, height: collectionView!.bounds.height)
	}
	
	override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
		
		var array: [UICollectionViewLayoutAttributes] = []
		for i in 0 ... max(0, numberOfItems - 1) {
			let indexPath = IndexPath(item: i, section: 0)
			let attributes = layoutAttributesForItem(at: indexPath)
			if attributes != nil {
//				array += [attributes]
        array.append(attributes!)
			}
		}
		return array
	}
	
	//MARK: attribute logic helpers
	func getFrame(_ collectionView: UICollectionView) -> CGRect {
		var frame = CGRect()
		
		frame.origin.x = (collectionView.bounds.width / 2) - (PageWidth / 2) + collectionView.contentOffset.x
		frame.origin.y = (collectionViewContentSize.height - PageHeight) / 2
		frame.size.width = PageWidth
		frame.size.height = PageHeight
		
		return frame
	}
	
	func getRatio(_ collectionView: UICollectionView, indexPath: IndexPath) -> CGFloat {
		
		//this ensures that pages next to each other are sticked together. to form a double sided page.
		let page = CGFloat(indexPath.item - indexPath.item % 2) * 0.5
		
		var ratio: CGFloat = -0.5 + page - (collectionView.contentOffset.x / collectionView.bounds.width)
		
		
		if ratio > 0.5 {
			ratio = 0.5 + 0.1 * (ratio - 0.5)
			
		}
		
		if ratio < -0.5 {
			ratio = -0.5 + 0.1 * (ratio + 0.5)
		}
		
		return ratio
	}

	func getAngle(_ indexPath: IndexPath, ratio: CGFloat) -> CGFloat {
		// Set rotation
		var angle: CGFloat = 0
		
		//1
		if indexPath.item % 2 == 0 {
			//2
			// The book's spine is on the left of the page
			angle = (1-ratio) * CGFloat(-Double.pi/2)
		}
		//3
		if indexPath.item % 2 == 1 {
			//4
			// The book's spine is on the right of the page
			angle = (1 + ratio) * CGFloat(Double.pi/2)
		}
		//5
		// Make sure the odd and even page don't have the exact same angle
		angle += CGFloat(indexPath.row % 2) / 1000
		//6
		return angle
	}
	
	func makePerspectiveTransform() -> CATransform3D {
		var transform = CATransform3DIdentity;
		transform.m34 = 1.0 / -2000;
		return transform;
	}
	
	func getRotation(_ indexPath: IndexPath, ratio: CGFloat) -> CATransform3D {
		//1
		var transform = makePerspectiveTransform()
		//2
		let angle = getAngle(indexPath, ratio: ratio)
		//3
		transform = CATransform3DRotate(transform, angle, 0, 1, 0)
		
		return transform
	}
	
	override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
		// Create layout attributes object
		let layoutAttributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
		
		// Set initial frame - align the page's edge to the spine
		let frame = getFrame(collectionView!)
		layoutAttributes.frame = frame
		
		let ratio = getRatio(collectionView!, indexPath: indexPath)
		
		// Back-face culling - display only front-face pages.
		if ratio > 0 && indexPath.item % 2 == 1
			|| ratio < 0 && indexPath.item % 2 == 0 {
				// Make sure the cover is always visible
				if indexPath.row != 0 {
					return nil
				}
		}
		
		// Apply rotation transform
		let rotation = getRotation(indexPath, ratio: min(max(ratio, -1), 1))
		layoutAttributes.transform3D = rotation
		
		// Make sure the cover is always above page 1 to avoid flickering when closing the book
		if indexPath.row == 0 {
			layoutAttributes.zIndex = Int.max
		}
		
		return layoutAttributes
	}
	
}
