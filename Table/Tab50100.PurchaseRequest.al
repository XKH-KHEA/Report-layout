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
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
}


