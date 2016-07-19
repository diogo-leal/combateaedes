/**
* Name: Combate o Aedes
* Author: Diogo Leal e Valéria Maria
* Description: Describe here the model and its experiments
* Tags: Tag1, Tag2, TagN
*/

model CombateAedes

global {
	int numero_de_pessoas <- 100;
	int numero_de_mosquitos <- 1500;
	init {
		create pessoa number:numero_de_pessoas;
		create mosquito number:numero_de_pessoas;
	}
}

species	pessoa skills: [ moving ] {
	bool isInfected <- false;
	
	init {
		speed <- 1.0;
	}
	
	reflex mover {
		do wander amplitude:90;
	}
	
	reflex interacao  {
		ask pessoa at_distance(1){
			
		}
	}
	
	aspect default {
		if(!isInfected) {
			draw circle(1) color: #green;
		} else {
			draw circle(1) color: #red;
		}
	}
}

species mosquito skills:[moving]{
	bool isInfected <- flip(0.3);
	int attack_range <- 1;
	
	init{

	}
	
	reflex moving{
		do wander;
	}
	
	reflex attack when: !empty(pessoa at_distance attack_range){
		ask pessoa at_distance attack_range{
			if (self.isInfected){
				myself.isInfected <- true;
			}
			else if (myself.isInfected) {
				self.isInfected <- true;
			}
		}
	}
	
	aspect base{
		draw circle(1) color: (isInfected) ? #red : #green;
	}
}

experiment MatarMosquisto type: gui{
	output {
		display myDisplay {
		species pessoa aspect:default ;
	}
}
}
