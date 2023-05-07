pageextension 50101 CustomerCard extends "Customer Card"
{
    layout
    {
        modify(Name)
        {
            trigger OnAfterValidate()
            var
                TranslationManagement: Codeunit TranslationManagement;
            begin
                if Name.EndsWith('.co.nz') then begin
                    if Confirm('Do you want to retrieve company details?', false) then
                        TranslationManagement.LookupAddressInfo(Rec.Name, Rec);
                end;
            end;
        }

        // addlast(General)
        // {
        //     field("Lookup Value Code_BO_TSL"; Rec."Lookup Value Code_BO_TSL")
        //     {
        //         ApplicationArea = All;
        //         ToolTip = 'specifies lookup value code';
        //     }

        // }
    }
}
