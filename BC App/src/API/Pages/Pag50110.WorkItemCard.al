page 50110 WorkItemCard
{
    ApplicationArea = All;
    Caption = 'Work Item Card';
    PageType = Card;
    SourceTable = WorkItem;
    
    
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                
                field(ID; Rec.ID)
                {
                    ToolTip = 'Specifies work item ID.';
                }
                field("Type"; Rec."Type")
                {
                    ToolTip = 'Specifies work item type.';
                }
                field("Project Name"; Rec."Project Name")
                {
                    ToolTip = 'Specifies project name.';
                }
                field(Title; Rec.Title)
                {
                    ToolTip = 'Specifies the value of the Title field.';
                }
                field(Sent; Rec.Sent)
                {
                    ToolTip = 'Specifies whether work item has been sent to Azure DevOps.';
                }
            }
        }
    }
}
