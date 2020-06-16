class Population {
    Dna[] population;
    PImage target;
    float maxFit;
    float totalFit;
    float mutationRate;
    int generation;
    Dna best;

    Population(PImage target, int popSize, int geneSize, float mutationRate) {
        this.target = target;
        this.generation = 0;
        this.mutationRate = mutationRate;

        this.population = new Dna[popSize];
        for (int i = 0; i<popSize; i++) {
            this.population[i] = new Dna(geneSize, this.target.width, this.target.height);
        }

        this.best = this.population[0];
    }

    void run() {
        runAndCalcFitness();
        selection();
    }

    void runAndCalcFitness() {
        maxFit = 0;
        totalFit = 0;
        this.best = population[0];
        //go through all members of population
        for (int i = 0; i<population.length; i++) {
            //draw their image
            population[i].run();

            //calculate their fitness
            population[i].calcFitness(target);

            //add their fitnes to total fitness
            totalFit+=population[i].fitness;

            //change max fitness and best if required
            if (population[i].fitness>maxFit) {
                maxFit = population[i].fitness;
                best = population[i];
            }
        }
    }

    void selection() {
        Dna[] newPop = new Dna[population.length];
        for (int i = 0; i<population.length; i++) {
            Dna partnerA = acceptReject();
            Dna partnerB = acceptReject();
            Dna child = partnerA.crossover(partnerB);
            child.mutate(mutationRate);
            newPop[i] = child;
        }
        population = newPop;
        generation++;
    }

    Dna acceptReject() {
        int safety = 0;

        while (safety<50000) {
            int index = (int)random(population.length);
            Dna dna = population[index];
            float r = random(1);
            if (r<dna.fitness/totalFit)return dna;
            safety++;
        }
        return null;
    }
}
