# Script in this test project to test out getting, saving, and printing user time
# It will also tell the user how long it has been since they last opened the program
extends Control

# Vars
@onready var CurrentDatetimeDict : Dictionary = Time.get_datetime_dict_from_system(false)
@onready var UserTimeZone : Dictionary = Time.get_time_zone_from_system()
@onready var UnixTime : int = Time.get_unix_time_from_datetime_dict(CurrentDatetimeDict)
@onready var LastLoginDict : Dictionary
# Nodes
# Current
@onready var CurrentDayLabel : Label = get_node("%CurrentDay")
@onready var CurrentMonthLabel : Label = get_node("%CurrentMonth")
@onready var CurrentYearLabel : Label = get_node("%CurrentYear")
@onready var CurrentHourLabel : Label = get_node("%CurrentHour")
@onready var CurrentMinLabel : Label = get_node("%CurrentMin")
# Last
@onready var LastDayLabel : Label = get_node("%LastDay")
@onready var LastMonthLabel : Label = get_node("%LastMonth")
@onready var LastYearLabel : Label = get_node("%LastYear")
@onready var LastHourLabel : Label = get_node("%LastHour")
@onready var LastMinLabel : Label = get_node("%LastMin")


# On ready, check if last logout is saved then set it to a var.
# Set up all the labels
func _ready():
	if FileAccess.file_exists("user://Logout.data"):
		var LogoutData = FileAccess.open("user://Logout.data", FileAccess.READ)
		LastLoginDict = Time.get_datetime_dict_from_unix_time(LogoutData.get_32())
		LogoutData = null
	
	# Debug / print lines
	print("Last logout: " + str(LastLoginDict))
	print("Currnet date dict: " + str(CurrentDatetimeDict))
	print("Unix time: " + str(UnixTime))
	print("User timezone is: " + str(UserTimeZone))
	
	# Current labels
	CurrentDayLabel.set_text("Current Day: " + str(CurrentDatetimeDict["day"]))
	CurrentMonthLabel.set_text("Current Month: " + str(CurrentDatetimeDict["month"]))
	CurrentYearLabel.set_text("Current Year: " + str(CurrentDatetimeDict["year"]))
	CurrentHourLabel.set_text("Current Hour: " + str(CurrentDatetimeDict["hour"]))
	CurrentMinLabel.set_text("Current Min: " + str(CurrentDatetimeDict["minute"]))
	# Last labels
	LastDayLabel.set_text("Last Day: " + str(LastLoginDict["day"]))
	LastMonthLabel.set_text("Last Month: " + str(LastLoginDict["month"]))
	LastYearLabel.set_text("Last Year: " + str(LastLoginDict["year"]))
	LastHourLabel.set_text("Last Hour: " + str(LastLoginDict["hour"]))
	LastMinLabel.set_text("Last Min: " + str(LastLoginDict["minute"]))

# Saves the time as 32 bit
func Quit():
	var LogoutData = FileAccess.open("user://Logout.data", FileAccess.WRITE_READ)
	LogoutData.store_32(UnixTime)
	LogoutData = null
	
	get_tree().quit()
