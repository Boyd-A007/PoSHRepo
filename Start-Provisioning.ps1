workflow ProvisionMe{
    param([string] $DataFile=".\Sequence.csv")

    sequence{
        import-csv $DataFile | %{Start-Process -FilePath $($_.Command) -ArgumentList $($_.arguments) -NoNewWindow -Wait}

    }
}