package com.ying.springboot.utils;

import org.xm.similarity.text.CosineSimilarity;
import org.xm.similarity.text.TextSimilarity;

public class TextSimilarityEvaluator {

    private final TextSimilarity textSimilarity;

    public TextSimilarityEvaluator() {
        this.textSimilarity = new CosineSimilarity();
    }

    public double calculateSimilarity(String text1, String text2) {
        return textSimilarity.getSimilarity(text1, text2);
    }

}