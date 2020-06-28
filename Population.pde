class Population {
    Dna[] population;
    PImage target;
    float maxFit;
    float totalFit;
    float mutationRate;
    int generation;
    Dna best;
    boolean terminated;
    float percentCompleted;

    Population(PImage target, int popSize, int geneSize, float mutationRate) {
        this.target = target;
        this.generation = 0;
        this.mutationRate = mutationRate;

        this.population = new Dna[popSize];
        for (int i = 0; i<popSize; i++) {
            this.population[i] = new Dna(geneSize, this.target.width, this.target.height);
        }

        this.best = this.population[0];

        this.percentCompleted = 0;
        this.terminated = false;
    }

    void run() {
        runAndCalcFitness();
        selection();
        if (frameCount%10 >= 0)    termination();
        if (terminated)    noLoop();
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
            //Dna partnerA = acceptReject();
            //Dna partnerB = acceptReject();
            Dna partnerA = tournament();
            Dna partnerB = tournament();
            Dna child = partnerA.crossover(partnerB);
            child.mutate(mutationRate);
            newPop[i] = child;
        }
        population = newPop;
        generation++;
    }

    Dna tournament() {
        int index = (int)random(population.length);
        Dna best = population[index];
        for (int i = 0; i<3; i++) {
            Dna contestant = population[((int)(random(population.length)))];
            if (contestant.fitness>best.fitness) {
                best = contestant;
            }
        }
        return best;
    }

    Dna acceptReject() {
        int safety = 0;

        while (safety<50000) {
            int index = (int)random(population.length);
            Dna dna = population[index];
            float r = random(1);
            if (r<maxFit)return dna;
            safety++;
        }
        return null;
    }

    void termination() {
        int skipPixels = 5;
        int totalPixels = 0;
        int correctPixels = 0;
        for (int x = 0; x<best.img.width; x+=skipPixels) {
            for (int y= 0; y<best.img.height; y+=skipPixels) {
                int index = x + y*best.img.width;
                println("MOuseX: "+mouseX);
                if (distSq(best.img.pixels[index], target.pixels[index])<40*40) {
                    correctPixels++;
                }
                totalPixels++;
            }
        }
        percentCompleted = ((float)(correctPixels)/totalPixels)*100;
        if (percentCompleted>90) {
            terminated = true;
        }
    }
}
