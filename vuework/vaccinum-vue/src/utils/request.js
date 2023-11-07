import axios from 'axios'
import router from "@/router";
import qs from "qs"
import Cookies from "js-cookie";
axios.defaults.withCredentials=true //让ajax请求携带cookie
//1、目的是封装请求对象  2、目的对请求和响应数据进行格式
// 创建对象
const request = axios.create({
    baseURL: 'http://localhost:8085',  // 注意！！ 这里是全局统一加上了 baseURL 前缀，
    timeout: 5000
})

// request 拦截器
request.interceptors.request.use(
    config => {
      //对请求的数据进行处理
      if (config.method != 'get') {
        config.data = qs.stringify(config.data);
      }
      // post请求方式的content格式
      config.headers['content-Type'] = 'application/x-www-form-urlencoded';//允许通过访问
      return config;
    },
    error => {
      console.log('err' + error) // for debug
      return Promise.reject(error)
    }
)

// response 拦截器
// 可以在接口响应后统一处理结果
request.interceptors.response.use(
    response => {
        let res = response.data;
        // 如果是返回的文件
        if (response.config.responseType === 'blob') {
            return res
        }
        // 兼容服务端返回的字符串数据
        if (typeof res === 'string') {
            res = res ? JSON.parse(res) : res
        }
        return res;
    },
    error => {
        console.log('err' + error) // for debug
        return Promise.reject(error)
    }
)

export default request
