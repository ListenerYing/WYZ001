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

      <el-table-column prop="sequence" label="志愿" width="140">
      </el-table-column>
      <el-table-column prop="teacherName" label="教师" width="120">
      </el-table-column>

      <el-table-column label="操作" width="200" align="center">
        <template slot-scope="scope">
          <el-button type="info"  @click="handleDetail(scope.row.teacherId)">查看详情</el-button>

            <el-button type="success" icon="el-icon-upload2" slot="reference" style="margin-left: 5px" v-if="scope.row.sequence>1" @click="handleUp(scope.row.id,scope.row.sequence,scope.row.studentId)">{{scope.row.sequence}}上移</el-button>

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

        <el-button type="primary" @click="dialogFormVisible=false">确定</el-button>
      </div>


    </el-dialog>
  </div>
</template>

<script>

export default {
  name: "Intention.vue",
  data(){
    return{
      tableData: [],
      pageNum: 1,
      pageSize: 5,
      username:"",
      nickname:"",
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

      // id:0,
      // sequence:0,
      // studentId:0,

      user:localStorage.getItem("user") ? JSON.parse(localStorage.getItem("user")) : {}

    }
  },


  created() {
    this.load()
  },
  methods:{
    load() {
      this.request.get("/intention/page",{
        params:{
          pageNum:this.pageNum,
          pageSize:this.pageSize,

          id:this.user.id,
        }
      }).then(res =>{
        console.log(res)
        this.tableData=res.data
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

    //处理志愿顺序 存在bug 暂未解决 2022/6/20
    handleUp(id,sequence,studentId){
      this.request.get("/intention/plus",{
        params:{
          studentId:studentId,
          sequence:sequence,
        }
      }).then(res=>{
        if(res.data){
         this.$message("+1成功")
        }else {
          this.$message.error("+1失败")
        }
      })

      this.request.get("/intention/reduce",{
        params:{
          id:id,
          sequence:sequence,
        }
      }).then(res=>{
        if(res.data){
          this.$message("-1成功")
        }else {
          this.$message.error("-1失败")
        }
      })
      location. reload()
      // this.load()




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

