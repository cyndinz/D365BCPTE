//TODO: In BC cloud am I correct in assuming when emailing a document to a vendor or customer eg a sales order confirmation to a customer that it's a one order one email process.  There is no functionality to send x5 order confirmations for x5 sales orders to the same customer as a single email to that customer is there?  Have we ever created a customer extension to achieve this - is it even possible?  ie could you choose more and select all the sales orders that relate to a single customer you want to send confirmations to and then click a button that creates the 5 documents and attaches them to a single email?

pageextension 50102 SalesOrder extends "Sales Order List"
{
    actions
    {
        addafter("&Order Confirmation")
        {
            action(SendCustom)
            {
                ApplicationArea = Baisc, Suite;
                Caption = 'Send Custom';
                Promoted = true;
                PromotedCategory = Category8;
                Ellipsis = true;
                Image = SendToMultiple;
                ToolTip = 'Prepare to send the document according to the customer''s sending profile, such as attached to an email. The Send document to window opens where you can confirm or select a sending profile.';
                trigger OnAction()
                begin
                    CreateDocumentsInBulk();
                end;
            }
        }
    }

    var
        ReportDistributionMgt: Codeunit "Report Distribution Management";
        SalesHeader: Record "Sales Header";
        DocumentSendingProfile: Record "Document Sending Profile";
        DummyReportSelections: Record "Report Selections";
        DocumentTypeTxt: Text[50];

    local procedure CreateDocumentsInBulk()
    begin
        CurrPage.SetSelectionFilter(SalesHeader);
        //DocumentTypeTxt := ReportDistributionMgt.GetFullDocumentTypeText(SalesHeader);
        DocumentTypeTxt := 'Order Confirmation';
        Message('Test lines in total: %1', SalesHeader.Count()); // this line is for testing purpose
        if SalesHeader.FindSet() then
            repeat
                DocumentSendingProfile.SendCustomerRecords(
                  DummyReportSelections.Usage::"S.Order".AsInteger(), SalesHeader, DocumentTypeTxt, SalesHeader."Bill-to Customer No.", SalesHeader."No.", SalesHeader.FieldNo("Bill-to Customer No."), SalesHeader.FieldNo("No."));
            until SalesHeader.Next() = 0;
    end;


}
