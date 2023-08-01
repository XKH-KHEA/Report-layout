page 50112 Request
{
    Caption = 'Request';
    PageType = Card;
    SourceTable = "Purchase Request";
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("ID Categoy"; Rec."ID Categoy")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the ID Categoy field.';
                }
                field(ITEM; Rec.ITEM)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the ITEM field.';
                }
                field(UOM; Rec.UOM)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the UOM field.';
                }
                field(Loocation; Rec.Loocation)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Loocation field.';
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Email field.';
                }
                field(Decrition; Rec.Decrition)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Decrition field.';
                }
                field("Order No"; Rec."Order No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Order No field.';
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Quantity field.';
                }
                field("PO No."; Rec."PO No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Po No field.';
                }
                field("Quote No"; Rec."Quote No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Quote No field.';
                }
                field("Requedt Name"; Rec."Requedt Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Requedt Name field.';
                }
                field("Request Date"; Rec."Request Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Request Date field.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                }
            }
        }
        area(factboxes)
        {
            part(Control82; "Vendor Picture")
            {
                ApplicationArea = Basic, Suite;
               // SubPageLink = "No." = FIELD("No.");
                Visible = NOT IsOfficeAddin;
            }
            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = CONST(23),
                              "No." = FIELD("No.");
            }
            part(VendorStatisticsFactBox; "Vendor Statistics FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "No." = FIELD("No.");
                            //   "Currency Filter" = FIELD("Currency Filter"),
                            //   "Date Filter" = FIELD("Date Filter"),
                            //   "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                            //   "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
            }
            part(AgedAccPayableChart; "Aged Acc. Payable Chart")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "No." = FIELD("No.");
               Visible = IsOfficeAddin;
            }
            part(VendorHistBuyFromFactBox; "Vendor Hist. Buy-from FactBox")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "No." = FIELD("No.");
                            //   "Currency Filter" = FIELD("Currency Filter"),
                            //   "Date Filter" = FIELD("Date Filter"),
                            //   "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                            //   "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
            }
            part(VendorHistPayToFactBox; "Vendor Hist. Pay-to FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "No." = FIELD("No.");
                              //"Currency Filter" = FIELD("Currency Filter"),
                             // "Date Filter" = FIELD("Date Filter"),
                            //  "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                            //  "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
               // Visible = false;
            }
            part(WorkflowStatus; "Workflow Status FactBox")
            {
                ApplicationArea = All;
                Editable = false;
                Enabled = false;
                ShowFilter = false;
               // Visible = ShowWorkflowStatus;
            }
            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
            }
        }
    }
     local procedure OnOpenPageFunc()
    var
        IntegrationTableMapping: Record "Integration Table Mapping";
        EnvironmentInfo: Codeunit "Environment Information";
        CRMIntegrationManagement: Codeunit "CRM Integration Management";
        PriceCalculationMgt: Codeunit "Price Calculation Mgt.";
    begin
        IsOfficeAddin := OfficeMgt.IsAvailable();
     end;
    var 
     OfficeMgt: Codeunit "Office Management";
     IsOfficeAddin: Boolean;
}
