<template>
  <el-card style=" width: 500px;">
    <el-form label-width="80px" size="small">
<!--      <el-upload-->
<!--          class="avatar-uploader"-->
<!--          :action="'http://' + serverIp +':9090/file/upload'"-->
<!--          :show-file-list="false"-->
<!--          :on-success="handleAvatarSuccess"-->
<!--      >-->
<!--        <img v-if="form.avatarUrl" :src="form.avatarUrl" class="avatar">-->
<!--        <i v-else class="el-icon-plus avatar-uploader-icon"></i>-->
<!--      </el-upload>-->

      <el-form-item label="用户名">
        <el-input v-model="form.username" disabled autocomplete="off"></el-input>
      </el-form-item>
      <el-form-item label="姓名">
        <el-input v-model="form.nickname" disabled autocomplete="off"></el-input>
      </el-form-item>
      <el-form-item label="邮箱">
        <el-input v-model="form.email" autocomplete="off"></el-input>
      </el-form-item>
      <el-form-item label="电话">
        <el-input v-model="form.phone" autocomplete="off"></el-input>
      </el-form-item>
      <el-form-item label="地址">
        <el-input type="textarea" v-model="form.address" autocomplete="off" autosize></el-input>
      </el-form-item>
      <el-form-item label="招生人数" v-if="user.role=='老师'" >
        <el-input v-model="extra.enrollment" autocomplete="off"></el-input>
      </el-form-item>

      <el-form-item label="要求"  v-if="user.role=='老师'">
        <el-input type="textarea" v-model="extra.requirement" autocomplete="off" autosize></el-input>
      </el-form-item>
      <el-form-item label="自我介绍">
        <el-input type="textarea" v-model="extra.introduction" autocomplete="off" autosize></el-input>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="save">确 定</el-button>
      </el-form-item>
    </el-form>
  </el-card>
</template>

<script>
// import {serverIp} from "../../public/config";

export default {
  name: "Person",
  data() {
    return {
      // serverIp: serverIp,
      extra:{},
      form: {},
      user: localStorage.getItem("user") ? JSON.parse(localStorage.getItem("user")) : {}
    }
  },
  created() {
    this.getUser().then(res => {
      console.log(res)
      this.form = res
    })
    this.getUserInfo(this.user.id,this.user.role)
  },
  methods: {
    async getUser() {
      return (await this.request.get("/user/" + this.user.id)).data
    },
    getUserInfo(id,role){
      if(role=="老师"){
        this.request.get("/teacher/"+id).then(res=>{
          if(res.data){
            this.extra=Object.assign({},res.data)
          }else {
            this.$message.error("There is something wrong!")
          }
        }
      )

      }
      else if(role=="学生"){this.request.get("/student/"+id).then(res=>{
            if(res.data){
              this.extra=Object.assign({},res.data)
            }else {
              this.$message.error("There is something wrong!")
            }
          }
      )}
    },
    save() {
      this.request.post("/user", this.form).then(res => {
        if (res.code === '200') {
          this.$message.success("保存成功")

          // 触发父级更新User的方法
          this.$emit("refreshUser")

          // 更新浏览器存储的用户信息
          this.getUser().then(res => {
            res.token = JSON.parse(localStorage.getItem("user")).token
            localStorage.setItem("user", JSON.stringify(res))
          })

        } else {
          this.$message.error("保存失败")
        }
      });
      this.request.post("/teacher", this.extra);
      this.request.post("/student", this.extra);

    },
    handleAvatarSuccess(res) {
      this.form.avatarUrl = res
    }
  }
}
</script>

<style scoped>

</style>
