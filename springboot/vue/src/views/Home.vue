<template>
  <div style="color: #666;font-size: 14px;">
    <div style="padding-bottom: 20px">
      <b>欢迎你！{{ user.nickname }}</b>
    </div>
    <div style="height: 1px; background: #ddd; margin: 20px 0"/>
    <div>
      <el-card style="margin: 10px 0">
        <div style="padding-bottom: 20px; font-size: 24px">富 文 本 的 系 统 公 告</div>
        <el-collapse accordion v-for="(item, index) in noticeRich">
          <el-collapse-item :name="index + ''">
            <template slot="title">
              <span style="font-size: 20px; color: #E6A23C">{{ item.name }}</span><i style="color: #E6A23C" class="header-icon el-icon-info"></i>
              <span style="margin-left: 20px">{{ item.time }}</span>
            </template>
            <div>
              <div style="padding: 10px 0"><el-image :src="item.img"></el-image></div>
              <div v-html="item.content"></div>
            </div>
          </el-collapse-item>
        </el-collapse>
      </el-card>
    </div>
  </div>


</template>


<script>
export default {
  name: "Home",
  data() {
    return {
      activeNames: ['0'],
      user: localStorage.getItem("user") ? JSON.parse(localStorage.getItem("user")) : {},
      notice: [],
      noticeRich: [],
    }
  },
  created() {
    // 简单公告
    // this.request.get("/notice/page").then(res => {
    //   this.notice = res.data.splice(0, 5)
    // })

    this.request.get("/notice").then(res => {
      this.noticeRich = res.data.splice(0, 5).reverse()
    })
  }
}
</script>