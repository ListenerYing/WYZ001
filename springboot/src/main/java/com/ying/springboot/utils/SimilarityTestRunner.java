package com.ying.springboot.utils;


import org.xm.similarity.text.CosineSimilarity;
import org.xm.similarity.text.TextSimilarity;

public class SimilarityTestRunner {

    // 假设的方法，模拟文本相似度计算（实际中应调用你的相似度计算实现）
    public static double calculateTextSimilarity(String text1, String text2) {
        // 这里应该是文本相似度计算的逻辑，假设总是返回0.75作为示例
        return 0.5;
    }

    public static void main(String[] args) {
        // 测试文本


        // 输出计算结果

//        String text1 = "于2008年取得英国计算机科学博士学位，发表多篇期刊和会议文章。现指导多名研究生从事计算机科学、教育技术学和神经科学等方面的教学和研究工作。";
//        String text2 = "我深深迷恋古人所说的读万卷书，行万里路。因此我一爱看书，二爱旅行。";
//        String text1 = "我不喜欢看电视，也不喜欢看电影";
//        String text2 = "我喜欢看电视，不喜欢看电影";
        String text1 = "我期望我的学生能够有坚实的数学基础，热爱数据科学领域，特别是对深度学习充满热情。我希望你已经有过使用Python及其数据科学库（如TensorFlow或PyTorch）解决实际问题的经历。此外，具备良好的团队合作精神和强烈的求知欲也是必不可少的。";
        String text2 = "我是一位热爱数据科学的学生，对深度学习特别感兴趣。我有坚实的数学基础和一些实际的项目经验，包括使用TensorFlow和PyTorch构建模型。我善于团队合作，始终保持对学习新知识的渴望，期待在实践中不断进步。";
        TextSimilarity cosSimilarity = new CosineSimilarity();
        double score1 = cosSimilarity.getSimilarity(text1, text2);
        System.out.println("cos相似度分值：" + score1);

    }
}