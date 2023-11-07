import Vue from 'vue'
import Router from 'vue-router'
import HelloWorld from '@/components/HelloWorld'
import Login from '@/components/Login'
//导入局部的页面Layout
import Layout from '@/components/Layout'

Vue.use(Router)
// 实现页面和url绑定
export default new Router({
  // 规则映射
  routes: [
    {
      path: '/',
      name: 'Login',
      component: Login
    },
    {
      path: '/layout',
      name: 'Layout',
      component: Layout,
      //  配置子路由
      children: [
        {
          path: 'vaccineType',//   --> /Layout/vaccineType
          name: 'vaccineType',
          component: () => import('@/type/TypeList')
        },
        {
          path: 'userInfo',//   --> /Layout/vaccineType
          name: 'userInfo',
          component: () => import('@/view/UserInfoList')
        },
        {
          path:'registration',
          name:'registration',
          component: () => import('@/view/RegisterList')
        }
      ]
    },


  ]
})
