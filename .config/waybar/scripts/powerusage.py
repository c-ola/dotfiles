import os


def main():
    power = os.popen("cat /sys/class/power_supply/BAT0/power_now").read()
    print(float(power)/1000000.)


if __name__ == "__main__":
    main()
