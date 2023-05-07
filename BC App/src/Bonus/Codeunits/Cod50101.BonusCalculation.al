codeunit 50101 "Bonus Calculation_BO_TSL"
{
    /*Subscriber #1 - insert bonus entry after posting the invoice*/

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterSalesInvLineInsert', '', true, true)]
    local procedure RunOnAfterSalesInvLineInsert(var SalesInvLine: Record "Sales Invoice Line")
    begin
        CalculateBonus(SalesInvLine);
    end;

    local procedure CalculateBonus(var SalesInvoiceLine: Record "Sales Invoice Line")
    var
        BonusHeader: Record "Bonus Header_BO_TSL";
    begin
        if SalesInvoiceLine.Type <> SalesInvoiceLine.Type::Item then
            exit;
        BonusHeader.SetRange("Customer No.", SalesInvoiceLine."Bill-to Customer No.");
        BonusHeader.SetRange(Status, BonusHeader.Status::Released);
        BonusHeader.SetFilter("Starting Date", '..%1', SalesInvoiceLine."Posting Date");
        BonusHeader.SetFilter("Ending Date", '%1..', SalesInvoiceLine."Posting Date");
        if BonusHeader.IsEmpty() then
            exit;
        if BonusHeader.FindSet() then
            repeat
                FindBonusForAllItems(BonusHeader, SalesInvoiceLine);
                FindBonusForOneItem(BonusHeader, SalesInvoiceLine);
            until BonusHeader.Next() = 0;
    end;

    local procedure FindBonusForAllItems(var BonusHeader: Record "Bonus Header_BO_TSL"; var SalesInvoiceLine: Record "Sales Invoice Line")
    var
        BonusLine: Record "Bonus Line_BO_TSL";
    begin
        BonusLine.SetRange("Document No.", BonusHeader."No.");
        BonusLine.SetRange(Type, BonusLine.Type::"All Items");
        if BonusLine.FindFirst() then
            InsertBonusEntry(BonusLine, SalesInvoiceLine);
    end;


    local procedure FindBonusForOneItem(var BonusHeader: Record "Bonus Header_BO_TSL"; var SalesInvoiceLine: Record "Sales Invoice Line");
    var
        BonusLine: Record "Bonus Line_BO_TSL";
    begin
        BonusLine.SetRange("Document No.", BonusHeader."No.");
        BonusLine.SetRange(Type, BonusLine.Type::Item);
        BonusLine.SetRange("Item No.", SalesInvoiceLine."No.");
        if BonusLine.FindFirst() then
            InsertBonusEntry(BonusLine, SalesInvoiceLine);
    end;

    local procedure InsertBonusEntry(var BonusLine: Record "Bonus Line_BO_TSL"; var SalesInvoiceLine: Record "Sales Invoice Line")
    var
        BonusEntry: Record "Bonus Entry_BO_TSL";
        EntryNo: Integer;
    begin
        if BonusEntry.FindLast() then
            EntryNo := BonusEntry."Entry No." + 1
        else
            EntryNo := 1;
        BonusEntry.Init();
        BonusEntry."Entry No." := EntryNo;
        BonusEntry."Bonus No." := BonusLine."Document No.";
        BonusEntry."Document No." := SalesInvoiceLine."Document No.";
        BonusEntry."Item No." := SalesInvoiceLine."No.";
        BonusEntry."Posting Date" := SalesInvoiceLine."Posting Date";
        BonusEntry."Bonus Amount" := SalesInvoiceLine."Line Amount" * BonusLine."Bonus Perc." / 100;
        BonusEntry.Insert();
    end;




    /*Subscriber #2 - update salesline discount and amount if bonus applies after release the sales order*/

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", 'OnBeforeReleaseSalesDoc', '', true, false)]
    // local procedure ReleaseSalesDocument_BeforeReleaseSalesDoc(var SalesHeader: Record "Sales Header")
    // begin
    //     UpdateBonus(SalesHeader);
    // end;

    // local procedure UpdateBonus(var SalesHeader: Record "Sales Header")
    // var
    //     BonusHeader: Record "Bonus Header_BO_TSL";

    // begin
    //     if SalesHeader."Document Type" <> SalesHeader."Document Type"::order then
    //         exit;

    //     BonusHeader.SetRange("Customer No.", SalesHeader."Bill-to Customer No.");
    //     BonusHeader.SetRange(Status, BonusHeader.Status::Released);
    //     BonusHeader.SetFilter("Starting Date", '..%1', SalesHeader."Posting Date");
    //     BonusHeader.SetFilter("Ending Date", '%1..', SalesHeader."Posting Date");
    //     if BonusHeader.IsEmpty() then
    //         exit;
    //     if BonusHeader.FindSet() then
    //         repeat
    //             AddBonusForAllItems(BonusHeader, SalesHeader);
    //             AddBonusForOneItem(BonusHeader, SalesHeader);
    //         until BonusHeader.Next() = 0;
    // end;




    // local procedure AddBonusForAllItems(var BonusHeader: Record "Bonus Header_BO_TSL"; var SalesHeader: Record "Sales Header")
    // var
    //     BonusLine: Record "Bonus Line_BO_TSL";
    // begin
    //     BonusLine.Reset();
    //     BonusLine.SetRange("Document No.", BonusHeader."No.");
    //     BonusLine.SetRange(Type, BonusLine.Type::"All Items");

    //     if BonusLine.FindSet() then
    //         repeat
    //             AddBonus := true;
    //             InsertLineDiscount(AddBonus, BonusLine, SalesHeader);
    //         until BonusLine.Next() = 0;
    // end;


    // local procedure AddBonusForOneItem(var BonusHeader: Record "Bonus Header_BO_TSL"; var SalesHeader: Record "Sales Header");
    // var
    //     BonusLine: Record "Bonus Line_BO_TSL";
    // begin
    //     BonusLine.SetRange("Document No.", BonusHeader."No.");
    //     BonusLine.SetRange(Type, BonusLine.Type::Item);

    //     if BonusLine.FindSet() then
    //         repeat
    //             AddBonus := true;
    //             InsertLineDiscount(AddBonus, BonusLine, SalesHeader);
    //         until BonusLine.Next() = 0;
    // end;


    // local procedure InsertLineDiscount(UpdateLineDiscount: Boolean; var BonusLine: Record "Bonus Line_BO_TSL"; var SalesHeader: Record "Sales Header")
    // var
    //     SalesLine: Record "Sales Line";
    // begin
    //     if UpdateLineDiscount = true then begin
    //         SalesLine.Reset();
    //         SalesLine.SetRange("Document No.", SalesHeader."No.");
    //         if BonusLine.Type = BonusLine.Type::Item then
    //             SalesLine.SetRange("No.", BonusLine."Item No.");

    //         if SalesLine.FindSet() then
    //             repeat
    //                 SalesLine."Line Discount %" := BonusLine."Bonus Perc.";
    //                 SalesLine."Line Amount" := SalesLine."Line Amount" * (SalesLine."Line Discount %" / 100);
    //                 SalesLine.Modify(true);
    //             until SalesLine.Next() = 0;
    //     end;
    // end;

    // var
    //     AddBonus: Boolean;



    /*Subscriber #3 - update salesline discount and amount if bonus applies when choose the salesline*/

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnBeforeValidateEvent', 'Line Discount %', true, false)]
    local procedure SalesLine_AfterValidateLineDiscPerc(var Rec: Record "Sales Line"; var xRec: Record "Sales Line")

    var
        BonusLine: Record "Bonus Line_BO_TSL";
        BonusHeader: Record "Bonus Header_BO_TSL";
    begin
        BonusHeader.SetRange("Customer No.", Rec."Sell-to Customer No.");
        if BonusHeader.FindSet() then
            repeat
                BonusLine.SetRange("Document No.", BonusHeader."No.");
                BonusLine.SetRange(Type, BonusLine.Type::Item);
                BonusLine.SetRange("Item No.", Rec."No.");
                if BonusLine.FindSet() then
                    repeat
                        rec."Line Discount %" := BonusLine."Bonus Perc.";
                    until BonusLine.Next() = 0;
            until BonusHeader.Next() = 0;

    end;

}
