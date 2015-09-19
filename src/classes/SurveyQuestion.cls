public with sharing class SurveyQuestion {
    
    public static Finder find = new Finder('Survey_Question__c');

    public static final String TYPE_CHECKBOX = 'Checkbox';
    public static final String TYPE_PICKLIST = 'Picklist';
    public static final String TYPE_TEXT     = 'Text';


    public List<SurveyQuestionOption> options;
    private Boolean mIsCheckbox;
    private Boolean mIsText;
    private Boolean mIsPicklist;

    public SurveyQuestion() {
        this(new Survey_Question__c());
    }

    public SurveyQuestion(Survey_Question__c question) {
        super(question);
        options = SurveyQuestionOption.decorate(question.Survey_Options__r);
    }

    public String getQuestion() {
        return (String)mObj.get('Question__c');
    }
    public void setQuestion(String question) {
        mObj.put('Question__c', question);
    }

    public String getType() {
        return (String)mObj.get('Type__c');
    }
    public void setType(String type) {
        mObj.put('Type__c', type);
    }
    

    public Boolean getIsCheckbox() {
        if (mIsCheckbox == null) {
            setupTypeBooleans();
        }
        return mIsCheckbox;
    }

    public Boolean getIsPicklist() {
        if (mIsPicklist == null) {
            setupTypeBooleans();
        }
        return mIsPicklist;
    }

    public Boolean getIsText() {
        if (mIsText == null) {
            setupTypeBooleans();
        }
        return mIsText;
    }

    private void setupTypeBooleans() {
        mIsCheckbox = false;
        mIsText     = false;
        mIsPicklist = false;

        String type == getType();
        if (type == TYPE_CHECKBOX) {
            mIsCheckbox = true;
        }
        else if (type == TYPE_PICKLIST) {
            mIsPicklist = true;
        }
        else if (type == TYPE_TEXT) {
            mIsText = true;
        }

    }
    public static List<SurveyQuestion> decorate(List<sObject> questions) {
        List<SurveyQuestion> result = new List<SurveyQuestion>();
        for (sObject q : questions) {
            result.add(new SurveyQuestion(q));
        }
        return result;
    }

    public class Finder extends BaseFinder {
        public Finder(String objectName) {
            super(objectName);
            addFields(new Set<String>{
                '(SELECT Id, Option__c FROM Survey_Options__r)'
            });
        }

        public List<SurveyQuestion> all() {
            return decorate(getSelect());
        }
    }
}
