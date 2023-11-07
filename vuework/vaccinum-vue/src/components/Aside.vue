<template>
 <div>
  <el-menu
   style="width: 250px; min-height: calc(100vh - 50px);padding-top: 10px;"
   default-active="2"
   class="el-menu-vertical-demo"
   @open="handleOpen"
   @close="handleClose"
   :default-openeds="[path]"
   router
  >
   <el-submenu index="1" v-if="role == 'manager'">
    <template slot="title">
     <i class="el-icon-s-management"></i>
     <!-- font-family:'Franklin Gothic Medium', 'Arial Narrow', Arial, sans-serif;" -->
     <span style="font-size: 17px; font-weight: bold;font-family:'苹方'">管理员模块</span>
    </template>
    <el-menu-item-group>
     <el-menu-item index="/Layout/adminList"
      ><i class="el-icon-link"></i>管理员列表</el-menu-item
     >
    </el-menu-item-group>
   </el-submenu>
   <el-submenu index="2">
    <template slot="title">
     <i class="el-icon-first-aid-kit"></i>
     <span style="font-size: 17px; font-weight: bold;font-family:'苹方'">医生模块</span>
    </template>
    <el-menu-item-group>
     <!-- <i class="icon_line"></i> -->
     <el-menu-item index="/Layout/doctorList"
      ><i class="el-icon-link"></i> 医生列表</el-menu-item
     >
     <el-menu-item
      index="/Layout/registration"
      v-if="role == 'manager' || role == 'doctor' || role == 'user'"
      ><i class="el-icon-link"></i>挂号记录</el-menu-item
     >
     <el-menu-item index="/Layout/vaccineRecord" v-if="role != 'doctor'"
      ><i class="el-icon-link"></i>接种记录</el-menu-item
     >
    </el-menu-item-group>
   </el-submenu>
   <el-submenu index="3" v-if="role == 'manager' || role == 'user'">
    <template slot="title">
     <i class="el-icon-user"></i>
     <span style="font-size: 17px; font-weight: bold;font-family:'苹方'">用户模块</span>
    </template>
    <el-menu-item-group>
     <el-menu-item index="/Layout/userList" v-if="role == 'manager'"
      ><i class="el-icon-link"></i>用户列表</el-menu-item
     >
     <el-menu-item index="/Layout/userRegis" v-if="role == 'user'"
      ><i class="el-icon-link"></i>预约挂号</el-menu-item
     >
     <el-menu-item index="/Layout/userInfo" v-if="role == 'user'"
      ><i class="el-icon-link"></i>用户详细信息查询</el-menu-item
     >
    </el-menu-item-group>
   </el-submenu>
   <el-submenu index="4">
    <template slot="title">
     <i class="el-icon-office-building"></i>
     <span style="font-size: 17px; font-weight: bold;font-family:'苹方'">医院模块</span>
    </template>
    <el-menu-item-group>
     <el-menu-item index="/Layout/hosList"
      ><i class="el-icon-link"></i>医院列表</el-menu-item
     >
     <el-menu-item index="/Layout/deptList"
      ><i class="el-icon-link"></i>科室列表</el-menu-item
     >
    </el-menu-item-group>
   </el-submenu>
   <el-submenu index="5">
    <template slot="title">
     <i class="el-icon-office-building"></i>
     <span style="font-size: 17px; font-weight: bold;font-family:'苹方'">疫苗模块</span>
    </template>
    <el-menu-item-group>
     <el-menu-item index="/Layout/vaccineType"
      ><i class="el-icon-link"></i>疫苗种类</el-menu-item
     >
     <el-menu-item index="/Layout/vaccine"
      ><i class="el-icon-link"></i>疫苗信息</el-menu-item
     >
     <el-menu-item index="/Layout/appVaccineList"
      ><i class="el-icon-link"></i>可预约疫苗</el-menu-item
     >
    </el-menu-item-group>
   </el-submenu>
  </el-menu>
 </div>
</template>
<style>
.icon1 {
 display: inline-block;
 width: 50px;
 height: 50px;
 background-image: url("../assets/BUTTON_NOOPEN.png");
 background-position: center center;
 background-repeat: no-repeat;
}
.icon_line {
 display: block;
 width: 20px;
 height: 20px;
 background-image: url("../assets/line1.png");
 position: relative;
 left: 75px;
 background-repeat: no-repeat;
}
</style>
   
<script>
import Cookies from "js-cookie";
import request from "@/utils/request";
export default {
 data() {
  return {
   //path变量
   path: this.$route.path,
   role: "",
   userId: "",
   timer: null,
  };
 },
 //生命周期【当页面对象创建成功，触发的函数】
 created() {
  //获取manager信息
  var userJson = JSON.parse(Cookies.get("user"));
  this.role = Cookies.get("role");
  console.log("this.role="+this.role);
  this.userId = userJson.id;
  // 启动定时器，每5秒钟检查一次
  this.timer = setInterval(this.checkDatabaseChanges, 5000);
 },
 methods: {
  //获取数据库最新数据，持续更新cookie
  // checkDatabaseChanges() {
  //  //判断是哪种用户
  //  let url =
  //   this.role == "manager"
  //    ? "/manager/selectById"
  //    : this.role == "doctor"
  //    ? "/doctor/selectById"
  //    : "/user/selectById";
  //  // 通过请求获取最新的数据
  //  request
  //   .get(url, {
  //    params: {
  //     id: this.userId,
  //    },
  //   })
  //   //回调函数
  //   .then((res) => {
  //    if (res.flag == true) {
  //     //更新Cookie值
  //     Cookies.set("user", JSON.stringify(res.user), { expires: 0.3 });
  //    }
  //   });
  // },
  handleOpen(key, keyPath) {
   console.log(key, keyPath);
   console.log("打开");
  },
  handleClose(key, keyPath) {
   console.log(key, keyPath);
   console.log("关闭");
  },
 },
 beforeDestroy() {
  // 销毁定时器
  clearInterval(this.timer);
 },
};
</script>