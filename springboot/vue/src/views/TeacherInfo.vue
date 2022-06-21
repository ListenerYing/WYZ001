<template>
  <div>
    <div style="padding: 10px 0">
      <el-input  style="width: 200px;margin-left: 5px" placeholder="请输入名称" suffix-icon="el-icon-search" v-model="username"></el-input>
      <el-button style="margin-left: 5px" type="primary" icon="el-icon-search" @click="load">搜索</el-button>
      <el-button style="margin-left: 5px" type="warning" @click="reset">重置</el-button>
    </div>
    <div style="margin: 10px 0">
      <el-button type="primary" icon="el-icon-circle-plus" @click="handleAdd">新增</el-button>
      <el-popconfirm
          confirm-button-text='确定'
          cancel-button-text='我再想想'
          icon="el-icon-info"
          icon-color="red"
          title="您确定批量删除这条记录吗？"
          @confirm="delBatch"
      >
        <el-button type="danger" icon="el-icon-remove-outline" slot="reference">批量删除</el-button>
      </el-popconfirm>
      <el-button type="primary" icon="el-icon-share" style="margin-left: 10px">导出</el-button>
      <el-button type="primary">导入<i class="el-icon-upload el-icon--right"></i></el-button>

    </div>
    <el-table :data="tableData" border stripe @selection-change="handleSelectionChange">
      <el-table-column
          type="selection"
          width="55"
      >
      </el-table-column>
      <el-table-column prop="id" label="ID" width="80">
      </el-table-column>
      <el-table-column prop="username" label="工号" width="140">
      </el-table-column>
      <el-table-column prop="nickname" label="姓名" width="120">
      </el-table-column>
      <el-table-column prop="email" label="邮箱">
      </el-table-column>
      <el-table-column prop="phone" label="电话">
      </el-table-column>
      <el-table-column prop="address" label="地址">
      </el-table-column>
      <el-table-column label="操作" width="200" align="center">
        <template slot-scope="scope">
          <el-button type="info"  @click="handleDetail(scope.row.id)">查看详情</el-button>
          <el-popconfirm
              confirm-button-text='确定'
              cancel-button-text='我再想想'
              icon="el-icon-info"
              icon-color="#67C23A"
              title="确定选择这位导师嘛？"
              @confirm="addItention() "

          >
            <el-button type="success" icon="el-icon-check" slot="reference" style="margin-left: 5px" v-if="user.role==='学生'">选择</el-button>
          </el-popconfirm>
        </template>
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
    <el-dialog
        title="导师详情"
        :visible.sync="dialogFormVisible"
        width="30%"
    >
      <el-form  label-width="80px" size="small">
        <el-form-item label="职称">
          <el-input v-model="form.title" auto-complete="off"></el-input>
        </el-form-item>
        <el-form-item label="招生人数">
          <el-input v-model="form.enrollment" auto-complete="off"></el-input>
        </el-form-item>
        <el-form-item label="要求">
          <el-input v-model="form.requirement" auto-complete="off"></el-input>
        </el-form-item>
        <el-form-item label="自我介绍">
          <el-input v-model="form.introduction" auto-complete="off"></el-input>
        </el-form-item>

      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogFormVisible=false">取消</el-button>
        <el-button type="primary" @click="save">确定</el-button>
      </div>


    </el-dialog>
  </div>
</template>

<script>

export default {
  name: "TeacherInfo.vue",
  data(){
    return{
      tableData: [],
      pageNum: 1,
      pageSize: 5,
      username:"",
      email:"",
      address:"",
      total:0,
      dialogFormVisible:false,
      form:{},
      multipleSelection:[],

      title:"",
      enrollment:0,
      requirement:"",
      introduction:"",


      user:localStorage.getItem("user") ? JSON.parse(localStorage.getItem("user")) : {}

    }
  },


  created() {
    this.load()
  },
  methods:{
    load() {
      this.request.get("/user/page/teacher",{
        params:{
          pageNum:this.pageNum,
          pageSize:this.pageSize,
          username:this.username,
          email:this.email,
          address:this.address,
        }
      }).then(res =>{
        console.log(res)
        this.tableData=res.data.records
        this.total=res.data.total
      })
    },
    save(){
      this.request.post("/user",this.form).then(res=> {
        if(res.data){
          this.$message.success("保存成功")
          this.dialogFormVisible=false
          this.load()
        }else {
          this.$message.error("保存失败！")
        }
      })
    },
    handleAdd(){
      this.dialogFormVisible=true
      this.form={}
    },

    //查看老师的详细信息
    handleDetail(id){
      this.request.get("/teacher/"+id).then(res=>{
        if(res.data){
          this.form=Object.assign({},res.data)
          this.dialogFormVisible=true
        }else {
          this.$message.error("查询失败！老师没有留下任何信息！")
        }
          }

      )
      // this.form=Object.assign({},row)
      // this.dialogFormVisible=true
    },
    del(id){
      this.request.delete("/user/"+id).then(res=>{
        if(res.data){
          this.$message.success("删除成功")
          this.load()
        }else {
          this.$message.error("删除失败！")
        }

      })
    },
    handleSelectionChange(val){
      console.log(val)
      this.multipleSelection=val
    },
    delBatch(){
      let ids=this.multipleSelection.map(v=>v.id)//把对象数组变成纯id数组
      this.request.post("/user/del/batch",ids).then(res=>{
        if(res.data){
          this.$message.success("批量删除成功")
          this.load()
        }else {
          this.$message.error("批量删除失败！")
        }

      })

    },
    reset(){
      this.username=""
      this.email=""
      this.address=""
      this.load()
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
