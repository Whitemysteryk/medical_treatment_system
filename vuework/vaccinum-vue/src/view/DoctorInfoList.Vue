<template>
    <div>
        <div style="margin: 20px 0px;">
            <el-row>
                <el-col :span="10" class="center">
                    <el-input v-model="search" @focus="focus" @blur="blur" @keyup.enter.native="searchHandler"
                        placeholder="搜索医生名称" clearable>
                        <el-button slot="append" icon="el-icon-search" id="search" @click="searchHandler"></el-button>
                    </el-input>
                    <!---设置z-index优先级,防止被走马灯效果遮挡-->
                    <el-card @mouseenter="enterSearchBoxHanlder" v-if="isSearch" class="box-card" id="search-box"
                        style="position:absolute;z-index:15">
                        <dl v-if="isHistorySearch">
                            <dt class="search-title" v-show="history">历史搜索</dt>
                            <dt class="remove-history" v-show="history" @click="removeAllHistory">
                                <i class="el-icon-delete"></i>清空历史记录
                            </dt>
                            <el-tag v-for="search in historySearchList" :key="search.id" closable :type="search.type"
                                @close="closeHandler(search)" @click="searchistory(search)"
                                style="margin-right:5px; margin-bottom:5px;">{{ search.name }}</el-tag>
                            <dt class="search-title">热门搜索</dt>
                            <dd v-for="search in hotSearchList" :key="search.id">{{ search }}</dd>
                        </dl>
                        <dl v-if="isSearchList">
                            <dd v-for="search in searchList" :key="search.id">{{ search }}</dd>
                        </dl>
                    </el-card>
                </el-col>
            </el-row>
            <el-dialog title="简介" :visible.sync="introductionDialog" width="30%">
                <el-form ref="form" :model="form" label-width="80px">
                    <el-form-item label="头像">
                        <!-- action表示为上传文件的url   -->
                        <el-upload class="avatar-uploader">
                            <img v-if="imageUrl" :src="imageUrl" class="avatar" />
                            <i v-else class="el-icon-plus avatar-uploader-icon"></i>
                        </el-upload>
                    </el-form-item>
                    <el-form-item label="姓名">
                        <h2>{{ form.name }}</h2>
                    </el-form-item>
                    <el-form-item label="个人简介">
                        <p>{{ form.introduction }}</p>
                    </el-form-item>
                </el-form>
            </el-dialog>
            <el-dialog title="预约" :visible.sync="appointmentDialog1" width="40%">
                <el-calendar v-model="value">
                    <div slot="dateCell" slot-scope="{ data }" @click="allcalendar(data)" class="temp">
                        <span>{{ data.day.split("-")[2] }}</span>
                    </div>
                </el-calendar>
            </el-dialog>
            <el-dialog title="预约" :visible.sync="appointmentDialog2" width="40%">
                    <el-table :data="bookTime" style="width: 100%">
                        <el-table-column label="日期" width="180">
                            <template slot-scope="scope">
                                <i class="el-icon-time"></i>
                                <span style="margin-left: 10px">{{ scope.row.time }}</span>
                            </template>
                        </el-table-column>
                        <el-table-column label="剩余" width="180">
                            <template slot-scope="scope">
                                <el-popover trigger="hover" placement="top">
                                    <p>人数: {{ scope.row.Remain }}</p>
                                    <div slot="reference" class="name-wrapper">
                                        <el-tag size="medium">{{ scope.row.Remain }}</el-tag>
                                    </div>
                                </el-popover>
                            </template>
                        </el-table-column>
                        <el-table-column label="操作">
                            <template slot-scope="scope">
                                <el-button size="mini" @click="handleBooktime(scope.$index, scope.row)">预约</el-button>
                            </template>
                        </el-table-column>
                    </el-table>
            </el-dialog>
        </div>
        <el-table :data="tableData" border style="width: 100%">
            <el-table-column prop="major" label="科室" sortable width="180" column-key="date" :filters="[{ text: '内科', value: '内科' },
            { text: '妇科', value: '妇科专业' },
            { text: '儿科', value: '儿科' },
            { text: '外科', value: '外科手术' }]" :filter-method="filterHandler">
            </el-table-column>
            <el-table-column prop="host_id" label="医生编号" width="120">
            </el-table-column>
            <el-table-column prop="name" label="医生名称" width="120">
            </el-table-column>
            <el-table-column prop="image" label="医生帅照" width="120">
            </el-table-column>
            <el-table-column prop="phone" label="电话" width="300">
 

            </el-table-column>
            <el-table-column fixed="right" label="操作" width="100">
                <template slot-scope="scope">
                    <el-button @click="handleCheck(scope.row)" type="text" size="small">查看</el-button>
                    <el-button @click="handleBook(scope.row)" type="text" size="small">预约</el-button>
                </template>
            </el-table-column>
        </el-table>
        <!-- 定义一个分页标签 -->
        <div>
            <el-pagination @size-change="handleSizeChange" @current-change="handleCurrentChange" :current-page="pageNum"
                :page-sizes="[3, 8, 15, 30]" :page-size="3" layout="total, sizes, prev, pager, next, jumper" :total="total">
            </el-pagination>
        </div>
    </div>
</template>
  
<script>
import RandomUtil from "../utils/randomUtil";
import Store from "../utils/store";
//导入request工具
import request from "@/utils/request";
export default {
    data() {
        return {
            search: "", //当前输入框的值
            isFocus: false, //是否聚焦
            hotSearchList: ["暂无热门搜索"], //热门搜索数据
            historySearchList: [], //历史搜索数据
            searchList: ["暂无数据"], //搜索返回数据,
            history: false,
            bookDoctor: '',
            bookTime: [
                {
                    time: "8:00~9:00",
                    Remain: 3,
                },
            ],
            introductionDialog: false,
            appointmentDialog1: false,
            appointmentDialog2: false,
            total: 0,
            pageNum: 1,
            pageSize: 3,
            value: new Date(),
            imageUrl: 'https://cube.elemecdn.com/6/94/4d3ea53c084bad6931a56d5158a48jpeg.jpeg',
            types: ["", "success", "info", "warning", "danger"], //搜索历史tag式样
            tableData: [
            ],
            form: {
                doctorId: '',
                department: '',
                name: '',
                province: '',
                city: '',
                address: '',
                culture: '',
                phone: '',
                image: '',
                sex: '',
                age: '',
                introduction: '',
            },
        };
    },
    created() {
        this.query();
    },
    methods: {
        focus() {
            this.isFocus = true;
            this.historySearchList =
                Store.loadHistory() == null ? [] : Store.loadHistory();
            this.history = this.historySearchList.length == 0 ? false : true;
        },
        blur() {
            var self = this;
            this.searchBoxTimeout = setTimeout(function () {
                self.isFocus = false;
            }, 300);
        },
        enterSearchBoxHanlder() {
            clearTimeout(this.searchBoxTimeout);
        },
        searchHandler() {
            //随机生成搜索历史tag式样
            let n = RandomUtil.getRandomNumber(0, 5);
            //发起一个异步请求，查询分类的数据
            request
                // get表示指定请求地址 和 请求参数
                .get("/vaccinum/doctor/SerchByName", {
                    params: {
                        pageNum: this.pageNum,
                        pageSize: this.pageSize,
                        name: this.search,
                    },
                })
                // then表示请求后的回调函数
                .then((res) => {
                    console.log(res);
                    // 把后台的响应的数据赋值给data中的tableData
                    this.tableData = res.list;
                    this.form = res.list;
                    this.total = res.total;
                });
            let exist =
                this.historySearchList.filter(value => {
                    return value.name == this.search;
                }).length == 0
                    ? false
                    : true;
            if (!exist) {
                this.historySearchList.push({ name: this.search, type: this.types[n] });
                Store.saveHistory(this.historySearchList);
            }
            this.history = this.historySearchList.length == 0 ? false : true;
        },
        closeHandler(search) {
            this.historySearchList.splice(this.historySearchList.indexOf(search), 1);
            Store.saveHistory(this.historySearchList);
            clearTimeout(this.searchBoxTimeout);
            if (this.historySearchList.length == 0) {
                this.history = false;
            }
        },
        searchistory(search) {
            this.search = search.name;
        },
        removeAllHistory() {
            Store.removeAllHistory();
        },
        // 重载方法
        query() {
            //发起一个异步请求，查询分类的数据
            request
                // get表示指定请求地址 和 请求参数
                .get("/vaccinum/doctor/list", {
                    params: {
                        pageNum: this.pageNum,
                        pageSize: this.pageSize,
                    },
                })
                // then表示请求后的回调函数
                .then((res) => {
                    console.log(res);
                    // 把后台的响应的数据赋值给data中的tableData
                    this.tableData = res.list;
                    this.form = res.list;
                    this.total = res.total;
                });

        },
        handleCheck(row) {
            console.log(row);
            this.introductionDialog = true;
            this.doctorId = row.doctorId;
            this.form.department = row.department;
            this.form.name = row.name;
            this.form.province = row.province;
            this.form.city = row.city;
            this.form.address = row.address;
            this.form.culture = row.culture;
            this.form.phone = row.phone;
            this.form.image = row.image;
            this.form.introduction = row.introduction;
        },
        handleBook(row) {
            console.log(row);
            this.bookDoctor = row.name;
            this.appointmentDialog1 = true;
        },
        handleBooktime(index,row){
            // TODO 向后端发送用户提交的预约信息
            console.log(row.time);
            this.bookTime[index].Remain=this.bookTime[index].Remain-1;

        },
        //筛选功能实现函数
        resetDateFilter() {
            this.$refs.filterTable.clearFilter('date');
        },
        clearFilter() {
            this.$refs.filterTable.clearFilter();
        },
        formatter(row, column) {
            return row.address;
        },
        filterTag(value, row) {
            return row.tag === value;
        },
        filterHandler(value, row, column) {
            const property = column['property'];
            return row[property] === value;
        },
        //修改单页数据数量
        handleSizeChange(val) {

            this.pageSize = val;
            this.query();
        },
        //跳转页码
        handleCurrentChange(val) {
            console.log(val);
            this.pageNum = val;
            this.query();
        },
        // 日历触发事件
        allcalendar(data) {
            const loading = this.$loading({
                // lock: true,  //加上这个 页面点击日历的时候会莫名其妙抖动一下 因为我界面上有滚动条，所以我注释了
                text: "Loading",
                spinner: "el-icon-loading",
                background: "rgba(0, 0, 0, 0.7)",
            });
            setTimeout(() => {
                this.value = data.day; //取到你需要的日期data.day
                //需要用到这日期做啥事，比如做为调接口的参数
                request
                    // get表示指定请求地址 和 请求参数
                    .get("/doctor/freetime", {
                        params: {
                            name: this.bookDoctor,
                            date: data.day,
                        },
                    })
                    // then表示请求后的回调函数
                    .then((res) => {
                        console.log(res);
                    });
                this.appointmentDialog1 = false;
                this.appointmentDialog2 = true;
                loading.close();
            }, 500);
        },
    },
    computed: {
        isHistorySearch() {
            return this.isFocus && !this.search;
        },
        isSearchList() {
            return this.isFocus && this.search;
        },
        isSearch() {
            return this.isFocus;
        }
    },
   
};
    
</script>
  
<style>
.left {
    margin-left: 200px;
}

.center {
    margin-top: 15px;
    margin-left: 200px;
}

#search {
    background-color: #616cee;
    border-radius: 0%;
}

.search-title {
    color: #bdbaba;
    font-size: 15px;
    margin-bottom: 5px;
}

.remove-history {
    color: #bdbaba;
    font-size: 15px;
    float: right;
    margin-top: -22px;
}

#search-box {
    width: 555px;
    height: 300px;
    margin-top: 0px;
    padding-bottom: 20px;
}

.avatar-uploader .el-upload {
    border: 1px dashed #d9d9d9;
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

.temp {
    padding: 20px;
}
</style>