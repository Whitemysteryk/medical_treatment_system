<template>
    <div style="width: 100%">
      <div class="top_div">
        <!-- 模糊查询表单 -->
        <el-form
          :inline="true"
          class="demo-form-inline"
          style="padding-top: 22px"
        >
          <!--批量删除、新增按钮-->
          <el-form-item v-if="role == 'manager' || role == 'nurse'">
            <el-popconfirm
              title="删除后无法恢复，确定吗？"
              icon-color="red"
              @confirm="batch_delete()"
            >
              <el-button slot="reference" plain type="danger">批量删除</el-button>
            </el-popconfirm>
          </el-form-item>
          <el-form-item>
            <el-input
              v-model="name"
              placeholder="请输入疫苗种类名关键字"
            ></el-input>
          </el-form-item>
          <el-form-item>
            <el-button
              type="primary"
              style="background-color: #254175"
              @click="selectPage"
              >查询</el-button
            >
            <el-button
              type="primary"
              style="background-color: #254175"
              @click="addOperate"
              >新增</el-button
            >
          </el-form-item>
        </el-form>
      </div>
      <div class="botoom_div">
        <!-- 疫苗种类信息展示表格 -->
        <el-table
          :data="tableData"
          style="width: 100%"
          @selection-change="handleSelectionChange"
        >
          <!-- 复选框 -->
          <el-table-column
            type="selection"
            width="55"
            v-if="role == 'manager' || role == 'nurse'"
          ></el-table-column>
          <el-table-column prop="id" label="种类编号"> </el-table-column>
          <el-table-column prop="name" label="种类名称" sortable>
          </el-table-column>
          <el-table-column prop="remark" label="介绍">
            <template #default="scope">
              <el-popover
                placement="top-start"
                width="100"
                trigger="click"
                :content="scope.row.remark"
              >
                <el-button slot="reference" class="ellipsis-button">{{
                  scope.row.remark
                }}</el-button>
              </el-popover>
            </template>
          </el-table-column>
          <!-- v-if="role == 'manager' || role == 'nurse'" -->
          <el-table-column prop="status" label="状态">
            <template #default="scope">
              <el-tag type="success" v-if="scope.row.status == 1">正常</el-tag>
              <el-tag type="danger" v-if="scope.row.status == 0">禁用</el-tag>
            </template>
          </el-table-column>
          <!-- v-if="role == 'manager' || role == 'nurse'" -->
          <el-table-column label="管理">
            <template #default="scope">
              <el-button
                size="small"
                v-if="scope.row.status == 1"
                type="danger"
                @click="updateStatus(scope.row)"
                >禁用</el-button
              >
              <el-button
                size="small"
                v-if="scope.row.status == 0"
                type="success"
                @click="updateStatus(scope.row)"
                >启用</el-button
              >
            </template>
          </el-table-column>
          <!-- v-if="role == 'manager' || role == 'nurse'" -->
          <el-table-column label="操作">
            <template #default="scope">
              <el-button size="small" @click="handleEdit(scope.$index, scope.row)"
                >修改</el-button
              >
              <el-popconfirm
                title="删除后无法恢复，确定吗？"
                icon-color="red"
                @confirm="handleDelete(scope.$index, scope.row)"
              >
                <el-button slot="reference" size="small" type="danger"
                  >删除</el-button
                >
              </el-popconfirm>
            </template>
          </el-table-column>
        </el-table>
        <!-- 添加-修改表单 -->
        <el-dialog
          :title="!vaccineType.id ? '疫苗种类-添加' : '疫苗种类-修改'"
          :visible.sync="formVisible"
          :close-on-click-modal="false"
        >
          <el-form
            :model="vaccineType"
            status-icon
            :rules="rules"
            ref="addType"
            label-width="50px"
            class="demo-vaccineType"
          >
            <el-form-item label="编号" prop="id" v-if="vaccineType.id">
              <el-input v-model="vaccineType.id" disabled></el-input>
            </el-form-item>
            <el-form-item label="种类名" prop="name">
              <el-input
                type="text"
                v-model="vaccineType.name"
                autocomplete="off"
              ></el-input>
            </el-form-item>
            <el-form-item label="介绍" prop="remark">
              <el-input
                type="textarea"
                v-model="vaccineType.remark"
                autocomplete="off"
              ></el-input>
            </el-form-item>
            <el-form-item>
              <el-button type="primary" @click="submitForm('addType')"
                >提交</el-button
              >
              <el-button @click="formVisible = false">取消</el-button>
            </el-form-item>
          </el-form>
        </el-dialog>
      </div>
    </div>
  </template>
      <script>
  //导入request工具
  import request from "@/utils/request";
  import Cookies from "js-cookie";
  export default {
    data() {
      return {
        role: "",
        name: "", //模糊查询数据 //表格数据
        tableData: [],
        ids: [], //根据id批量删除存放的容器
        vaccineType: {
          id: "",
          name: "",
          remark: "",
        },
        rules: {
          name: [
            { required: true, message: "请输入疫苗种类名称", trigger: "blur" },
          ],
          remark: [
            { required: true, message: "请输入疫苗种类介绍", trigger: "blur" },
          ],
        },
        formVisible: false,
      };
    }, //当vue创建后，发起请求查询数据
    created() {
      if (Cookies.get("user")) {
        //获取登录用户角色
        var userJson = JSON.parse(Cookies.get("user"));
        this.role = userJson.role;
      }
      this.selectPage();
    },
    methods: {
      //分页-模糊查询函数
      selectPage() {
        //发送请求
        request
          .get("/vaccinetype/query", {
            params: {
              name: this.name,
            },
          })
          .then((res) => {
            //处理响应
            if (res.flag == false) {
              //查询失败
              this.$message.error(res.message);
            } else {
              this.$message.success("查询成功"); //将查询到的数据赋值到当前tableData中
              this.tableData = res.list;
            }
          });
      }, //当复选框状态改变时，自动调用该函数，将复选框选中的行的数据id存入ids数组中
      handleSelectionChange(selection) {
        //遍历selection数组，存储id值
        this.ids = selection.map((item) => item.id);
      }, //批量删除函数
      batch_delete(index, row) {
        if (this.ids != "") {
          request
            .get("/vaccinetype/batchDelete", {
              params: {
                ids: this.ids.toString(),
              },
            })
            .then((res) => {
              //处理响应
              if (res.flag == false) {
                //删除失败
                this.$message.error(res.message);
              } else {
                this.$message.success("删除成功");
                this.selectPage();
              }
            });
        } else {
          this.$message.error("请先选择需要删除的数据！");
        }
      }, //删除函数
      handleDelete(index, row) {
        request
          .get("/vaccinetype/delete", {
            params: {
              //参数
              id: row.id,
            },
          })
          .then((res) => {
            //处理响应
            if (res.flag == false) {
              //删除失败
              this.$message.error(res.message);
            } else {
              this.$message.success("删除成功");
              this.selectPage();
            }
          });
      }, //每页展示多少条
      handleSizeChange(val) {
        this.pageSize = val;
        this.selectPage();
      }, //当前页为多少页
      handleCurrentChange(val) {
        this.currentPage = val;
        this.selectPage();
      }, //打开添加表单
      addOperate() {
        this.formVisible = true; //对该表单项进行移除校验结果
        this.$refs.addType.resetFields();
        this.vaccineType = {
          id: "",
          name: "",
          remark: "",
        };
      }, //修改-添加表单提交函数
      submitForm(formName) {
        //validate校验代码
        this.$refs[formName].validate((valid) => {
          // ok--通过校验
          if (valid) {
            if (this.vaccineType.id) {//id存在则是进行修改操作
              request
                .post("/vaccinetype/update", this.vaccineType)
                .then((res) => {
                  if (res.flag == false) {
                    //修改失败
                    this.$message.error(res.message);
                    // 查询方法
                    this.selectPage();
                  } else {
                    //修改成功
                    this.formVisible = false;
                    this.$message.success("修改成功");
                    this.vaccineType = {
                      id: "",
                      name: "",
                      remark: "",
                    };
                    this.selectPage();
                  }
                });
            } else {//id不存在则是进行添加操作
              //发送请求
              request
                .post("/vaccinetype/insert", this.vaccineType)
                .then((res) => {
                  //处理响应
                  if (res.flag == false) {
                    //添加失败
                    this.$message.error(res.message);
                  } else {
                    this.$message.success("添加成功"); //关闭模态框
                    this.formVisible = false; //清空数据
                    this.vaccineType = {
                      id: "",
                      name: "",
                      remark: "",
                    }; //重新查询数据
                    this.selectPage();
                  }
                });
            }
          }
        });
      }, // 打开修改表单函数
      handleEdit(index, row) {
        //打开嵌套表单的修改对话框
        this.formVisible = true; //将数据进行回显
        this.vaccineType.id = row.id;
        this.vaccineType.name = row.name;
        this.vaccineType.remark = row.remark; //对该表单项进行移除校验结果 // this.$refs.addType.clearValidate();
      },
    },
  };
  </script>
      <style>
  .top_div {
    border-radius: 15px;
    box-shadow: rgba(0, 0, 0, 0.32) 0px 2px 5px;
    margin-bottom: 50px;
    background-color: #fff;
  }
  .botoom_div {
    border-radius: 15px;
    padding-top: 25px;
    padding-bottom: 25px;
    box-shadow: rgba(0, 0, 0, 0.32) 0px 2px 5px;
    margin-bottom: 50px;
    background-color: #fff;
  }
  .ellipsis-button {
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
    height: 50px;
    max-width: 200px;
    /* 假设按钮最大宽度为100px，根据需要进行调整 */
  }
  </style>