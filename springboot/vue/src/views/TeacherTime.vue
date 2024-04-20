<template>
  <div>
    <!-- 新增时间配置按钮 -->
    <el-button type="primary" @click="handleAdd">新增时间配置</el-button>
    <!-- 时间配置列表 -->
    <el-table :data="periods" style="width: 100%">
      <!-- 描述列 -->
      <el-table-column prop="description" label="描述"></el-table-column>

      <el-table-column prop="firstPeriod" label="第一志愿开始时间"></el-table-column>
      <el-table-column prop="secondPeriod" label="第二志愿开始时间"></el-table-column>

      <el-table-column prop="thirdPeriod" label="第三志愿开始时间"></el-table-column>
      <!-- 是否激活列 -->
      <el-table-column prop="isActive" label="是否激活">
        <template slot-scope="scope">
          <!-- 激活状态切换按钮 -->
          <el-switch v-model="scope.row.isActive" @change="toggleActive(scope.row)"></el-switch>
        </template>
      </el-table-column>
      <!-- 操作列 -->
      <el-table-column label="操作">
        <template slot-scope="scope">
          <!-- 编辑按钮 -->
          <el-button @click="handleEdit(scope.row)">编辑</el-button>
          <!-- 删除按钮 -->
          <el-button @click="handleDelete(scope.row.id)">删除</el-button>
        </template>
      </el-table-column>
    </el-table>
    <!-- 分页组件 -->
    <el-pagination
        :current-page="query.pageNum"
        :page-size="query.pageSize"
        :total="total"
        layout="total, prev, pager, next"
        @current-change="handleCurrentChange">
    </el-pagination>
    <!-- 编辑时间配置对话框 -->
    <el-dialog :title="currentAction === 'create' ? '新增时间配置' : '编辑时间配置'"
               :visible.sync="dialogVisible">
      <el-form :model="form" label-width="160px" size="large">
        <!-- 描述输入框 -->
        <el-form-item label="描述">
          <el-input v-model="form.description"></el-input>
        </el-form-item>
        <!-- 开始时间选择器 -->
        <el-form-item label="第一志愿开始时间">
          <el-date-picker v-model="form.firstPeriod" type="datetime" placeholder="选择日期时间"></el-date-picker>
        </el-form-item>
        <!-- 结束时间选择器 -->
        <el-form-item label="第二志愿开始时间">
          <el-date-picker v-model="form.secondPeriod" type="datetime" placeholder="选择日期时间"></el-date-picker>
        </el-form-item>
        <el-form-item label="第三志愿开始时间">
          <el-date-picker v-model="form.thirdPeriod" type="datetime" placeholder="选择日期时间"></el-date-picker>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <!-- 取消按钮 -->
        <el-button @click="dialogVisible = false">取消</el-button>
        <!-- 保存按钮 -->
        <el-button type="primary" @click="save">保存</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
export default {
  data() {
    return {
      // 时间配置的列表信息
      periods: [],
      // 总条数，用于分页
      total: 0,
      // 查询参数和页面信息
      query: {
        pageNum: 1,
        pageSize: 5,
      },
      // 对话框可见状态和表单模型
      dialogVisible: false,
      form: {
        id: null,
        description: '',
        firstPeriod: '',
        secondPeriod: '',
        thirdPeriod: '',

      },
      // 标记当前行为是创建还是编辑
      currentAction: 'create',
    };
  },
  created() {
    // 组件创建时加载数据
    this.load();
  },
  methods: {
    // 获取时间配置数据的方法
    load() {
      this.request.get(`/period/page?pageNum=${this.query.pageNum}&pageSize=${this.query.pageSize}`)
          .then(res => {
            if (res.data) {
              this.periods = res.data.records;
              this.total = res.data.total;
            } else {
              this.$message.error('数据加载失败');
            }
          });
    },
    // 打开创建时间配置的对话框
    handleAdd() {
      this.currentAction = 'create';
      this.form = { id: null, description: '', firstPeriod: '', secondPeriod: '',thirdPeriod: '' };
      this.dialogVisible = true;
    },
    // 打开编辑时间配置的对话框
    handleEdit(row) {
      this.currentAction = 'edit';
      // 注意: 不包括isActive字段，根据需求不在编辑表单中显示
      this.form = { ...row, isActive: undefined };
      this.dialogVisible = true;
    },
    save(){
      this.request.post("/period",this.form).then(res=> {
        if(res.data){
          this.$message.success("保存成功")
          this.dialogFormVisible=false
          this.load()
        }else {
          this.$message.error("保存失败！")
        }
      })
    },
    // 保存时间配置
    handleSave() {
      const url = this.currentAction === 'create' ? '/period' : `/period/${this.form.id}`;
      const method = this.form.id ? 'post' : 'post';

      this.request[method](url, this.form).then(res => {
        if (res.data) {
          this.$message.success('时间配置保存成功');
          this.dialogVisible = false;
          this.load();
        } else {
          this.$message.error('保存失败');
        }
      });
    },
    // 删除时间配置
    handleDelete(id) {
      this.$confirm('确认删除这个时间配置吗?', '删除确认', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        this.request.delete(`/period/${id}`).then(res => {
          if (res.data) {
            this.$message.success('时间配置删除成功');
            this.load();
          } else {
            this.$message.error('删除失败');
          }
        });
      }).catch(() => {});
    },
    // 切换激活状态
    toggleActive(row) {

      // 先转换 isActive 到布尔类型，以便正确地反转值
      const isActiveBoolean = Boolean(row.isActive);

      // 然后创建更新的period对象，确保反转isActive值
      const updatedperiod = {
        ...row,
        isActive: isActiveBoolean
      };
      console.log(updatedperiod)

      // 发送 POST 请求到后端来保存更新的 period 对象
      this.request.post(`/period`, updatedperiod).then(res => {
        if (res.data) {
          this.$message.success('状态变更成功');
          this.load(); // 重新加载数据，展示最新状态
        } else {
          this.$message.error('状态激活失败');
        }
      }).catch(error => {
        this.$message.error(`状态更新失败: ${error.message}`);
      });
    },
    // 处理分页页面变化
    handleCurrentChange(newPage) {
      this.query.pageNum = newPage;
      this.load();
    },
  },
};
</script>