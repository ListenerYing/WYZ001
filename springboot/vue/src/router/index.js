import Vue from 'vue'
import VueRouter from 'vue-router'
import store from "@/store";

Vue.use(VueRouter)

const routes = [
  {
    path: '/',
    component: () => import('../views/Manage.vue'),
    redirect: "/home",
    children: [
      { path: 'home', name: '首页', component: () => import('../views/Home.vue')},
      { path: 'course', name: '课程管理', component: () => import('../views/Course.vue')},
      { path: 'teacherInfo', name: '导师信息', component: () => import('../views/TeacherInfo.vue')},
      { path: 'intention', name: '志愿信息', component: () => import('../views/Intention.vue')},
      { path: 'studentInfo', name: '查看报名', component: () => import('../views/StudentInfo.vue')},

      {
        path: 'im',
        name: 'Im',
        component: () => import("@/views/Im"),
      },
      { path: 'user', name: '用户管理', component: () => import('../views/User.vue')},
      { path: 'person', name: '个人信息', component: () => import('../views/Person.vue')},
    ]
  },
  {
    path: '/about',
    name: 'About',
    component: () => import('../views/About.vue')
  },
  {
    path: '/login',
    name: 'Login',
    component: () => import('../views/Login.vue')
  },
  {
    path: '/register',
    name: 'Register',
    component: () => import("@/views/Register")
  },



]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

// 路由守卫
router.beforeEach((to, from, next) => {
  localStorage.setItem("currentPathName", to.name)  // 设置当前的路由名称，为了在Header组件中去使用
  store.commit("setPath")  // 触发store的数据更新
  next()  // 放行路由
})

export default router
