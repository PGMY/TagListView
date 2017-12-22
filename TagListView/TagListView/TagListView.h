//
//  TagListView.h
//  TagListView
//
//  Created by Mika Yamamoto on 2017/12/22.
//  Copyright © 2017年 PGMY. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^TagEditButtonAction)(void);

@interface TagListView : UIView
- (void)setupTags:(NSMutableArray<NSString*>*)tagArr;
@end
