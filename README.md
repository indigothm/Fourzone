<h3 align="center">FourZone, By Alex, Auora, Christian, and Elliot</h3>
---

This project is a tutorial ([Check tutorial here](http://www.appcoda.com/facebook-pop-framework-intro/ "Facebook Pop Tutorial")) for how to use Pop framework by Facebook. Its very easy and effecient framework that helps you to make decent animation in no time. 
In this project you will find some simple demoes, they are not big demoes but I promise you, they will help you in mastering the framework.

### What is FourZone?
Pop is an extensible animation engine for both iOS and OS X. In addition to basic animations including Linear, Ease-In, Ease-Out, Ease-In-Ease-Out animations, it supports spring (at the time of its release, spring animation was not supported in iOS), decay and custom animations:

- Spring: dynamic animation that creates a nice bouncing effect.
- Decay: dynamic animation that brings a movement to a smooth halt.
- Custom: because the engine is designed to be extensible, you can create your own custom animations.

The Pop API is very developer friendly that lets you easily build some realistic, physics-based interactions. For instance, here is the code snippet for creating a spring animation on a text label:

```Objective-c
POPSpringAnimation *sprintAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
sprintAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(0.9, 0.9)];
sprintAnimation.velocity = [NSValue valueWithCGPoint:CGPointMake(2, 2)];
sprintAnimation.springBounciness = 20.f;
[self.textLabel pop_addAnimation:sprintAnimation forKey:@"springAnimation"];
```

<h3 align="center">Made Entirly in Swift</h3>
---
Navigate to this "Swift Version" folder or ([click here](https://github.com/hossamghareeb/Facebook-POP-Tutorial/tree/master/Swift%20Version "Swift Version")) to see the full working exmples written in Swift.

<h3 align="center">Made To Be Put Straight Onto Your Device</h3>
---
At this point we know you must be thking how useful and cool this technology is!  Likely you want to give it a try, lucky for you FourZone is going to be available for free in the iOS app store in the near future.  However, for those of you that can not wait you can follow these easy steps and get FourZone running on your device quickly.  
1) Install Xcode
2) Download the project zip
3) Run the project on your iPhone
4) IMPORTANT: FourZone will not work unless you give it permission to your heart rate data!  In order to give permissions just open the app and allow FourZone to access the heart rate data from the prompt :)
5) Enjoy!  We are always looking to improve our projects so if you have any questions or ideas for future features please drop us a line!

<h3 align="center">FourZone Examples</h3>
---

### Animate UITableView cells selection:
<p align="center"><img src ="https://github.com/most-wanted/Facebook-POP-Tutorial/blob/master/screenshots/pop-animation-1-1.gif"/></p>

### Facebook Messenger Send/Like animation:

<p align="center"><img src ="https://github.com/most-wanted/Facebook-POP-Tutorial/blob/master/screenshots/pop-animation-2.gif"/></p>

### UITextField wrong entry animation:

<p align="center"><img src ="https://github.com/most-wanted/Facebook-POP-Tutorial/blob/master/screenshots/pop-animation-3-2.gif"/></p>

### Custom Transition for Modal ViewControllers:

<p align="center"><img src ="https://github.com/most-wanted/Facebook-POP-Tutorial/blob/master/screenshots/pop-animation-4.gif"/></p>

<h3 align="center">License</h3>
---

The MIT License (MIT)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
