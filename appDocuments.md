#app沙盒
出于安全考虑，iOS系统的沙盒机制规定每个应用都只能访问当前沙盒目录下面的文件（也有例外，比如系统通讯录能在用户授权的情况下被第三方应用访问），这个规则把iOS系统的封闭性展现的淋漓尽致。
一、沙盒中几个主要的目录
每个沙盒下面都有相似的目录结构，如下图所示：
![](/Users/tangdaoyong/Desktop/TDY_iOSGit/TDY_沙盒/app沙盒图片/20140114190236109.jpeg)
每个应用的沙盒目录都是相似的，主要包含图中所示的4个目录：
###1、MyApp.app
①存放内容
该目录包含了应用程序本身的数据，包括资源文件和可执行文件等。程序启动以后，会根据需要从该目录中动态加载代码或资源到内存，这里用到了lazy loading的思想。
②整个目录是只读的
为了防止被篡改，应用在安装的时候会将该目录签名。非越狱情况下，该目录中内容是无法更改的；在越狱设备上如果更改了目录内容，对应的签名就会被改变，这种情况下苹果官网描述的后果是应用程序将无法启动，我没实践过。
③是否会被iTunes同步
否
###2、Documents
①存放内容
我们可以将应用程序的数据文件保存在该目录下。不过这些数据类型仅限于不可再生的数据，可再生的数据文件应该存放在Library/Cache目录下。
②是否会被iTunes同步
是
###3、Documents/Inbox
①存放内容
该目录用来保存由外部应用请求当前应用程序打开的文件。
比如我们的应用叫A，向系统注册了几种可打开的文件格式，B应用有一个A支持的格式的文件F，并且申请调用A打开F。由于F当前是在B应用的沙盒中，我们知道，沙盒机制是不允许A访问B沙盒中的文件，因此苹果的解决方案是讲F拷贝一份到A应用的Documents/Inbox目录下，再让A打开F。
②是否会被iTunes同步
是
###4、Library
①存放内容
苹果建议用来存放默认设置或其它状态信息。
②是否会被iTunes同步
是，但是要除了Caches子目录外
#####5、Library/Caches
①存放内容
主要是缓存文件，用户使用过程中缓存都可以保存在这个目录中。前面说过，Documents目录用于保存不可再生的文件，那么这个目录就用于保存那些可再生的文件，比如网络请求的数据。鉴于此，应用程序通常还需要负责删除这些文件。
②是否会被iTunes同步
否。
#####6、Library/Preferences
①存放内容
应用程序的偏好设置文件。我们使用NSUserDefaults写的设置数据都会保存到该目录下的一个plist文件中，这就是所谓的写道plist中！
②是否会被iTunes同步
是
###7、tmp
①存放内容
各种临时文件，保存应用再次启动时不需要的文件。而且，当应用不再需要这些文件时应该主动将其删除，因为该目录下的东西随时有可能被系统清理掉，目前已知的一种可能清理的原因是系统磁盘存储空间不足的时候。
②是否会被iTunes同步
否
#二、获取主要目录路径的方式
1、沙盒目录

    NSLog(@"%@",NSHomeDirectory());
2、tmp

    NSLog(@"%@",NSTemporaryDirectory());
3、Myapp.app

    NSLog(@"%@",[[NSBundle mainBundle] bundlePath]);
4、Documents

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    NSLog(@"%@",path);
这里用到的NSSearchPathForDirectoriesInDomains方法需要解释下，其声明如下：

    FOUNDATION_EXPORT NSArray *NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory directory, NSSearchPathDomainMask domainMask, BOOL expandTilde);
该方法用于返回指定范围内的指定名称的目录的路径集合。有三个参数：
#####directory
NSSearchPathDirectory类型的enum值，表明我们要搜索的目录名称，比如这里用NSDocumentDirectory表明我们要搜索的是Documents目录。如果我们将其换成NSCachesDirectory就表示我们搜索的是Library/Caches目录。
#####domainMask
NSSearchPathDomainMask类型的enum值，指定搜索范围，这里的NSUserDomainMask表示搜索的范围限制于当前应用的沙盒目录。还可以写成NSLocalDomainMask（表示/Library）、NSNetworkDomainMask（表示/Network）等。
#####expandTilde
BOOL值，表示是否展开波浪线\~。我们知道在iOS中\~的全写形式是/User/userName，该值为YES即表示写成全写形式，为NO就表示直接写成“~”。