# hmsl --  **H**VCC (L)earning **M**anagement **S**ystem (i)n **L**inux

## Project Over View
hmsl is a learning management system to teach students Linux and Bash scripting. hmsl is motivated from CISS 100 at HVCC. hmsl allows students to repeatedly test, score, and submit their work all through Linux. Unix file permissions secures student work, as well as secure course assessment scripts. Grades are stored in a CSV and can be uploaded to BrightSpace.

AI is used in the development of the ideas and code for hmsl.  

## Project Goals
hmsl seeks to immerse students in Linux. Student assessment is built into the shell as they are learning shell and bash scripting. 

hmsl supports iterative design and learning. hmsl score allows students to frequently score their work. This suports the iterative design process in software design (and many other fields). hmsl affords students with greater transparency in how they are assessed. 

hmsl further re-enforces the importance of repeated practice. hmsl reset will clear students' workspaces so students can re-do labs testing their understanding. Students may receive help/assistance from many sources (instructor, peers, LLMs), but students can choose to still engage in self-directed practice. 

## Command Line Interface
hmsl will behave similarly to git. There are two commands exposed to students. 

1. hmsl score [lab##]
2. hmsl reset [lab##]

For course administator, hmsl exposes the following additional commands. 

1. hmsl collect [lab##]
2. hmsl init
3. hmsl register [roster.txt]

## Project Organization

| hmsl - /
	|-- bin/
			hmsl
	|-- lib/
	|		scorelib.sh
	|		resetlib.sh
	|-- commands/
	|		score.sh
	|		reset.sh
	|




































