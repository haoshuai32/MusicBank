//
//  ToolCollectionViewCell.swift
//  MusicBank
//
//  Created by flqy on 2021/3/22.
//  Copyright © 2021 onelact. All rights reserved.
//

import UIKit
import IGListKit

let  kItemWidth:CGFloat = 70;     // item宽高
let  kPaddingMid:CGFloat = 30    // item间距
let  kPaddingLeft:CGFloat = 20   // 最左边item左边距

class MyCollectionFlowLayout: UICollectionViewFlowLayout, UIScrollViewDelegate, UICollectionViewDelegate {
    // 每页可以完整展示的item个数
    var _pageCapacity = 0
    // 当前页码（滑动前）
    var  _currentIndex = 0
    
//    prepareLayout
    override func prepare() {
        super.prepare()
        guard let collectionView = self.collectionView,
              let dataSource = collectionView.dataSource else {
            assert(false)
            return
        }
        collectionView.delegate = self

        
        // 计算paddingRight
//        CGFloat paddingRight = 0.0;
        var paddingRight:CGFloat = 0.0;
//
//        // item个数
//        // collectionView调用reloadData后，layout会重新prepareLayout
//        NSInteger itemsCount = [self.collectionView.dataSource collectionView:self.collectionView numberOfItemsInSection:0];
        let itemsCount = dataSource.collectionView(collectionView, numberOfItemsInSection: 0)
        
//
//        // item间距
//        self.minimumInteritemSpacing = kPaddingMid;
        self.minimumInteritemSpacing = kPaddingMid
        self.minimumLineSpacing = kPaddingMid;
//        self.itemSize = CGSizeMake(kItemWidth, kItemWidth);
        self.itemSize = CGSize(width: kItemWidth, height: kItemWidth)
//
//        CGFloat collectionViewWidth = CGRectGetWidth(self.collectionView.bounds);
        let collectionViewWidth = collectionView.bounds.width
//
//        // 每页可以完整显示的items个数
//        NSInteger pageCapacity = (NSInteger)(collectionViewWidth - kPaddingLeft + kPaddingMid) / (NSInteger)(kItemWidth + kPaddingMid);
        let pageCapacity = (collectionViewWidth - kPaddingLeft + kPaddingMid) / (kItemWidth + kPaddingMid)
//        _pageCapacity = pageCapacity;
        self._pageCapacity = Int(pageCapacity)
//
//        // 完整显示所有items的总页数
//        NSInteger pages = itemsCount / pageCapacity;
        var pages:Int = itemsCount / Int(pageCapacity)
//        NSInteger remainder = itemsCount % pageCapacity;
        let remainder = itemsCount % Int((pageCapacity))
        
//        if (remainder == 0) {
//            paddingRight = collectionViewWidth - pageCapacity * (kItemWidth + kPaddingMid) + kPaddingMid - kPaddingLeft;
//        } else {
//            paddingRight = collectionViewWidth - remainder * (kItemWidth + kPaddingMid) + kPaddingMid - kPaddingLeft;
//            pages ++;
//        }
//
        if remainder == 0 {
            paddingRight = collectionViewWidth - CGFloat(pageCapacity) * (kItemWidth + kPaddingMid) + kPaddingMid - kPaddingLeft;
        } else {
            paddingRight = collectionViewWidth - CGFloat(remainder) * (kItemWidth + kPaddingMid) + kPaddingMid - kPaddingLeft;
            pages += 1
        }
        
//        // padding top bottom
//        CGFloat paddingVertical = (CGRectGetHeight(self.collectionView.bounds) - kItemWidth) / 2;
        let paddingVertical = (collectionView.bounds.height - kItemWidth) / 2
//        self.sectionInset = UIEdgeInsetsMake(paddingVertical, kPaddingLeft, paddingVertical, paddingRight);
        
        self.sectionInset = UIEdgeInsets(top: paddingVertical, left: kPaddingLeft, bottom: paddingVertical, right: paddingRight)
        debugPrint("sectionInset",self.sectionInset)
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
//        NSInteger index = (NSInteger)proposedContentOffset.x / (NSInteger)(_pageCapacity * (kItemWidth + kPaddingMid));
        var index = Int(proposedContentOffset.x) / Int(CGFloat(_pageCapacity) * (kItemWidth + kPaddingMid))
//
//            NSInteger remainder = (NSInteger)proposedContentOffset.x % (NSInteger)(_pageCapacity * (kItemWidth + kPaddingMid));
        let remainder = Int(proposedContentOffset.x) % Int(CGFloat(_pageCapacity) * (kItemWidth + kPaddingMid))
        if (remainder > 10 && velocity.x > 0.3) {
            index += 1
        }
        if (velocity.x < -0.3 && index > 0) {
            index -= 1
        }
//
//            if (remainder > 10 && velocity.x > 0.3) {
//                index ++;
//            }
//
//            if (velocity.x < -0.3 && index > 0) {
//                index --;
//            }
//
//            // 保证一次只滑动一页
//            index = MAX(index, _currentIndex - 1);
        index = max(index, _currentIndex - 1)
//            index = MIN(index, _currentIndex + 1);
       index = min(index, _currentIndex + 1)
//            CGPoint point = CGPointMake(0, 0);
        var point = CGPoint.zero
        if index >  0 {
            point.x = CGFloat(index * _pageCapacity) * (kItemWidth + kPaddingMid);
        }
//            if (index > 0) {
//                point.x = index * _pageCapacity * (kItemWidth + kPaddingMid);
//            }
//
            return point;
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        /*
          * 分子scrollView.contentOffset.x为什么要+kItemWidth ？？
          * 消除scrollView在摆动的时候的误差，此时contentOffset.x比预期减少了10左右像素，导致_currentIndex比预期小1
          */
//         _currentIndex = (NSInteger)(scrollView.contentOffset.x + kItemWidth) / (NSInteger)(_pageCapacity * (kItemWidth + kPaddingMid));
        _currentIndex = Int(scrollView.contentOffset.x + kItemWidth) / Int(CGFloat(_pageCapacity) * (kItemWidth + kPaddingMid))
    }
    
}

class ToolCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ToolItemCell", for: indexPath) as? ToolItemCell else {
            fatalError()
        }
        cell.nameLabel.text = "\(indexPath.item)"
        return cell
    }
    

    @IBOutlet weak var colleciontView: UICollectionView!
    
    
    lazy var bottomLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.yellow
        return view
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let layout = MyCollectionFlowLayout()
        layout.scrollDirection = .horizontal
        colleciontView.decelerationRate = .fast
        colleciontView.setCollectionViewLayout(layout, animated: false)
<<<<<<< HEAD
        
        let  threadPort = NSMachPort.init(machPort: 1)
        threadPort.send(before: <#T##Date#>, components: <#T##NSMutableArray?#>, from: <#T##Port?#>, reserved: <#T##Int#>)
        
        // Initialization code
=======
        colleciontView.register(UINib(nibName: "ToolItemCell", bundle: nil), forCellWithReuseIdentifier: "ToolItemCell")
        colleciontView.delegate = self
        colleciontView.dataSource = self
>>>>>>> d7295c5c041c57d5811f8b41d697edbb93d70268
    }
    
    
    
    
    
    

}
