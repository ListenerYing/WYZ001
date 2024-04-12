<template>
  <div>
    <div style="padding: 10px 0">
      <el-input  style="width: 200px;margin-left: 5px" placeholder="请输入名称" suffix-icon="el-icon-search" v-model="username"></el-input>
      <el-button style="margin-left: 5px" type="primary" icon="el-icon-search" @click="load">搜索</el-button>
      <el-button style="margin-left: 5px" type="warning" @click="reset">重置</el-button>
    </div>
    <div style="margin: 10px 0">


    </div>
    <el-table :data="tableData" border stripe @selection-change="handleSelectionChange">
      <el-table-column
          type="selection"
          width="55"
      >
      </el-table-column>
      <el-table-column prop="id" label="ID" width="80">
      </el-table-column>
      <el-table-column prop="username" label="学号" width="140">
      </el-table-column>
      <el-table-column prop="nickname" label="姓名" width="120">
      </el-table-column>
      <el-table-column prop="email" label="邮箱">
      </el-table-column>
      <el-table-column prop="phone" label="电话">
      </el-table-column>
      <el-table-column prop="address" label="地址">
      </el-table-column>
      <el-table-column label="操作" width="300" align="center">
        <template slot-scope="scope">
          <el-button type="info"  @click="handleDetail(scope.row.id)">查看详情</el-button>
          <el-popconfirm
              confirm-button-text='确定'
              cancel-button-text='我再想想'
              icon="el-icon-info"
              icon-color="#67C23A"
              title="确定选择这位学生嘛？"
              @confirm="handleChoose(scope.row.id)"

          >
            <el-button type="success" icon="el-icon-check" slot="reference" style="margin-left: 5px" >选择</el-button>
          </el-popconfirm>
          <el-popconfirm
              confirm-button-text='确定'
              cancel-button-text='我再想想'
              icon="el-icon-info"
              icon-color="#67C23A"
              title="确定不要这位学生嘛？"
              @confirm="del(scope.row.id)"

          >
            <el-button type="danger" icon="el-icon-delete-solid" slot="reference" style="margin-left: 5px" >不要</el-button>
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
        title="学生详情"
        :visible.sync="dialogFormVisible"
        width="30%"
    >
      <el-form  label-width="80px" size="small">
        <el-form-item label="绩点">
          <el-input v-model="form.gpa" auto-complete="off"></el-input>
        </el-form-item>

        <el-form-item label="自我介绍">
          <el-input  type="textarea" v-model="form.introduction" auto-complete="off" autosize></el-input>
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
  name: "StudentInfo.vue",
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

      gpa:0,
      introduction:"",


      user:localStorage.getItem("user") ? JSON.parse(localStorage.getItem("user")) : {}

    }
  },


  created() {
    this.load()
  },
  methods:{
    load() {
      this.request.get("/user/page/student",{
        params:{
          id:this.user.id,
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
    //选择学生
    handleChoose(id){
      this.request.get("/student/saveTeacherId/"+id,{
        params:{
          id:id,
          tid:this.user.id

        }
      }).then(res=>{
            if(res.data){
              this.$message.success("选择成功！")
            }else {
              this.$message.error("选择失败！")
            }
        this.load()
          }

      )

    },
    //查看学生的详细信息
    handleDetail(id){
      this.request.get("/student/"+id).then(res=>{
            if(res.data){
              this.form=Object.assign({},res.data)
              this.dialogFormVisible=true
            }else {
              this.$message.error("查询失败！学生没有填写任何信息！")
            }
          }

      )
      // this.form=Object.assign({},row)
      // this.dialogFormVisible=true
    },
    del(id){

      this.request.get("/intention/push/"+id).then(res=>{
        if(res.data){
          this.$message.success("PUSH成功")
          this.load()
        }else {
          this.$message.error("PUSH失败！")
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

