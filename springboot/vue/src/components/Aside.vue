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
        <img src="../assets/陈冠希.jpeg" alt="" style="width: 20px; position: relative; top: 5px; right: 5px">
        <b style="color: white" v-show="logoTextShow">教务管理系统</b>
      </div>
    <div>
      <el-menu-item index="/home">
        <i class="el-icon-house"></i>
        <span slot="title">主页</span>
      </el-menu-item>
      <el-menu-item index="/im"> <i class="el-icon-chat-dot-round"></i>
        <span slot="title">聊天室</span>
      </el-menu-item>

      <el-menu-item index="/teacherInfo">
        <i class="el-icon-user"></i>
        <span slot="title">导师信息</span>
      </el-menu-item>

      <el-menu-item index="/intention" >
        <i class="el-icon-reading"></i>
        <span slot="title">志愿信息</span>
      </el-menu-item>


            <el-submenu index="2" >
              <template slot="title">
                <i class="el-icon-menu"></i>
                <span slot="title">教师功能</span>
              </template>
              <el-menu-item index="/studentInfo">
                <i class="el-icon-search"></i>
                <span slot="title">查看报名</span>
              </el-menu-item>
              <el-menu-item index="/intention">
                <i class="el-icon-search"></i>
                <span slot="title">查看已选</span>
              </el-menu-item>
            </el-submenu >





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
    </div>
  </el-menu>
</template>

<script>
export default {
  name: "Aside",
  props: {
    isCollapse: Boolean,
    logoTextShow: Boolean
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
