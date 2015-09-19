public with sharing class SurveyQuestionOptionController {
    
    @AuraEnabled
    public static List<SurveyQuestion> getSurveyQuestionOptions(String questionId) {
        return SurveyQuestionOption.find.byQuestionId(questionId);
    }
}
