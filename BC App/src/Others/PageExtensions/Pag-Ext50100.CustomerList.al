// Welcome to your new AL extension.
// Remember that object names and IDs should be unique across all extensions.
// AL snippets start with t*, like tpageext - give them a try and happy coding!

pageextension 50100 CustomerList extends "Customer List"
{
    // layout
    // {
    //     addlast(Control1)
    //     {
    //         field(Bonuses_BO_TSL; Rec.Bonuses_BO_TSL)
    //         {
    //             ApplicationArea = All;
    //             ToolTip = 'Shows number of assgined bonuses to customer.';
    //         }
    //     }
    // }

    actions
    {
        addlast(navigation)
        {
            action(BonusList_BO_TSL)
            {
                Caption = 'Bonuses';
                ApplicationArea = All;
                Image = Discount;
                RunObject = page "Bonus List_BO_TSL";
                RunPageLink = "Customer No." = field("No.");
                ToolTip = 'Opens Bonus List.';
            }
        }

        addfirst("&Customer")
        {
            action("Reward Levels")
            {
                ApplicationArea = All;
                Image = CustomerRating;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Open the list of reward levels.';

                // trigger OnAction();
                // var
                //     CustomerRewardsExtMgt: Codeunit "Customer Rewards Ext Mgt";
                // begin
                //     if CustomerRewardsExtMgt.IsCustomerRewardsActivated then
                //         CustomerRewardsExtMgt.OpenRewardsLevelPage
                //     else
                //         CustomerRewardsExtMgt.OpenCustomerRewardsWizard;
                // end;
            }
        }
    }



    trigger OnOpenPage();
    begin
        Message('App published: Hello world');
    end;
}

