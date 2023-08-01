table 50105 Category
{
    Caption = 'Category';
    DataClassification = SystemMetadata;
    LookupPageID = Category;
    fields
    {
        
        field(1; "ID Categoy"; Code[20])
        {
            Caption = 'ID Categoy';
            DataClassification = SystemMetadata;
           // TableRelation = Category;
        }
        field(2; Category; Text[100])
        {
            Caption = 'Category';
            DataClassification = SystemMetadata;
        }
    }
    keys
    {
        key(PK; "ID Categoy")
        {
            Clustered = true;
        }
    }
}
