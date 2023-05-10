table 50107 WorkItem
{
    Caption = 'WorkItem';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; ID; Integer)
        {
            Caption = 'ID';
            DataClassification = CustomerContent;
        }
        field(2; "Type"; Enum "Work Item Type")
        {
            Caption = 'Type';
            DataClassification = CustomerContent;
        }
        field(3; Title; Text[2048])
        {
            Caption = 'Title';
            DataClassification = CustomerContent;
        }
        field(4; "Project Name"; Text[250])
        {
            Caption = 'Project Name';
            DataClassification = CustomerContent;
        }
        field(5; Sent; Boolean)
        {
            Caption = 'Sent to Azure DevOps';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; ID)
        {
            Clustered = true;
        }
    }
}
