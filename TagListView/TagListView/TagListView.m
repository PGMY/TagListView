//
//  TagListView.m
//  TagListView
//
//  Created by Mika Yamamoto on 2017/12/22.
//  Copyright © 2017年 PGMY. All rights reserved.
//

#import "TagListView.h"

@interface TagLabel : UILabel

@property (nonatomic, assign) UIEdgeInsets padding;
@end

@implementation TagLabel

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if ( self ) {
        self.padding = UIEdgeInsetsMake(4, 8, 4, 8);
        self.backgroundColor = [UIColor lightGrayColor];
        self.font = [UIFont systemFontOfSize:12];
        self.layer.cornerRadius = 2;
        self.clipsToBounds = YES;
    }
    return self;
}

- (void)drawTextInRect:(CGRect)rect {
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, self.padding)];
}

- (CGSize)intrinsicContentSize {
    CGSize intrinsicContentSize = super.intrinsicContentSize;
    intrinsicContentSize.height += self.padding.top + self.padding.bottom;
    intrinsicContentSize.width += self.padding.left + self.padding.right;
    return intrinsicContentSize;
}

- (CGSize)sizeThatFits:(CGSize)size {
    
    CGSize contentSize = size;
    CGFloat hOffset = self.padding.left + self.padding.right;
    CGFloat vOffset = self.padding.top + self.padding.bottom;
    
    contentSize.width -= hOffset;
    contentSize.height -= vOffset;
    
    CGSize baseSize = [super sizeThatFits:size];
    baseSize.width += hOffset;
    baseSize.height += vOffset;
    baseSize.height = 24;
    return baseSize;
    
}

@end

@interface TagButton : UIButton
@end
@implementation TagButton
@end


@interface TagListView ()
@property (nonatomic, strong) NSMutableArray<TagLabel*> *tagLabels;
@property (nonatomic, strong) NSMutableArray<TagButton*> *tagButtons;
@property (nonatomic, strong) UIButton *addButton;
@property (nonatomic, strong) TagEditButtonAction addAction;
@end

@implementation TagListView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if ( self ) {
        self.backgroundColor = [UIColor grayColor];
        
        self.addButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 32)];
        self.addButton.titleLabel.font = [UIFont systemFontOfSize:12];
        self.addButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self.addButton setTitle:@"編集" forState:UIControlStateNormal];
        [self.addButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.addButton setImage:[UIImage imageNamed:@"ButtonEditTag"] forState:UIControlStateNormal];
        [self.addButton addTarget:self action:@selector(tapEditTagButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.addButton];
    }
    return self;
}

- (void)tapEditTagButton:(UIButton*)sender {
    if ( self.addAction ) self.addAction();
}

- (void)setupTags:(NSMutableArray<NSString*>*)tagArr {
    for (UIView *sub in self.subviews) {
        if ( [sub isKindOfClass:TagLabel.class] ) {
            [sub removeFromSuperview];
        }
    }
    
    self.tagLabels = [NSMutableArray array];
    for (NSString *str in tagArr) {
        TagLabel *label = [[TagLabel alloc] initWithFrame:CGRectZero];
        label.text = str;
//        label.backgroundColor = [UIColor colorWithTagId:memo.tagColor];
        [self addSubview:label];
        [self.tagLabels addObject:label];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat sx = 0;
    CGFloat const margin = 8;
    CGFloat sy = 0;
    for (TagLabel *tagLabel in self.tagLabels) {
        
        CGSize maxSize = CGSizeMake(self.frame.size.width,24);
        CGSize tagLabelSize = [tagLabel sizeThatFits:maxSize];
        
        if ( tagLabelSize.width + margin *2 > self.frame.size.width ) tagLabelSize.width = self.frame.size.width - margin *2;
        if ( sx + margin + tagLabelSize.width > self.frame.size.width ) {
            sy += tagLabelSize.height + margin;
            sx = margin;
        } else {
            sx += margin;
        }
        
        tagLabel.frame = CGRectMake(sx, sy, tagLabelSize.width, tagLabelSize.height);
        sx += tagLabelSize.width;
        
    }
    CGFloat buttonWidth = 55;
    if ( sx + margin + buttonWidth > self.frame.size.width ) {
        sy += 24 + margin;
        sx = margin;
    } else {
        sx += margin;
    }
    self.addButton.frame = CGRectMake(sx, sy-4, buttonWidth, 32);
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, sy + 24);
    NSLog(@"%f",self.frame.size.width);

}

@end


