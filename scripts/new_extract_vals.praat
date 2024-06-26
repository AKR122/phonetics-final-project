# Set up output file ----------------------------------------------------------

# Store path to where we want to save data (look at the structure of your proj)


### add code
savePath$ = "..\data\"
### here ⬆

# Choose name for .csv file
outFile$ = "trills.csv"

filePath$ = "..\stim\"



# -----------------------------------------------------------------------------

# Delete current file if it exists
filedelete 'savePath$'/'outFile$'

# Create file with headers
fileappend 'savePath$'/'outFile$' file name,number of occlusions,word,duration'newline$'





# Set up loop -----------------------------------------------------------------

Create Strings as file list... dirFiles 'filePath$'/*.wav
select Strings dirFiles
fileName$ = Get string... 1
prefix$ = fileName$ - ".wav"
Read from file... 'filePath$'/'prefix$'.wav
Read from file... 'filePath$'/'prefix$'.TextGrid

# Check intervals
soundname$ = selected$ ("TextGrid", 1)
select TextGrid 'soundname$'
numberOfIntervals = Get number of intervals... 1
end_at = numberOfIntervals

# Set defaults
files = 0
intervalstart = 0
intervalend = 0
interval = 1
intnumber = 1 - 1
intname$ = ""
intervalfile$ = ""
endoffile = Get finishing time

for interval from 1 to end_at
    xxx$ = Get label of interval... 1 interval
    check = 0
    if xxx$ = ""
        check = 1
    endif
    if check = 0
       files = files + 1
    endif
endfor

interval = 1


# Loop

for interval from 1 to end_at
    select TextGrid 'soundname$'
    intname$ = ""
    intname$ = Get label of interval... 1 interval
    check = 0
    if intname$ = ""
        check = 1
    endif
    if check = 0
        intnumber = intnumber + 1
        intervalstart = Get starting point... 1 interval
            if intervalstart > 0.01
                intervalstart = intervalstart - 0.01
            else
                intervalstart = 0
            endif
    
        intervalend = Get end point... 1 interval
            if intervalend < endoffile - 0.01
                intervalend = intervalend + 0.01
            else
                intervalend = endoffile
            endif

	# Get trill duration	
	    startTime = Get starting point... 2 1
	    endTime = Get end point... 2 1
	    duration = (endTime - startTime) * 1000

	# Get number of occlusions
	    numberOfOcclusions$ = left$ (xxx$, 1)
	    wordLength = length (xxx$)
	    word$ = right$ (xxx$, wordLength - 1)

	
printline 'fileName$','word$','numberOfOcclusions$','duration'
fileappend 'savePath$'/'outfile$' 'fileName$','word$','numberOfOcclusions$','duration''newline$'

	select all
	minus Strings dirFiles
	Remove
	endif
	
endfor

select all
Remove
	
