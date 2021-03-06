class Dna {
    PGraphics img;
    float fitness;
    float[][] genes;
    /*    each row of genes looks like this-
     *
     *    [diameter, xPos, yPos, red, green, blue]
     */

    Dna(int w, int h) {
        //default constructor for setting up fitness and img
        this.img = createGraphics(w, h);
        this.fitness = 0;
    }

    Dna(int geneSize, int w, int h) {
        this(w, h);

        //instantiate genes and fill with corresponding random values
        this.genes = new float[geneSize][4];
        for (int i = 0; i<genes.length; i++) {
            for (int j = 0; j< genes[0].length; j++) {
                this.genes[i][j] = random(1);
            }
        }
    }

    Dna(float[][] genes, int w, int h) {
        this(w, h);

        //directly set genes to the genes veriable received as an argument
        this.genes = genes;
    }

    void run() {
        img.beginDraw();
        img.background(255);
        img.noStroke();
        for (int i = 0; i<genes.length; i++) {

            float diameter = map(genes[i][0], 0, 1, 1, 17);
            float x = map(genes[i][1], 0, 1, 0, img.width);
            float y = map(genes[i][2], 0, 1, 0, img.height);
            //float r = map(genes[i][3], 0, 1, 0, 255);
            //float g = map(genes[i][4], 0, 1, 0, 255);
            //float b = map(genes[i][5], 0, 1, 0, 255);
            float c = map(genes[i][3], 0, 1, 0, 255);
            //img.fill(r, g, b, 100);
            img.fill(c, 100);
            img.ellipse(x, y, diameter, diameter);
        }
        img.endDraw();
    }

    void calcFitness(PImage target) {
        img.loadPixels();
        target.loadPixels();

        float score = 0;
        for (int x = 0; x<img.width; x+=3) {
            for (int y = 0; y<img.height; y+=3) {
                int index = x+y*img.width;
                score += distSq(img.pixels[index], target.pixels[index]);
                //score += distSq(
                //    red   (img.pixels[index]), 
                //    green (img.pixels[index]), 
                //    blue  (img.pixels[index]), 
                //    red   (target.pixels[index]), 
                //    green (target.pixels[index]), 
                //    blue  (target.pixels[index])
                //    );
            }
        }
        fitness = (1/score)*1e10;
        //fitness = pow(fitness, 1);
        //println("Fitness: "+fitness);
    }

    Dna crossover(Dna partner) {
        float[][] newGenes = new float[genes.length][genes[0].length];

        int point1 = (int)random(genes.length-2);       
        int point2 = (int)random(point1, genes.length);

        for (int i = 0; i<genes.length; i++) {
            if (i<point1) {
                newGenes[i] = genes[i];
            } else if (i<point2) {
                newGenes[i] = partner.genes[i];
            } else {
                newGenes[i] = genes[i];
            }
        }

        //float weight= 0.5;
        //for (int i = 0; i<genes.length; i++) {
        //    for (int j = 0; j<genes[0].length; j++) {
        //        newGenes[i][j] = (weight*genes[i][j])+((1-weight)*partner.genes[i][j]);
        //    }
        //}

        return new Dna(newGenes, img.width, img.height);
    }

    void mutate(float mutationRate) {
        for (int i = 0; i<genes.length; i++) {
            if (i<mutationRate) {
                for (int j = 0; j<genes[0].length; j++) {
                    genes[i][j] = random(1);
                }
            }
        }
    }


}
