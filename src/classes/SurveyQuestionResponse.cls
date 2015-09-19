public with sharing class SurveyQuestionResponse extends BaseModel {

    public static Finder find = new Finder('Survey_Question_Response__c');

    private SurveyQuestion mQuestion;

    public SurveyQuestionResponse() {
        this(new Survey_Question_Response__c());
    }

    public SurveyQuestionResponse(Survey_Question_Response__c response) {
        this(response, new SurveyQuestion(response.Survey_Question__r));
    }

    public SurveyQuestionResponse(Survey_Question_Response__c response, SurveyQuestion question) {
        super(response);
        mQuestion = question;
    }

    public Id getSurveyQuestionId() {
        return (Id)mObj.get('Survey_Question__c');
    }
    public void setSurveyQuestionId(Id surveyQuestion) {
        mObj.put('Survey_Question__c', surveyQuestion);
    }

    public Boolean getBooleanResponse() {
        return (Boolean)mObj.get('Boolean_Response__c');
    }
    public void setBooleanResponse(Boolean booleanResponse) {
        mObj.put('Boolean_Response__c', booleanResponse);
    }

    public String getTextResponse() {
        return (String)mObj.get('Text_Response__c');
    }
    public void setTextResponse(String textResponse) {
        mObj.put('Text_Response__c', textResponse);
    }

    public static List<SurveyQuestionResponse> decorate(List<sObject> questions) {
        List<SurveyQuestionResponse> result = new List<SurveyQuestionResponse>();
        for (Survey_Question_Response__c q : (List<Survey_Question_Response__c>)questions) {
            result.add(new SurveyQuestionResponse(q));
        }
        return result;
    }

    public class Finder extends BaseFinder {
        public Finder(String objectName) {
            super(objectName);
        }

        public List<SurveyQuestionResponse> byQuestion(String questionId) {
            return decorate(getSelectWhere('Question__c', questionId));
        }
    }
}
