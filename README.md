# 网络组件使用API

### 网络组件组成
<pre>
1.class TSNetworkManager
描述：网络请求类
创建：需要传入遵守TSMoyaAddable协议的泛型
</pre>
<pre>
2.class TSBaseRequest
描述：网络API基础类
创建：TSBaseRequest.init()
属性：
var path: 请求Path
var privateHost: 特殊请求Host
var HTTPMethod: 请求方式
var timeoutInterval: 请求超时
var parameter: [String:Any]? = 请求参数
var particularHost : 证书域名策略配置
方法：
func tsRequestUrl -> String 配置请求URLString
func tsRequestHeader -> [String : String] 配置请求头
</pre>
<pre>
3.class TSBaseResponse
code: 业务返回数据code
jsonData: JsonObject
responeObject: 数据模型
</pre>
<pre>
4.enum TSNetworkError	
var message: 错误信息
var code: 错误code	    
var error: 错误原生error
var networkType: 当前网络状态 分为 WiFi Wan NoNetwork Other
</pre>
<pre>
5.TSMoyaAddable 协议
objectToModelFinish : object转模型结束
</pre>
<pre>
6.class TSNetworkMonitor  
描述：网络监听类 是单例
属性：
var reachabilityStatus ： 当前网络状态 分为 WiFi Wan NoNetwork Other
方法：	
func startNotifier (monitorStatus : @escaping (Bool) -> () )  ： 开始监听
func stopNotifier ： 停止监听
</pre>
### 网络请求API
	class TSNetworkManager
    public func send<R: TSBaseRequest & TSRequestProtocol>(
        _ type: R,
        completion: @escaping ((TSBaseResponse<T>?) -> ()),
        error: @escaping (TSNetworkError) -> () )
        -> DataRequest?
	参数说明：
	type:TSBaseReques子类并且遵守TSRequestProtocol协议
	completion:请求成功回调，
	error:请求失败回调，TSNetworkError
	return : DataRequest,请求Task
	
### 网络监听API

	class TSNetworkMonitor
	var reachabilityStatus ： 当前网络状态属性 分为 WiFi Wan NoNetwork Other
	
	开始监听网络：
	public func startNotifier (monitorStatus : @escaping (Bool) -> () )
	闭包内返回当前是否有网络
	
	停止监听网络：
	public func stopNotifier ()
                                
### 网络配置例子
	基于TSBaseRequest创建自己的网络基类
	class TSCustomBaseAPI : TSBaseRequest {
   		required init() {
        super.init()
    	}
		//重写配置网络URL方法
    	override func tsRequestUrl() -> String? {
        return "https://sports.caiqr.cn/api"
      	//重写配置网络请求头方法 注意事项：如果重写User_Agent的key，Value会在默认Value的基础上拼接
      	override func tsRequestHeader() -> [String : String]? {
      		return ["" : ""]
      	}
    }
	}
### 模型配置
	创建模型，可为Class或是Struct，需要准守TSMoyaAddable协议
	注意事项： 如果想重写协议定义API，需要创建模型为Class
	例子：
	Class TSDemoModel : TSMoyaAddable {
		 required init () { }
	    func objectToModelFinish() {
	        
	    }
	    var aaa : String?
	}
### 使用例子

```
    let api = MJTSCustomAPI()
    api.parameter = ["cmd" : "get_home_operate_info"]
    api.path = "/get_home_operate_info"
    TSNetworkManager<MJTSOmModel>.send(api, completion: { (resp) in
        let model = resp.responeObject
  
    }) { (error) in
        
    }
```
### Pod引用
	source 'http://gitlab.caiqr.com/zhangjunjie/ExchangePodSpecs.git'
	pod 'TSNetwork'
	
### 未来
    1.支持接口返回数据结构可配置
    2.支持数据缓存API