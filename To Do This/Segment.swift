//
//  Segment.swift
//  To Do This
//
//  Created by Devin Yancey on 12/1/16.
//  Copyright © 2016 Devin Yancey. All rights reserved.
//

import Foundation
import UIKit
import Segmentio

struct Segment{
    
    static func setUpSegement(withSeg: Segmentio, segmentioStyle: SegmentioStyle){
        withSeg.setup(
            content: segmentioContent(),
            style: segmentioStyle,
            options: segmentioOptions(segmentioStyle: segmentioStyle)
        )
    }
    
    private static func segmentioContent() -> [SegmentioItem] {
        var segments:[SegmentioItem] = []
        for group in User.shared.groups{
            segments.append(SegmentioItem(title: group.name, image: nil))
            
        }
        return segments
    }
  
    private static func segmentioOptions(segmentioStyle: SegmentioStyle) -> SegmentioOptions {
        var imageContentMode = UIViewContentMode.center
        switch segmentioStyle {
        case .imageBeforeLabel, .imageAfterLabel:
            imageContentMode = .scaleAspectFit
        default:
            imageContentMode = .scaleAspectFit
            break
        }
        
        return SegmentioOptions(
            backgroundColor: UIColor.clear,
            maxVisibleItems: 5,
            scrollEnabled: true,
            indicatorOptions: segmentioIndicatorOptions(),
            horizontalSeparatorOptions: segmentioHorizontalSeparatorOptions(),
            verticalSeparatorOptions: segmentioVerticalSeparatorOptions(),
            imageContentMode: imageContentMode,
            labelTextAlignment: .center,
            labelTextNumberOfLines: 1,
            segmentStates: segmentioStates(),
            animationDuration: 0.3
        )
    }
    
    private static func segmentioStates() -> SegmentioStates {
        let font = UIFont.exampleAvenirMedium(ofSize: 13)
        return SegmentioStates(
            defaultState: segmentioState(
                backgroundColor: User.shared.colorPallete!["nav"]!,
                titleFont: font,
                titleTextColor: ColorPalette.white
            ),
            selectedState: segmentioState(
                backgroundColor: User.shared.colorPallete!["nav"]!,
                titleFont: font,
                titleTextColor: ColorPalette.white
            ),
            highlightedState: segmentioState(
                backgroundColor: ColorPalette.whiteSmoke,
                titleFont: font,
                titleTextColor: ColorPalette.white
            )
        )
    }
    
    private static func segmentioState(backgroundColor: UIColor, titleFont: UIFont, titleTextColor: UIColor) -> SegmentioState {
        return SegmentioState(
            backgroundColor: backgroundColor,
            titleFont: titleFont,
            titleTextColor: titleTextColor
        )
    }
    
    private static func segmentioIndicatorOptions() -> SegmentioIndicatorOptions {
        return SegmentioIndicatorOptions(
            type: .bottom,
            ratio: 1,
            height: 10,
            color: (User.shared.colorPallete?["selectionColor"])!
        )
    }
    
    private static func segmentioHorizontalSeparatorOptions() -> SegmentioHorizontalSeparatorOptions {
        return SegmentioHorizontalSeparatorOptions(
            type: .topAndBottom,
            height: 1,
            color: .clear
        )
    }
    
    private static func segmentioVerticalSeparatorOptions() -> SegmentioVerticalSeparatorOptions {
        return SegmentioVerticalSeparatorOptions(
            ratio: 1,
            color: .clear
        )
    }
}
