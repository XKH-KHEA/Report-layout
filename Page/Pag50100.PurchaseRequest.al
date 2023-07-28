page 50101 "Purchase Request"
{
    Caption = 'Purchase Request';
    PageType = List;
    SourceTable = "Purchase Request";
    ApplicationArea = All;
    UsageCategory = Administration;
    Editable = true;
    CardPageID = "Purchase Request";
    PromotedActionCategories = 'New,Process,Request,Tester,Request Approval,Print/Send,Order,Release,Posting,Navigate';
    QueryCategory = 'Purchase Resquest';
     RefreshOnActivate = true;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                 field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                 field("Requedt Name"; Rec."Requedt Name")
                {
                    ApplicationArea = All;
                }

                field(ITEM; Rec.ITEM)
                {
                    ApplicationArea = All;
                }
                field(Decrition; Rec.Decrition)
                {
                    ApplicationArea = All;
                }
                field("Order Date"; Rec."Request Date"  )
                {
                    ApplicationArea = All;
                }
               
                  field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
            }
        }
    } 
    actions {
        area(Processing)
        {      
         group(Action2)
         {
            Caption = 'New'   ;
            Image = Absence;   
              action(addss)
              {
                Caption = 'New';
                ApplicationArea = all;
                Image = AddAction;
                Promoted =true;
                PromotedCategory = New;
                PromotedIsBig =true;
                PromotedOnly = true;
              }
         }
     group(News)          
        {

        Caption = 'New';
        Image = New;
            action(New)
            {
                Caption ='New';
                Image = New;
                PromotedCategory = New;
                Promoted =true;
                PromotedIsBig =true;
                trigger OnAction()
                begin
                    Message('khmer');
                end;
            }
        }
        }
        area (Reporting){
           
             group(General1)
            {
                Caption = 'General';   
                Image = GetEntries;         
                  action("Purchase request")
                {
                    ApplicationArea = Suite;
                    Caption = 'Purchase request Report';
                    Image = "Report";
                    RunObject = Report Purchase;
                    ToolTip = 'View a list of the vendors from whom you purchase the most or to whom you owe the most.';
                }
                  action("Test")
                {
                    ApplicationArea = Suite;
                    Caption = 'Test';
                    Image = "Report";
                    RunObject = Report "Test";
                    ToolTip = 'View a list of the vendors from whom you purchase the most or to whom you owe the most.';
                }
            }
        }

    }
}



