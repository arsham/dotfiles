package main

import (
	"fmt"
	"os/exec"
	"regexp"
	"strconv"
	"strings"

	"github.com/sirupsen/logrus"
	"github.com/spf13/cobra"
	"github.com/spf13/viper"
)

var (
	logger  = logrus.StandardLogger().WithField("service", "teller")
	adapter string
	fanMode = false
	gpuMode = false
	low     = 50
	high    = 80
	tempRe  = regexp.MustCompile(`:\s+\+(\d+)\.`)
	fanRe   = regexp.MustCompile(`(\d{3,4})`)

	rootCmd = &cobra.Command{
		Use:   "polytemp",
		Short: "Returns a polybar string for temperatures",
		RunE: func(*cobra.Command, []string) error {
			if gpuMode {
				return printGPUFans()
			}
			return printCPUMetrics()
		},
	}
)

func main() {
	cobra.CheckErr(rootCmd.Execute())
}

func init() {
	cobra.OnInitialize(viper.AutomaticEnv)

	rootCmd.PersistentFlags().StringVarP(&adapter, "a", "a", "ISA", "Adapter partial name")
	rootCmd.PersistentFlags().BoolVarP(&fanMode, "f", "f", false, "Looking for fans")
	rootCmd.PersistentFlags().BoolVarP(&gpuMode, "g", "g", false, "Looking for GPU fans")
	rootCmd.PersistentFlags().IntVarP(&low, "l", "l", 50, "Low value")
	rootCmd.PersistentFlags().IntVarP(&high, "H", "H", 80, "High value")
}

var bars = []string{
	" ",
	"▁",
	"▂",
	"▃",
	"▄",
	"▅",
	"▆",
	"▇",
	"█",
}

var (
	a = "#6bff49"
	b = "#f4cb24"
	c = "#ff8819"
	d = "#ff3205"
	e = "#f40202"
)

func printCPUMetrics() error {
	// TODO: use the json format.
	cmd := exec.Command("sensors")
	out, err := cmd.CombinedOutput()
	if err != nil {
		return err
	}

	lines := strings.Split(string(out), "\n")
	inSection := false
	temps := []int{}
	for _, line := range lines {
		if strings.TrimSpace(line) == "" && inSection {
			break
		}
		if strings.Contains(line, adapter) {
			inSection = true
			continue
		}
		if !inSection || strings.HasPrefix(line, "Package") {
			continue
		}

		re := tempRe
		if fanMode {
			re = fanRe
		}
		got := re.FindStringSubmatch(line)
		if len(got) < 2 {
			continue
		}
		i, err := strconv.Atoi(got[1])
		if err != nil {
			continue
		}
		temps = append(temps, i)
	}

	for _, temp := range temps {
		printTemp(temp)
	}
	return nil
}

func printColour(c, str string) {
	fmt.Printf("%%{F%s}%s%%{F-}", c, str)
}

func printTemp(temp int) {
	diff := high - low
	step := diff / 8

	switch {
	case temp < low+step:
		printColour(a, bars[0])
	case temp < low+(step*2):
		printColour(a, bars[1])
	case temp < low+(step*3):
		printColour(a, bars[2])
	case temp < low+(step*4):
		printColour(b, bars[3])
	case temp < low+(step*5):
		printColour(b, bars[4])
	case temp < low+(step*6):
		printColour(c, bars[5])
	case temp < low+(step*7):
		printColour(d, bars[6])
	case temp < low+(step*8):
		printColour(d, bars[7])
	default:
		printColour(e, bars[8])
	}
}

func printGPUFans() error {
	cmd := exec.Command("nvidia-smi", "--query-gpu=fan.speed,temperature.gpu", "--format=csv,noheader")
	out, err := cmd.CombinedOutput()
	if err != nil {
		return err
	}

	lines := strings.Split(string(out), "\n")
	temps := []int{}
	for _, line := range lines {
		got := strings.Split(line, ",")
		if len(got) < 2 {
			continue
		}
		value := got[1]
		if fanMode {
			value = got[0]
		}
		value = strings.Trim(value, " %")
		i, err := strconv.Atoi(value)
		if err != nil {
			continue
		}
		temps = append(temps, i)
	}

	for _, temp := range temps {
		printTemp(temp)
	}
	return nil
}
