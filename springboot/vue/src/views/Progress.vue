<template>
<!--  <div>-->
<!--    <el-form ref="form" :model="form" label-width="80px">-->

<!--      <el-form-item label="第一志愿截至时间">-->
<!--        <el-col :span="11">-->
<!--          <el-date-picker type="date" placeholder="选择日期" v-model="form.date1" style="width: 100%;"></el-date-picker>-->
<!--        </el-col>-->
<!--        <el-col class="line" :span="2">-</el-col>-->
<!--        <el-col :span="11">-->
<!--          <el-time-picker placeholder="选择时间" v-model="form.date2" style="width: 100%;"></el-time-picker>-->
<!--        </el-col>-->
<!--      </el-form-item>-->
<!--      <el-form-item label="第二志愿截至时间">-->
<!--        <el-col :span="11">-->
<!--          <el-date-picker type="date" placeholder="选择日期" v-model="form.date1" style="width: 100%;"></el-date-picker>-->
<!--        </el-col>-->
<!--        <el-col class="line" :span="2">-</el-col>-->
<!--        <el-col :span="11">-->
<!--          <el-time-picker placeholder="选择时间" v-model="form.date2" style="width: 100%;"></el-time-picker>-->
<!--        </el-col>-->
<!--      </el-form-item>-->
<!--      <el-form-item label="第三志愿截至时间">-->
<!--        <el-col :span="11">-->
<!--          <el-date-picker type="date" placeholder="选择日期" v-model="form.date1" style="width: 100%;"></el-date-picker>-->
<!--        </el-col>-->
<!--        <el-col class="line" :span="2">-</el-col>-->
<!--        <el-col :span="11">-->
<!--          <el-time-picker placeholder="选择时间" v-model="form.date2" style="width: 100%;"></el-time-picker>-->
<!--        </el-col>-->
<!--      </el-form-item>-->

<!--      <el-form-item>-->
<!--        <el-button type="primary" @click="onSubmit">立即创建</el-button>-->
<!--        <el-button>取消</el-button>-->
<!--      </el-form-item>-->
<!--    </el-form>-->
<!--  </div>-->
  <div>
    <el-timeline>
      <el-timeline-item
          v-for="(activity, index) in activities"
          :key="index"
          :icon="activity.icon"
          :type="activity.type"
          :color="activity.color"
          :size="activity.size"
          :timestamp="activity.timestamp">
        {{activity.content}}
      </el-timeline-item>
    </el-timeline>
  </div>
</template>

<script>
export default {
  name: "Progress",
  data() {
    return {
      form: {
        name: '',
        region: '',
        date1: '',
        date2: '',
        delivery: false,
        type: [],
        resource: '',
        desc: ''
      },
      time:{},
      activities: [{
        content: '第三志愿截至,结果公布',
        timestamp:'',
        size: 'large',
        type: 'primary',
        icon: 'el-icon-top',
        color: '#3112d9'
      }, {
        content: '第二志愿截至',
        timestamp: '',
        size: 'large',
        icon: 'el-icon-top',
        color: '#0bbd87'
      }, {
        content: '第一志愿截至',
        timestamp: '',

        icon: 'el-icon-top',
        size: 'large',
        color:'#d23232'
      }, {
        content: '学生志愿上报截至',
        timestamp: '',
        size: 'large',
        icon: 'el-icon-top',
        color:'#00e3e0'
      }]
    }
  },
  created() {
    this.load()
  },
  methods:{
    load(){
      this.request.get("/deadline/"+1).then(res =>{
        console.log(res)

        if(res.code==='200') {
              this.activities[2].timestamp=res.data.first
          this.activities[1].timestamp=res.data.second
          this.activities[0].timestamp=res.data.third
        } else {
          this.$message.error(res.msg)}


      })


    }

  }
}

</script>

<style scoped>

</style>
