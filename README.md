<h3 align="center">FourZone, By Alex, Auora, Christian, and Elliot</h3>
---

It is becoming ever more common to see people with smart watches, fitness trackers, and other personal technologies.  Specifically, our team was inspired by fitness tracking and improving our individual performance during workouts.  We all wear fitness trackers daily (Apple Watch, Fitbit Surge, and Fitbit HR) and we discussed what our pain points were.  One clear feature that is constantly boasted about is heart beat tracking, yet we had no idea what these beats per minute meant in relation to most efficiently working out.  We conducted some further research and learned that there truly is a science behind improved fitness and target heart rate zones.  The science explained how there are four target heart rate zones that allow someone to maximize fat burn, endurance, performance, or muscle build.  Further we noticed that no application was available that motivated users based on his or her individual target heart rate zones and what they were trying to do. Our team has since created an apple watch application that tracks heart rate and based on the type of workout you are completing motives you to push harder (to reach your target and ideal heart zone for the exercise) or to slow down if your heart rate is at a dangerous level.  FourZone motivates and keeps users heart healthy and safe :)

### What is FourZone?
Now that you know what inspires us, solving real world problems, we can explain what FourZone does.  In short, FourZone is a heart rate coach that can educate, motivate, and assist users in best conducting his or her workout by using target heart rate zones.  The app name of FourZone steams from the fact that there are four target heart rate zones and the design of the logo was inspired by Haberdasher Puzzles...If you do not know what a Haberdasher Puzzle is...Check out this gif by Brent Clouse:

![Alt text](/triangle2.gif?raw=true "Credit: Brent Clouse")

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

- Install Xcode
- Download the project zip
- Run the project on your iPhone
- IMPORTANT: FourZone will not work unless you give it permission to your heart rate data!  In order to give permissions just open the app and allow FourZone to access the heart rate data from the prompt :)
- Enjoy!  We are always looking to improve our projects so if you have any questions or ideas for future features please drop us a line!

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
