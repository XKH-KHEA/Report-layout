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
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Requedt Name","PO No.";

            column(Requedt_No; "No.")
            {
                IncludeCaption = true;
            }
            column(Requedt_Name; "Requedt Name")
            {
                IncludeCaption = true;
            }
            column(ITEM; ITEM)
            {
                IncludeCaption = true;
            }

            column(Quantity; Quantity)
            {
                IncludeCaption = true;
            }
            column(UOM; UOM)
            {
                IncludeCaption = true;
            }
            column(Loocation; Loocation)
            {
                IncludeCaption = true;
            }
            column(Decrition; Decrition)
            {
                IncludeCaption = true;
            }
            column(Quote_No; "Quote No")
            {
                IncludeCaption = true;
            }
            column(Order_No; "Order No")
            {
                IncludeCaption = true;
            }
            column(Status; Status)
            {
                IncludeCaption = true;
            }
            column(Requedt_Date; "Request Date")
            {

                IncludeCaption = true;
            }
            dataitem(Khmer; "Integer")
            {
                DataItemTableView = SORTING(Number);

                trigger OnPreDataItem()
                begin
                     SetRange(Number, 1, "Purchase Request"."PO No.");
                end;
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
        Puchase: Record "Purchase Request";
        Amt: Decimal;
        i: Integer;
    begin
        with Puchase do begin
            SetCurrentKey("PO No.", "Order No","Request Date");
            SetRange(ITEM, "Purchase Request"."No.");
            SetFilter("Request Date", "Purchase Request".GetFilter("Request Date"));
            for i := 1 to 3 do begin
                case i of
                    1:
                        SetRange("PO No.",1, "Purchase Request"."PO No.");
                   // 2:
                       // SetRange("Document Type", "Document Type"::"Credit Memo");
                   // 3:
                      //  SetRange("Document Type", "Document Type"::Refund);
                end;
                //CalcSums(Quantity);
                Amt := Amt + Price;
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


