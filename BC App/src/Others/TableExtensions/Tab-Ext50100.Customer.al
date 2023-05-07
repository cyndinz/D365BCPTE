tableextension 50100 Customer extends Customer
{
    // fields
    // {
    //     field(59000; Bonuses_BO_TSL; Integer)
    //     {
    //         Caption = 'Bonuses';
    //         FieldClass = FlowField;
    //         CalcFormula = count("Bonus Header_BO_TSL" where("Customer No." = field("No.")));
    //         Editable = false;
    //     }

    //     field(59005; "Lookup Value Code_BO_TSL"; Code[10])
    //     {
    //         Caption = 'Lookup Value Code';
    //         TableRelation = "LookupValue_BO_TSL";
    //     }

    // }

    var
        BonusExistsErr: Label 'You can not delete Customer %1 because there is at least one Bonus assigned.', Comment = '%1 = Customer No.';

    trigger OnBeforeDelete()
    var
        BonusHeader: Record "Bonus Header_BO_TSL";

    begin
        if not BonusHeader.IsEmpty() then
            Error(BonusExistsErr, "No.");
    end;
}
