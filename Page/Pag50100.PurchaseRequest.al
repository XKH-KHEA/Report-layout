page 50109 "Purchase Request"
{
    Caption = 'Purchase Request';
    PageType = List;
    SourceTable = "Purchase Request";
    ApplicationArea = All;
    UsageCategory = Administration;
    Editable = true;
    CardPageID = Request;
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
                field("Order Date"; Rec."Request Date")
                {
                    ApplicationArea = All;
                }

                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field(UOM; Rec.UOM)
                {
                    ApplicationArea = all;
                }
                field(Loocation; Rec.Loocation)
                {
                    ApplicationArea = all;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = all;
                }
                field("Quote No"; Rec."Quote No")
                {
                    ApplicationArea = all;
                }
                field("Order No"; Rec."Order No")
                {
                    ApplicationArea = all;
                }
   
            }
        }
        area(factboxes)
        {
            part("Power BI Report FactBox"; "Power BI Report FactBox")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Power BI Reports';
                Visible = PowerBIVisible;
            }
            part(VendorDetailsFactBox; "Vendor Details FactBox")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "No." = FIELD("No."),
                              "ABN Division Part No." = FIELD(Decrition),
                              ABN = FIELD(ITEM),
                              Address = FIELD(Quantity),
                              "Global Dimension 2 Filter" = FIELD(Decrition);
                Visible = false;
            }
            part(VendorStatisticsFactBox; "Vendor Statistics FactBox")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "No." = FIELD("No."),
                            "ABN Division Part No." = FIELD(Decrition),
                              ABN = FIELD(ITEM),
                              Address = FIELD(Quantity),
                              "Global Dimension 2 Filter" = FIELD(Decrition);
            }
            part(VendorHistBuyFromFactBox; "Vendor Hist. Buy-from FactBox")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "No." = FIELD("No."),
                             "ABN Division Part No." = FIELD(Decrition),
                              ABN = FIELD(ITEM),
                              Address = FIELD(Quantity),
                              "Global Dimension 2 Filter" = FIELD(Decrition);
            }
            part(VendorHistPayToFactBox; "Vendor Hist. Pay-to FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "No." = FIELD("No."),
                            "ABN Division Part No." = FIELD(Decrition),
                              ABN = FIELD(ITEM),
                              Address = FIELD(Quantity),
                              "Global Dimension 2 Filter" = FIELD(Decrition);
                Visible = false;
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
    actions
    {
        area(Processing)
        {
            group(Action2)
            {
                Caption = 'New';
                Image = Absence;
                action(addss)
                {
                    Caption = 'New';
                    ApplicationArea = all;
                    Image = AddAction;
                    Promoted = true;
                    PromotedCategory = New;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                }
            }
            group(News)
            {

                Caption = 'New';
                Image = New;
                action(New)
                {
                    Caption = 'New';
                    Image = New;
                    PromotedCategory = New;
                    Promoted = true;
                    PromotedIsBig = true;
                    trigger OnAction()
                    begin
                        Message('khmer');
                    end;
                }
            }
             action(category)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'category';
                Image = Create;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page Category;
                RunPageMode = Create;
                ToolTip = 'Opens vendor ledger entries for the selected vendor with invoices that have not been paid yet.';
            }
             action(Email)
            {
                ApplicationArea = All;
                Caption = 'Send Email';
                Image = Email;
                ToolTip = 'Send an email to this vendor.';
                Promoted = true;
                PromotedCategory = Process;
                Enabled = CanSendEmail;
                trigger OnAction()
                var
                    TempEmailItem: Record "Email Item" temporary;
                    EmailScenario: Enum "Email Scenario";
                begin
                    TempEmailItem.AddSourceDocument(Database::"Purchase Request", Rec.SystemId);
                    TempEmailitem."Send to" := Rec."E-Mail";
                    TempEmailItem.Send(false, EmailScenario::Default);
                end;
            }
        }
        area(Reporting)
        {

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
     trigger OnAfterGetCurrRecord()
    var
        Vendor: Record "Purchase Request";
        CRMCouplingManagement: Codeunit "CRM Coupling Management";
        RecordId: RecordId;
    begin
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RecordId);

        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RecordId);

        WorkflowWebhookManagement.GetCanRequestAndCanCancel(RecordId, CanRequestApprovalForFlow, CanCancelApprovalForFlow);

        CRMIsCoupledToRecord := CRMIntegrationEnabled or CDSIntegrationEnabled;
        if CRMIsCoupledToRecord then
            CRMIsCoupledToRecord := CRMCouplingManagement.IsRecordCoupledToCRM(RecordId);

        // Contextual Power BI FactBox: send data to filter the report in the FactBox
       // CurrPage."Power BI Report FactBox".PAGE.SetCurrentListSelection(, false, PowerBIVisible);

        CurrPage.SetSelectionFilter(Vendor);
        CanSendEmail := Vendor.Count() = 1;
    end;
    var
        //PowerBIVisible: Boolean;
        
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        ReadSoftOCRMasterDataSync: Codeunit "ReadSoft OCR Master Data Sync";
        WorkflowWebhookManagement: Codeunit "Workflow Webhook Management";
        [InDataSet]
        CanSendEmail: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        PowerBIVisible: Boolean;
        ResyncVisible: Boolean;
        CanRequestApprovalForFlow: Boolean;
        CanCancelApprovalForFlow: Boolean;
        CRMIntegrationEnabled: Boolean;
        CDSIntegrationEnabled: Boolean;
        CRMIsCoupledToRecord: Boolean;
        BlockedFilterApplied: Boolean;
        ExtendedPriceEnabled: Boolean;
}



