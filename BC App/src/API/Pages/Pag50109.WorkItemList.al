page 50109 "Work Item List"
{
    ApplicationArea = All;
    Caption = 'Work Item List';
    PageType = List;
    SourceTable = WorkItem;
    UsageCategory = Lists;
    CardPageId = WorkItemCard;
    

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("ID"; Rec."ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies work item ID.';
                }

                field("Type"; Rec.Type)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies work item type.';
                }

                field("Project Name"; Rec."Project Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies project name.';
                }
                field(Title; Rec.Title)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Title field.';
                }
                field("Sent to Azure DevOps"; Rec.Sent)
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies whether work item has been sent to Azure DevOps.';
                }

            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(SendtoAzureDevOps)
            {
                ApplicationArea = All;
                Caption = 'Send to Azure DevOps';
                Image = PostSendTo;
  
                trigger OnAction()
                var
                    WorkItemsManagement: Codeunit WorkItemsManagement;
                begin
                    WorkItemsManagement.SendWorkItems();
                end;
            }
        }
    }
}
