public with sharing class SurveyQuestionOption extends BaseModel {

    public static Finder find = new Finder('Survey_Question_Option__c');

    public SurveyQuestionOption() {
        this(new Survey_Question_Option__c());
    }

    public SurveyQuestionOption(Survey_Question_Option__c option) {
        super(option);
    }

    public Id getSurveyQuestionId() {
        return (Id)mObj.get('Survey_Question__c');
    }
    public void setSurveyQuestionId(Id surveyQuestion) {
        mObj.put('Survey_Question__c', surveyQuestion);
    }

    public String getOption() {
        return (String)mObj.get('Option__c');
    }
    public void setOption(String option) {
        mObj.put('Option__c', option);
    }

    public static List<SurveyQuestionOption> decorate(List<sObject> questions) {
        List<SurveyQuestionOption> result = new List<SurveyQuestionOption>();
        for (Survey_Question_Option__c q : (List<Survey_Question_Option__c>)questions) {
            result.add(new SurveyQuestionOption(q));
        }
        return result;
    }

    public class Finder extends BaseFinder {
        public Finder(String objectName) {
            super(objectName);
        }

        public List<SurveyQuestionOption> byQuestion(String questionId) {
            return decorate(getSelectWhere('Question__c', questionId));
        }
    }
}
