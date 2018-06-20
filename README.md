# 网络组件使用API
### 网络请求使用方法

```
1.定义PAI
let api = MJTSCustomAPI() 基于TSBaseRequest的子类，需要重写配置请求域名方法
api.parameter = ["cmd" : "get_home_operate_info"] 请求参数
 api.HTTPMethod = .tsPost 请求方式，包括Get、Post请求
api.path = "/get_home_operate_info" 请求Path
api.timeoutInterval = 10 请求超时时间
可选配置 基本上用不到
api.privateHost 可定请求域名
api.particularHost 配置非默认网络策略域名 （pinCertificates 策略 ，validateCertificateChain为true，validateHost为true）
2.请求网络
TSNetworkManager<MJTSOmModel>.send(api, completion: { (resp) in
    let model = resp.responeObject 请求配置的模型
	 let jsonObject = resp.jsonData 请求返回的jsonObject
	 
}) { (error) in
    let code = error.code  错误Code码 ，包括网络和业务返回Code
    let message  = error.message 错误信息
    let urlError = error.error 网络错误的URLError
    let netType = error.networkType 当前网络类型
}
```
### 网络监听使用方法

```
开始监听
TSNetworkMonitor.shared.startNotifier { [weak self] (status) in
	status : 当前网络状态        
}
let netType = TSNetworkMonitor.shared.reachabilityStatus 当前网络类型1.tsFiwi 2.tsWan 3.tsOther 4.tsNoNet
停止监听
TSNetworkMonitor.shared.stopNotifier() 
```                             
### 网络配置例子
	基于TSBaseRequest创建自己的网络基类
	class MJTSCustomAPI : TSBaseRequest {
		//配置默认请求方式 其余配置可默认配置
		override var HTTPMethod: TSRequestMethod {
        set {
            
        }
        get {
            return .tsPost
        }
    	}
		//必须重写配置网络URL方法
    	override func tsRequestUrl() -> String? {
        return "https://sports.caiqr.cn/api"
      	//重写配置网络请求头方法 注意事项：如果重写User_Agent的key，Value会在默认Value的基础上拼接
      	override func tsRequestHeader() -> [String : String]? {
      		return ["" : ""]
      	}
    }
	}
### 模型配置使用
	创建模型，可为Class或是Struct，需要准守TSMoyaAddable协议
	注意事项： 如果想重写协议定义API，需要创建模型为Class
	例子：
	Class MJTSOmModel : TSMoyaAddable {
		 required init () { }
	    func objectToModelFinish() {
	        
	    }
	    var aaa : String?
	}
### Pod引用
	source 'http://gitlab.caiqr.com/zhangjunjie/ExchangePodSpecs.git'
	pod 'TSNetwork'
	
### 未来
    1.支持接口返回数据结构可配置
    2.支持数据缓存API