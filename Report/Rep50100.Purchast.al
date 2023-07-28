report 50102 "Purchase"
{
    DefaultLayout = RDLC;
    RDLCLayout = './PurchaseRequest.rdl';
    ApplicationArea = Basic, Suite;
    Caption = 'Puchase';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Purchase Request"; "Purchase Request")
        {
            RequestFilterFields = "No.","Request Date";
           
            column(Requedt_No; "No.")
            {
                IncludeCaption = true;
            }
            column(Requedt_Name;"Requedt Name")
            {
                IncludeCaption = true;
            }
            column(ITEM;ITEM)
            {
                IncludeCaption = true;
            }
        
            column(Quantity;Quantity)
            {
                IncludeCaption =true;
            }
            column(Requedt_Date; "Request Date")
            {

                IncludeCaption =true;
            }

            trigger OnAfterGetRecord()
            var
                FormatAddr: Codeunit "Format Address";
            begin
                Total := CalculateAmtOfPurchaseLCY;
                if Total < Price then
                    CurrReport.Skip();

            //    if not HideAddr then
            //        FormatAddr.PurchHeaderPayTo();(VendorAddr, "Purchase Request");
            end;
        }
    }

    requestpage
    {
        SaveValues = true;
        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(Quantity; Price)
                    {
                        ApplicationArea = Basic, Suite;
                        AutoFormatType = 1;
                        Caption = 'Amounts';
                        ToolTip = 'Specifies an amount so that the report will only include those customers to which you have sold more than this amount within the specified dates.';
                    }
                    field(HideAddr; HideAddr)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Hide Address Detail';
                        ToolTip = 'Specifies that you do not want the report to show address details for each vendor.';
                    }
                    field(Total; Total)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Total';
                        ToolTip = 'Specifies that you do not want the report to show address details for each vendor.';
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    var
        FormatDocument: Codeunit "Format Document";
    begin
      VendFilter := FormatDocument.GetRecordFiltersWithCaptions("Purchase Request");
    end;

    var
        Price: Decimal;
        HideAddr: Boolean;
        Total: Decimal;
        VendorAddr: array[8] of Text[100];
        VendFilter: Text;
        VendPurchListCaptLbl: Label 'Vendor - Purchase List';
        CurrRptPageNoCaptLbl: Label 'Page';
        MinAmtLCYCaptLbl: Label 'Amounts (LCY) greater than';
        AmtPurchLCYCaptLbl: Label 'Amount of Purchase (LCY)';
        TotRptedAmtofPurchLCYCaptLbl: Label 'Total Reported Amount of Purchase (LCY)';

    local procedure CalculateAmtOfPurchaseLCY(): Decimal
    var
        VendorLedgEntry: Record "Vendor Ledger Entry";
        Amt: Decimal;
        i: Integer;
    begin
        with VendorLedgEntry do begin
            SetCurrentKey("Document Type", "Vendor No.", "Posting Date");
            SetRange("Vendor No.", "Purchase Request"."No.");
            SetFilter("Posting Date", "Purchase Request".GetFilter("Request Date"));
            for i := 1 to 3 do begin
                case i of
                    1:
                        SetRange("Document Type", "Document Type"::Invoice);
                    2:
                        SetRange("Document Type", "Document Type"::"Credit Memo");
                    3:
                        SetRange("Document Type", "Document Type"::Refund);
                end;
                CalcSums("Purchase (LCY)");
                Amt := Amt + "Purchase (LCY)";
            end;
            exit(-Amt);
        end;
    end;

    procedure InitializeRequest(NewMinAmtLCY: Decimal; NewHideAddress: Boolean)
    begin
        Price := NewMinAmtLCY;
        HideAddr := NewHideAddress;
    end;
}


