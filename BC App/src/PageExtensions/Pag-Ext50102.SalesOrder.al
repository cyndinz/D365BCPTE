pageextension 50102 SalesOrder extends "Sales Order List"
{
    actions
    {
        addlast(processing)
        {
            action(SendCustom)
            {
                ApplicationArea = Baisc, Suite;
                Caption = 'Send Custom';
                Ellipsis = true;
                Image = Email;
                ToolTip = 'Prepare to send the document according to the customer''s sending profile, such as attached to an email. The Send document to window opens where you can confirm or select a sending profile.';
                trigger OnAction()
                var
                    HeaderName: Variant;
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
