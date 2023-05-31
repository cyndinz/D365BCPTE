page 50113 "Reward Level"
{
    APIGroup = 'Cindy';
    APIPublisher = 'Cindy';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'rewardLevel';
    DelayedInsert = true;
    EntityName = 'rewardLevel';
    EntitySetName = 'rewardLevels';
    PageType = API;
    SourceTable = "Reward Level";


    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(level; Rec.Level)
                {
                    Caption = 'Level';
                }
                field(minimumRewardPoints; Rec."Minimum Reward Points")
                {
                    Caption = 'Minimum Reward Points';
                }
                field(systemCreatedAt; Rec.SystemCreatedAt)
                {
                    Caption = 'SystemCreatedAt';
                }
                field(systemCreatedBy; Rec.SystemCreatedBy)
                {
                    Caption = 'SystemCreatedBy';
                }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
                field(systemModifiedAt; Rec.SystemModifiedAt)
                {
                    Caption = 'SystemModifiedAt';
                }
                field(systemModifiedBy; Rec.SystemModifiedBy)
                {
                    Caption = 'SystemModifiedBy';
                }
            }
        }
    }
}
