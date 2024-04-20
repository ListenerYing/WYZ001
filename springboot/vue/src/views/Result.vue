<template>
  <div>
    <template>
      <div class="handle-box" v-if="user.role === 'admin'">
        <el-button type="success" style="border-radius: 4px; margin-right: 10px;" @click="exportXlsx">导出Excel</el-button>

        <el-tooltip class="item" effect="dark" content="随机给学生分配一个还有招生名额的老师" placement="top">
          <el-button type="danger" style="border-radius: 4px; margin-right: 10px;" @click="assign">一键分配</el-button>
        </el-tooltip>

        <el-tooltip class="item" effect="dark" content="基于学生自述与老师要求的文本匹配度进行智能匹配" placement="top">
          <el-button type="danger" style="border-radius: 4px;" @click="assign2">智能分配</el-button>
        </el-tooltip>
      </div>
    </template>



    <el-table :data="tableData" border stripe @selection-change="handleSelectionChange">


<!--      <el-table-column prop="id" label="ID" width="80">-->
<!--      </el-table-column>-->
      <el-table-column prop="学号" label="学号" width="140">
      </el-table-column>
      <el-table-column prop="姓名" label="姓名" width="120">

      </el-table-column>
      <el-table-column prop="导师姓名" label="导师姓名" width="120">
      </el-table-column>
      <el-table-column prop="导师邮箱" label="导师邮箱" width="170">
      </el-table-column>



    </el-table>
    <div style="padding: 10px 0">
      <el-pagination
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
          :current-page="pageNum"
          :page-sizes="[5, 10, 15, 20,100]"
          :page-size="pageSize"
          layout="total, sizes, prev, pager, next, jumper"
          :total="total">
      </el-pagination>
    </div>

  </div>
</template>

<script>
import { saveAs } from 'file-saver';
import * as XLSX from 'xlsx';
export default {
  name: "Result.vue",
  data(){
    return{
      user:localStorage.getItem("user") ? JSON.parse(localStorage.getItem("user")) : {},
      tableData: [],
      pageNum: 1,
      pageSize: 20,
      username:"",
      email:"",
      total:0,
      dialogFormVisible:false,
      form:{},
      multipleSelection:[]
    }
  },
  created() {
    this.load()
  },
  methods:{
    load() {
      this.request.get("/user/page/result",{
        params:{
          pageNum:this.pageNum,
          pageSize:this.pageSize
        }
      }).then(res =>{
        console.log(res)
        this.tableData=res.data.records
        this.total=res.data.total
      })
    },
    handleSelectionChange(val){
      console.log(val)
      this.multipleSelection=val
    },

    handleSizeChange(pageSize){
      console.log(pageSize)
      this.pageSize=pageSize
      this.load()
    },
    handleCurrentChange(pageNum){
      console.log(pageNum)
      this.pageNum=pageNum
      this.load()
    },
    exportXlsx() {
      // 将JSON对象数组转化为二维数组
      const data = this.tableData.map(row => Object.values(row)),
          // 加入表头
          headers = ['','学号', '姓名', '导师姓名', '导师邮箱'],
          worksheet = XLSX.utils.aoa_to_sheet([headers].concat(data)),
          workbook =XLSX.utils.book_new();
      // 将工作表添加到工作簿中
      XLSX.utils.book_append_sheet(workbook, worksheet, 'Sheet1');
      // 生成Excel文件的二进制字符串
      const wbout = XLSX.write(workbook, { bookType: 'xlsx', type: 'binary' });
      // 把二进制字符串转换为字符数组
      function s2ab(s) {
        const buf = new ArrayBuffer(s.length);
        const view = new Uint8Array(buf);
        for (let i = 0; i < s.length; i++) view[i] = s.charCodeAt(i) & 0xFF;
        return buf;
      }
      // 利用file-saver保存文件
      saveAs(new Blob([s2ab(wbout)], { type: "application/octet-stream" }), "result.xlsx");
    },
    assign() {
      this.request.get('/student/assign')
          .then(res => {
            // 根据响应结果显示提示
            if (res.data) {
              this.$message.success('导师分配成功');
              // 分配成功后重新载入数据
              this.load();
            } else {
              // 如果响应结果不是预期的成功码，提醒用户分配失败
              this.$message.error('导师分配失败');
            }
          })
          .catch(error => {
            // 如果请求失败，提示用户
            console.error('分配请求失败: ', error);
            this.$message.error('分配请求失败: ' + error.message);
          });
    },
    assign2() {
      this.request.get('/match/assign')
          .then(res => {
            // 根据响应结果显示提示
            if (res.data===null) {
              this.$message.success('导师分配成功');
              // 分配成功后重新载入数据
              this.load();
            } else {
              // 如果响应结果不是预期的成功码，提醒用户分配失败
              this.$message.error('分配失败');
            }
          })
          .catch(error => {
            // 如果请求失败，提示用户
            console.error('分配请求失败: ', error);
            this.$message.error('分配请求失败: ' + error.message);
          });
    },
  }

}

</script>

<style scoped>
.handle-box {
  margin-bottom: 20px; /* 添加了一行 */
  display: flex;
  align-items: center;
  justify-content: start;
}
/*.handle-box {*/
/*  display: flex;*/
/*  align-items: center;*/
/*  justify-content: start;*/
/*}*/

.el-button {
  margin-right: 10px; /* 控制按钮之间的间距 */
}

.el-button:last-child {
  margin-right: 0; /* 最后一个按钮不需要右边距 */
}
</style>
