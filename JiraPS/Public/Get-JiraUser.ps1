function get-JiraUser{
    param(
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('User', 'Name')]
        [String[]]
        $UserName,

        [Parameter()]
        [System.Management.Automation.PSCredential]
        [System.Management.Automation.Credential()]
        $Credential = [System.Management.Automation.PSCredential]::Empty
        )


        $server = Get-JiraConfigServer -ErrorAction Stop -Debug:$false
        $resourceURi = "$server/rest/api/3/users?maxResults=2000"

        $parameter = @{
            URI        = $resourceURi
            Method     = "Get"
            Credential = $Credential
        }
        Write-Debug "[$($MyInvocation.MyCommand.Name)] Invoking JiraMethod with `$parameter"
            if ($result = Invoke-JiraMethod @parameter) {
               $result | Where-Object {$_.emailAddress -like "*$UserName*"}
            }
        Write-Verbose "[$($MyInvocation.MyCommand.Name)] Complete"
        }