<template>
  <div>
    <div class="handle-box">
      <el-button type="primary" @click="exportXlsx">导出Excel</el-button>
    </div>



    <el-table :data="tableData" border stripe @selection-change="handleSelectionChange">


<!--      <el-table-column prop="id" label="ID" width="80">-->
<!--      </el-table-column>-->
      <el-table-column prop="学号" label="学号" width="140">
      </el-table-column>
      <el-table-column prop="姓名" label="姓名" width="120">

      </el-table-column>
      <el-table-column prop="导师姓名" label="导师姓名">
      </el-table-column>
      <el-table-column prop="导师邮箱" label="导师邮箱">
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
  }

}

</script>

<style scoped>

</style>
