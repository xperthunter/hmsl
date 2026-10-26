# hmsl --  **H**VCC (L)earning **M**anagement **S**ystem (i)n **L**inux

## Project Over View
hmsl is a learning management system to teach students Linux and Bash scripting. hmsl is motivated from CISS 100 at HVCC. hmsl allows students to repeatedly test, score, and submit their work all through Linux. Unix file permissions secures student work. Grades are stored in a CSV and can be uploaded to BrightSpace. 

## Project Goals
hmsl seeks to immerse students in Linux. hmsl determines if students used the correct commands by inspecting their command history. hmsl also determines if the correct files/directories are produced. The instructor has to determine which artifacts and commands to assess students on. hmsl provides a library to collect these measurable steps. 

hmsl also leans into a interative development mindset. hmsl score allows student to score their current progress in a lab at any time, as many times as they want. 

## Command Line Interface
hmsl will behave similarly to git. There are three commands exposed to students. 

1. hmsl score [lab##]
2. hmsl reset [lab##]
3. hmsl submit [lab##]

For course administator, hmsl exposes the following additional commands. 

1. hmsl collect [lab##]
2. hmsl init
3. hmsl register [roster.txt]

## Project Organization

-- > bin/ contains the hmsl caller
