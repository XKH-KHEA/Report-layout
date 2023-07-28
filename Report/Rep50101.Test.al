report 50111 Test
{
  RDLCLayout = './layouts/MyOrderConf.rdl'; 
    Caption = 'My Order Confirmation'; 
    DefaultLayout = RDLC; 
   Dataset 
    { 
        dataitem(SalesHeader; "Sales Header") 
        { 
            column(No; "No.") 
            {   
          } 
 
            column(BilltoCustomerNo; "Bill-to Customer No.") 
            {   
        } 
 
            column(BilltoName; "Bill-to Name") 
            { 
 
            } 
 
            column(BilltoAddress; "Bill-to Address") 
 
            { 
 
            } 
 
            column(BilltoCity; "Bill-to City") 
 
            { 
 
            } 
 
            column(BilltoPostCode; "Bill-to Post Code") 
 
            { 
 
            } 
 
        
        dataitem(Line; "Sales Line") 
        {
        DataItemLink = "Document No." = FIELD("No."); 
         DataItemLinkReference = SalesHeader; 
         DataItemTableView = SORTING("Document No.", "Line No."); 
 
         column(No_;"No.") 
         {} 
 
         column(Description;Description) 
         {} 
 
  } 
        } 
 
    } 
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
}
