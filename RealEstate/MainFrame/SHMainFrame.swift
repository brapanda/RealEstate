import Foundation
import UIKit

extension UINavigationController {
    
    public override func childViewControllerForStatusBarHidden() -> UIViewController? {
        return self.topViewController
    }
    
    public override func childViewControllerForStatusBarStyle() -> UIViewController? {
        return self.topViewController
    }
}

class SHMainFrame: UITabBarController {
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        self.tabBar.tintColor = navigationColor
        self.tabBar.backgroundColor = .whiteColor()
        addTabs()
    }
    
    func addTabs(){
        
        let mapViewPage = SHMapViewController()
        let navNavigationPage1 = UINavigationController(rootViewController:mapViewPage)
        navNavigationPage1.navigationBar.barTintColor = navigationColor
        navNavigationPage1.tabBarItem = UITabBarItem(title: "地图",
                                                     image: UIImage.fontAwesomeIconWithName(FontAwesome.Globe,textColor: tabBarColor,size: CGSize(width: 30, height: 30)),
                                                     tag: 1)
        
        let listViewPage = SHListViewController()
        let navNavigationPage2 = UINavigationController(rootViewController:listViewPage)
        navNavigationPage2.navigationBar.barTintColor = navigationColor
        navNavigationPage2.tabBarItem = UITabBarItem(title: "列表",
                                                     image: UIImage.fontAwesomeIconWithName(FontAwesome.ThList,textColor: tabBarColor, size: CGSize(width: 30, height: 30)),
                                                     tag: 2)
        
        
        self.viewControllers = [navNavigationPage1,navNavigationPage2];
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    func imageFromColor(color: UIColor,size: CGSize, withCornerRadius radius: CGFloat) -> UIImage{
//        let rect = CGRectMake(0, 0, size.width, size.height)
//        UIGraphicsBeginImageContext(size)
//        
//        let context = UIGraphicsGetCurrentContext()
//        CGContextSetFillColorWithColor(context, color.CGColor)
//        CGContextFillRect(context, rect)
//        
//        var image = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        
//        UIGraphicsBeginImageContext(size)
//        
//        UIBezierPath(roundedRect: rect, cornerRadius: radius).addClip()
//        
//        image.drawInRect(rect)
//        
//        image = UIGraphicsGetImageFromCurrentImageContext()
//        
//        UIGraphicsEndImageContext()
//        
//        return image
//    }
    
}
