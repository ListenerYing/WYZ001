<template>
  <div>




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
          :page-sizes="[5, 10, 15, 20]"
          :page-size="pageSize"
          layout="total, sizes, prev, pager, next, jumper"
          :total="total">
      </el-pagination>
    </div>

  </div>
</template>

<script>

export default {
  name: "Result.vue",
  data(){
    return{
      tableData: [],
      pageNum: 1,
      pageSize: 5,
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
    }
  }

}
</script>

<style scoped>

</style>
