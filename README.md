# Neuralyne
Right now, Neuralyne is a proof of concept wrapper that dynamically allocates memory page size based on load, tested on stress-ng.

# Dependancies
Neuralyne uses sysctl and stress-ng although the latter isn't needed if you edit the script

# Goals
- A pretty GTK gui.
- Ryzen clustered multithreading using CPPC as well as CCX proximity.
- Adaptive Page file size mutification in real time.

# Installation
set working directory in terminal
`chmod +x Neuralyne.sh`
`sudo ./Neuralyne.sh`
