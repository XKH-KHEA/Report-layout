table 50103 "Purchase Request"
{

    Caption = 'Purchase Request';
    DataClassification =SystemMetadata;
   // DataCaptionFields = "No.", "Buy-from Vendor Name";
    LookupPageID = "Purchase Request";
    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = SystemMetadata;
           // TableRelation = "Purchase Request";
        }
        field(2; "Requedt Name"; Text[100])
        {
            Caption = 'Requedt Name';
            DataClassification = SystemMetadata;
        }
        field(3; ITEM; Text[100])
        {
            Caption = 'ITEM';
            DataClassification = SystemMetadata;
        }
        field(4; Quantity; Code[100])
        {
            Caption = 'Quantity';
            DataClassification = SystemMetadata;
        }
         field(7; Loocation; Code[100])
        {
            Caption = 'Loocation';
            DataClassification = SystemMetadata;
        }
         field(8; UOM; Code[100])
        {
            Caption = 'UOM';
            DataClassification = SystemMetadata;
        }
         field(5; Decrition; Code[100])
        {
            Caption = 'Decrition';
            DataClassification = SystemMetadata;
        }
         field(6; "Request Date"; Date)
        {
            Caption = 'Request Date';
            DataClassification = SystemMetadata;
        }
        field(9; "Quote No"; Code[100])
        {
            Caption = 'Quote No';
            DataClassification = SystemMetadata;
        }
        field(10; "Order No"; Code[100])
        {
            Caption = 'Order No';
            DataClassification = SystemMetadata;
            
        }
          field(11; "Status"; Code[100])
        {
            Caption = 'Status';
            DataClassification = SystemMetadata;
            
        }
          field(12; "PO No.";  Integer)
        {
            Caption = 'Po No';
            DataClassification = SystemMetadata;
            
        } 
        field(13; "ID Categoy"; Code[20])
        {
            Caption = 'ID Categoy';
            DataClassification = SystemMetadata;
            TableRelation = Category;
        }

         field(102; "E-Mail"; Text[80])
        {
            Caption = 'Email';
            ExtendedDatatype = EMail;

            trigger OnValidate()
            var
                MailManagement: Codeunit "Mail Management";
            begin
                if "E-Mail" = '' then
                    exit;
                MailManagement.CheckValidEmailAddresses("E-Mail");
            end;
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
}


