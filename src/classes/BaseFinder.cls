public abstract class BaseFinder {

    private Set<String> mFieldSet;
    private String mSObjectName;

    public BaseFinder() {}

    public BaseFinder(String sObjectName) {
        this.mSObjectName = sObjectName;
        SObjectType objToken = Schema.getGlobalDescribe().get(sObjectName);
        mFieldSet = new Set<String>(objToken.getDescribe().fields.getmap().keyset());
    }

    public Set<String> getFieldSet() {
        return mFieldSet;
    }

    public void setFieldSet(Set<String> newFieldSet) {
        mFieldSet = newFieldSet;
    }

    protected String getFields() {
        return String.join(
                   new List<String>(mFieldSet), ',');
    }

    protected void addFields(Set<String> newFields) {
        mFieldSet.addAll(newFields);
    }

    protected String getSelect() {
        return 'select ' + getFields() + ' from ' + mSObjectName + ' ';
    }

    protected List<sObject> getAll() {
        return Database.query(getSelect());
    }

    protected List<SObject> getSelectWhere(String field, String whereClause) {
        return Database.query(getSelect() + 'where ' + field + ' =: whereClause');
    }

    protected List<SObject> getSelectIn(String field, List<String> whereIn) {
        return Database.query(getSelect() + 'where ' + field + ' in: whereIn');
    }

    protected List<SObject> getSelectIn(String field, Set<String> whereIn) {
        return Database.query(getSelect() + 'where ' + field + ' in: whereIn');
    }

    public virtual BaseModel byId(Id recId) {
        List<SObject> objList = Database.query(getSelect() + 'where Id =: recId');
        if (objList == null || objList.size() == 0) {
            return null;
        }

        return new BaseModel(objList[0]);
    }

    public static String quote (String param) {
        return '\'' + String.escapeSingleQuotes(param) + '\'';
    }

    public static String quote(List<String> params) {
        String res = '(';
        for (String param : params) {
            res += '\'' + String.escapeSingleQuotes(param) + '\',';
        }
        //---Remove trailing comma
        res = res.removeEnd(',');
        return res + ')';
    }

    public static String quote(Set<String> params) {
        String res = '(';
        for (String param : params) {
            res += '\'' + String.escapeSingleQuotes(param) + '\',';
        }
        //---Remove trailing comma
        res = res.removeEnd(',');
        return res + ')';
    }

    public static List<String> getPicklistOptions(Schema.sObjectField field) {
        List<Schema.PicklistEntry> ple = field.getDescribe().getPicklistValues();

        List<String> options = new List<String>();
        for ( Schema.PicklistEntry f : ple) {
            options.add(f.getValue());
        }
        return options;
    }

    //public class TestException extends Exception {}
}
