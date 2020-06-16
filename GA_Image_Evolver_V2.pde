Population population;
float t1;
PImage target;

void setup() {
    size(440, 440);

    target = loadImage("target.png");
    int popSize = 150;
    int geneSize = 200;
    float mutationRate = 0.5;    
    population = new Population(target, popSize, geneSize, mutationRate);
    t1 = millis();
}

void draw() {

    //for (int i = 0; i<5000; i++) {
    //    for (int j = 0; j<5000; j++) {

    //    }
    //}
    //println(millis()-t1);

    background(255);
    population.run();
    image(population.best.img, 0, 0);
    image(target, 220, 0);
    fill(0);
    text("Gen: "+population.generation, 20, 240);
    text("MaxFit: "+population.maxFit, 20, 260);
    text("Mutation: "+population.mutationRate, 20, 280);
    text("Pop Size: "+population.population.length, 20, 300);
    text("Gene Size: "+population.population[0].genes.length, 20, 320);
    text("Time: "+(millis()-t1)/1000 + "seconds", 20, 340);

    //int r = (int)random(255);
    //int g = (int)random(255);
    //int b = (int)random(255);
    //color c = color(r, g, b);
    //println(c);
}
