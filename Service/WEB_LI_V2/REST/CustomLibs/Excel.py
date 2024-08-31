# encoding=utf8
import xlrd
import sys

def read_excel_file(filename, sheetname):
    wb = xlrd.open_workbook(filename, sheetname)
    ws = wb.sheet_by_name(sheetname)
    #for sheet in wb.sheets():
    #for sheet in ws:
        #number_of_rows = ws.nrows
        #number_of_columns = ws.ncols


    number_of_rows = ws.nrows
    number_of_columns = ws.ncols
        #rowStartIndex = 1
        #colStartIndex = 0
    data = []

        #rows = []
    for row in range(1, number_of_rows):
        values = []
        for col in range(number_of_columns):
            value = (ws.cell(row,col).value)

            try:
                value = str(int(value))

            except ValueError:
                pass
            finally:
                values.append(value)
        data.append(values)
    return data