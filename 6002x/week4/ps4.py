# 6.00.2x Problem Set 4

import numpy
import random
import pylab
from ps3b import *

#
# PROBLEM 1
#        


def simulationWithDrug(numViruses, maxPop, maxBirthProb, clearProb, resistances,
                       mutProb, delay,numTrials):
    """
    Runs simulations and plots graphs for problem 5.

    For each of numTrials trials, instantiates a patient, runs a simulation for
    150 timesteps, adds guttagonol, and runs the simulation for an additional
    150 timesteps.  At the end plots the average virus population size
    (for both the total virus population and the guttagonol-resistant virus
    population) as a function of time.

    numViruses: number of ResistantVirus to create for patient (an integer)
    maxPop: maximum virus population for patient (an integer)
    maxBirthProb: Maximum reproduction probability (a float between 0-1)        
    clearProb: maximum clearance probability (a float between 0-1)
    resistances: a dictionary of drugs that each ResistantVirus is resistant to
                 (e.g., {'guttagonol': False})
    mutProb: mutation probability for each ResistantVirus particle
             (a float between 0-1). 
    numTrials: number of simulation runs to execute (an integer)
    
    """
    sizes=[]
    resistSizes=[]
    patients=[]
    for i in range(numTrials):
        viruses=[]
        for i in range(numViruses):           
            viruse=ResistantVirus(maxBirthProb, clearProb, resistances.copy(), mutProb)
            viruses.append(viruse)
        patient=TreatedPatient(viruses, maxPop)
        patients.append(patient)
    
    for j in range(delay):
        total=0
        totalResist=0
        for patient in patients:
            total+=patient.update()
            totalResist+=patient.getResistPop(["guttagonol"])
        sizes.append(total/float(numTrials))
        resistSizes.append(totalResist/float(numTrials))

    for patient in patients:
        patient.addPrescription("guttagonol")
        patient.addPrescription("grimpex")

    for j in range(150):
        total=0
        totalResist=0
        for patient in patients:
            total+=patient.update()
            totalResist+=patient.getResistPop(["guttagonol"])
        sizes.append(total/float(numTrials))
        resistSizes.append(totalResist/float(numTrials))
    #print sizes

    pylab.plot(range(delay+150), sizes)
    pylab.plot(range(delay+150), resistSizes)
    pylab.title('SimpleVirus simulation')
    pylab.xlabel('Time Steps')
    pylab.ylabel('Average Virus Population')
    pylab.legend('SimpleVirus')
    pylab.show()

def simulationDelayedTreatment(numTrials):
    """
    Runs simulations and make histograms for problem 1.

    Runs numTrials simulations to show the relationship between delayed
    treatment and patient outcome using a histogram.

    Histograms of final total virus populations are displayed for delays of 300,
    150, 75, 0 timesteps (followed by an additional 150 timesteps of
    simulation).

    numTrials: number of simulation runs to execute (an integer)
    """
    
    # TODO
    simulationWithDrug(100, 1000, 0.1, 0.05, {'guttagonol': False},  0.005,300,10)


##simulationWithDrug(100, 1000, 0.1, 0.05, {'guttagonol': False},  0.005,150,10)
simulationWithDrug(100, 1000, 0.1, 0.05, {'guttagonol': False, 'grimpex': False},  0.005,150,10)


#
# PROBLEM 2
#
def simulationTwoDrugsDelayedTreatment(numTrials):
    """
    Runs simulations and make histograms for problem 2.

    Runs numTrials simulations to show the relationship between administration
    of multiple drugs and patient outcome.

    Histograms of final total virus populations are displayed for lag times of
    300, 150, 75, 0 timesteps between adding drugs (followed by an additional
    150 timesteps of simulation).

    numTrials: number of simulation runs to execute (an integer)
    """
    # TODO
