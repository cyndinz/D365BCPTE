xmlport 50100 MyXmlportExportCustomer
{
    Caption = 'MyXmlportExportCustomer';
    Direction = Export;
    Format = VariableText;
    FieldSeparator = ';';
    RecordSeparator = '<LF>';

    schema
    {
        textelement(RootNodeName)
        {
            tableelement(Customer; Customer)
            {
                fieldattribute(No; Customer."No.")
                {
                }
                fieldattribute(Name; Customer.Name)
                {
                }
                fieldattribute(Address; Customer.Address)
                {
                }
                fieldattribute(City; Customer.City)
                {
                }
                fieldattribute(Country; Customer."Country/Region Code")
                {
                    trigger OnAfterAssignField()
                    begin
                        //Executed after a field has been assigned a value and before it is validated and imported.
                    end;
                }
            }
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
}


