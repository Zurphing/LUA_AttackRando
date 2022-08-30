LUAGUI_NAME = "Attack Rando"
LUAGUI_AUTH = "Zurph"
LUAGUI_DESC = "Randomizes Sora & his drive forms attack animations among themselves. Rerandomizes every room transition."

function _OnInit()
	if GAME_ID == 0x431219CC and ENGINE_TYPE == "BACKEND" then
		ConsolePrint("Attack Rando Installation: Success!")
	else
		ConsolePrint("Attack Rando Installation: Failed.")
	end
end


--List of Base Sora Animations: (These are all multiplied by 4)
--Aerial Sweep: 191			Aerial Dive: 196		Aerial Attack 2: 182		Aerial Attack 1: 181
--Explosion: 166			Finisher AoE: 154		Guard Break: 165			Finisher Single: 155
--Vicinity Break: 170		Flash Step: 169			Aerial Finish: 194			Aerial Spiral: 192
--Attack 1 AoE:	152			Attack 2: 153			Attack 1: 151				Counterguard: 171
--Dodge Slash: 163			Finishing Leap: 167		Guard: 173					Horizontal Slash: 193
--Magnet Burst: 197			Retaliating Slash: 172	Slapshot: 162				Sliding Dash: 164
--Upper Slash: 161			Air Finish Single: 183	Air Finish AoE: 184


--AERIALS:
--0xBF, 0xC4, 0xB5, 0xB6, 0xA7 (Aerial Sweep/AirDive/AirAtk1/AirAtk2/Finishing Leap)
--0xC0, 0xC5, 0xAC, 0xC2, 0xC1 (Aerial Spiral/Magnet Burst/Retaliating Slash/Aerial Finish/Horizontal Slash)
--0xB6 & 0xB7: (Aerial Finish Single & AoE)
--So ALL AERIALS: 0xA7, 0xAC, 0xB5, 0xB6, 0xB7, 0xBF, 0xC0, 0xC1, 0xC2, 0xC4, 0xC5

--GROUND ATTACKS:
--0xA6, 0x9A, 0xA5, 0x9B, 0xAA, 0xA9	(Explosion/FinAoE/GuardBreak/FinSing/VicinBreak/FlashStep)
--0x97, 0x98, 0x99, 0xAB, 0xA3, 0xAD 	(ATK 1/ATK1-AOE/ATK2/CounterGuard/DodgeSlash/Guard)
--0xA2, 0xA4, 0xA1						(Slapshot/Sliding Dash/Upper Slash)

--ALL GROUND MOVES: 0xA6, 0x9A, 0xA5, 0x9B, 0xAA, 0xA9, 0x97, 0x98, 0x99, 0xAB, 0xA3, 0xAD, 0xA2, 0xA4, 0xA1

--Valor Animations: Has 15 entries, 9 animations
--ATK1: 151		ATK1 AOE: 152	ATK2: 153	FINISHER_AOE: 154	FINISHER_SINGLE: 155
--AIR1: 181		AIR2: 182		AIR_FIN_S: 183	AIR_FIN_AOE: 184

--Wisdom Animations: 5 entries, 3 animations
--ATK1: 151		FIN_AOE: 154	AERIAL ATTACK 1: 181

--Limit Animations: 21 entries, 17 animations
--ATK1: 151		AOE_1: 152		ATK2: 153	FIN_AOE: 154	FIN_SING: 155
--SLAP: 162		SLIDE: 164		GUARD: 173	AIR1: 181		AIR2: 182
--AIRFIN1: 183	AIRSWEEP: 191	RAG1: 242	RAG2: 243		RAG3: 244
--RAG4: 245		RAG5: 246		

--Master Animations: 16 entries, 5 animations
--AIR1: 181		AIR2: 182		AIR3: 183		AIR4: 184		AIR5: 185

--Final Animations: 12 entries, 7 animations
--ATK 1: 151	ATK1_AOE: 152	ATK2: 153	FIN_AOE: 154	AIR_1: 181		AIR2: 182	AIR_FIN: 183

--Anti Animations: 13 entries, 11 animations
--ATK1: 151		ATK1_AOE: 152	ATK2: 153	FIN_AOE: 154	FIN_SING: 155	UPPERSLASH: 161
--GUARD: 173	AIR1: 181		AIR2: 182	AIR_FIN_S: 183	AIR_FIN_A: 184

--Quick recap: For loop (for i = 0, x, 1), x should equal number of entries.
--Then, math.random(y) should be number of animations, aka, length of the table.
function _OnFrame()
RoomTrans = 0x9B80D0-0x56454E
Btl = 0x2A74840 - 0x56450E
PTYAStart = Btl+0x1FF20 --Start of PTYA File
local BaseSoraFirstAnim = PTYAStart+0x12C
local ValorSoraFirstAnim = Btl+0x20A24
local WisdomSoraFirstAnim = Btl+0x20E24
local LimitSoraFirstAnim = Btl+0x234D8
local MasterSoraFirstAnim = Btl+0x20F7C
local FinalSoraFirstAnim = Btl+0x213C0
local AntiSoraFirstAnim = Btl+0x216F4
BASE_RANDOM_ANIM_GROUND = {0xA6, 0x9A, 0xA5, 0x9B, 0xAA, 0xA9, 0x97, 0x98, 0x99, 0xAB, 0xA3, 0xAD, 0xA2, 0xA4, 0xA1}
BASE_RANDOM_ANIM_AIR = {0xA7, 0xAC, 0xB5, 0xB6, 0xB7, 0xBF, 0xC0, 0xC1, 0xC2, 0xC4, 0xC5}
BASE_RANDOM_ANIM_ALL = {0xA7, 0xAC, 0xB5, 0xB6, 0xB7, 0xBF, 0xC0, 0xC1, 0xC2, 0xC4, 0xC5, 0xA6, 0x9A, 0xA5, 0x9B, 0xAA, 0xA9, 0x97, 0x98, 0x99, 0xAB, 0xA3, 0xAD, 0xA2, 0xA4, 0xA1}
VALOR_RANDOM_ANIM_ALL = {0x97, 0x98, 0x99, 0x9A, 0x9B, 0xB5, 0xB6, 0xB7, 0xB8}
WISDOM_RANDOM_ANIM_ALL = {0x97, 0x9A, 0xB5}
--LIMIT_RANDOM_ANIM_ALL =  {0x97, 0x98, 0x99, 0x9A, 0x9B, 0xA2, 0xA4, 0xAD, 0xB5, 0xB6, 0xB7, 0xBF, 0xF2, 0xF3, 0xF4, 0xF5, 0xF6}
LIMIT_RANDOM_ANIM_ALL =  {0x97, 0x98, 0x99, 0x9A, 0x9B, 0xA2, 0xA4, 0xAD, 0xB5, 0xB6, 0xB7, 0xBF} --Removes ragnarok animations from randomizer. May be able to restore some.
MASTER_RANDOM_ANIM_ALL = {0xB5, 0xB6, 0xB7, 0xB8, 0xB9}
FINAL_RANDOM_ANIM_ALL = {0x97, 0x98, 0x99, 0x9A, 0xB5, 0xB6, 0xB7}
ANTI_RANDOM_ANIM_ALL = {0x97, 0x98, 0x99, 0x9A, 0xAD, 0x9B, 0xB5, 0xB6, 0xB7, 0xB8}


if ReadByte(BaseSoraFirstAnim) == 0xBF or ReadByte(RoomTrans) == 0 then
	for i = 0, 37, 1 do
		BASE_RAN = BASE_RANDOM_ANIM_ALL[math.random(27)]
		WriteByte(BaseSoraFirstAnim, BASE_RAN)
		ConsolePrint(ReadByte(BaseSoraFirstAnim))
			BaseSoraFirstAnim = BaseSoraFirstAnim+0x44
	end
	for i = 0, 15, 1 do
		VAL_RAN = VALOR_RANDOM_ANIM_ALL[math.random(9)]
		WriteByte(ValorSoraFirstAnim, VAL_RAN)
			ValorSoraFirstAnim = ValorSoraFirstAnim+0x44
	end
	for i = 0, 5, 1 do
		WIS_RAN = WISDOM_RANDOM_ANIM_ALL[math.random(3)]
		WriteByte(WisdomSoraFirstAnim, WIS_RAN)
			WisdomSoraFirstAnim = WisdomSoraFirstAnim+0x44
	end
	for i = 0, 16, 1 do
		LIM_RAN = LIMIT_RANDOM_ANIM_ALL[math.random(12)]
		WriteByte(LimitSoraFirstAnim, LIM_RAN)
			LimitSoraFirstAnim = LimitSoraFirstAnim+0x44
	end
	for i = 0, 16, 1 do
		MAS_RAN = MASTER_RANDOM_ANIM_ALL[math.random(5)]
		WriteByte(MasterSoraFirstAnim, MAS_RAN)
			MasterSoraFirstAnim = MasterSoraFirstAnim+0x44
	end
	for i = 0, 12, 1 do
		FIN_RAN = FINAL_RANDOM_ANIM_ALL[math.random(7)]
		WriteByte(FinalSoraFirstAnim, FIN_RAN)
			FinalSoraFirstAnim = FinalSoraFirstAnim+0x44
	end
	for i = 0, 13, 1 do
		ANT_RAN = ANTI_RANDOM_ANIM_ALL[math.random(11)]
		WriteByte(AntiSoraFirstAnim, ANT_RAN)
			AntiSoraFirstAnim = AntiSoraFirstAnim+0x44
	end
end
end
