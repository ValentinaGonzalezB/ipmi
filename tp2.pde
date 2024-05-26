
int pantallaActual = 0; // Pantalla inicial
int ancho = 640; // Ancho de la pantalla
int alto = 480; // Alto de la pantalla
int tiempoPantalla = 3000; // Tiempo de cada pantalla (en milisegundos)
int tiempoInicio = 0; // Tiempo de inicio de la pantalla actual

int xSnake = 100;
int ySnake = 100;
int tamañoSnake = 10;
int velocidadSnake = 3; // Aumentar la velocidad
int direccion = 0; // 0: derecha, 1: arriba, 2: izquierda, 3: abajo
boolean juegoActivo = false; // Indica si el juego está activo
ArrayList<Integer> colaSnake = new ArrayList<Integer>(); // Cola de la serpiente


int xComida = 0;
int yComida = 0;
int score = 0; 
int comidaComida = 0; 


PFont fuente;

void setup() {
  size(640, 480);
  frameRate(30);
  smooth();
  fuente = createFont("Arial", 16);
  textFont(fuente);
  
  generarComida();
}

void draw() {
  background(150, 220, 150); // Color de fondo del juego

  
  stroke(0);
  strokeWeight(2);
  fill(150, 220, 150);
  rect(10, 10, ancho - 20, alto - 20);

 
  mostrarPantalla();

 
  if (juegoActivo) {
  
    if (keyPressed) {
      if (key == CODED) {
        if (keyCode == UP && direccion != 3) {
          direccion = 1;
        } else if (keyCode == DOWN && direccion != 1) {
          direccion = 3;
        } else if (keyCode == LEFT && direccion != 0) {
          direccion = 2;
        } else if (keyCode == RIGHT && direccion != 2) {
          direccion = 0;
        }
      }
    }

   
    moverSnake();

    fill(0);
    for (int i = 0; i < colaSnake.size(); i += 2) {
      rect(colaSnake.get(i), colaSnake.get(i + 1), tamañoSnake, tamañoSnake);
    }

    
    fill(255, 0, 0);
    rect(xComida, yComida, tamañoSnake, tamañoSnake);

  
    comprobarColisiones();

   
    fill(0);
    textSize(16);
    text("Score: " + score, 15, 25);
  }
}


void mostrarPantalla() {
  if (pantallaActual == 0) {

    fill(0);
    textSize(32);
    text("¡Bienvenidos a Snake!", ancho / 2 - 120, alto / 2 - 50);
    textSize(20);
    text("Presiona cualquier tecla para comenzar", ancho / 2 - 150, alto / 2);
  } else if (pantallaActual == 1) {
    // Pantalla de juego
    // No se muestra ningún texto en esta pantalla
  } else if (pantallaActual == 2) {
    // Pantalla de fin de juego
    fill(0);
    textSize(32);
    text("¡Game Over!", ancho / 2 - 100, alto / 2 - 50);
    textSize(20);
    text("Tu puntuación final es: " + score, ancho / 2 - 120, alto / 2);
    // Dibujar botón de reiniciar
    fill(0);
    rect(ancho / 2 - 50, alto / 2, 100, 30);
    fill(255);
    textSize(16);
    text("Reiniciar", ancho / 2 - 30, alto / 2 + 20);
  } else if (pantallaActual == 3) {
  
    fill(0);
    textSize(32);
    text("¡Victoria!", ancho / 2 - 80, alto / 2 - 50);
    textSize(20);
    text("Tu puntuación final es: " + score, ancho / 2 - 120, alto / 2);
  
    fill(0);
    rect(ancho / 2 - 50, alto / 2, 100, 30);
    fill(255);
    textSize(16);
    text("Reiniciar", ancho / 2 - 30, alto / 2 + 20);
  }


  float tiempoTranscurrido = millis() - tiempoInicio;
  if (tiempoTranscurrido < tiempoPantalla / 2) {
    // Hacer fade-in del texto
    float alpha = map(tiempoTranscurrido, 0, tiempoPantalla / 2, 0, 255);
    fill(0, 0, 0, alpha);
  } else {
 
    float alpha = map(tiempoTranscurrido, tiempoPantalla / 2, tiempoPantalla, 255, 0);
    fill(0, 0, 0, alpha);
  }


  if (millis() - tiempoInicio >= tiempoPantalla) {
    if (pantallaActual == 0) {

      pantallaActual = 1; // Pasa a la pantalla de juego
      tiempoInicio = millis();
    } else if (pantallaActual == 1) {
     
    } else if (pantallaActual == 2 || pantallaActual == 3) {

      if (mouseX > ancho / 2 - 50 && mouseX < ancho / 2 + 50 && mouseY > alto / 2 && mouseY < alto / 2 + 30) {
    
        pantallaActual = 0;
        tiempoInicio = millis();
        resetSnake(); // Función para reiniciar la serpiente
        direccion = 0;
        juegoActivo = false;
        score = 0;
        comidaComida = 0;
        generarComida();
      }
    }
   
    pantallaActual++;
    tiempoInicio = millis();
  }
}


void moverSnake() {
 
  if (direccion == 0) {
    xSnake += velocidadSnake;
  } else if (direccion == 1) {
    ySnake -= velocidadSnake;
  } else if (direccion == 2) {
    xSnake -= velocidadSnake;
  } else if (direccion == 3) {
    ySnake += velocidadSnake;
  }


  colaSnake.add(0, xSnake);
  colaSnake.add(1, ySnake);


  if (colaSnake.size() > 2 * velocidadSnake) {
    colaSnake.remove(colaSnake.size() - 1);
    colaSnake.remove(colaSnake.size() - 1);
  }
}

void generarComida() {
  xComida = int(random(20, ancho - 30));
  yComida = int(random(20, alto - 30));
}


void comprobarColisiones() {
  // Colisión con la comida
  if (xSnake == xComida && ySnake == yComida) {
    generarComida();
    score++;
    comidaComida++;
  
    colaSnake.add(xSnake);
    colaSnake.add(ySnake);
  }


  if (xSnake < 20 || xSnake > ancho - 30 || ySnake < 20 || ySnake > alto - 30) {
    juegoActivo = false;
    pantallaActual = 2;
    tiempoInicio = millis();
  }


  for (int i = 2; i < colaSnake.size(); i += 2) {
    if (xSnake == colaSnake.get(i) && ySnake == colaSnake.get(i + 1)) {
      juegoActivo = false;
      pantallaActual = 2;
      tiempoInicio = millis();
      break; 
    }
  }


  if (comidaComida >= 10) {
    pantallaActual = 3;
    tiempoInicio = millis();
    juegoActivo = false;
  }
}


void mouseClicked() {

  if (mouseX > ancho / 2 - 50 && mouseX < ancho / 2 + 50 && mouseY > alto / 2 && mouseY < alto / 2 + 30 && (pantallaActual == 2 || pantallaActual == 3)) {
  
    pantallaActual = 0;
    tiempoInicio = millis();
    resetSnake(); // Función para reiniciar la serpiente
    direccion = 0;
    juegoActivo = false;
    score = 0;
    comidaComida = 0; 
    generarComida();
  }
}

void keyPressed() {
 
  if (pantallaActual == 0) {
    pantallaActual = 1;
    tiempoInicio = millis();
   
    juegoActivo = true;
   
    resetSnake(); // Función para reiniciar la serpiente
  } else if (pantallaActual == 1 && !juegoActivo) {
    
    juegoActivo = true;
    resetSnake();
  }
}
void resetSnake() {
  xSnake = 100;
  ySnake = 100;
  colaSnake.clear();
 
  for (int i = 0; i < velocidadSnake; i++) {
    colaSnake.add(xSnake);
    colaSnake.add(ySnake);
  }
}
