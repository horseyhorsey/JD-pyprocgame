Option Explicit
Const VPinMAMEDriverVer = 3.32
'=======================
' VPinMAME driver core.
'=======================
' New in 3.32 (Update by Destruk)
'   - Added Playmatic Replay setting switches
' New in 3.31 (Update by Destruk)
' - (System VBS Additions)
'   - Added play1.vbs
' New in 3.30 (Update by Destruk)
' - (System VBS Additions)
'   - Added zacproto.vbs
' New in 3.29 (Update by Noah)
' - (System VBS Additions)
'   - Added jvh.vbs and ali.vbs by Destruk for Jac van Ham and Allied Leisure
' Corrected VPBuild Number for slingshots/bumpers and ball decals - Seeker
' New in 3.27 (Update by PD)
' - (System VBS Additions)
'   - Added gts1.vbs by Inkochnito for Gottlieb System 1
' New in 3.26 (Update by PD)
' - (Core Changes)
'    - Added "GICallback2" function to support Steve Ellenoff's new support in VPM for Dimming GI in WMS games
'      GICallaback returns numeric values 0-8 instead of a boolean 0 or 1 (on/off) like GICallback does.
'      Existing tables will need to be altered to support dimming levels and need to use GICallback2 instead.
'      The old GICallback is left intact so older tables are not broken by the new code
'
' New in 3.25 (release 2) (Update by PD)
' - (Core Changes)
'    - Restored former flipper speed due to complaints about some tables having BTTF problem returned and a resolution
'      of arguments over the settings
'    - New Optional Flipper Code Added (vpmSolFlip2) that let's you specify both up and down-swing speeds in the script
'      plus the ability to turn flipper sounds on or off for that call
'      Format: vpmSolFlip2 (Flip1obj, Flip2obj, UpSpeed, DownSpeed, SoundOn, Enable) 
'
' New in 3.24 (Update by PD)
' - (Core Changes)
'    - Altered flipper code so the upswing defaults to your downswing (i.e. VBS no longer adds a different value)
'      (This change was done due to arguments over issues now resolved)
'    - I have decreased the return strength setting to be very low, though.  So any downswing hits (say from a ball
'      heading to the trough) won't get hit with any real power.  So, assuming you have a reasonably fast upswing,
'      you won't get any balls through the flipper and any balls hit by the underside won't get pegged anymore, which
'      is a more realistic behavior.
'
' New in 3.23 (Update by PD)
' - (System.vbs Additions)
'    - SlamtTilt definitions added to AlvinG and Capcom systems
'    - High Score Reset Switch Added to Williams System7 (S7.vbs)
'    - Sleic.vbs system added (courtesy of Destruk)
'    - Peper.vbs system added (courtesy of Destruk)
'    - Juegos.vbs system added (courtesy of Destruk)
'
' New in 3.22 (Update by PD)
' - (Core Changes)
'   - Outhole switch handling updated so it resets correctly with an F3 reset.  
'     This affects mostly Gottlieb System3 games (Thanks Racerxme for pointing this out)
'   - Flipper handling modified to have a low return strength setting so any balls under such flippers
'     won't get hit hard.  This allows the higher 'flipper fix' return speed without the associated hard hit issue.
' - (System.vbs Additions)
'   -Inder.vbs test switches updated (Thanks Peter)
'   -Bally.vbs swSoundDiag value changed to -6 (Thanks Racerxme)
'
' New in 3.21 (Update by PD)
' -(Core Changes)
'   - Attemped bug fix in the Impulse Plunger object that could cause weak plunges sometimes on full pulls
'   
' -(System.vbs Additions)
'   -Zac1.vbs has the program enable switch added to it (Thanks TomB)
'   -GamePlan.vbs has the accounting reset switch added to it (Thanks Incochnito)
'
' -(Other Additions)
'   -PD Light System VBS file updated to V5.5 (adds fading reel pop bumper handler and checklight function)
'
' New in 3.20 (Update by PD)
' -(System.vbs Additions)
'   -Apparently Atari2.vbs uses 81/83 for the flipper switches and Atar1.vbs uses 82/84 so this repairs
'    the Atari2.vbs file.
'
' New in 3.19 (Update by PD)
' -(System.vbs Additions)
'   - Fixed the swLLFlip and swLRFlip switch numbers in the Atari1.vbs, Atari2.vbs and Atari.vbs files
'     SolFlipper should now work with Atari tables using the updated file
'
' New in 3.18 (Update by PD)
' -(System.vbs Additions)
'   - Added Atari1.vbs and Atari2.vbs files (Thanks to Inkochnito).  
'     -The old Atari.vbs file is now obsolete, but included for backwards compatability with any existing tables
'      that may have used it. New Tables should use the appropriate Atari1.vbs or Atari2.vbs files.
'
' New in 3.17 (Update by PD)
' -(System.vbs Additions)
'   -Fixed wrong switch definition in Sys80.vbs for the self-test switch.  The operator menus should work now.
'    (Thanks to Inkochnito for pointing it out).
'   -Added inder.vbs, nuova.vbs, spinball.vbs and mrgame.vbs files (Thanks to Destruk)
'
' New in 3.16 (Update by PD)
' -(System.vbs Additions)
'   -Added "BeginModal" and "EndModal" statements to each system (required for latest versions of VP ( >V6.1) to
'    avoid problems during the VPM "F3" reset.
' -(Other Additions)
'   - PDLightSystem Core updated to version 5.4
'
' New in 3.15 (Update by PD)
' -(Core Additions)
'   - Added a new higher resolution Impulse Plunger Object 
'      (It uses a trigger to plunge the ball.  It can be a variable Manual Plunger or function as an Automatic Plunger)
'      (It also features random variance options and optional pull / plunge sounds)
'
' -(System.vbs Additions)
'   - Fixed wrong switch number for Tilt & Slam Tilt in Sega.vbs
'   - Added Master CPU Enter switch to S7.vbs for Dip Switch control in Williams System7
'
' -(Other Additions)
'   - Added PDLightSystem.vbs (V5.3) file to archive 
'     (open it with a text editor to see how to use it; it's called separately like the core file)
'
' New in 3.14 (Update by PD)
' -(System.vbs Additions)
'   - Added latest Zac1.vbs and Zac2.vbs files to archive
'
' New in 3.13 (Update by PD)
' -(Core Additions)
'   - Added Destruk's code to "Add" or "Remove" a ball from the table when "B" is pressed.
'   - Added "AutoplungeS" call which is the same as "Autoplunger" except it will play a specified sound when fired
'
' -(System.vbs Additions)
'   - Taito.vbs updated to fix service menu keys and default dip switch menu added
'   - Dip Switch / Option Menu "class" code added to all table VBS scripts to ease menu coding for table authors
'   - Fixed some labeling errors and organization and added a "Last Updated" version comment at the start of each file
'
' New in 3.12
'   - Made flipper return speed a constant conFlipRetSpeed
'   - set conFlipRetSpeed to 0.137 to reduce ball thru flipper problem
'
' New in 3.11
'   - Added a short delay between balls in the ballstacks to ensure
'     that the game registers the switches as off when balls are rolling
'     in the trough. All balls should probably move at the same time but it is
'     a bit tricky to implement without changing a lot of code.
'   - Removed support for the wshltdlg.dll since funtionality is in VPM now
' New in 3.10
'   - Public release
' Put this at the top of the table file
'LoadVPM "02000000", "xxx.VBS", 3.15
'Const cGameName    = "xxxx" ' PinMAME short game name
'Const UseSolenoids = True
'Const UseLamps     = True
''Standard sound
'Const SSolenoidOn  = "SolOn"       'Solenoid activates
'Const SSolenoidOff = "SolOff"      'Solenoid deactivates
'Const SFlipperOn   = "FlipperUp"   'Flipper activated
'Const SFlipperOff  = "FlipperDown" 'Flipper deactivated
'Const SCoin        = "Quarter"     'Coin inserted
''Callbacks
'Set LampCallback   = GetRef("UpdateMultipleLamps")
'Set GICallback     = GetRef("UpdateGI")  ' Original GI Callback (returns boolean on and off values only)
'Set GICallback2    = GetRef("UpdateGI")  ' New GI Callback supports Newer VPM Dimming GI and returns values numeric 0-8)
'Set MotorCallback  = GetRef("UpdateMotors")
'
'Sub LoadVPM(VPMver, VBSfile, VBSver)
'	On Error Resume Next
'		If ScriptEngineMajorVersion < 5 Then MsgBox "VB Script Engine 5.0 or higher required"
'		ExecuteGlobal GetTextFile(VBSfile)
'		If Err Then MsgBox "Unable to open " & VBSfile & ". Ensure that it is in the same folder as this table. " & vbNewLine & Err.Description : Err.Clear
'		Set Controller = CreateObject("VPinMAME.Controller")
'		If Err Then MsgBox "Can't Load VPinMAME." & vbNewLine & Err.Description
'		If VPMver>"" Then If Controller.Version < VPMver Or Err Then MsgBox "VPinMAME ver " & VPMver & " required." : Err.Clear
'		If VPinMAMEDriverVer < VBSver Or Err Then MsgBox VBSFile & " ver " & VBSver & " or higher required."
'End Sub
'
'Sub Table_KeyDown(ByVal keycode)
'	If vpmKeyDown(keycode) Then Exit Sub
'	If keycode = PlungerKey Then Plunger.Pullback
'End Sub
'Sub Table_KeyUp(ByVal keycode)
'	If vpmKeyUp(keycode) Then Exit Sub
'	If keycode = PlungerKey Then Plunger.Fire
'End Sub
'
'Const cCredits  = ""
'Sub Table_Init
'	vpmInit Me
'	On Error Resume Next
'		With Controller
'			.GameName = cGameName
'			If Err Then MsgBox "Can't start Game" & cGameName & vbNewLine & Err.Description : Exit Sub
'			.SplashInfoLine = cCredits
'			.HandleMechanics = 0
'			.ShowDMDOnly = True : .ShowFrame = False : .ShowTitle = False
'			.Run : If Err Then MsgBox Err.Description
'		End With
'	On Error Goto 0
'' Nudging
'	vpmNudge.TiltSwitch = swTilt
'	vpmNudge.Sensitivity = 5
'	vpmNudge.TiltObj = Array(Bumper1,Bumper2,LeftslingShot,RightslingShot)
'' Map switches and lamps
'	vpmCreateEvents colSwObjects ' collection of triggers etc
'	vpmMapLights    colLamps     ' collection of all lamps
'' Trough handler
'	Set bsTrough = New cvpmBallStack
'	bsTrough.InitNoTrough BallRelease, swOuthole, 90, 2
'	'or
'	bsTrough.InitSw swOuthole,swTrough1,swTrough2,0,0,0,0
'---------------------------------------------------------------
Dim Controller   ' VPinMAME Controller Object
Dim vpmTimer     ' Timer Object
Dim vpmNudge     ' Nudge handler Object
Dim Lights(200)  ' Put all lamps in an array for easier handling
' If more than one lamp is connected, fill this with an array of each light
Dim vpmMultiLights() : ReDim vpmMultiLights(0)
Private gNextMechNo : gNextMechNo = 0 ' keep track of created mech handlers (would be nice with static members)

' Callbacks
Dim SolCallback(64) ' Solenoids (parsed at Runtime)
Dim LampCallback    ' Called after lamps are updated
Dim GICallback      ' Called for each changed GI String
Dim GICallback2     ' Called for each changed GI String
Dim MotorCallback   ' Called after solenoids are updated
Dim vpmCreateBall   ' Called whenever a vpm class needs to create a ball

' Assign Null Default Sub so script won't error if only one is defined in a script (should redefine in your script)
Set GICallback = GetRef("NullSub")
Set GICallback2 = GetRef("NullSub")

' Game specific info
Dim ExtraKeyHelp    ' Help string for game specific keys
Dim vpmShowDips     ' Show DIPs function
'-----------------------------------------------------------------------------
' These helper function requires the following objects on the table:
'   PinMAMETimer   : Timer object
'   PulseTimer     : Timer object
'
' Available classes:
' ------------------
' cvpmTimer (Object = vpmTimer)
'   (Public)  .PulseSwitch   - pulse switch and call callback after delay (default)
'   (Public)  .PulseSw       - pulse switch
'   (Public)  .AddTimer      - call callback after delay
'   (Public)  .Reset         - Re-set all ballStacks
'   (Friend)  .InitTimer     - initialise fast or slow timer
'   (Friend)  .EnableUpdate  - Add/remove automatic update for an instance
'   (Private) .Update        - called from slow timer
'   (Private) .FastUpdate    - called from fast timer
'   (Friend)  .AddResetObj   - Add object that needs to catch reset
'
' cvpmBallStack (Create as many as needed)
'   (Public) .InitSw        - init switches used in stack
'   (Public) .InitSaucer    - init saucer
'   (Public) .InitNoTrough  - init a single ball, no trough handler
'   (Public) .InitKick      - init exit kicker
'   (Public) .InitAltKick   - init second kickout direction
'   (Public) .CreateEvents  - Create addball events for kickers
'   (Public) .KickZ         - Z axis kickout angle (radians)
'   (Public) .KickBalls     - Maximum number of balls kicked out at the same time
'   (Public) .KickForceVar  - Initial ExitKicker Force value varies by this much (+/-, minimum force = 1)
'   (Public) .KickAngleVar  - ExitKicker Angle value varies by this much (+/-)
'   (Public) .BallColour    - Set ball colour
'   (Public) .TempBallImage  - Set ball image for next ball only
'   (Public) .TempBallColour - Set ball colour for next ball only
'   (Public) .BallImage     - Set ball image
'   (Public) .InitAddSnd    - Sounds when ball enters stack
'   (Public) .InitEntrySnd  - Sounds for Entry kicker
'   (Public) .InitExitSnd   - Sounds for Exit kicker
'   (Public) .AddBall       - add ball in "kicker" to stack
'   (Public) .SolIn         - Solenoid handler for entry solenoid
'   (Public) .EntrySol_On   - entry solenoid fired
'   (Public) .SolOut        - Solenoid handler for exit solenoid
'   (Public) .SolOutAlt     - Solenoid handler for exit solenoid 2nd direction
'   (Public) .ExitSol_On    - exit solenoid fired
'   (Public) .ExitAltSol_On - 2nd exit solenoid fired
'   (Public) .Balls         - get/set number of balls in stack (default)
'   (Public) .BallsPending  - get number of balls waiting to come in to stack
'   (Public) .IsTrough      - Specify that this is the main ball trough
'   (Public) .Reset         - reset and update all ballstack switches
'   (Friend) .Update        - Update ball positions (from vpmTimer class)
'  Obsolete
'   (Public) .SolExit       - exit solenoid handler
'   (Public) .SolEntry      - Entry solenoid handler
'   (Public) .InitProxy     - Init proxy switch

' cvpmNudge (Object = vpmNudge)
'   Hopefully we can add a real pendulum simulator in the future
'   (Public)  .TiltSwitch   - set tilt switch
'   (Public)  .Senitivity   - Set tiltsensitivity (0-10)
'   (Public)  .TiltObj      - Set objects affected by tilt
'   (Public)  .DoNudge dir,power  - Nudge table
'   (Public)  .SolGameOn    - Game On solenoid handler
'   (Private) .Update       - Handle tilting
'
' cvpmDropTarget (create as many as needed)
'   (Public)  .InitDrop     - initialise DropTarget bank
'   (Public)  .CreateEvents - Create Hit events
'   (Public)  .InitSnd      - sound to use for targets
'   (Public)  .AnyUpSw      - Set AnyUp switch
'   (Public)  .AllDownSw    - Set all down switch
'   (Public)  .AllDown      - All targets down?
'   (Public)  .Hit          - A target had been hit
'   (Public)  .SolHit       - Solenoid handler for dropping a target
'   (Public)  .SolUnHit     - Solenoid handler for raising a target
'   (Public)  .SolDropDown  - Solenoid handler for Bank down
'   (Public)  .SolDropUp    - Solenoid handler for Bank reset
'   (Public)  .DropSol_On   - Reset target bank
'   (Friend)  .SetAllDn     - check alldown & anyup switches
'
' cvpmMagnet (create as many as needed)
'   (Public)  .InitMagnet   - initialise magnet
'   (Public)  .CreateEvents - Create Hit/Unhit events
'   (Public)  .Solenoid     - Set solenoid that controls magnet
'   (Public)  .GrabCenter   - Magnet grabs ball at center
'   (Public)  .MagnetOn     - Turn magnet on and off
'   (Public)  .X            - Move magnet
'   (Public)  .Y            - Move magnet
'   (Public)  .Strength     - Change strength
'   (Public)  .Size         - Change magnet reach
'   (Public)  .AddBall      - A ball has come within range
'   (Public)  .RemoveBall   - A ball is out of reach for the magnet
'   (Public)  .Balls        - Balls currently within magnets reach
'   (Public)  .AttractBall  - attract ball to magnet
'   (Private) .Update       - update all balls (called from timer)
'   (Private) .Reset        - handle emulation reset
'  Obsolete
'   (Public)  .Range        - Change magnet reach

' cvpmTurnTable (create as many as needed)
'   (Public)  .InitTurnTable - initialise turntable
'   (Public)  .CreateEvents  - Create Hit/Unhit events
'   (Public)  .MaxSpeed      - Maximum speed
'   (Public)  .SpinUp        - Speedup acceleration
'   (Public)  .SpinDown      - Retardation
'   (Public)  .Speed         - Current speed
'   (Public)  .MotorOn       - Motor On/Off
'   (Public)  .SpinCW        - Control direction
'   (Public)  .SolMotorState - Motor on/off solenoid handler
'   (Public)  .AddBall       - A ball has come withing range
'   (Public)  .RemoveBall    - A ball is out of reach for the magnet
'   (Public)  .Balls         - Balls currently within magnets reach
'   (Public)  .AffectBall    - affect a ball
'   (Private) .Update        - update all balls (called from timer)
'   (Private) .Reset         - handle emulation reset

' cvpmMech (create as many as needed)
'   (Public)  .Sol1, Sol2    - Controlling solenoids
'   (Public)  .MType         - type of mechanics
'   (Public)  .Length, Steps
'   (Public)  .Acc, Ret      - Acceleration, retardation
'   (Public)  .AddSw         - Automatically controlled switches
'   (Public)  .AddPulseSw    - Automatically pulsed switches
'   (Public)  .Callback      - Update graphics function
'   (Public)  .Start         - Start mechanics handler
'   (Public)  .Position      - Current position
'   (Public)  .Speed         - Current Speed
'   (Private) .Update
'   (Private) .Reset
'
' cvpmCaptiveBall (create as many as needed)
'   (Public)  .InitCaptive   - Initialise captive balls
'   (Public)  .CreateEvents  - Create events for captive ball
'   (Public)  .ForceTrans    - Amount of force tranferred to captive ball (0-1)
'   (Public)  .MinForce      - Minimum force applied to the ball
'   (Public)  .NailedBalls   - Number of "nailed" balls infront of captive ball
'   (Public)  .RestSwitch    - Switch activated when ball is in rest position
'   (Public)  .Start         - Create moving ball etc.
'   (Public)  .TrigHit       - trigger in front of ball hit (or unhit)
'   (Public)  .BallHit       - Wall in front of ball hit
'   (Public)  .BallReturn    - Captive ball has returned to kicker
'   (Private) .Reset
'
' cvpmVLock (create as many as needed)
'   (Public)  .InitVLock     - Initialise the visible ball stack
'   (Public)  .ExitDir       - Balls exit angle (like kickers)
'   (Public)  .ExitForce     - Force of balls kicked out
'   (Public)  .KickForceVar  - Vary kickout force
'   (Public)  .InitSnd       - Sounds to make on kickout
'   (Public)  .Balls         - Number of balls in Lock
'   (Public)  .SolExit       - Solenoid event
'   (Public)  .CreateEvents  - Create events needed
'   (Public)  .TrigHit       - called from trigger hit event
'   (Public)  .TrigUnhit     - called from trigger unhit event
'   (Public)  .KickHit       - called from kicier hit event
'
' cvpmDips (create as many as needed) => (Dip Switch And/Or Table Options Menu)
'   (Public)  .AddForm       - create a form (AKA dialogue)
'   (Public)  .AddChk        - add a chckbox
'   (Public)  .AddChkExtra   -   -  "" -     for non-dip settings
'   (Public)  .AddFrame      - add a frame with checkboxes or option buttons
'   (Public)  .AddFrameExtra -  - "" - for non-dip settings
'   (Public)  .AddLabel      - add a label (text string)
'   (Public)  .ViewDips      - Show form
'   (Public)  .ViewDipsExtra -  - "" -  with non-dip settings
'
' cvpmImpulseP (create as many as needed) => (Impulse Plunger Object using a Trigger to Plunge Manual/Auto)
'   (Public)  .InitImpulseP - Initialise Impulse Plunger Object (Trigger, Plunger Power, Time to Full Plunge [0 = Auto])
'   (Public)  .CreateEvents - Create Hit/Unhit events
'   (Public)  .Strength     - Change plunger strength
'   (Public)  .Time         - Change plunger time (in seconds) to full plunger strength (0 = Auto Plunger)
'   (Public)  .Pullback     - Pull the plunger back
'   (Public)  .Fire	    - Fires / Releases the Plunger (Manual or Auto depending on Timing Value given)
'   (Public)  .AutoFire	    - Fires / Releases the Plunger at Maximum Strength +/- Random variation (i.e. Instant Auto)
'   (Public)  .Switch	    - Switch Number to activate when ball is sitting on plunger trigger (if any)
'   (Public)  .Random       - Sets the multiplier level of random variance to add (0 = No Variance / Default) 
'   (Public)  .InitEntrySnd - Plays Sound as Plunger is Pulled Back
'   (Public)  .InitExitSnd  - Plays Sound as Plunger is Fired (WithBall,WithoutBall)
'
' Generic solenoid handlers:
' --------------------------
' vpmSolFlipper flipObj1, flipObj2  		- "flips flippers". Set unused to Nothing
' vpmSolFlip2   flipObj1, flipObj2, flipSpeedUp, flipSpeedDn, sndOn).  Set unused to Nothing
' vpmSolDiverter divObj, sound      		- open/close diverter (flipper) with/without sound
' vpmSolWall wallObj, sound            		- Raise/Drop wall with/without sound
' vpmSolToggleWall wall1, wall2, sound		- Toggle between two walls
' vpmSolToggleObj obj1,obj2,sound   		- Toggle any objects
' vpmSolAutoPlunger plungerObj, var, enabled  	- Autoplunger/kickback
' vpmSolAutoPlungeS plungerObj, sound, var, enabled - Autoplunger/kickback With Specified Sound To Play
' vpmSolGate obj, sound             		- Open/close gate
' vpmSolSound sound                 		- Play sound only
' vpmFlasher flashObj               		- Flashes flasher
'
' Generating events:
' ------------------
' vpmCreateEvents
' cpmCreateLights
'
' Variables declared (to be filled in):
' ---------------------------------------
' SolCallback()  - handler for each solenoid
' Lights()       - Lamps
'
' Constants used (must be defined):
' ---------------------------------
' UseSolenoids   - Update solenoids
' MotorCallback  - Called once every update for mechanics or custom sol handler
' UseLamps       - Update lamps
' LampCallback   - Sub to call after lamps are updated
'                  (or every update if UseLamps is false)
' GICallback     - Sub to call to update GI strings
' GICallback2    - Sub to call to update GI strings
' SFlipperOn     - Flipper activate sound
' SFlipperOff    - Flipper deactivate sound
' SSolenoidOn    - Solenoid activate sound
' SSolenoidOff   - Solenoid deactivate sound
' SCoin          - Coin Sound
' ExtraKeyHelp   - Game specific keys in help window
'
' Exported variables:
' -------------------
' vpmTimer      - Timer class for PulsSwitch etc
' vpmNudge      - Class for table nudge handling
'-----------------------------------------------------
Private Const PinMameInterval = 1

Private Const conStackSw    = 7  ' Stack switches
Private Const conMaxBalls   = 10
Private Const conMaxTimers  = 20 ' Spinners can generate a lot of timers
Private Const conTimerPulse = 40 ' Timer runs at 25Hz
Private Const conFastTicks  = 4  ' Fast is 4 times per timer pulse
Private Const conMaxSwHit   = 5  ' Don't stack up more that 5 events for each switch

Private Const conFlipRetStrength = 0.01  ' Flipper return strength
Private Const conFlipRetSpeed    = 0.137 ' Flipper return strength


' Dictionary
' Somehow Microsoft managed to make the dictionary object "unsafe for scripting"!
' To avoid security warnings I create my own dictionary
' To make it easier the key must be an object and the item must not be an object
Class cvpmDictionary
	Private mKey(), mItem(), mNext

	Private Sub Class_Initialize : mNext = 0 : ReDim mKey(0), mItem(0) : End Sub

	Private Function FindKey(aKey)
		Dim ii : FindKey = -1
		If mNext > 0 Then
			For ii = 0 To mNext - 1
				If mKey(ii) Is aKey Then FindKey = ii : Exit Function
			Next
		End If
	End Function

	Public Property Get Count : Count = mNext : End Property

	Public Property Get Item(aKey)
		Dim no : no = FindKey(aKey)
		If no >= 0 Then Item = mItem(no) Else Add aKey, Empty : Item = Empty
	End Property

	Public Property Let Item(aKey, aData)
		Dim no : no = FindKey(aKey)
		If no >= 0 Then mItem(no) = aData Else Add aKey, aData
	End Property

	Public Property Set Key(aKey)
		Dim no : no = FindKey(aKey)
		If no >= 0 Then Set mKey(no) = aKey Else Exit Property ' Err.Raise xxx
	End Property

	Public Sub Add(aKey, aItem)
		Dim no : no = FindKey(aKey)
		If no >= 0 Then ' already exists. Just change the value
			mItem(no) = aItem
		Else
			ReDim Preserve mKey(mNext), mItem(mNext)
			Set mKey(mNext) = aKey : mItem(mNext) = aItem : mNext = mNext + 1
		End If
	End Sub

	Public Sub Remove(aKey)
		Dim ii, no
		no = FindKey(aKey) : If no < 0 Then Exit Sub 'Err.Raise xxx
		mNext = mNext - 1
		If no < mNext Then
			For ii = no To mNext - 1 : Set mKey(ii) = mKey(ii+1) : mItem(ii) = mItem(ii+1) : Next
		End If
		ReDim Preserve mKey(mNext), mItem(mNext)
	End Sub

	Public Sub RemoveAll : ReDim mKey(0), mItem(0) : mNext = 0 : End Sub

	Public Function Exists(aKey) : Exists = FindKey(aKey) >= 0 : End Function

	Public Function Items : If mNext > 0 Then Items = mItem Else Items = Array() : End If : End Function

	Public Function Keys  : If mNext > 0 Then Keys  = mKey  Else Keys  = Array() : End If : End Function
End Class

'--------------------
'       Timer
'--------------------
Class cvpmTimer
	Private mQue, mNow, mTimers
	Private mSlowUpdates, mFastUpdates, mResets, mFastTimer

	Private Sub Class_Initialize
		ReDim mQue(conMaxTimers) : mNow = 0 : mTimers = 0
		Set mSlowUpdates = New cvpmDictionary : Set mFastUpdates = New cvpmDictionary : Set mResets = New cvpmDictionary
	End Sub

	Public Sub InitTimer(aTimerObj, aFast)
		If aFast Then
			Set mFastTimer = aTimerObj
			aTimerObj.TimerInterval = conTimerPulse \ conFastTicks
			aTimerObj.TimerEnabled = False
			vpmBuildEvent aTimerObj, "Timer", "vpmTimer.FastUpdate"
		Else
			aTimerObj.Interval = conTimerPulse : aTimerObj.Enabled = True
			vpmBuildEvent aTimerObj, "Timer", "vpmTimer.Update"
		End If
	End Sub

	Sub EnableUpdate(aClass, aFast, aEnabled)
		On Error Resume Next
		If aFast Then
			If aEnabled Then mFastUpdates.Add aClass, 0 : Else mFastUpdates.Remove aClass
			mFastTimer.TimerEnabled = mFastUpdates.Count > 0
		Else
			If aEnabled Then mSlowUpdates.Add aClass, 0 : Else mSlowUpdates.Remove aClass
		End If
	End Sub

	Public Sub Reset
		Dim obj : For Each obj In mResets.Keys : obj.Reset : Next
	End Sub

	Public Sub FastUpdate
		Dim obj : For Each obj In mFastUpdates.Keys : obj.Update : Next
	End Sub

	Public Sub Update
		Dim ii, jj, sw, obj, mQuecopy

		For Each obj In mSlowUpdates.Keys : obj.Update : Next
		If mTimers = 0 Then Exit Sub
		mNow = mNow + 1 : ii = 1

		Do While ii <= mTimers
			If mQue(ii)(0) <= mNow Then
				If mQue(ii)(1) = 0 Then
					If isObject(mQue(ii)(3)) Then
						Call mQue(ii)(3)(mQue(ii)(2))
					ElseIf varType(mQue(ii)(3)) = vbString Then
						If mQue(ii)(3) > "" Then Execute mQue(ii)(3) & " " & mQue(ii)(2) & " "
					End If
					mTimers = mTimers - 1
					For jj = ii To mTimers : mQue(jj) = mQue(jj+1) : Next : ii = ii - 1
				ElseIf mQue(ii)(1) = 1 Then
					mQuecopy = mQue(ii)(2)
					Controller.Switch(mQuecopy) = False
					mQue(ii)(0) = mNow + mQue(ii)(4) : mQue(ii)(1) = 0
				Else '2
					mQuecopy = mQue(ii)(2)
					Controller.Switch(mQuecopy) = True
					mQue(ii)(1) = 1
				End If
			End If
			ii = ii + 1
		Loop
	End Sub

	Public Sub AddResetObj(aObj)  : mResets.Add aObj, 0 : End Sub

	Public Sub PulseSw(aSwNo) : PulseSwitch aSwNo, 0, 0 : End Sub

	Public Default Sub PulseSwitch(aSwNo, aDelay, aCallback)
		Dim ii, count, last
		count = 0
		For ii = 1 To mTimers
			If mQue(ii)(1) > 0 And mQue(ii)(2) = aSwNo Then count = count + 1 : last = ii
		Next
		If count >= conMaxSwHit Or mTimers = conMaxTimers Then Exit Sub
		mTimers = mTimers + 1 : mQue(mTimers) = Array(mNow, 2, aSwNo, aCallback, aDelay\conTimerPulse)
		If count Then mQue(mTimers)(0) = mQue(last)(0) + mQue(last)(1)
	End Sub

	Public Sub AddTimer(aDelay, aCallback)
		If mTimers = conMaxTimers Then Exit Sub
		mTimers = mTimers + 1
		mQue(mTimers) = Array(mNow + aDelay \ conTimerPulse, 0, 0, aCallback)
	End Sub
End Class

'--------------------
'     BallStack
'--------------------
Class cvpmBallStack
	Private mSw(), mEntrySw, mBalls, mBallIn, mBallPos(), mSaucer, mBallsMoving
	Private mInitKicker, mExitKicker, mExitDir, mExitForce
	Private mExitDir2, mExitForce2
	Private mEntrySnd, mEntrySndBall, mExitSnd, mExitSndBall, mAddSnd
	Private mSwcopy
	Public KickZ, KickBalls, KickForceVar, KickAngleVar

	Private Sub Class_Initialize
		ReDim mSw(conStackSw), mBallPos(conMaxBalls)
		mBallIn = 0 : mBalls = 0 : mExitKicker = 0 : mInitKicker = 0 : mBallsMoving = False
		KickBalls = 1 : mSaucer = False : mExitDir = 0 : mExitForce = 0
		mExitDir2 = 0 : mExitForce2 = 0 : KickZ = 0 : KickForceVar = 0 : KickAngleVar = 0
		mAddSnd = 0 : mEntrySnd = 0 : mEntrySndBall = 0 : mExitSnd = 0 : mExitSndBall = 0
		vpmTimer.AddResetObj Me
	End Sub

	Private Property Let NeedUpdate(aEnabled) : vpmTimer.EnableUpdate Me, False, aEnabled : End Property

	Private Function SetSw(aNo, aStatus)
		SetSw = False : If HasSw(aNo) Then 
			mSwcopy = mSw(aNo)
			Controller.Switch(mSwcopy) = aStatus : SetSw = True
		End if
	End Function

	Private Function HasSw(aNo)
		HasSw = False : If aNo <= conStackSw Then If mSw(aNo) Then HasSw = True
	End Function

	Public Sub Reset
		Dim mEntrySwcopy
		Dim ii : If mBalls Then For ii = 1 to mBalls : SetSw mBallPos(ii), True : Next
	      If mEntrySw And mBallIn > 0 Then 
		      mEntrySwcopy = mEntrySw
		      Controller.Switch(mEntrySwcopy) = True
		End if
	End Sub

	Public Sub Update
		Dim BallQue, ii, mSwcopy
		NeedUpdate = False : BallQue = 1
		For ii = 1 To mBalls
			If mBallpos(ii) > BallQue Then ' next slot available
				NeedUpdate = True
				If HasSw(mBallPos(ii)) Then ' has switch
					mSwcopy = mSw(mBallPos(ii))
					If Controller.Switch(mSwcopy) Then
						SetSw mBallPos(ii), False
					Else
						mBallPos(ii) = mBallPos(ii) - 1
						SetSw mBallPos(ii), True
					End If
				Else ' no switch. Move ball to first switch or occupied slot
					Do
						mBallPos(ii) = mBallPos(ii) - 1
					Loop Until SetSw(mBallPos(ii), True) Or mBallPos(ii) = BallQue
				End If
			End If
			BallQue = mBallPos(ii) + 1
		Next
	End Sub

	Public Sub AddBall(aKicker)
		Dim mEntrySwcopy
		If isObject(aKicker) Then
			If mSaucer Then
				If aKicker Is mExitKicker Then
					mExitKicker.Enabled = False : mInitKicker = 0
				Else
					aKicker.Enabled = False : Set mInitKicker = aKicker
				End If
			Else
				aKicker.DestroyBall
			End If
		ElseIf mSaucer Then
			mExitKicker.Enabled = False : mInitKicker = 0
		End If
		If mEntrySw Then
			mEntrySwcopy = mEntrySw
			Controller.Switch(mEntrySwcopy) = True : mBallIn = mBallIn + 1
		Else
			mBalls = mBalls + 1 : mBallPos(mBalls) = conStackSw + 1 : NeedUpdate = True
		End If
		PlaySound mAddSnd
	End Sub

	' A bug in the script engine forces the "End If" at the end
	Public Sub SolIn(aEnabled)     : If aEnabled Then KickIn        : End If : End Sub
	Public Sub SolOut(aEnabled)    : If aEnabled Then KickOut False : End If : End Sub
	Public Sub SolOutAlt(aEnabled) : If aEnabled Then KickOut True  : End If : End Sub
	Public Sub EntrySol_On   : KickIn        : End Sub
	Public Sub ExitSol_On    : KickOut False : End Sub
	Public Sub ExitAltSol_On : KickOut True  : End Sub

	Private Sub KickIn
		Dim mEntrySwcopy
		If mBallIn Then PlaySound mEntrySndBall Else PlaySound mEntrySnd : Exit Sub
		mBalls = mBalls + 1 : mBallIn = mBallIn - 1 : mBallPos(mBalls) = conStackSw + 1 : NeedUpdate = True
		If mEntrySw And mBallIn = 0 Then 
			mEntrySwcopy = mEntrySw
			Controller.Switch(mEntrySwcopy) = False
		End if
	End Sub

	Private Sub KickOut(aAltSol)
		Dim ii,jj, kForce, kDir, kBaseDir
		If mBalls Then PlaySound mExitSndBall Else PlaySound mExitSnd : Exit Sub
		If aAltSol Then kForce = mExitForce2 : kBaseDir = mExitDir2 Else kForce = mExitForce : kBaseDir = mExitDir
		kForce = kForce + (Rnd - 0.5)*KickForceVar
		If mSaucer Then
			SetSw 1, False : mBalls = 0 : kDir = kBaseDir + (Rnd - 0.5)*KickAngleVar
			If isObject(mInitKicker) Then
				vpmCreateBall mExitKicker : mInitKicker.Destroyball : mInitKicker.Enabled = True
			Else
				mExitKicker.Enabled = True
			End If
			mExitKicker.Kick kDir, kForce, KickZ
		Else
			For ii = 1 To kickballs
				If mBalls = 0 Or mBallPos(1) <> ii Then Exit For ' No more balls
				For jj = 2 To mBalls ' Move balls in array
					mBallPos(jj-1) = mBallPos(jj)
				Next
				mBallPos(mBalls) = 0 : mBalls = mBalls - 1 : NeedUpdate = True
				SetSw ii, False
				If isObject(mExitKicker) Then
					If kForce < 1 Then kForce = 1
					kDir = kBaseDir + (Rnd - 0.5)*KickAngleVar
					vpmTimer.AddTimer (ii-1)*200, "vpmCreateBall(" & mExitKicker.Name & ").Kick " &_
					  CInt(kDir) & "," & Replace(kForce,",",".") & "," & Replace(KickZ,",",".") & " '"
				End If
				kForce = kForce * 0.8
			Next
		End If
	End Sub

	Public Sub InitSaucer(aKicker, aSw, aDir, aPower)
		InitKick aKicker, aDir, aPower : mSaucer = True
		If aSw Then mSw(1) = aSw Else mSw(1) = aKicker.TimerInterval
	End Sub

	Public Sub InitNoTrough(aKicker, aSw, aDir, aPower)
		InitKick aKicker, aDir, aPower : Balls = 1
		If aSw Then mSw(1) = aSw Else mSw(1) = aKicker.TimerInterval
		If Not IsObject(vpmTrough) Then Set vpmTrough = Me
	End Sub

	Public Sub InitSw(aEntry, aSw1, aSw2, aSw3, aSw4, aSw5, aSw6, aSw7)
		mEntrySw = aEntry : mSw(1) = aSw1 : mSw(2) = aSw2 : mSw(3) = aSw3 : mSw(4) = aSw4
		mSw(5) = aSw5 : mSw(6) = aSw6 : mSw(7) = aSw7
		If Not IsObject(vpmTrough) Then Set vpmTrough = Me
	End Sub

	Public Sub InitKick(aKicker, aDir, aForce)
		Set mExitKicker = aKicker : mExitDir = aDir : mExitForce = aForce
	End Sub

	Public Sub CreateEvents(aName, aKicker)
		Dim obj, tmp
		If Not vpmCheckEvent(aName, Me) Then Exit Sub
		vpmSetArray tmp, aKicker
		For Each obj In tmp
			If isObject(obj) Then
				vpmBuildEvent obj, "Hit", aName & ".AddBall Me"
			Else
				vpmBuildEvent mExitKicker, "Hit", aName & ".AddBall Me"
			End If
		Next
	End Sub

	Public Property Let IsTrough(aIsTrough)
		If aIsTrough Then
			Set vpmTrough = Me
		ElseIf IsObject(vpmTrough) Then
			If vpmTrough Is Me Then vpmTrough = 0
		End If
	End Property

	Public Property Get IsTrough : IsTrough = vpmTrough Is Me : End Property

	Public Sub InitAltKick(aDir, aForce)
		mExitDir2 = aDir : mExitForce2 = aForce
	End Sub

	Public Sub InitEntrySnd(aBall, aNoBall) : mEntrySndBall = aBall : mEntrySnd = aNoBall : End Sub
	Public Sub InitExitSnd(aBall, aNoBall)  : mExitSndBall = aBall  : mExitSnd = aNoBall  : End Sub
	Public Sub InitAddSnd(aSnd) : mAddSnd = aSnd : End Sub

	Public Property Let Balls(aBalls)
		Dim ii
		For ii = 1 To conStackSw
			SetSw ii, False : mBallPos(ii) = conStackSw + 1
		Next
		If mSaucer And aBalls > 0 And mBalls = 0 Then vpmCreateBall mExitKicker
		mBalls = aBalls : NeedUpdate = True
	End Property

	Public Default Property Get Balls : Balls = mBalls         : End Property
	Public Property Get BallsPending  : BallsPending = mBallIn : End Property

	' Obsolete stuff
	Public Sub SolEntry(aSnd1, aSnd2, aEnabled)
		If aEnabled Then mEntrySndBall = aSnd1 : mEntrySnd = aSnd2 : KickIn
	End Sub
	Public Sub SolExit(aSnd1, aSnd2, aEnabled)
		If aEnabled Then mExitSndBall = aSnd1 : mExitSnd = aSnd2 : KickOut False
	End Sub
	Public Sub InitProxy(aProxyPos, aSwNo) : End Sub
	Public TempBallColour, TempBallImage, BallColour
	Public Property Let BallImage(aImage) : vpmBallImage = aImage : End Property
End Class

'--------------------
'       Nudge
'--------------------
class cvpmNudge
	Private mCount, mSensitivity, mNudgeTimer, mSlingBump, mForce
	Public TiltSwitch

	Private Sub Class_Initialize
		mCount = 0 : TiltSwitch = 0 : mSensitivity = 5 : vpmTimer.AddResetObj Me
	End sub

	Private Property Let NeedUpdate(aEnabled) : vpmTimer.EnableUpdate Me, False, aEnabled : End Property

	Public Property Let TiltObj(aSlingBump)
		Dim ii
		ReDim mForce(vpmSetArray(mSlingBump, aSlingBump))
		For ii = 0 To UBound(mForce)
			If TypeName(mSlingBump(ii)) = "Bumper" Then mForce(ii) = mSlingBump(ii).Force
			If TypeName(mSlingBump(ii)) = "Wall" Then mForce(ii) = mSlingBump(ii).SlingshotStrength
		Next
	End Property

	Public Property Let Sensitivity(aSens) : mSensitivity = (10-aSens)+1 : End property

	Public Sub DoNudge(ByVal aDir, ByVal aForce)
		aDir = aDir + (Rnd-0.5)*15*aForce : aForce = (0.6+Rnd*0.8)*aForce
		Nudge aDir, aForce
		If TiltSwitch = 0 Then Exit Sub ' If no switch why care
		mCount = mCount + aForce * 1.2
		If mCount > mSensitivity + 10 Then mCount = mSensitivity + 10
		If mCount >= mSensitivity Then vpmTimer.PulseSw TiltSwitch
		NeedUpdate = True
	End sub

	Public Sub Update
		If mCount > 0 Then
			mNudgeTimer = mNudgeTimer + 1
			If mNudgeTimer > 1000\conTimerPulse Then
				If mCount > mSensitivity+1 Then mCount = mCount - 1 : vpmTimer.PulseSw TiltSwitch
				mCount = mCount - 1 : mNudgeTimer = 0
			End If
		Else
			mCount = 0 : NeedUpdate = False
		End If
	End Sub

	Public Sub Reset : mCount = 0 : End Sub

	Public Sub SolGameOn(aEnabled)
		Dim obj, ii
		If aEnabled Then
			ii = 0
			For Each obj In mSlingBump
				If TypeName(obj) = "Bumper" Then obj.Force = mForce(ii) 
				If TypeName(obj) = "Wall" Then obj.SlingshotStrength = mForce(ii)
				ii = ii + 1
			Next
		Else
			For Each obj In mSlingBump
				If TypeName(obj) = "Bumper" Then obj.Force = 0
				If TypeName(obj) = "Wall" Then obj.SlingshotStrength = 0
			Next
		End If
	End Sub
End Class

'--------------------
'    DropTarget
'--------------------
Class cvpmDropTarget
	Private mDropObj, mDropSw(), mDropSnd, mRaiseSnd, mSwAnyUp, mSwAllDn, mAllDn, mLink

	Private Sub Class_Initialize
		mDropSnd = 0 : mRaiseSnd = 0 : mSwAnyUp = 0 : mSwAllDn = 0 : mAllDn = False : mLink = Empty
	End sub

	Private Sub CheckAllDn(ByVal aStatus)
		Dim obj
		If Not IsEmpty(mLink) Then
			If aStatus Then
				For Each obj In mLink : aStatus = aStatus And obj.AllDown : Next
			End If
			For Each obj In mLink: obj.SetAllDn aStatus : Next
		End If
		SetAllDn aStatus
	End Sub

	Public Sub SetAllDn(aStatus)
		If mSwAllDn Then Controller.Switch(mSwAllDn) = aStatus
		If mSwAnyUp Then Controller.Switch(mSwAnyUp) = Not aStatus
	End Sub

	Public Sub InitDrop(aWalls, aSw)
		Dim obj, obj2, ii
		' Fill in switch number
		On Error Resume Next : ReDim mDropSw(0)
		If IsArray(aSw) Then
			ReDim mDropSw(UBound(aSw))
			For ii = 0 To UBound(aSw) : mDropSw(ii) = aSw(ii) : Next
		ElseIf aSw = 0 Or Err Then
			On Error Goto 0
			If vpmIsArray(aWalls) Then
				ii = 0 : If IsArray(aWalls) Then ReDim mDropSw(UBound(aWalls)) Else ReDim mDropSw(aWalls.Count-1)
				For Each obj In aWalls
					If vpmIsArray(obj) Then
						For Each obj2 In obj
							If obj2.HasHitEvent Then mDropSw(ii) = obj2.TimerInterval : Exit For
						Next
					Else
						mDropSw(ii) = obj.TimerInterval
					End If
					ii = ii + 1
				Next
			Else
				mDropSw(0) = aWalls.TimerInterval
			End If
		Else
			mDropSw(0) = aSw
		End If
		' Copy walls
		vpmSetArray mDropObj, aWalls
	End Sub

	Public Sub CreateEvents(aName)
		Dim ii, obj1, obj2
		If Not vpmCheckEvent(aName, Me) Then Exit Sub
		ii = 1
		For Each obj1 In mDropObj
			If vpmIsArray(obj1) Then
				For Each obj2 In obj1
					If obj2.HasHitEvent Then vpmBuildEvent obj2, "Hit", aName & ".Hit " & ii
				Next
			Else
				vpmBuildEvent obj1, "Hit", aName & ".Hit " & ii
			End If
			ii = ii + 1
		Next
	End Sub

	Public Property Let AnyUpSw(aSwAnyUp)   : mSwAnyUp = aSwAnyUp : Controller.Switch(mSwAnyUp) = True : End Property
	Public Property Let AllDownSw(aSwAllDn) : mSwAllDn = aSwAllDn : End Property
	Public Property Get AllDown : AllDown = mAllDn : End Property
	Public Sub InitSnd(aDrop, aRaise) : mDropSnd = aDrop : mRaiseSnd = aRaise : End Sub
	Public Property Let LinkedTo(aLink)
		If IsArray(aLink) Then mLink = aLink Else mLink = Array(aLink)
	End Property

	Public Sub Hit(aNo)
		Dim ii
		vpmSolWall mDropObj(aNo-1), mDropSnd, True
		Controller.Switch(mDropSw(aNo-1)) = True
		For Each ii In mDropSw
			If Not Controller.Switch(ii) Then Exit Sub
		Next
		mAllDn = True : CheckAllDn True
	End Sub

	Public Sub SolHit(aNo, aEnabled) : If aEnabled Then Hit aNo : End If : End Sub

	Public Sub SolUnhit(aNo, aEnabled)
		Dim ii : If Not aEnabled Then Exit Sub
		PlaySound mRaiseSnd : vpmSolWall mDropObj(aNo-1), False, False
		Controller.Switch(mDropSw(aNo-1)) = False
		mAllDn = False : CheckAllDn False
	End Sub

	Public Sub SolDropDown(aEnabled)
		Dim ii : If Not aEnabled Then Exit Sub
		PlaySound mDropSnd
		For Each ii In mDropObj : vpmSolWall ii, False, True : Next
		For Each ii In mDropSw  : Controller.Switch(ii) = True : Next
		mAllDn = True : CheckAllDn True
	End Sub

	Public Sub SolDropUp(aEnabled)
		Dim ii : If Not aEnabled Then Exit Sub
		PlaySound mRaiseSnd
		For Each ii In mDropObj : vpmSolWall ii, False, False : Next
		For Each ii In mDropSw  : Controller.Switch(ii) = False : Next
		mAllDn = False : CheckAllDn False
	End Sub

	Public Sub DropSol_On : SolDropUp True : End Sub
End Class

'--------------------
'       Magnet
'--------------------
Class cvpmMagnet
	Private mEnabled, mBalls, mTrigger
	Public X, Y, Strength, Size, GrabCenter, Solenoid

	Private Sub Class_Initialize
		Size = 1 : Strength = 0 : Solenoid = 0 : mEnabled = False
		Set mBalls = New cvpmDictionary
	End Sub

	Private Property Let NeedUpdate(aEnabled) : vpmTimer.EnableUpdate Me, True, aEnabled : End Property

	Public Sub InitMagnet(aTrigger, aStrength)
		Dim tmp
		If vpmIsArray(aTrigger) Then Set tmp = aTrigger(0) Else Set tmp = aTrigger
		X = tmp.X : Y = tmp.Y : Size = tmp.Radius : vpmTimer.InitTimer tmp, True
		If IsArray(aTrigger) Then mTrigger = aTrigger Else Set mTrigger = aTrigger
		Strength = aStrength : GrabCenter = aStrength > 14
	End Sub

	Public Sub CreateEvents(aName)
		If vpmCheckEvent(aName, Me) Then
			vpmBuildEvent mTrigger, "Hit", aName & ".AddBall ActiveBall"
			vpmBuildEvent mTrigger, "UnHit", aName & ".RemoveBall ActiveBall"
		End If
	End Sub

	Public Property Let MagnetOn(aEnabled) : mEnabled = aEnabled : End Property
	Public Property Get MagnetOn
		If Solenoid > 0 Then MagnetOn = Controller.Solenoid(Solenoid) Else MagnetOn = mEnabled
	End Property

	Public Sub AddBall(aBall)
		With mBalls
			If .Exists(aBall) Then .Item(aBall) = .Item(aBall) + 1 Else .Add aBall, 1 : NeedUpdate = True
		End With
	End Sub

	Public Sub RemoveBall(aBall)
		With mBalls
			If .Exists(aBall) Then .Item(aBall) = .Item(aBall) - 1 : If .Item(aBall) <= 0 Then .Remove aBall
			NeedUpdate = (.Count > 0)
		End With
	End Sub

	Public Property Get Balls : Balls = mBalls.Keys : End Property

	Public Sub Update
		Dim obj
		If MagnetOn Then
			On Error Resume Next
			For Each obj In mBalls.Keys
				If obj.X < 0 Or Err Then mBalls.Remove obj Else AttractBall obj
			Next
			On Error Goto 0
		End If
	End Sub

	Public Sub AttractBall(aBall)
		Dim dX, dY, dist, force, ratio
		dX = aBall.X - X : dY = aBall.Y - Y : dist = Sqr(dX*dX + dY*dY)
		If dist > Size Or dist < 1 Then Exit Sub 'Just to be safe
		If GrabCenter And dist < 20 Then
			aBall.VelX = 0 : aBall.VelY = 0 : aBall.X = X : aBall.Y = Y
		Else
			ratio = dist / (1.5*Size)
			force = Strength * exp(-0.2/ratio)/(ratio*ratio*56) * 1.5
			aBall.VelX = (aBall.VelX - dX * force / dist) * 0.985
			aBall.VelY = (aBall.VelY - dY * force / dist) * 0.985
		End if
	End Sub
	' obsolete
	Public Property Let Range(aSize) : Size = aSize : End Property
	Public Property Get Range        : Range = Size : End Property
End Class

'--------------------
'     Turntable
'--------------------
Class cvpmTurntable
	Private mX, mY, mSize, mMotorOn, mDir, mBalls, mTrigger
	Public MaxSpeed, SpinUp, SpinDown, Speed

	Private Sub Class_Initialize
		mMotorOn = False : Speed = 0 : mDir = 1 : SpinUp = 10 : SpinDown = 4
		Set mBalls = New cvpmDictionary
	End Sub

	Private Property Let NeedUpdate(aEnabled) : vpmTimer.EnableUpdate Me, True, aEnabled : End Property

	Public Sub InitTurntable(aTrigger, aMaxSpeed)
		mX = aTrigger.X : mY = aTrigger.Y : mSize = aTrigger.Radius : vpmTimer.InitTimer aTrigger, True
		MaxSpeed = aMaxSpeed : Set mTrigger = aTrigger
	End Sub

	Public Sub CreateEvents(aName)
		If vpmCheckEvent(aName, Me) Then
			vpmBuildEvent mTrigger, "Hit", aName & ".AddBall ActiveBall"
			vpmBuildEvent mTrigger, "UnHit", aName & ".RemoveBall ActiveBall"
		End If
	End Sub

	Public Sub SolMotorState(aCW, aEnabled)
		mMotorOn = aEnabled : If aEnabled Then If aCW Then mDir = 1 Else mDir = -1
		NeedUpdate = True
	End Sub

	Public Property Let MotorOn(aEnabled)
		mMotorOn = aEnabled : NeedUpdate = mBalls.Count Or SpinUp Or SpinDown
	End Property
	Public Property Get MotorOn : MotorOn = mMotorOn : End Property

	Public Sub AddBall(aBall)
		On Error Resume Next : mBalls.Add aBall,0 : NeedUpdate = True
	End Sub
	Public Sub RemoveBall(aBall)
		On Error Resume Next
		mBalls.Remove aBall : NeedUpdate = mBalls.Count Or SpinUp Or SpinDown
	End Sub
	Public Property Get Balls : Balls = mBalls.Keys : End Property
	Public Property Let SpinCW(aCW)
		NeedUpdate = True : If aCW Then mDir = 1 Else mDir = -1
	End Property

	Public Property Get SpinCW : SpinCW = (mDir = 1) : End Property

	Public Sub Update
		If mMotorOn Then
			Speed = Speed + mDir*SpinUp/100
			If mDir * Speed >= MaxSpeed Then Speed = mDir * MaxSpeed : NeedUpdate = mBalls.Count
		Else
			Speed = Speed - mDir*SpinDown/100
			If mDir * Speed <= 0 Then Speed = 0 : NeedUpdate = mBalls.Count
		End If
		If Speed Then
			Dim obj
			On Error Resume Next
			For Each obj In mBalls.Keys
				If obj.X < 0 Or Err Then mBalls.Remove obj Else AffectBall obj
			Next
			On Error Goto 0
		End If
	End Sub

	Public Sub AffectBall(aBall)
		Dim dX, dY, dist
		dX = aBall.X - mX : dY = aBall.Y - mY : dist = Sqr(dX*dX + dY*dY)
		If dist > mSize Or dist < 1 Or Speed = 0 Then Exit Sub
		aBall.VelX = aBall.VelX - (dY * Speed / 8000)
		aBall.VelY = aBall.VelY + (dX * Speed / 8000)
	End Sub
End Class

'--------------------
'     Mech
'--------------------
Const vpmMechLinear    = &H00
Const vpmMechNonLinear = &H01
Const vpmMechCircle    = &H00
Const vpmMechStopEnd   = &H02
Const vpmMechReverse   = &H04
Const vpmMechOneSol    = &H00
Const vpmMechOneDirSol = &H10
Const vpmMechTwoDirSol = &H20
Const vpmMechStepSol   = &H40
Const vpmMechSlow      = &H00
Const vpmMechFast      = &H80
Const vpmMechStepSw    = &H00
Const vpmMechLengthSw  = &H100

Class cvpmMech
	Public Sol1, Sol2, MType, Length, Steps, Acc, Ret
	Private mMechNo, mNextSw, mSw(), mLastPos, mLastSpeed, mCallback

	Private Sub Class_Initialize
		ReDim mSw(10)
		gNextMechNo = gNextMechNo + 1 : mMechNo = gNextMechNo : mNextSw = 0 : mLastPos = 0 : mLastSpeed = 0
		MType = 0 : Length = 0 : Steps = 0 : Acc = 0 : Ret = 0 : vpmTimer.addResetObj Me
	End Sub

	Public Sub AddSw(aSwNo, aStart, aEnd)
		mSw(mNextSw) = Array(aSwNo, aStart, aEnd, 0)
		mNextSw = mNextSw + 1
	End Sub

	Public Sub AddPulseSwNew(aSwNo, aInterval, aStart, aEnd)
		If Controller.Version >= "01200000" Then
			mSw(mNextSw) = Array(aSwNo, aStart, aEnd, aInterval)
		Else
			mSw(mNextSw) = Array(aSwNo, -aInterval, aEnd - aStart + 1, 0)
		End If
		mNextSw = mNextSw + 1
	End Sub

	Public Sub Start
		Dim sw, ii
		With Controller
			.Mech(1) = Sol1 : .Mech(2) = Sol2 : .Mech(3) = Length
			.Mech(4) = Steps : .Mech(5) = MType : .Mech(6) = Acc : .Mech(7) = Ret
			ii = 10
			For Each sw In mSw
				If IsArray(sw) Then
					.Mech(ii) = sw(0) : .Mech(ii+1) = sw(1)
					.Mech(ii+2) = sw(2) : .Mech(ii+3) = sw(3)
					ii = ii + 10
				End If
			Next
			.Mech(0) = mMechNo
		End With
		If IsObject(mCallback) Then mCallBack 0, 0, 0 : mLastPos = 0 : vpmTimer.EnableUpdate Me, False, True
	End Sub

	Public Property Get Position : Position = Controller.GetMech(mMechNo) : End Property
	Public Property Get Speed    : Speed = Controller.GetMech(-mMechNo)   : End Property
	Public Property Let Callback(aCallBack) : Set mCallback = aCallBack : End Property

	Public Sub Update
		Dim currPos, speed
		currPos = Controller.GetMech(mMechNo)
		speed = Controller.GetMech(-mMechNo)
		If currPos < 0 Or (mLastPos = currPos And mLastSpeed = speed) Then Exit Sub
		mCallBack currPos, speed, mLastPos : mLastPos = currPos : mLastSpeed = speed
	End Sub

	Public Sub Reset : Start : End Sub
	' Obsolete
	Public Sub AddPulseSw(aSwNo, aInterval, aLength) : AddSw aSwNo, -aInterval, aLength : End Sub
End Class

'--------------------
'   Captive Ball
'--------------------
Class cvpmCaptiveBall
	Private mBallKicked, mBallDir, mBallCos, mBallSin, mTrigHit
	Private mTrig, mWall, mKickers, mVelX, mVelY, mKickNo
	Public ForceTrans, MinForce, RestSwitch, NailedBalls

	Private Sub Class_Initialize
		mBallKicked = False : ForceTrans = 0.5 : mTrigHit = False : MinForce = 3 : NailedBalls = 0
		vpmTimer.addResetObj Me
	End Sub

	Public Sub InitCaptive(aTrig, aWall, aKickers, aBallDir)
		Set mTrig = aTrig : Set mWall = aWall
		mKickNo = vpmSetArray(mKickers, aKickers)
		mBallDir = aBallDir : mBallCos = Cos(aBallDir * 3.1415927/180) : mBallSin = Sin(aBallDir * 3.1415927/180)
	End Sub

	Public Sub Start
		vpmCreateBall mKickers(mKickNo + (mKickNo <> NailedBalls))
		If RestSwitch Then Controller.Switch(RestSwitch) = True
	End Sub

	Public Sub TrigHit(aBall)
		mTrigHit = IsObject(aBall) : If mTrigHit Then mVelX = aBall.VelX : mVelY = aBall.VelY
	End Sub

	Public Sub Reset : If RestSwitch Then Controller.Switch(RestSwitch) = True : End If : End Sub

	Public Sub BallHit(aBall)
		Dim dX, dY, force
		If mBallKicked Then Exit Sub ' Ball is not here
		If mTrigHit Then mTrigHit = False Else mVelX = aBall.VelX : mVelY = aBall.VelY
		dX = aBall.X - mKickers(0).X : dY = aBall.Y - mKickers(0).Y
		force = -ForceTrans * (dY * mVelY + dX * mVelX) * (dY * mBallCos + dX * mBallSin) / (dX*dX + dY*dY)
		If force < 1 Then Exit Sub
		If force < MinForce Then force = MinForce
		If mKickNo <> NailedBalls Then
			vpmCreateBall mKickers(mKickNo)
			mKickers(mKickNo-1).DestroyBall
		End If
		mKickers(mKickNo).Kick mBallDir, force : mBallKicked = True
		If RestSwitch Then Controller.Switch(RestSwitch) = False
	End Sub

	Public Sub BallReturn(aKicker)
		If mKickNo <> NailedBalls Then vpmCreateBall mKickers(mKickNo-1) : aKicker.DestroyBall
		mBallKicked = False
		If RestSwitch Then Controller.Switch(RestSwitch) = True
	End Sub

	Public Sub CreateEvents(aName)
		If vpmCheckEvent(aName, Me) Then
			If Not mTrig Is Nothing Then
				vpmBuildEvent mTrig, "Hit", aName & ".TrigHit ActiveBall"
				vpmBuildEvent mTrig, "UnHit", aName & ".TrigHit 0"
			End If
			vpmBuildEvent mWall, "Hit", aName & ".BallHit ActiveBall"
			vpmBuildEvent mKickers(mKickNo), "Hit", aName & ".BallReturn Me"
		End If
	End Sub
	' Obsolete
	Public BallImage, BallColour
End Class

'--------------------
'   Visible Locks
'--------------------
Class cvpmVLock
	Private mTrig, mKick, mSw(), mSize, mBalls, mGateOpen, mRealForce, mBallSnd, mNoBallSnd
	Public ExitDir, ExitForce, KickForceVar

	Private Sub Class_Initialize
		mBalls = 0 : ExitDir = 0 : ExitForce = 0 : KickForceVar = 0 : mGateOpen = False
		vpmTimer.addResetObj Me
	End Sub

	Public Sub InitVLock(aTrig, aKick, aSw)
		Dim ii
		mSize = vpmSetArray(mTrig, aTrig)
		If vpmSetArray(mKick, aKick) <> mSize Then MsgBox "cvpmVLock: Unmatched kick+trig" : Exit Sub
		On Error Resume Next
		ReDim mSw(mSize)
		If IsArray(aSw) Then
			For ii = 0 To UBound(aSw) : mSw(ii) = aSw(ii) : Next
		ElseIf aSw = 0 Or Err Then
			For ii = 0 To mSize: mSw(ii) = mTrig(ii).TimerInterval : Next
		Else
			mSw(0) = aSw
		End If
	End Sub

	Public Sub InitSnd(aBall, aNoBall) : mBallSnd = aBall : mNoBallSnd = aNoBall : End Sub
	Public Sub CreateEvents(aName)
		Dim ii
		If Not vpmCheckEvent(aName, Me) Then Exit Sub
		For ii = 0 To mSize
			vpmBuildEvent mTrig(ii), "Hit", aName & ".TrigHit ActiveBall," & ii+1
			vpmBuildEvent mTrig(ii), "Unhit", aName & ".TrigUnhit ActiveBall," & ii+1
			vpmBuildEvent mKick(ii), "Hit", aName & ".KickHit " & ii+1
		Next
	End Sub

	Public Sub SolExit(aEnabled)
		Dim ii
		mGateOpen = aEnabled
		If Not aEnabled Then Exit Sub
		If mBalls > 0 Then PlaySound mBallSnd : Else PlaySound mNoBallSnd : Exit Sub
		For ii = 0 To mBalls-1
			mKick(ii).Enabled = False : If mSw(ii) Then Controller.Switch(mSw(ii)) = False
		Next
		If ExitForce > 0 Then ' Up
			mRealForce = ExitForce + (Rnd - 0.5)*KickForceVar : mKick(mBalls-1).Kick ExitDir, mRealForce
		Else ' Down
			mKick(0).Kick 0, 0
		End If
	End Sub

	Public Sub Reset
		Dim ii : If mBalls = 0 Then Exit Sub
		For ii = 0 To mBalls-1
			If mSw(ii) Then Controller.Switch(mSw(ii)) = True
		Next
	End Sub

	Public Property Get Balls : Balls = mBalls : End Property

	Public Property Let Balls(aBalls)
		Dim ii : mBalls = aBalls
		For ii = 0 To mSize
			If ii >= aBalls Then
				mKick(ii).DestroyBall : If mSw(ii) Then Controller.Switch(mSw(ii)) = False
			Else
				vpmCreateBall mKick(ii) : If mSw(ii) Then Controller.Switch(mSw(ii)) = True
			End If
		Next
	End Property

	Public Sub TrigHit(aBall, aNo)
		aNo = aNo - 1 : If mSw(aNo) Then Controller.Switch(mSw(aNo)) = True
		If aBall.VelY < -1 Then Exit Sub ' Allow small upwards speed
		If aNo = mSize Then mBalls = mBalls + 1
		If mBalls > aNo Then mKick(aNo).Enabled = Not mGateOpen
	End Sub

	Public Sub TrigUnhit(aBall, aNo)
		aNo = aNo - 1 : If mSw(aNo) Then Controller.Switch(mSw(aNo)) = False
		If aBall.VelY > -1 Then
			If aNo = 0 Then mBalls = mBalls - 1
			If aNo < mSize Then mKick(aNo+1).Kick 0, 0
		Else
			If aNo = mSize Then mBalls = mBalls - 1
			If aNo > 0 Then mKick(aNo-1).Kick ExitDir, mRealForce
		End If
	End Sub

	Public Sub KickHit(aNo) : mKick(aNo-1).Enabled = False : End Sub
End Class

'--------------------
'   View Dips
'--------------------
Class cvpmDips
	Private mLWF, mChkCount, mOptCount, mItems()

	Private Sub Class_Initialize
		ReDim mItems(100)
	End Sub

	Private Sub addChkBox(aType, aLeft, aTop, aWidth, aNames)
		Dim ii, obj
		If Not isObject(mLWF) Then Exit Sub
		For ii = 0 To UBound(aNames) Step 2
			Set obj = mLWF.AddCtrl("chkBox", 10+aLeft, 5+aTop+ii*7, aWidth, 14, aNames(ii))
			mChkCount = mChkCount + 1 : mItems(mChkCount+mOptCount) = Array(aType, obj, mChkCount, aNames(ii+1), aNames(ii+1))
		Next
	End Sub

	Private Sub addOptBox(aType, aLeft, aTop, aWidth, aHeading, aMask, aNames)
		Dim ii, obj
		If Not isObject(mLWF) Then Exit Sub
		mLWF.AddCtrl "Frame", 10+aLeft, 5+aTop, 10+aWidth, 7*UBound(aNames)+25, aHeading
		If aMask Then
			For ii = 0 To UBound(aNames) Step 2
				Set obj = mLWF.AddCtrl("OptBtn", 10+aLeft+5, 5+aTop+ii*7+14, aWidth, 14, aNames(ii))
				mOptCount = mOptCount + 1 : mItems(mChkCount+mOptCount) = Array(aType+2,obj,mOptCount,aNames(ii+1),aMask)
			Next
		Else
			addChkBox aType, 5+aLeft, 15+aTop, aWidth, aNames
		End If
	End Sub

	Public Sub addForm(ByVal aWidth, aHeight, aName)
		If aWidth < 80 Then aWidth = 80
		On Error Resume Next
		Set mLWF = CreateObject("VPinMAME.WSHDlg") : If Err Then Exit Sub
		With mLWF
			.x = -1 : .y = -1 ' : .w = aWidth : .h = aHeight+60
			.Title = aName : .AddCtrl "OKBtn", -1, -1, 70, 25, "&Ok"
		End With
		mChkCount = 0 : mOptCount = 0
	End Sub

	Public Sub addChk(aLeft, aTop, aWidth, aNames)
		addChkBox 0, aLeft, aTop, aWidth, aNames
	End Sub
	Public Sub addChkExtra(aLeft, aTop, aWidth, aNames)
		addChkBox 1, aLeft, aTop, aWidth, aNames
	End Sub
	Public Sub addFrame(aLeft, aTop, aWidth, aHeading, aMask, aNames)
		addOptBox 0, aLeft, aTop, aWidth, aHeading, aMask, aNames
	End Sub
	Public Sub addFrameExtra(aLeft, aTop, aWidth, aHeading, aMask, aNames)
		addOptBox 1, aLeft, aTop, aWidth, aHeading, aMask, aNames
	End Sub

	Public Sub addLabel(aLeft, aTop, aWidth, aHeight, aCaption)
		If Not isObject(mLWF) Then Exit Sub
		mLWF.AddCtrl "Label", 10+aLeft, 5+aTop, aWidth, aHeight, aCaption
	End Sub

	Public Sub viewDips : viewDipsExtra 0 : End Sub
	Public Function viewDipsExtra(aExtra)
		Dim dips(1), ii, useDip
		If Not isObject(mLWF) Then Exit Function
		With Controller
			dips(0) = .Dip(0) + .Dip(1)*256 + .Dip(2)*65536 + (.Dip(3) And &H7f)*&H1000000
			If .Dip(3) And &H80 Then dips(0) = dips(0) Or &H80000000 'workaround for overflow error
		End With
		useDip = False : dips(1) = aExtra
		For ii = 1 To mChkCount + mOptCount
			mItems(ii)(1).Value = -((dips(mItems(ii)(0) And &H01) And mItems(ii)(4)) = mItems(ii)(3))
			If (mItems(ii)(0) And &H01) = 0 Then useDip = True
		Next
		mLWF.Show GetPlayerHWnd
		dips(0) = 0 : dips(1) = 0
		For ii = 1 To mChkCount + mOptCount
			If mItems(ii)(1).Value Then dips(mItems(ii)(0) And &H01) = dips(mItems(ii)(0) And &H01) Or mItems(ii)(3)
		Next
		If useDip Then
			With Controller
				.Dip(0) =  (dips(0) And 255)
				.Dip(1) = ((dips(0) And 65280)\256) And 255
				.Dip(2) = ((dips(0) And &H00ff0000)\65536) And 255
				.Dip(3) = ((dips(0) And &Hff000000)\&H01000000) And 255
			End With
		End If
		viewDipsExtra = dips(1)
	End Function
End Class

'--------------------
'   Impulse Plunger
'--------------------
Class cvpmImpulseP
	Private mEnabled, mBalls, mTrigger, mEntrySnd, mExitSnd, MExitSndBall
	Public X, Y, Strength, Res, Size, Solenoid, IMPowerOut, Time, mCount, Pull, IMPowerTrans, cFactor, Auto, RandomOut, SwitchNum, SwitchOn, BallOn

	Private Sub Class_Initialize
		Size = 1 : Strength = 0 : Solenoid = 0 : Res = 1 : IMPowerOut = 0 : Time = 0 : mCount = 0 : mEnabled = False
		Pull = 0 : IMPowerTrans = 0 : Auto = False : RandomOut = 0 : SwitchOn = 0 : SwitchNum = 0 : BallOn = 0
		Set mBalls = New cvpmDictionary
	End Sub

	Private Property Let NeedUpdate(aEnabled) : vpmTimer.EnableUpdate Me, True, aEnabled : End Property

	Public Sub InitImpulseP(aTrigger, aStrength, aTime)
		Dim tmp
		If vpmIsArray(aTrigger) Then Set tmp = aTrigger(0) Else Set tmp = aTrigger
		X = tmp.X : Y = tmp.Y : Size = tmp.Radius : vpmTimer.InitTimer tmp, True
		If IsArray(aTrigger) Then mTrigger = aTrigger Else Set mTrigger = aTrigger
		Strength = aStrength
		Res = 500
		Time = aTime
		If aTime = 0 Then 
			Auto = True
		Else
			cFactor = (Res / Time) / 100
			Auto = False
		End If
	End Sub

	Public Sub CreateEvents(aName)
		If vpmCheckEvent(aName, Me) Then
			vpmBuildEvent mTrigger, "Hit", aName & ".AddBall ActiveBall"
			vpmBuildEvent mTrigger, "UnHit", aName & ".RemoveBall ActiveBall"
		End If
	End Sub

 
	Public Property Let PlungeOn(aEnabled) : mEnabled = aEnabled : End Property
	Public Property Get PlungeOn
		If Solenoid > 0 Then PlungeOn = Controller.Solenoid(Solenoid) Else PlungeOn = mEnabled
	End Property

	Public Sub AddBall(aBall)
		Dim SwitchNumcopy
		With mBalls
			If .Exists(aBall) Then .Item(aBall) = .Item(aBall) + 1 Else .Add aBall, 1 : NeedUpdate = True
		End With
		If SwitchOn = True Then	
			SwitchNumcopy = SwitchNum
			controller.switch(SwitchNumcopy) = 1
		End if
		BallOn = 1
	End Sub

	Public Sub RemoveBall(aBall)
		Dim SwitchNumcopy
		With mBalls
			If .Exists(aBall) Then .Item(aBall) = .Item(aBall) - 1 : If .Item(aBall) <= 0 Then .Remove aBall
			NeedUpdate = (.Count > 0)
		End With
		If SwitchOn = True Then	
			SwitchNumcopy = SwitchNum
			controller.switch(SwitchNumcopy) = 0
		End if
		BallOn = 0
	End Sub

	Public Property Get Balls : Balls = mBalls.Keys : End Property

	Public Sub Update
		Dim obj
		If pull = 1 and mCount < Res Then
			mCount = mCount + cFactor
			IMPowerTrans = mCount
			NeedUpdate = True
		Else
			IMPowerTrans = mCount
			NeedUpdate = False
		End If
		If PlungeOn Then
			On Error Resume Next
			For Each obj In mBalls.Keys
				If obj.X < 0 Or Err Then : mBalls.Remove obj : Else : PlungeBall obj : End If
			Next
			On Error Goto 0
		End If
	End Sub

	Public Sub PlungeBall(aBall)
			aBall.VelY = IMPowerOut
	End Sub

	Public Sub Random(aInput) ' Random Output Varience
		RandomOut = aInput
	End Sub

	Public Sub Fire	    	  ' Resets System and Transfer Power Value
		If Auto = True Then
		IMPowerOut = -Strength + ((Rnd) * RandomOut)
		Else
		IMPowerOut = -Strength * (IMPowerTrans + ((Rnd-0.5) * cFactor * RandomOut)) / Res
		End If
		PlungeOn = True
		Update
		PlungeOn = False
		Pull = 0 : IMPowerOut = 0 : IMPowerTrans = 0 : mCount = 0
		If BallOn = 1 Then : PlaySound mExitSndBall : Else : PlaySound mExitSnd : End If
	End Sub

	Public Sub AutoFire	  ' Auto-Fire Specific Call (so you don't have to change timing)
		IMPowerOut = -Strength + ((Rnd) * RandomOut)
		PlungeOn = True
		Update
		PlungeOn = False
		Pull = 0 : IMPowerOut = 0 : IMPowerTrans = 0 : mCount = 0
		If BallOn = 1 Then : PlaySound mExitSndBall : Else : PlaySound mExitSnd : End If
	End Sub
	
	Public Sub Pullback     ' Pull Plunger
		Pull = 0 : IMPowerOut = 0 : IMPowerTrans = 0 : mCount = 0 ' reiniatialize to be sure
		Pull = 1 : NeedUpdate = True
    		PlaySound mEntrySnd
	End Sub
	
	Public Sub Switch(aSw)
		SwitchOn = True
		SwitchNum = aSw
	End Sub
	
    Public Sub InitEntrySnd(aNoBall) : mEntrySnd = aNoBall : End Sub
    Public Sub InitExitSnd(aBall, aNoBall)  : mExitSndBall = aBall  : mExitSnd = aNoBall  : End Sub
End Class

Set vpmTimer = New cvpmTimer
Set vpmNudge = New cvpmNudge

'---------------------------
' Check VP version running
'---------------------------
Private Function vpmCheckVPVer
	On Error Resume Next
	' a bug in VBS?: Err object is not cleared on Exit Function
	If VPBuildVersion < 0 Or Err Then vpmCheckVPVer = 50 : Err.Clear : Exit Function
	If VPBuildVersion > 2806 Then
		vpmCheckVPVer = 63
	ElseIf VPBuildVersion > 2721 Then
		vpmCheckVPVer = 61
	ElseIf VPBuildVersion >= 900 and VPBuildVersion <= 999 Then
		vpmCheckVPVer = 90
	Else
		vpmCheckVPVer = 60
	End If
End Function
Private vpmVPVer : vpmVPVer = vpmCheckVPVer()
'--------------------
' Initialise timers
'--------------------
Sub PulseTimer_Init  : vpmTimer.InitTimer Me, False : End Sub
Sub PinMAMETimer_Init : Me.Interval = PinMAMEInterval : Me.Enabled = True : End Sub

'---------------------------------------------
' Init function called from Table_Init event
'---------------------------------------------
Public Sub vpmInit(aTable)
	Set vpmTable = aTable
	If vpmVPVer >= 60 Then
		On Error Resume Next
		If Not IsObject(GetRef(aTable.Name & "_Paused")) Or Err Then
			vpmBuildEvent aTable, "Paused",   "Controller.Pause = True"
			vpmBuildEvent aTable, "UnPaused", "Controller.Pause = False"
		End If
	End If
End Sub

' Exit function called in Table_Exit event
Public Sub vpmExit : End Sub
'------------------------------------------------------
' All classes call this function to create a ball
' Assign vpmCreateBall if you want a custom function
'------------------------------------------------------
Private Function vpmDefCreateBall(aKicker)
	If Not IsEmpty(vpmBallImage) Then aKicker.CreateBall.Image = vpmBallImage Else aKicker.CreateBall : End If
	Set vpmDefCreateBall = aKicker
End Function
Set vpmCreateBall = GetRef("vpmDefCreateBall")
Private vpmTrough ' Default Trough. Used to clear up missing balls
Private vpmTable  ' Table object

'-------------------
' Main Loop
'------------------
Private Const CHGNO = 0
Private Const CHGSTATE = 1
Private vpmTrueFalse : vpmTrueFalse = Array(" True", " False"," True")

Sub vpmDoSolCallback(aNo, aEnabled)
	If SolCallback(aNo) <> "" Then Execute SolCallback(aNo) & vpmTrueFalse(aEnabled+1)
End Sub

Sub vpmDoLampUpdate(aNo, aEnabled)
	On Error Resume Next : Lights(aNo).State = Abs(aEnabled)
End Sub

Sub PinMAMETimer_Timer
	Dim ChgLamp,ChgSol,ChgGI, ii, tmp, idx
	Me.Enabled = False
	On Error Resume Next
		If UseLamps Then ChgLamp = Controller.ChangedLamps Else LampCallback
		If UseSolenoids Then ChgSol  = Controller.ChangedSolenoids
		If isObject(GICallback) or isObject (GICallback2) Then ChgGI = Controller.ChangedGIStrings
		MotorCallback
	On Error Goto 0
	If Not IsEmpty(ChgLamp) Then
		On Error Resume Next
			For ii = 0 To UBound(ChgLamp)
				idx = chgLamp(ii, 0)
				If IsArray(Lights(idx)) Then
					For Each tmp In Lights(idx) : tmp.State = ChgLamp(ii, 1) : Next
				Else
					Lights(idx).State = ChgLamp(ii, 1)
				End If
			Next
			For Each tmp In vpmMultiLights
				For ii = 1 To UBound(tmp) : tmp(ii).State = tmp(0).State : Next
			Next
			LampCallback
		On Error Goto 0
	End If
	If Not IsEmpty(ChgSol) Then
		For ii = 0 To UBound(ChgSol)
			tmp = SolCallback(ChgSol(ii, 0))
			If tmp <> "" Then Execute tmp & vpmTrueFalse(ChgSol(ii, 1)+1)
		Next
	End If
	If Not IsEmpty(ChgGI) Then
		For ii = 0 To UBound(ChgGI)
			GICallback ChgGI(ii, 0), CBool(ChgGI(ii, 1))
			GICallback2 ChgGI(ii, 0), ChgGI(ii, 1)
		Next
	End If
	Me.Enabled = True
End Sub

'
' Private helper functions
'
Private Sub vpmPlaySound(aEnabled, aSound)
	If VarType(aSound) = vbString Then
		If aEnabled Then StopSound aSound : PlaySound aSound
	ElseIf aSound Then
		If aEnabled Then PlaySound SSolenoidOn Else PlaySound SSolenoidOff
	End If
End Sub

Private Sub vpmToggleObj(aObj, aEnabled)
	Select Case TypeName(aObj)
		Case "Wall"                        aObj.IsDropped = aEnabled
		Case "Bumper", "Light"             aObj.State     = Abs(aEnabled)
		Case "Kicker", "Trigger", "Timer"  aObj.Enabled   = aEnabled
		Case "Gate"                        aObj.Open      = aEnabled
		Case "Integer"                     Controller.Switch(aObj) = aEnabled
		Case Else MsgBox "vpmToggleObj: Unhadled Object " & TypeName(aObj)
	End Select
End Sub

Private Function vpmCheckEvent(aName, aObj)
	vpmCheckEvent = True
	On Error Resume Next
	If Not Eval(aName) Is aObj Or Err Then MsgBox "CreateEvents: Wrong name " & aName : vpmCheckEvent = False
End Function

Private Sub vpmBuildEvent(aObj, aEvent, aTask)
	Dim obj, str
	str = "_" & aEvent & " : " & aTask & " : End Sub"
	If vpmIsArray(aObj) Then
		For Each obj In aObj : ExecuteGlobal "Sub " & obj.Name & str : Next
	Else
		ExecuteGlobal "Sub " & aObj.Name & str
	End If
End Sub

Private Function vpmIsCollection(aObj)
	vpmIsCollection =  TypeName(aObj) = "Collection" Or TypeName(aObj) = "ICollection"
End Function
Private Function vpmIsArray(aObj)
	vpmIsArray = IsArray(aObj) Or vpmIsCollection(aObj)
End Function

Private Function vpmSetArray(aTo, aFrom)
	If IsArray(aFrom) Then
		aTo = aFrom : vpmSetArray = UBound(aFrom)
	ElseIf vpmIsCollection(aFrom) Then
		Set aTo = aFrom : vpmSetArray = aFrom.Count - 1
	Else
		aTo = Array(aFrom) : vpmSetArray = 0
	End If
End Function

Sub vpmCreateEvents(aHitObjs)
	Dim obj
	For Each obj In aHitObjs
		Select Case TypeName(obj)
			Case "Trigger"
				vpmBuildEvent obj, "Hit", "Controller.Switch(" & Obj.TimerInterval & ") = True"
				vpmBuildEvent obj, "UnHit", "Controller.Switch(" & Obj.TimerInterval & ") = False"
			Case "Wall"
				If obj.HasHitEvent Then
					vpmBuildEvent obj, "Hit", "vpmTimer.PulseSw " & Obj.TimerInterval
				Else
					vpmBuildEvent obj, "SlingShot", "vpmTimer.PulseSw " & Obj.TimerInterval
				End If
			Case "Bumper", "Gate"
				vpmBuildEvent obj, "Hit","vpmTimer.PulseSw " & Obj.TimerInterval
			Case "Spinner"
				vpmBuildEvent obj, "Spin","vpmTimer.PulseSw " & Obj.TimerInterval
		End Select
	Next
End Sub

Sub vpmMapLights(aLights)
	Dim obj, str, ii, idx
	For Each obj In aLights
		idx = obj.TimerInterval
		If IsArray(Lights(idx)) Then
			str = "Lights(" & idx & ") = Array("
			For Each ii In Lights(idx) : str = str & ii.Name & "," : Next
			ExecuteGlobal str & obj.Name & ")"
		ElseIf IsObject(Lights(idx)) Then
            Lights(idx) = Array(Lights(idx),obj)
		Else
			Set Lights(idx) = obj
		End If
	Next
End Sub

Function vpmMoveBall(aBall, aFromKick, aToKick)
	With aToKick.CreateBall
		If TypeName(aBall) = "IBall" Then
			.Color = aBall.Color   : .Image = aBall.Image
			If vpmVPVer >= 60 Then
				.FrontDecal = aBall.FrontDecal : .BackDecal = aBall.BackDecal
'				.UserValue = aBall.UserValue
			End If
		End If
	End With
	aFromKick.DestroyBall : Set vpmMoveBall = aToKick
End Function

Sub vpmAddBall
Dim Answer
	If IsObject(vpmTrough) Then
			Answer=MsgBox("Click YES to Add A ball to the Trough, No Removes a ball from the Trough",vbYesNoCancel + vbQuestion)
		If Answer = vbYes Then vpmTrough.AddBall 0
		If Answer = vbNo Then vpmTrough.Balls=vpmTrough.Balls-1
	End If
End Sub

'----------------------------
' Generic solenoid handlers
'----------------------------
' ----- Flippers ------
Sub vpmSolFlipper(aFlip1, aFlip2, aEnabled)
	Dim oldStrength, oldSpeed
	If aEnabled Then
		PlaySound SFlipperOn : aFlip1.RotateToEnd : If Not aFlip2 Is Nothing Then aFlip2.RotateToEnd
	Else
		PlaySound SFlipperOff
		oldStrength = aFlip1.Strength : aFlip1.Strength = conFlipRetStrength
                If VPBuildVersion < 10000 Then
                        oldSpeed = aFlip1.Speed : aFlip1.Speed = conFlipRetSpeed
                End If
		aFlip1.RotateToStart : aFlip1.Strength = oldStrength
                If VPBuildVersion < 10000 Then
                        aFlip1.Speed = oldSpeed
                End If
		If Not aFlip2 Is Nothing Then
			oldStrength = aFlip2.Strength : aFlip2.Strength = conFlipRetStrength
                        If VPBuildVersion < 10000 Then
                                oldSpeed = aFlip2.Speed : aFlip2.Speed = conFlipRetSpeed
                        End If
			aFlip2.RotateToStart : aFlip2.Strength = oldStrength
                        If VPBuildVersion < 10000 Then
                                aFlip2.Speed = oldSpeed
                        End If
		End If
	End If
End Sub

' ----- Flippers With Speed Control ------
Sub vpmSolFlip2(aFlip1, aFlip2, aFlipSpeedUp, aFlipSpeedDn, aSnd, aEnabled) ' DEPRECATED, as VP10 does not feature speed on flippers anymore
	Dim oldStrength, oldSpeed
	If aEnabled Then
		If aSnd = true then : PlaySound SFlipperOn : End If
		If Not aFlipSpeedUp = 0 Then
			aFlip1.Speed = aFlipSpeedUp
			aFlip1.RotateToEnd
		Else
			aFlip1.RotateToEnd
		End If
		If Not aFlip2 Is Nothing Then 
			If Not aFlipSpeedUp = 0 Then
				aFlip2.Speed = aFlipSpeedUp
				aFlip2.RotateToEnd
			Else
				aFlip2.RotateToEnd
			End If
		End If
	Else
		If aSnd = true then : PlaySound SFlipperOff : End If
		oldStrength = aFlip1.Strength
		aFlip1.Strength = conFlipRetStrength
		oldSpeed = aFlip1.Speed
		If Not aFlipSpeedDn = 0 Then
			aFlip1.Speed = aFlipSpeedDn 
		Else 
			aFlip1.Speed = conFlipRetSpeed
		End If
		aFlip1.RotateToStart : aFlip1.Strength = oldStrength : aFlip1.Speed = oldSpeed
		If Not aFlip2 Is Nothing Then
			oldStrength = aFlip2.Strength
			oldSpeed = aFlip2.Speed 
			If Not aFlipSpeedDn = 0 Then
				aFlip2.Speed = aFlipSpeedDn 
			Else 
				aFlip2.Speed = conFlipRetSpeed
			End If
			aFlip2.Strength = conFlipRetStrength
			aFlip2.RotateToStart : aFlip2.Strength = oldStrength : aFlip2.Speed = oldSpeed
		End If
	End If
End Sub

' ------ Diverters ------
Sub vpmSolDiverter(aDiv, aSound, aEnabled)
	If aEnabled Then aDiv.RotateToEnd : Else aDiv.RotateToStart
	vpmPlaySound aEnabled, aSound
End sub

' ------ Walls ------
Sub vpmSolWall(aWall, aSound, aEnabled)
	Dim obj
	If vpmIsArray(aWall) Then
		For Each obj In aWall : obj.IsDropped = aEnabled : Next
	Else
		aWall.IsDropped = aEnabled
	End If
	vpmPlaySound aEnabled, aSound
End Sub

Sub vpmSolToggleWall(aWall1, aWall2, aSound, aEnabled)
	Dim obj
	If vpmIsArray(aWall1) Then
		For Each obj In aWall1 : obj.IsDropped = aEnabled : Next
	Else
		aWall1.IsDropped = aEnabled
	End If
	If vpmIsArray(aWall2) Then
		For Each obj In aWall2 : obj.IsDropped = Not aEnabled : Next
	Else
		aWall2.IsDropped = Not aEnabled
	End If
	vpmPlaySound aEnabled, aSound
End Sub

' ------- Autoplunger ------
Sub vpmSolAutoPlunger(aPlung, aVar, aEnabled)
	Dim oldFire
	If aEnabled Then
		oldFire = aPlung.FireSpeed : aPlung.FireSpeed = oldFire * (100-aVar*(2*Rnd-1))/100
		PlaySound SSolenoidOn : aPlung.Fire : aPlung.FireSpeed = oldFire
	Else
		aPlung.Pullback
	End If
End Sub

' --------Autoplunger with Specified Sound To Play ---------
Sub vpmSolAutoPlungeS(aPlung, aSound, aVar, aEnabled)
	Dim oldFire
	If aEnabled Then
		oldFire = aPlung.FireSpeed : aPlung.FireSpeed = oldFire * (100-aVar*(2*Rnd-1))/100
		PlaySound aSound : aPlung.Fire : aPlung.FireSpeed = oldFire
	Else
		aPlung.Pullback
	End If
End Sub

' --------- Gate -----------
Sub vpmSolGate(aGate, aSound, aEnabled)
	Dim obj
	If vpmIsArray(aGate) Then
		For Each obj In aGate : obj.Open = aEnabled : Next
	Else
		aGate.Open = aEnabled
	End If
	vpmPlaySound aEnabled, aSound
End Sub

' ------ Sound Only -------
Sub vpmSolSound(aSound, aEnabled)
	If aEnabled Then StopSound aSound : PlaySound aSound
End Sub

' ------- Flashers --------
Sub vpmFlasher(aFlash, aEnabled)
	Dim obj
	If vpmIsArray(aFlash) Then
		For Each obj In aFlash : obj.State = Abs(aEnabled) : Next
	Else
		aFlash.State = Abs(aEnabled)
	End If
End Sub

'---- Generic object toggle ----
Sub vpmSolToggleObj(aObj1, aObj2, aSound, aEnabled)
	Dim obj
	If vpmIsArray(aObj1) Then
		If IsArray(aObj1(0)) Then
			For Each obj In aObj1(0) : vpmToggleObj obj, aEnabled     : Next
			For Each obj In aObj1(1) : vpmToggleObj obj, Not aEnabled : Next
		Else
			For Each obj In aObj1    : vpmToggleObj obj, aEnabled     : Next
		End If
	ElseIf Not aObj1 Is Nothing Then
		vpmToggleObj aObj1, aEnabled
	End If
	If vpmIsArray(aObj2) Then
		If IsArray(aObj2(0)) Then
			For Each obj In aObj2(0) : vpmToggleObj obj, Not aEnabled : Next
			For Each obj In aObj2(1) : vpmToggleObj obj, aEnabled     : Next
		Else
			For Each obj In aObj2    : vpmToggleObj obj, Not aEnabled : Next
		End If
	ElseIf Not aObj2 Is Nothing Then
		vpmToggleObj aObj2, Not aEnabled
	End If
	vpmPlaySound aEnabled, aSound
End Sub

'
' Stubs to allow older games to still work
' These will be removed one day
'
Sub SolFlipper(f1,f2,e) : vpmSolFlipper f1,f2,e : End Sub
Sub SolDiverter(d,s,e) : vpmSolDiverter d,s,e : End Sub
Sub SolSound(s,e) : vpmSolSound s,e : End Sub
Sub Flasher(f,e) : vpmFlasher f,e : End Sub
Sub SolMagnet(m,e) : vpmSolMagnet m,e : End Sub
Sub SolAutoPlunger(p,e) : vpmSolAutoPlunger p,0,e : End Sub
Function KeyDownHandler(ByVal k) : KeyDownHandler = vpmKeyDown(k) : End Function
Function KeyUpHandler(ByVal k) : KeyUpHandler = vpmKeyUp(k) : End Function
Function KeyName(ByVal k) : KeyName = vpmKeyName(k) : End Function
Sub vpmSolMagnet(m,e) : m.Enabled = e : If Not e Then m.Kick 180,1 : End If : End Sub
Dim vpmBallImage : vpmBallImage = Empty ' Default ball properties
Dim vpmBallColour

'-- Flipper solenoids (all games)
Const sLRFlipper = 46
Const sLLFlipper = 48
Const sURFlipper = 34
Const sULFlipper = 36

' Convert keycode to readable string
Private keyNames1, keyNames2
keyNames1 = Array("Escape","1","2","3","4","5","6","7","8","9","0","Minus '-'",_
"Equals '='","Backspace","Tab","Q","W","E","R","T","Y","U","I","O","P","[","]",_
"Enter","Left Ctrl","A","S","D","F","G","H","J","K","L",";","'","`","Left Shift",_
"\","Z","X","C","V","B","N","M",",",".","/","Right Shift","*","Left Menu","Space",_
"Caps Lock","F1","F2","F3","F4","F5","F6","F7","F8","F9","F10","NumLock","ScrlLock",_
"Numpad 7","Numpad 8","Numpad 9","Numpad -","Numpad 4","Numpad 5","Numpad 6",_
"Numpad +","Numpad 1","Numpad 2","Numpad 3","Numpad 0","Numpad .","?","?","?",_
"F11","F12","F13","F14","F15")
keyNames2 = Array("Pause","?","Home","Up","PageUp","?","Left","?","Right","?",_
"End","Down","PageDown","Insert","Delete")

Function vpmKeyName(ByVal aKeycode)
	If aKeyCode-1 <= UBound(keyNames1) Then
		vpmKeyName = keyNames1(aKeyCode-1)
	ElseIf aKeyCode >= 197 And aKeyCode <= 211 Then
		vpmKeyName = keyNames2(aKeyCode-197)
	ElseIf aKeyCode = 184 Then
		vpmKeyName = "R.Alt"
	Else
		vpmKeyName = "?"
	End If
End Function

Private vpmSystemHelp
Private Sub vpmShowHelp
	Dim szKeyMsg
	szKeyMsg = "The following keys are defined: "                  & vbNewLine &_
	           "(American keyboard layout)"                        & vbNewLine &_
		vbNewLine & "Visual PinMAME keys:"                         & vbNewLine &_
		vpmKeyName(keyShowOpts)   & vbTab & "Game options..."      & vbNewLine &_
		vpmKeyName(keyShowKeys)   & vbTab & "Keyboard settings..." & vbNewLine &_
		vpmKeyName(keyReset)      & vbTab & "Reset emulation"      & vbNewLine &_
		vpmKeyName(keyFrame)      & vbTab & "Toggle Display lock"  & vbNewLine &_
		vpmKeyName(keyDoubleSize) & vbTab & "Toggle Display size"  & vbNewLine
	If IsObject(vpmShowDips) Then
			szKeyMsg = szKeyMsg & vpmKeyName(keyShowDips)   & vbTab & "Show DIP Switch / Option Menu" & vbNewLine
		End If
	If IsObject(vpmTrough) Then
		szKeyMsg = szKeyMsg & vpmKeyName(keyAddBall) & vbTab & "Add / Remove Ball From Table" & vbNewLine
	End If
	szKeyMsg = szKeyMsg & vpmKeyName(keyBangBack) & vbTab & "Bang Back" & vbNewLine &_
		vbNewLine & vpmSystemHelp & vbNewLine
	If ExtraKeyHelp <> "" Then
		szKeyMsg = szKeyMsg & vbNewLine & "Game Specific keys:" &_
			vbNewLine & ExtraKeyHelp & vbNewLine
	End If
	szKeyMsg = szKeyMsg & vbNewLine & "Visual Pinball keys:"     & vbNewLine &_
		vpmKeyName(LeftFlipperKey)  & vbTab & "Left Flipper"     & vbNewLine &_
		vpmKeyName(RightFlipperKey) & vbTab & "Right Flipper"    & vbNewLine &_
		vpmKeyName(PlungerKey)      & vbTab & "Launch Ball"      & vbNewLine &_
		vpmKeyName(StartGameKey)    & vbTab & "Start Button"     & vbNewLine &_
		vpmKeyName(LeftTiltKey)     & vbTab & "Nudge from Left"  & vbNewLine &_
		vpmKeyName(RightTiltKey)    & vbTab & "Nudge from Right" & vbNewLine &_
		vpmKeyName(CenterTiltKey)   & vbTab & "Nudge forward"    & vbNewLine
	MsgBox szKeyMsg,vbOkOnly,"Keyboard Settings..."
End Sub

Private Sub NullSub(no,enabled) 
'Place Holder Sub
End Sub


