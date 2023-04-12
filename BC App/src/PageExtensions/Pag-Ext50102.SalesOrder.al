pageextension 50102 SalesOrder extends "Sales Order List"
{
    actions
    {
        addafter("&Order Confirmation")
        {
            action(EmailBulk)
            {
                ApplicationArea = Baisc, Suite;
                Caption = 'Email Bulk';
                Ellipsis = true;
                Image = Email;
                ToolTip = 'Send an order confirmation by email. The Send Email window opens prefilled for the customer so you can add or change information before you send the email.';

                trigger OnAction()
                begin
                    DocPrint.EmailSalesHeader(Rec);
                end;
            }

        }
    }

    var
        DocPrint: Codeunit "Document-Print";
}
