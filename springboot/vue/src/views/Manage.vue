<template>
  <div style="height: 100%">
    <el-container style="height: 100%">
      <el-aside :width="sideWith" style="background-color: rgb(238, 241, 246);box-shadow:2px 0px 6px aqua" height="100%">
        <Aside :isCollapse="isCollapse" :logoTextShow="logoTextShow" />
      </el-aside>

      <el-container>
        <el-header style="border-bottom: 1px solid #ccc;">
          <Header :collapseBtnClass="collapseBtnClass" @asideCollapse="collapse" />
        </el-header>

        <el-main>
          <!--       表示当前页面的子路由会在 <router-view /> 里面展示-->
          <router-view />
        </el-main>
      </el-container>
    </el-container>
  </div>
</template>

<script>

import Aside from "@/components/Aside";
import Header from "@/components/Header";
export default {
  name: 'Home',

  data() {
    return {

      collapseBtnClass:'el-icon-s-fold',
      isCollapse:false,
      sideWith:200,
      logoTextShow:true,
      user:localStorage.getItem("user") ? JSON.parse(localStorage.getItem("user")) : {}
    }
  },
  components:{
    Aside,
    Header
  }

  ,
  methods:{
    collapse(){//点击收缩按钮收缩
      this.isCollapse=!this.isCollapse
      if (this.isCollapse) {
        this.collapseBtnClass = 'el-icon-s-unfold';
        this.sideWith = 64;
        this.logoTextShow = false;
      }
      else{//展开
        this.collapseBtnClass='el-icon-s-fold';
        this.sideWith=200;
        this.logoTextShow=true;
      }


    },
  //   getUser() {
  //     let username = localStorage.getItem("user") ? JSON.parse(localStorage.getItem("user")).username : ""
  //     if (username) {
  //       // 从后台获取User数据
  //       this.request.get("/user/username/" + username).then(res => {
  //         // 重新赋值后台的最新User数据
  //         this.user = res.data
  //       })
  //     }
  //
  // }

  }
}

</script>
