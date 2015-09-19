public virtual class BaseModel {

    protected sObject mObj {get; set;}

    public BaseModel(sObject obj) {
        mObj = obj;
    }

    public Id getId(){
        return mObj.Id;
    }

    public void setId(Id i) {
        mObj.Id = i;
    }

    public Boolean getIsNew() {
        return String.isBlank(getId());
    }
    public Boolean getIsExisting() {
        return !getIsNew();
    }

    public sObject getObj() {
        return mObj;
    }

    public virtual void save() {
        upsert mObj;
    }

    public virtual void destroy() {
        delete mObj;
    }

    public static void destroy(List<BaseModel> modelList) {
        List<sObject> records = new List<sObject>();
        for(BaseModel record : modelList) {
            if (record.getId() != null) records.add(record.getObj());
        }
        if (!records.isEmpty()) {
            delete records;
        }
    }

    public virtual BaseModel cloneModel() {
        return new BaseModel(mObj.clone(false, true));
    }

    public static void save(List<BaseModel> modelList) {
        List<sObject> updateList = new List<sObject>();
        List<sObject> insertList = new List<sObject>();
        for (BaseModel tempModel : modelList) {
            if (tempModel != null) {
                if(tempModel.getId() != null) {
                    updateList.add(tempModel.getObj());
                } else {
                    insertList.add(tempModel.getObj());
                }
            }
        }
        if (!insertList.isEmpty()) insert insertList;
        if (!updateList.isEmpty()) update updateList;
    }

}
