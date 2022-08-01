# This is a common function to release excel objects

function Release-Ref ($ref) {

    ([System.Runtime.InteropServices.Marshal]::ReleaseComObject(

    [System.__ComObject]$ref) -gt 0)

    [System.GC]::Collect()

    [System.GC]::WaitForPendingFinalizers()

}


# Create excel object

$excel = new-object -comobject excel.application 

$excel.Visible = $True 

 # Directory location where we have our excel files

$ExcelFilesLocation = "C:\Data\"

 #Excel Filename

$ExcelFileName = "MyWB1.xlsx"

 # Open our excel file

$UserWorkBook = $excel.Workbooks.Open($ExcelFilesLocation + $ExcelFileName) 

# Here Item(1) refers to sheet 1 of of the workbook. If we want to access sheet 10, we have to modifythe code to Item(10)

$UserWorksheet = $UserWorkBook.Worksheets.Item(1)

 # This is counter which will help to iterrate trough the loop. This is simply row count

# I am taking row count as 2, because the first row in my case is header. So we dont need to read the header data

$rowNum = 2

Do {

    # Reading the first column of the current row

    $FirstName = $UserWorksheet.Cells.Item($rowNum, 1).Value()

    # Reading the second column of the current row

    $LastName = $UserWorksheet.Cells.Item($rowNum, 2).Value()

    # Reading the first column of the current row. I am assuming that this is an email id field

    $Location = $UserWorksheet.Cells.Item($rowNum, 3).Value()

    # Move to next row

    Write-Host "$FirstName $LastName is in $Location"

    $rowNum++

} While ($UserWorksheet.Cells.Item($rowNum,1).Value() -ne $null)


# Exiting the excel object

$excel.Quit()

 #Release all the objects used above

$a = Release-Ref($UserWorksheet)

$a = Release-Ref($UserWorkBook) 

$a = Release-Ref($excel)

 

