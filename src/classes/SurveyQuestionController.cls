public with sharing class SurveyQuestionController {
    @AuraEnabled
    public static List<SurveyQuestion> getSurveyQuestions() {
        return SurveyQuestion.find.all();
    }
}
