package main

import (
    "fmt"
    "regexp"
    "strconv"
)

type House struct {
    rooms []string
    name string
    sizeFt []roomSz
}

type roomSz struct {
    width, length float32
}

type Home interface {
    inputSqft()
    printMetric()
}

func NewHouse() *House {
    roomSizes := make([]roomSz, 4)

    return &House{[]string{"kitchen", "living", "dining", "main"}, "House", roomSizes}
}

func NewHouseRooms(extraRooms []string) *House {
    roomSizes := make([]roomSz, 4 + len(extraRooms))
    newRooms := append([]string{"kitchen", "living", "dining", "main"}, extraRooms...)

    return &House{newRooms, "House", roomSizes}
}

func (house *House) inputSqft() {
    fmt.Println("Entrez la taille des salles:\n")

    for i := 0; i < len(house.rooms); i++ {
        var dimensions string

        fmt.Printf("%s : width x length: ", house.rooms[i])
        fmt.Scanf("%s\n", &dimensions)

        house.sizeFt[i].changeRoomSize(getDimensions(dimensions))
    }
}

func (house *House) printMetric() {
  var ftToMRatio float32 = 0.3048

  fmt.Printf("%s\n", house.name)

  for i, room := range house.rooms {
    fmt.Printf("%s : %.2f x %.2f m\n", room, ftToMRatio * house.sizeFt[i].width, ftToMRatio * house.sizeFt[i].length)
  }
}

func getDimensions(str string) (float32, float32) {
    regex, _ := regexp.Compile(`(.+)x(.+)`)

    res := regex.FindStringSubmatch(str)

    i, _ := strconv.ParseFloat(res[1], 32)
    j, _ := strconv.ParseFloat(res[2], 32)

    return float32(i), float32(j)
}

func (roomSize *roomSz) changeRoomSize(width, length float32) {
    roomSize.width = width
    roomSize.length = length
}

type Semi struct {
  house *House
}

func NewSemi() *Semi {
    innerHouse := NewHouse()
    innerHouse.name = "Semi"

    return &Semi{innerHouse}
}

func NewSemiRooms(extraRooms []string) *Semi {
    innerHouse := NewHouseRooms(extraRooms)
    innerHouse.name = "Semi"

    return &Semi{innerHouse}
}

func (semi *Semi) inputSqft() {
  semi.house.inputSqft()
}

func (semi *Semi) printMetric() {
  semi.house.printMetric()
}

func main() {
    // h1 := NewHouse()
    // (*h1).inputSqft()
    // fmt.Println()
    // h1.printMetric()
    //
    // fmt.Println()

    // h2 := NewHouseRooms([]string{"bedroom1", "bedroom2"})
    // h2.inputSqft()
    // fmt.Println()
    // h2.printMetric()

    s1 := NewSemiRooms([]string{"bedroom1", "bedroom2"})
    s1.inputSqft()
    fmt.Println()
    s1.printMetric()
}
