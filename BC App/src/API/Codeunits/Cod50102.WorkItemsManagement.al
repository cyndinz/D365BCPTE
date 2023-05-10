codeunit 50102 WorkItemsManagement
{
    procedure SendWorkItems()
    var
        AuthString: Text;
        Base64Convert: Codeunit "Base64 Convert";
        PAT: Text;
        OrganizationName: Text;
        HttpClient: HttpClient;
        response: HttpResponseMessage;
        WorkItem: Record WorkItem;
        json: JsonObject;
        jsonArray: JsonArray;
        uri: Text;
        content: HttpContent;
        contentHeaders: HttpHeaders;
        responseText: Text;
        contentText: Text;
    begin
        OrganizationName := '{org}';
        PAT := '{PAT}';
        AuthString := Base64Convert.ToBase64(':' + PAT);
        AuthString := StrSubstNo('Basic %1', AuthString);
        HttpClient.DefaultRequestHeaders().Add('Authorization', AuthString);

        WorkItem.SetRange(Sent, false);
        if WorkItem.FindSet(true) then
            repeat
                // Create the json request body
                json.Add('op', 'add');
                json.Add('path', '/fields/System.Title');
                json.Add('value', WorkItem.Title);
                jsonArray.Add(json);
                uri := 'https://dev.azure.com/' + OrganizationName + '/' + WorkItem."Project Name" + '/_apis/wit/workitems/$' + Format(WorkItem.Type) + '?api-version=7.1-preview.3';
                HttpClient.SetBaseAddress(uri);
                jsonArray.WriteTo(contentText);
                content.WriteFrom(contentText);

                // Retrieve the contentHeaders associated with the content
                content.GetHeaders(contentHeaders);
                contentHeaders.Clear();
                contentHeaders.Add('Content-Type', 'application/json-patch+json');
                HttpClient.Post(uri, content, response);

                // Read the response content as json
                response.Content().ReadAs(responseText);

                // Here you can parse the json response
                WorkItem.Sent := true;
                WorkItem.Modify();
            until WorkItem.Next() = 0;
    end;
}
