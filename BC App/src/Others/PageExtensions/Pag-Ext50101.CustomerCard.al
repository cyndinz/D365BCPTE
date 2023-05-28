pageextension 50101 CustomerCard extends "Customer Card"
{
    layout
    {
        addafter(Name)
        {
            field(RewardLevel; RewardLevel)
            {
                ApplicationArea = All;
                Caption = 'Reward Level';
                Description = 'Reward level of the customer.';
                ToolTip = 'Specifies the level of reward that the customer has at this point.';
                Editable = false;
            }

            field(RewardPoints; Rec.RewardPoints)
            {
                ApplicationArea = All;
                Caption = 'Reward Points';
                Description = 'Reward points accrued by customer';
                ToolTip = 'Specifies the total number of points that the customer has at this point.';
                Editable = false;
            }
        }

        modify(Name)
        {
            trigger OnAfterValidate()
            var
                TranslationManagement: Codeunit TranslationManagement;
            begin
                if Rec.Name.EndsWith('.co.nz') then begin
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

    // trigger OnAfterGetRecord(); 
    //  var 
    //      CustomerRewardsMgtExt: Codeunit "Customer Rewards Ext Mgt"; 
    //  begin 
    //      // Get the reward level associated with reward points 
    //      RewardLevel := CustomerRewardsMgtExt.GetRewardLevel(Rec.RewardPoints); 
    //  end; 

    var
        RewardLevel: Text;
}





