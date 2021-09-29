all: compile

compile:
	makensis base.nsi

clean: 
	del setup.exe