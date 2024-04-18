package com.ying.springboot.controller;



import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.ying.springboot.common.Constants;
import com.ying.springboot.common.Result;
import com.ying.springboot.entity.*;
import com.ying.springboot.service.*;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.xm.similarity.text.CosineSimilarity;
import org.xm.similarity.text.TextSimilarity;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;


@Transactional(isolation = Isolation.SERIALIZABLE )
@RestController
@RequestMapping("/match")
public class MatchController {

    @Resource
    private IStudentService studentService;
    @Resource
    private ITeacherService teacherService;

    @Transactional(isolation = Isolation.SERIALIZABLE)
    @GetMapping("/assign")
    public Result assignTeachersToStudents() {
        // 使用QueryWrapper查找没有导师的学生
        QueryWrapper<Student> studentQueryWrapper = new QueryWrapper<>();
        studentQueryWrapper.eq("teacher_id", 0);
        List<Student> studentsWithoutTeacher = studentService.list(studentQueryWrapper);

        // 使用QueryWrapper查找招生名额未满的老师
        QueryWrapper<Teacher> teacherQueryWrapper = new QueryWrapper<>();
        teacherQueryWrapper.apply("enrollment > (SELECT COUNT(*) FROM student WHERE teacher_id = id)");
        List<Teacher> teachersWithVacancies = teacherService.list(teacherQueryWrapper);

        // 把学生和老师匹配逻辑放这里
// 假设Student和Teacher实体类中已经包含了对应的字段：introduction和requirement

// 存储匹配得分的映射
        Map<Integer, Map<Integer, Double>> studentScores = new HashMap<>();

        for (Student student : studentsWithoutTeacher) {
            String studentIntroduction = student.getIntroduction(); // 学生自我介绍
            Map<Integer, Double> teacherScores = new HashMap<>(); // 这个学生对应的所有老师的得分

            for (Teacher teacher : teachersWithVacancies) {
                String teacherRequirement = teacher.getRequirement(); // 老师的招生要求
                // 计算相似度得分
                TextSimilarity cosSimilarity = new CosineSimilarity();
                double score = cosSimilarity.getSimilarity(studentIntroduction, teacherRequirement);
                teacherScores.put(teacher.getId(), score);
            }

            studentScores.put(student.getId(), teacherScores);
        }

// 找出每个学生匹配得分最高的老师并分配
        for (Map.Entry<Integer, Map<Integer, Double>> entry : studentScores.entrySet()) {
            Integer studentId = entry.getKey();
            Double maxScore = -1.0;
            Integer bestTeacherId = null;

            for (Map.Entry<Integer, Double> scoreEntry : entry.getValue().entrySet()) {
                if (scoreEntry.getValue() > maxScore) {
                    maxScore = scoreEntry.getValue();
                    bestTeacherId = scoreEntry.getKey();
                }
            }

            if (bestTeacherId != null) {
                // 找到了最佳匹配的老师，更新学生信息
                Student studentToUpdate = studentService.getById(studentId);
                studentToUpdate.setTeacherId(bestTeacherId);
                studentService.updateById(studentToUpdate);

                // 更新老师的招生人数
//                Teacher teacherToUpdate = teacherService.getById(bestTeacherId);
//                teacherToUpdate.setEnrollment(teacherToUpdate.getEnrollment() - 1);
//                teacherService.updateById(teacherToUpdate);
            }
        }
        return  Result.success();
    }
}
