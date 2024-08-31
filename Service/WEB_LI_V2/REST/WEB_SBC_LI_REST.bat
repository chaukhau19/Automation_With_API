@echo off

call robot -d result -i excute Tests
call robot -d send_email Tests\SendEmail.robot

