//
//  PRJHShakeButton.m
//
//  Created by Harshad on 02/04/13.
//  Copyright (c) 2013 FlyingKittySorcerers. All rights reserved.
//

#import "PRJHWiggleButton.h"

#define kAnimationHorizontalTranslationScaleFactor        0.1f

@interface PRJHWiggleButton()

@property (nonatomic, weak, readwrite) UILabel *titleLabel;
@property (strong, nonatomic) NSDictionary *sendActionParameters;
@property (nonatomic) BOOL shouldRegisterNewAction;

@end

@implementation PRJHWiggleButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setShouldRegisterNewAction:YES];
        
        [self setBackgroundColor:[UIColor clearColor]];

        UILabel *aLabel = [[UILabel alloc] initWithFrame:self.bounds];
        [aLabel setAutoresizingMask:(UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth)];
        [aLabel setBackgroundColor:[UIColor clearColor]];
        [aLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:25]];
        [aLabel setAdjustsFontSizeToFitWidth:YES];
        [aLabel setMinimumScaleFactor:0.5f];
        [aLabel setTextAlignment:NSTextAlignmentCenter];
        [aLabel setText:@"Shake Button"];
        [self addSubview:aLabel];
        [self setTitleLabel:aLabel];
        
        [self.titleLabel setUserInteractionEnabled:NO];
    }
    return self;
}

#pragma mark - Private methods

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    [self.titleLabel setHighlighted:YES];

    return YES;
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    [self.titleLabel setHighlighted:YES];

    return YES;
}

- (void)cancelTrackingWithEvent:(UIEvent *)event {
    [self.titleLabel setHighlighted:NO];

}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {

    [self setUserInteractionEnabled:NO];
    [UIView animateWithDuration:0.12f delay:0.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
        [self.titleLabel setFrame:CGRectOffset(self.titleLabel.frame, self.titleLabel.bounds.size.width * kAnimationHorizontalTranslationScaleFactor, 0)];
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.12f delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
            
            [self.titleLabel setFrame:CGRectOffset(self.titleLabel.frame, -(self.titleLabel.bounds.size.width * kAnimationHorizontalTranslationScaleFactor * 1.5), 0)];
            
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:0.12f delay:0.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
                
                [self.titleLabel setFrame:self.bounds];
                
            } completion:^(BOOL finished) {
                
                [self.titleLabel setHighlighted:NO];
                
                NSString *selectorName = self.sendActionParameters[@"action"];
                
                [super sendAction:NSSelectorFromString(selectorName) to:self.sendActionParameters[@"target"] forEvent:self.sendActionParameters[@"event"]];
                
                [self setShouldRegisterNewAction:YES];
                [self setUserInteractionEnabled:YES];
                
            }];
        }];
    }];

}

- (void)sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    if (!self.shouldRegisterNewAction) {
        return;
    }
    
    [self setShouldRegisterNewAction:NO];
    NSString *actionName = NSStringFromSelector(action);
    
    NSDictionary *delayParameters = @{@"action" : actionName, @"target" : target, @"event" : event};
    
    [self setSendActionParameters:delayParameters];
}





@end
