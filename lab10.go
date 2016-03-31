package main

import (
	"fmt" 
	"math"
)

// Exercice 1
type rect struct {
	largeur, hauteur int
}


func (r rect) rectArea() int {
	return r.hauteur * r.largeur
}

func (r rect) rectPerim() int {
	return 2*(r.hauteur + r.largeur)
}

func main() {
	r1 := rect{2, 3}
	c1 := Cercle{3}
	s1 := Square{8}
	r1.largeur = 5
	fmt.Println(r1.largeur)
	fmt.Println(r1.rectArea())
	fmt.Println(r1.rectPerim())
	fmt.Println(c1.getArea())
	fmt.Println(c1.getPerim())
	measure(c1)
	measure(s1)
	printNumbers()
}




// Exercice 2
type Forme interface {
	getArea() float64
	getPerim() float64
}

type Cercle struct {
	rayon float64
}

type Square struct {
	cote float64
}

func (c Cercle) getArea() float64 {
	return math.Pi * math.Pow(c.rayon, 2)
}

func (c Cercle) getPerim() float64 {
	return 2 * c.rayon * math.Pi	
}

func (s Square) getArea() float64 {
	return math.Pow(s.cote, 2)
}

func (s Square) getPerim() float64 {
	return 4 * s.cote
}

func measure(form Forme) {
	fmt.Printf("Aire: %f \nPerimetre: %f\n", form.getArea(), form.getPerim())
}


// Exercice 3
func numberGen(start, count int, out chan<- int) {
	for i := start; i <= start + count; i++ {
		out <- i
	}
}

func printNumbers() {
	c := make(chan int)
	
	go numberGen(5, 10, c)
	num := <- c
	
	fmt.Println(num)
}