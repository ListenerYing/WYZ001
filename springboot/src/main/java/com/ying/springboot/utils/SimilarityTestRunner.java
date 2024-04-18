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

        String text1 = "于2008年取得英国计算机科学博士学位，发表多篇期刊和会议文章。现指导多名研究生从事计算机科学、教育技术学和神经科学等方面的教学和研究工作。";
        String text2 = "我深深迷恋古人所说的读万卷书，行万里路。因此我一爱看书，二爱旅行。";
        TextSimilarity cosSimilarity = new CosineSimilarity();
        double score1 = cosSimilarity.getSimilarity(text1, text2);
        System.out.println("cos相似度分值：" + score1);

    }
}