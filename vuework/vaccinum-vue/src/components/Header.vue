<template>
   <div
    style="
     height: 65px;
     line-height: 65px;
     border-bottom: 1px solid #ccc;
     background-color: #254175;
     display: flex;
    "
   >
    <div
     style="
      width: 200px;
      padding-left: 30px;
      font-weight: bold;
      color: dodgerblue;
     "
    >
     <img
      src="../assets/logo-06.png"
      style="width: 200px; height: 50px; padding-top: 5px"
      alt=""
     />
    </div>
    <div style="flex: 1"></div>
    <div style="width: 250px">
     <el-dropdown @command="handleCommand">
      <span class="el-dropdown-link">
       <el-row :gutter="5">
        <el-col :span="12" style="padding-top: 9px;"><el-avatar :src="image" shape="square" :size="50"></el-avatar></el-col>
        <el-col :span="9" style="color:#fff;font-weight: bold;">{{ name }}</el-col>
        <el-col :span="3" style="color:#fff;font-weight: bold;"><i class="el-icon-arrow-down el-icon--right"></i></el-col>
       </el-row>
      </span>
      <el-dropdown-menu slot="dropdown">
       <el-dropdown-item command="a" v-if="role !== 'manager'"
        >个人信息</el-dropdown-item
       >
       <el-dropdown-item command="b">退出系统</el-dropdown-item>
      </el-dropdown-menu>
     </el-dropdown>
    </div>
   </div>
  </template>
    
    <script>
  import router from "@/router";
  import Cookies from "js-cookie";
  export default {
   name: "Header",
   data() {
    return {
     name: "未登录",
     image: "",
     role: "",
    };
   },
   created() {
    //获取登录用户信息
    var userJson = JSON.parse(Cookies.get("user"));
    this.name = userJson.name;
    this.image = userJson.image;
    this.role = Cookies.get("role");
   },
   methods: {
    handleCommand(command) {
     if (command == "b") {
      Cookies.remove("user");
      //跳转到登录
      router.push("/login");
     } else {
      //跳转到个人信息
      router.push("/Layout/personalInfo");
     }
    },
   },
  };
  </script>