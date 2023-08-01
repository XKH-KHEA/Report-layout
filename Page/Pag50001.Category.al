page 50101 Category
{
    Caption = 'Category';
    PageType = Card;
    SourceTable = Category;
    ApplicationArea = All;
    UsageCategory = Administration;
    CardPageID = Category;
    Editable = true;
    PromotedActionCategories = 'New,Process,Request,Tester,Request Approval,Print/Send,Order,Release,Posting,Navigate';
    QueryCategory = 'Category';
    RefreshOnActivate = true;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                
                field("ID Categoy"; Rec."ID Categoy")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the ID Categoy field.';
                }
                field(Category; Rec.Category)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Category field.';
                }
                
            }
        }
    }
}
