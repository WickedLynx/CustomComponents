CustomComponents
================

Fancy custom components for iOS Apps.

This is a collection of custom iOS controls and UI elements.

## Components

###PRJHWiggleButton

A normal iOS button, except that its text wiggles sideways when you click it.

####How to use:

1.	Import `PRJHWiggleButton.h`
2.	Create a wiggle button:  
  
>			PRJHWiggleButton *aWiggleButton = [[PRJHWiggleButton alloc] 
>														initWithFrame:CGRectMake(10, 10, 100, 40)];
>			[aWiggleButton addTarget:self action:@selector(actionName) 
>													forControlEvents:(UIControlEventTouchUpInside)];
>			[self.view addSubview:aWiggleButton];