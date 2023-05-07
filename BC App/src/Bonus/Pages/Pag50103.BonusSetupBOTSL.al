page 50103 "Bonus Setup_BO_TSL"
{
    ApplicationArea = All;
    Caption = 'Bonus Setup';
    PageType = Card;
    SourceTable = "Bonus Setup_BO_TSL";
    UsageCategory = Administration;
    DeleteAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(content)
        {
            group(Numbering)
            {
                Caption = 'Numbering';
                field("Bonus No."; Rec."Bonus No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies number series what will be used for bonus numbers.';
                }
            }
        }
    }
    trigger OnOpenPage()
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.init();
            Rec.insert();
        end;
    end;
}

