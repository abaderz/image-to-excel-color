VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "ThisWorkbook"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True
Sub ColorCellsBasedOnImage()
    ' Ask the user for an image file
    Dim ImageFile As String
    ImageFile = Application.GetOpenFilename(FileFilter:="Image Files,*.jpg;*.png;*.bmp", Title:="Select an Image File", MultiSelect:=False)

    If ImageFile = "False" Then Exit Sub ' User cancelled

    ' Define the path to the Python script and the image file
    Dim PythonScript As String
    PythonScript = "C:\Users\bader\OneDrive\Bureau\cours\VBA\calculate_mean_color.py"

    ' Run the Python script with the image file as an argument
    Dim Command As String
    Command = "python " & PythonScript & " " & """" & ImageFile & """"
    Dim results As String
    results = CreateObject("WScript.Shell").Exec(Command).StdOut.ReadAll

    ' Split the results into lines
    Dim MeanColors() As String
    MeanColors = Split(results, vbCrLf)

    ' Explicitly select the active sheet
    Dim ws As Worksheet
    Set ws = ActiveSheet

    ' Color the cells in the active sheet based on the mean colors
    Dim i As Long, j As Long
    Dim cellIndex As Long
    cellIndex = 0
    For i = 1 To 20
        For j = 1 To 20
            ' Check if there are enough mean colors
            If cellIndex >= UBound(MeanColors) Then Exit Sub
            
            ' Split the mean color into components
            Dim colorComponents() As String
            colorComponents = Split(MeanColors(cellIndex), ",")
            
            ' Check if the mean color has correct format
            If UBound(colorComponents) < 2 Then Exit Sub
            
            Dim R As Integer, G As Integer, B As Integer
            R = Mid(colorComponents(0), 2)
            G = colorComponents(1)
            B = Left(colorComponents(2), Len(colorComponents(2)) - 1)
            
            ' Color the corresponding cell with the mean color
            With ws.Cells(i, j).Interior
                .Color = RGB(R, G, B)
            End With
            
            cellIndex = cellIndex + 1
        Next j
    Next i
End Sub

