28/03/2024: replace all https://192.168.33.166:443/soap to https://192.168.33.166:443/soap

restart resource before running SOAPUI auto:
	pcs resource restart li_daemon

AddDF TestCase
	For The DF --> Can add maximum 12 DF

DeleteDF TestCase
	Add_Valid_Interception_to_use_DF_12_for_delete_invalid_DF_disabled (No assertions - only prepare data for the next step) --> Delete_Invalid_DF_With_DF_used_by_an_active_Interception