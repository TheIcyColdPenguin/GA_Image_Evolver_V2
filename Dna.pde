class Dna{
    PGraphics img;
    float[][] genes;
    float fitness;
    
    Dna(int w, int h){
        this.img = createGraphics(w, h);
        this.fitness = 0;
    }
    Dna(int geneSize, int w, int h){
        this(w, h);
        this.genes = new float[geneSize][4];
        for(int i = 0; i<geneSize;i++){
            for(int j = 0; j< 3;j++){
                this.genes[i][j] = (float)Math.random();
            }
            this.genes[i][3] = color((float)Math.random()*255, (float)Math.random()*255, (float)Math.random()*255);
        }
    }
    Dna(float[][] genes, int w, int h){
        this(w, h);
        this.genes = genes;
    }
}
