<template>
  <el-menu :default-openeds="['1', '3']" style="min-height: 100%; overflow-x: hidden"
           background-color="rgb(48, 65, 86)"
           text-color="#fff"
           active-text-color="#ffd04b"
           :collapse-transition="false"
           :collapse="isCollapse"
           router
  >

      <div style="height: 60px; line-height: 60px; text-align: center">
        <img src="../assets/zjut.png" alt="" style="width: 20px; position: relative; top: 5px; right: 5px">
        <b style="color: white" v-show="logoTextShow">导师制双向选择系统</b>
      </div>
    <div>
      <el-menu-item index="/home">
        <i class="el-icon-house"></i>
        <span slot="title">主页</span>
      </el-menu-item>
<!--      <el-menu-item index="/im"> <i class="el-icon-chat-dot-round"></i>-->
<!--        <span slot="title">聊天室</span>-->
<!--      </el-menu-item>-->

      <el-menu-item index="/teacherInfo">
        <i class="el-icon-user"></i>
        <span slot="title">导师信息</span>
      </el-menu-item>
        <div v-if="this.user.role==='学生'">
          <el-menu-item index="/intention" >
            <i class="el-icon-reading"></i>
            <span slot="title">志愿信息</span>
          </el-menu-item>
        </div>

      <div v-if="this.user.role==='老师'">
        <el-submenu index="teacherPower" >
          <template slot="title">
            <i class="el-icon-menu"></i>
            <span slot="title">教师功能</span>
          </template>
          <el-menu-item index="/studentInfo">
            <i class="el-icon-search"></i>
            <span slot="title">查看报名</span>
          </el-menu-item>
          <el-menu-item index="/ChosenStudentInfo">
            <i class="el-icon-search"></i>
            <span slot="title">查看已选</span>
          </el-menu-item>
        </el-submenu >
      </div>







      <el-submenu index="1">
        <template slot="title">
          <i class="el-icon-menu"></i>
          <span slot="title">系统管理</span>
        </template>
        <el-menu-item index="/user">
          <i class="el-icon-s-custom"></i>
          <span slot="title">用户管理</span>
        </el-menu-item>

      </el-submenu>
      <el-menu-item index="/progress">
        <i class="el-icon-time"></i>
        <span slot="title">查看进度</span>
      </el-menu-item>
      <el-menu-item index="/result">
        <i class="el-icon-data-board"></i>
        <span slot="title">结果公示</span>
      </el-menu-item>
    </div>
  </el-menu>
</template>

<script>
export default {
  name: "Aside",
  props: {
    isCollapse: Boolean,
    logoTextShow: Boolean
  },
  data(){
    return{
      user:localStorage.getItem("user") ? JSON.parse(localStorage.getItem("user")) : {}
    }
  }
}
</script>

<style scoped>

</style>

<style>
.el-menu-item.is-active {
  background-color: rgb(38, 52, 69) !important;
}
.el-menu-item:hover {
  background-color: rgb(38, 52, 69) !important;
}

.el-submenu__title:hover {
  background-color: rgb(38, 52, 69) !important;
}
/*解决收缩菜单文字不消失问题*/
.el-menu--collapse span {
  visibility: hidden;
}
</style>
