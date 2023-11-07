<template>
    <div class="login">
          <!-- 登录表单 v-model -->
          <div class="login-form">
               <!-- :gutter="20" -->
               <el-row :gutter="20">
                    <el-col :span="12">
                         <div>
                              <img        src="../assets/logo.png"        alt=""        style="
            position: relative;
            left: -100px;
            width: 250px;
            height: 85px;
           "       />
                             </div>
                         <div style="position: relative; left: 50px">
                              <img src="../assets/icon-big.png" alt="" />
                             </div>
                        </el-col>
                    <el-col :span="2"></el-col>
                    <el-col :span="10">
                         <!-- 登录的form组件【提交的信息】 -->
                         <el-form       ref="loginForm"       :model="loginForm"      
                        style="margin-left: 150px; margin-top: 150px"     >
                              <el-form-item>
                                   <el-tabs         v-model="roleType"        
                                @tab-click="selectRole"         :stretch="true"       >
                                        <el-tab-pane label="用户登录" name="用户"></el-tab-pane>
                                        <el-tab-pane label="医生登录" name="医生"></el-tab-pane>
                                        <el-tab-pane label="管理员登录" name="管理员"></el-tab-pane>
                                       </el-tabs>
                                  </el-form-item>
                              <el-form-item prop="name" v-if="roleType === '管理员'">
                                   <el-input         prefix-icon="el-icon-user"        
                                v-model="loginForm.name"         type="text"         placeholder="账号"   
                                   >
                                       </el-input>
                                  </el-form-item>
                              <el-form-item prop="phone" v-if="roleType !== '管理员'">
                                   <el-input         prefix-icon="el-icon-user"        
                                v-model="loginForm.phone"         type="text"         placeholder="账号"   
                                   >
                                       </el-input>
                                  </el-form-item>
                              <el-form-item prop="password">
                                   <el-input         prefix-icon="el-icon-lock"        
                                v-model="loginForm.password"         autocomplete="off"        
                                show-password         placeholder="密码"       >
                                       </el-input>
                                  </el-form-item>
                              <el-form-item prop="code" v-if="captchaEnabled">
                                   <el-input         v-model="loginForm.code"        
                                placeholder="请输入验证码"         style="width: 63%"       >
                                       </el-input>
                                   <div class="login-code">
                                        <el-avatar          shape="square"         
                                    style="width: 100px"          :src="codeUrl"        ></el-avatar>
                                       </div>
                                  </el-form-item>
                              <el-form-item style="width: 100%">
                                   <el-button         size="medium"         type="primary"     
                                   style="width: 100%; background-color: rgb(77, 167, 252)"        
                                @click="doLogin()"       >
                                        <span style="font-size: 20px">登 录</span>
                                       </el-button>
                                  </el-form-item>
                              <el-form-item style="width: 100%">
                                   <el-button         size="medium"         type="primary"     
                                   style="width: 100%; background-color: rgb(77, 167, 252)"        
                                v-if="roleType == '用户'"         @click="registerFormVisible = true"       >
                                        <span style="font-size: 20px">注 册</span>
                                       </el-button>
                                  </el-form-item>
                             </el-form>
                         <!-- 登录的form组件【提交的信息】 -->
                        </el-col>
                   </el-row>
              </div>
          <!-- 用户注册表单 -->
          <el-dialog    title="用户注册"    :visible.sync="registerFormVisible"    :close-on-click-modal="false"  >
               <el-form     label-position="top"     :model="registerForm"     status-icon    
                ref="registerForm"     label-width="100px"     class="demo-registerForm"   >
                    <!-- 头像 -->
                    <el-form-item label="头像" prop="image">
                         <el-upload       class="avatar-uploader"      
                        action="http://localhost:8085/file/upload"       :show-file-list="false"      
                        :on-success="handleAvatarSuccess"       :before-upload="beforeAvatarUpload"     >
                              <img v-if="imageUrl" :src="imageUrl" class="avatar" />
                              <i v-else class="el-icon-plus avatar-uploader-icon"></i>
                             </el-upload>
                         <!-- 隐藏输入字段，用来存储图片的文件名 -->
                         <input type="hidden" name="avatar" v-model="registerForm.image" />
                        </el-form-item>
                    <!-- 用户名\性别 -->
                    <el-row :gutter="20">
                         <el-col :span="12">
                              <el-form-item label="用户名" prop="name">
                                   <el-input         type="text"         v-model="registerForm.name"
                                        autocomplete="off"       ></el-input>
                                  </el-form-item>
                             </el-col>
                         <el-col :span="12">
                              <el-form-item label="性别" prop="sex">
                                   <el-input         type="text"         v-model="registerForm.sex" 
                                       autocomplete="off"       ></el-input>
                                  </el-form-item>
                             </el-col>
                        </el-row>
                    <!-- 年龄\身份证号 -->
                    <el-row :gutter="20">
                         <el-col :span="12">
                              <el-form-item label="年龄" prop="age">
                                   <el-input         type="text"         v-model="registerForm.age" 
                                       autocomplete="off"       ></el-input>
                                  </el-form-item>
                             </el-col>
                         <el-col :span="12">
                              <el-form-item label="身份证号" prop="codeid">
                                   <el-input         type="text"        
                                v-model="registerForm.codeid"         autocomplete="off"       ></el-input>
                                  </el-form-item>
                             </el-col>
                        </el-row>
                    <!-- 密码\密码 -->
                    <el-row :gutter="20">
                         <el-col :span="12">
                              <el-form-item label="密 码" prop="password">
                                   <el-input         type="password"        
                                v-model="registerForm.password"         autocomplete="off"       ></el-input>
                                  </el-form-item>
                             </el-col>
                         <el-col :span="12">
                              <el-form-item label="确认密码" prop="password_check">
                                   <el-input         type="password"        
                                v-model="registerForm.password_check"         autocomplete="off"      
                                ></el-input>
                                  </el-form-item>
                             </el-col>
                        </el-row>
                    <!-- 手机号\地址 -->
                    <el-row :gutter="20">
                         <el-col :span="12">
                              <el-form-item label="手机号" prop="phone">
                                   <el-input         type="text"         v-model="registerForm.phone"
                                        autocomplete="off"       ></el-input>
                                  </el-form-item>
                             </el-col>
                         <el-col :span="12">
                              <el-form-item label="地址" prop="address">
                                   <el-input         type="text"        
                                v-model="registerForm.address"         autocomplete="off"       ></el-input>
                                  </el-form-item>
                             </el-col>
                        </el-row>
                    <el-form-item>
                         <el-button type="primary" @click="registerSumbit">提交</el-button>
                         <el-button       @click="
                             registerFormVisible = false;
                         this.registerForm = {
                             name: '',
                             password: '',
                             password_check: '',
                             phone: '',
                         };
                         "      >取消</el-button     >
                        </el-form-item>
                   </el-form>
              </el-dialog>
          <!-- 用户注册表单 -->
          <!-- 底部 -->
          <div class="el-login-footer">
               <span>Copyright © 2018-2022 gec All Rights Reserved.</span>
              </div>
          <!-- 底部 -->
         </div>
</template>
<script>
import router from "@/router";
//注意导入请求工具类和cookie
import Cookies from "js-cookie";
import request from "@/utils/request.js";
export default {
    name: "Login",
    data() {
        return {
            password_type: "password", //密码显示类型
            imageUrl: "", //头像上传路径
            codeUrl: "",
            loginForm: {
                //登录的表单数据
                name: "李平",
                phone: "12345645602",
                password: "123",
                code: "",
            },
            registerForm: {
                //注册的表单数据
                name: "",
                sex: "",
                age: "",
                password: "",
                password_check: "",
                image: "",
                codeid: "",
                phone: "",
                address: "",
            },
            loading: false,
            captchaEnabled: true,
            register: true,
            registerFormVisible: false,
            roleType: "用户",
        };
    },
    created() { 
        this.getCode();
    },
    methods: {
        
        getCode(){
            request.get("/captcha/getCaptcha").then((res)=>{
                console.log("res:",res);
                if(res.code == 200){
                    this.codeUrl = "data:image/jpg;base64," + res.imgStr;
                }
            })
        },

        //修改密码显示类型
        cho() {
            this.password_type = this.password_type == "text" ? "password" : "text";
        }, //选择哪个用户类型就显示那个类型
        selectRole() {
            console.log(this.roleType); // this.roleType = command;
        }, //登录的处理函数
        doLogin() {
      //通过请求对象发起一个异步请求操作【axios】
      request
        .post("/user/loginUser", this.loginForm) //第一个参数是请求地址、第二个参数提交的数据 //回调函数\获取服务器响应的结果
        .then((res) => {
          //如果成功flag
          if (res.flag == true) {
            this.$message.success("登录成功！"); //把user信息、角色信息存放在cookie中
            Cookies.set("user", JSON.stringify(res.user), { expires: 0.3 });
            Cookies.set("role", res.role, { expires: 0.3 }); 
            //通过路由跳转、登录成功后跳转到首页
            router.push("/Layout");
          } else {
            //登录失败提示信息
            this.$message.error(res.message);
          }
        });
    },
        registerSumbit() {
            //发起了异步请求
            request
                .post("/user/register", this.registerForm) //回调函数
                .then((res) => {
                    if (res.flag == true) {
                        this.$message.success("注册成功！");
                        this.registerFormVisible = false;
                        this.registerForm = {
                            name: "",
                            sex: "",
                            age: "",
                            password: "",
                            password_check: "",
                            image: "",
                            codeId: "",
                            phone: "",
                            address: "",
                        };
                        this.imageUrl = "";
                    } else {
                        //注册失败提示信息
                        this.$message.error(res.message);
                    }
                });
        }, //在上传成功后处理函数中，获取服务端返回的图片文件名或URL
        handleAvatarSuccess(res, file) {
            this.registerForm.image = res.fileName;
            this.imageUrl = URL.createObjectURL(file.raw);
        }, // 在上传之前，清空旧图片信息
        beforeAvatarUpload(file) {
            this.registerForm.image = "";
            this.imageUrl = "";
            const isJPG = file.type === "image/jpeg";
            const isLt2M = file.size / 1024 / 1024 < 2;
            if (!isJPG) {
                this.$message.error("上传头像图片只能是 JPG 格式!");
            }
            if (!isLt2M) {
                this.$message.error("上传头像图片大小不能超过 2MB!");
            }
            return isJPG && isLt2M;
        },
    },
};
</script>
       
<style>
.el-dialog {
    border-radius: 45px;
}

.login {
    position: absolute;
    width: 100%;
    height: 100%;
    overflow: hidden;
    background-image: url("../assets/1.png");
    background-size: 100% 100%;
    background-repeat: no-repeat;
    
}

.title {
    margin: 0px auto 30px auto;
    text-align: center;
    color: #707070;
}

.login-form {
    margin: 150px auto;
    background-image: url("../assets/beijing.png");
    border-radius: 45px;
    background-position: -35px, -35px;
    width: 1240px;
    height: 657px;
    /* padding: 25px 25px 5px 25px; */
}

.el-input {
    height: 38px;
}

input {
    height: 38px;
}

.input-icon {
    height: 39px;
    width: 14px;
    margin-left: 2px;
}

.login-tip {
    font-size: 13px;
    text-align: center;
    color: #bfbfbf;
}

.login-code {
    width: 33%;
    height: 38px;
    float: right;
}

.el-login-footer {
    height: 40px;
    line-height: 40px;
    position: fixed;
    bottom: 0;
    width: 100%;
    text-align: center;
    /* color: #fff; */
    font-family: Arial;
    font-size: 12px;
    letter-spacing: 1px;
}

.login-code-img {
    height: 38px;
}

.avatar-uploader .el-upload {
    /* border: 1px dashed #d9d9d9; */
    border: 1px solid black;
    border-radius: 6px;
    cursor: pointer;
    position: relative;
    overflow: hidden;
}

.avatar-uploader .el-upload:hover {
    border-color: #409eff;
}

.avatar-uploader-icon {
    font-size: 28px;
    color: #8c939d;
    width: 178px;
    height: 178px;
    line-height: 178px;
    text-align: center;
}

.avatar {
    width: 178px;
    height: 178px;
    display: block;
}
</style>