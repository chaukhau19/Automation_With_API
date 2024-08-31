# encoding=utf8
import xlrd
import sys

def get_data_from_spreadsheet(fileName, sheetname): 
    workbook = xlrd.open_workbook(fileName)
    worksheet = workbook.sheet_by_name(sheetname)
    rowEndIndex = worksheet.nrows - 1
    colEndIndex = worksheet.ncols - 1
    rowStartIndex = 1
    colStartIndex = 0
    testData = []
    curr_row = rowStartIndex
    while curr_row <= rowEndIndex:
        dataRow = []
        cur_col = colStartIndex
        while cur_col <= colEndIndex:
            cell_type = worksheet.cell_type(curr_row, cur_col)
            value = worksheet.cell_value(curr_row, cur_col)
            print(value)
            dataRow.append(value)
            print(dataRow)
            cur_col+=1
        curr_row+=1
        testData.append(dataRow)
    return testData
    #return dataRow