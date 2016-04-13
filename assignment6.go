package main

import (
    "fmt"
    "regexp"
    "strconv"
    "time"
    "os"
    "runtime"
    "bufio"
    "sync"
)

/* Question 1 */
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

    // s1 := NewSemiRooms([]string{"bedroom1", "bedroom2"})
    // s1.inputSqft()
    // fmt.Println()
    // s1.printMetric()

    // homes := []Home{
    //   NewHouse(),
    //   NewSemi(),
    //   NewHouseRooms([]string{"bedroom1", "bedroom2"}),
    // }
    //
    // for _, home := range homes {
    //   home.inputSqft()
    // }
    //
    // for _, home := range homes {
    //   home.printMetric()
    // }

    main2()
}



/* Question 2 */
func main2() {
  src1, err := os.Open("input1.txt")
  if err != nil {
    return
  }
  defer src1.Close()
  scan1 := bufio.NewScanner(src1)
  scan1.Split(bufio.ScanWords)
  chanStr1 := make(chan string)

  src2, err := os.Open("input2.txt")
  if err != nil {
    return
  }
  defer src2.Close()
  scan2 := bufio.NewScanner(src2)
  scan2.Split(bufio.ScanWords)
  chanStr2 := make(chan string)

  out, err := os.Create("out.txt")
  if err != nil {
    return
  }
  defer out.Close()
  chanOut := make(chan string, 100)

  runtime.GOMAXPROCS(4)

  ticker := time.NewTicker(time.Millisecond * 1000)

  var waitingGroup sync.WaitGroup
  waitingGroup.Add(1)

  // read file 1
  go func() {
    for scan1.Scan() {
      chanStr1 <- scan1.Text()
      time.Sleep(time.Millisecond * 200)
    }

    close(chanStr1)
  }()

  // read file 2
  go func() {
    for scan2.Scan() {
      chanStr2 <- scan2.Text()
      time.Sleep(time.Millisecond * 300)
    }

    close(chanStr2)
  }()

  go func() {
    chanClosed := 0

    for {
      if chanClosed == 2 {
        close(chanOut)
        return
      }

      select {
      case str1, ok := <- chanStr1:
        fmt.Printf("%s ", str1)
        chanOut <- str1 + " "

        if !ok {
          chanClosed++
        }
        // out.WriteString(str1 + " ")
      case str2, ok := <- chanStr2:
        fmt.Printf("%s ", str2)
        chanOut <- str2 + " "

        if !ok {
          chanClosed++
        }
        // out.WriteString(str2 + " ")
      case <- ticker.C:
        fmt.Printf("\n")
        chanOut <- "\n"
        // out.WriteString("\n")
      }
    }
  }()

  go func() {
    defer waitingGroup.Done()

    for elem := range chanOut {
      out.WriteString(elem)
    }
  }()


  waitingGroup.Wait()
  ticker.Stop()
}
