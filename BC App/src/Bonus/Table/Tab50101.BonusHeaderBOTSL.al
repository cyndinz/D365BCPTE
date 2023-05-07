table 50101 "Bonus Header_BO_TSL"
{
    Caption = 'Bonus Header';
    DataClassification = ToBeClassified;
    DrillDownPageId = "Bonus List_BO_TSL";
    LookupPageId = "Bonus List_BO_TSL";


    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                TestStatusOpen();
            end;
        }
        field(2; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            DataClassification = CustomerContent;
            TableRelation = Customer;
            trigger OnValidate()
            begin
                TestStatusOpen();
            end;
        }
        field(3; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                TestStatusOpen();
            end;
        }
        field(4; "Ending Date"; Date)
        {
            Caption = 'Ending Date';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                TestStatusOpen();
            end;
        }
        field(5; Status; Enum "Bonus Status_BO_TSL")
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
        }
        field(6; "Customer Name"; Text[100])
        {
            Caption = 'Customer Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Customer.Name where("No." = field("Customer No.")));
        }


    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

    procedure TestStatusOpen()
    begin
        //define the field which you testing and you can specify an expected value. If the value will be different, then the standard message will be shown
        TestField(Status, Status::Open);
    end;
}
