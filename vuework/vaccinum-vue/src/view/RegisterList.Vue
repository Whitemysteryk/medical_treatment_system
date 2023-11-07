<template>
    <div>

        <div style="box-shadow: 0 2px 4px rgba(0, 0, 0, .12), 0 0 6px rgba(0, 0, 0, .04);height: 30px; padding-top: 1%;">
            <el-breadcrumb separator="/">
                <el-breadcrumb-item :to="{ path: '/' }">首页</el-breadcrumb-item>
                <el-breadcrumb-item><a href="/">医生模块</a></el-breadcrumb-item>
                <el-breadcrumb-item>挂号记录查询</el-breadcrumb-item>
            </el-breadcrumb>
        </div>

        <!-- 顶部搜索栏 -->
        <div style="display: flex; align-items: center; margin-left: 40%; margin-top: 2%;">

            <el-input v-model="input" placeholder="请输入挂号订单编号快速查询" ></el-input>
            <el-button type="primary" icon="el-icon-search" @click = "queryById">搜索</el-button>
        </div>

        <div
            style="margin: 0 auto; width: 63%;  box-shadow: 0 2px 4px rgba(0, 0, 0, .12), 0 0 6px rgba(0, 0, 0, .04); margin-top: 2%;">
            <!-- 表格展示数据 -->
            <el-table :data="tableData" border style="width: 100%">
                <el-table-column fixed prop="id" label="挂号订单编号" width="150">
                </el-table-column>
                <el-table-column prop="UserName" label="病号名称" width="120">
                </el-table-column>
                <el-table-column prop="registration_time" label="订单时间" width="120">
                </el-table-column>
                <el-table-column prop="status" label="病历单状态" width="300">
                </el-table-column>
                <el-table-column prop="doctorName" label="负责医生" width="120">
                </el-table-column>

                <el-table-column fixed="right" label="操作" width="250" >
                    <template slot-scope="scope">

                        <!-- 通过按键打开内容 -->
                        <el-button type="info" @click="centerDialogVisible = true" style="width: 120px;">病情详细信息</el-button>

                        <el-dialog title="病例详细描述" :visible.sync="centerDialogVisible" width="30%" center>
                            <span>{{discription}}</span>
                            <span slot="footer" class="dialog-footer">
                                <el-button @click="centerDialogVisible = false">取 消</el-button>
                                <el-button type="primary" @click="centerDialogVisible = false">确 定</el-button>
                            </span>
                        </el-dialog>
                        <!-- 撤回按钮 -->
                        <el-popconfirm title="你确定要撤回预约挂号记录吗？">
                            <el-button type="danger" slot="reference" disabled>撤回</el-button>
                        </el-popconfirm>
                    </template>
                </el-table-column>
            </el-table>
        </div>
        <!-- 分页标签 -->
        <div class="block">
            <el-pagination @size-change="handleSizeChange" @current-change="handleCurrentChange"
                :current-page.sync="currentPage2" :page-sizes="[8, 10, 12]" :page-size="pageSize"
                layout="sizes, prev, pager, next" :total="tableData.length">
            </el-pagination>
        </div>

    </div>
</template>
<script>
//导入request工具
import request from "@/utils/request";


export default {
    methods: {
        handleClick(row) {
            console.log(row);
        },
//      实现根据挂号记录id查询挂号功能
        queryById(){
            request
            // 这里设置功能根据id查询对应的用户
            .get("/",{
                params:{
                    id : this.input,
                }
            }).then((res)=>{
                // 将后台数据返回到表单中
                this.tableData = res.list;
                if(res.flag == false){
                    this.$message.error("查询失败");
                }else{
                    this.$message.success("查询成功");
                }
            })
        },

//      查询所有挂号记录功能
        query(){
            request
            // 对应后端路径
            .get("/",{
                // 发送分页参数
                params:{
                    currentPageNum: this.currentPageNum,
                    pageSize: this.pageSize,
                }
            }).then((res)=>{
                this.tableData = res.list;
                this.total = res.total;
            })
        },
//      分页函数处理
    handleSizeChange(val){
        console.log(val);
        this.pageSize = val;
        this.query();
    },
    handleCurrentChange(val){
        console.log(val);
        this.currentPage = val;
        this.query();
    },

//      查询挂号记录中用户的病情
    
    },


//  Vue的生命周期周期
    created() {
    // 在访问网页时候就进行get请求请求所有挂号记录
    this.query()
    },


//  Vue 数据存放处
    data() {
        return {
            tableData: [{
                id: '1',
                UserName: '王小虎',
                registration_time: '2023-10-22',
                status: '已处理',
                doctorName: '陈志平',
            },],
            centerDialogVisible: false,

//          存放默认分页
            currentPageNum:1,
            pageSize:8,
//          存放病情描述
            discription:"我测你们码",
            
        }
    }
}

</script>
<style>
.el-input {
    width: 25%;
}
</style>