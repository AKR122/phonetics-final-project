# Set up output file ----------------------------------------------------------


### add code
savePath$ = "..\data\"
### here ⬆

# Choose name for .csv file
outFile$ = "trill_data.csv"

# Delete current file
filedelete 'savePath$'/'outFile$'

# Create file with headers
fileappend 'savePath$'/'outFile$' file name,word,number of occlusions,duration (ms)'newline$'

# -----------------------------------------------------------------------------

# Set up loop -----------------------------------------------------------------

# Set path to stim files (.wav and .TextGrid)

### add code
filePath$ = "C:\Users\locom\Desktop\Kendra Project\wavs\"
### here ⬆

# Get .wav file and store in list
Create Strings as file list... dirFiles 'filePath$'/*.wav

# Select .wav file and corresponding textgrid
select Strings dirFiles
fileName$ = Get string... 1
prefix$ = fileName$ - ".wav"
Read from file... 'filePath$'/'prefix$'.wav
Read from file... 'filePath$'/'prefix$'.TextGrid

# Check Intervals
soundname$ = selected$ ("TextGrid")
select TextGrid 'soundname$'
numberOfIntervals = Get number of intervals... 2
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
    label$ = Get label of interval... 2 interval
    check = 0
    if label$ = ""
        check = 1
    endif
    if check = 0
       files = files + 1
    endif
endfor

interval = 1



# loop ---------------------------------------------------------------------------------
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
	numberOfOcclusions$ = left$ (label$, 1)
	wordLength = length (label$)
	word$ = right$ (label$, wordLength - 1)

	

	fileappend 'savePath$'/'outfile$' 'fileName$','word$','numberOfOcclusions$','duration''newline$'
	
	printline 'fileName$','word$','numberOfOcclusions$','duration'

	select all
	minus Strings dirFiles
	Remove
	endif
endfor