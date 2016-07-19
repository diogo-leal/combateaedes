/**
* Name: Combate o Aedes
* Author: Diogo Leal e Valéria Maria
* Description: Describe here the model and its experiments
* Tags: Tag1, Tag2, TagN
*/

model CombateAedes

global {
	int numero_de_humanos <- 100;
	int numero_de_mosquitos <- 1500;
	init {
		create humano number:numero_de_humanos;
	}
}

species	humano skills: [ moving ] {
	bool contaminado <- flip(0.5);
	float agressividade <- 10.0;
	
	init {
		speed <- 1.0;
	}
	
	reflex mover {
		do wander amplitude:90;
	}
	
	reflex interacao  {
		ask humano at_distance(1){
			if(self.contaminado and !myself.contaminado){
				if(self.agressividade >= myself.agressividade){
					myself.contaminado <- true;
					myself.agressividade <- myself.agressividade + 1;
				}else{
					do die;
				}
			}else if(!self.contaminado and !myself.contaminado){
				myself.agressividade <- myself.agressividade + 1;
				self.agressividade <- self.agressividade + 1;
			}
			
		}
	}
	
	aspect default {
		if(!contaminado) {
			draw circle(1) color: #green;
		} else {
			draw circle(1) color: #red;
		}
		draw string(agressividade) color: #black; 
	}
}

experiment apocalipse type: gui{
	output {
		display myDisplay {
		species humano aspect:default ;
	}
}
}
