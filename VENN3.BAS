REM The following code produces a program which allows one to draw
REM VENN diagrams.  The program title is stored in the following
REM line.  This program is copyright (c) by Jim Gerrie 1995
RANDOMIZE TIMER

title$ = "VENN DRAW 2.1"
CompileDate$ = "December 2000"

DIM MajPrem$(256)
DIM MinPrem$(256)
DIM Conc(256)
DIM Fall$(256)
DIM Form$(256)
DIM Valflag(256)
DIM Premise(2)
i$ = ""
score% = 0
outof% = 0
auto% = 0
xflag% = 0
a% = 0
b% = 0
c% = 0
p% = 0
t% = 0

SCREEN 8
COLOR 1, 7

GOSUB LoadData
GOSUB DrawScreen
GOSUB Menu
GOSUB Selection
CLS
PRINT "      Thanks for using " + title$; ""
PRINT "    Copyright (c) 1999 by James Gerrie"
PRINT "              6 Tasker St."
PRINT "           St. Catharines, ON"
PRINT "            L2R 3Z8   Canada"
PRINT "jgerrie@becon.org   OR jgerrie@uoguelph.ca"
PRINT
PRINT "Press any key to continue."
WHILE INKEY$ = ""
WEND
END

DrawScreen:
CLS
GOSUB DrawS
GOSUB DrawM
GOSUB DrawP
LINE (0, 0)-(639, 90), 1, B
LINE (0, 0)-(495, 90), 1, B
LOCATE 3, 65, 0
PRINT title$;
LOCATE 5, 65, 0
PRINT "Copyright  c";
LOCATE 7, 65, 0
PRINT CompileDate$;
LOCATE 9, 65, 0
PRINT "      By";
LOCATE 10, 65, 0
PRINT "James B. Gerrie";
CIRCLE (602, 36), 9, 1
GOSUB Menu
p% = 0
c% = 0
xflag% = 0
Premise(1) = 0
Premise(2) = 0
RETURN

DrawS:
CIRCLE (200, 30), 50, 1
LOCATE 3, 18, 0
PRINT "S";
RETURN

DrawP:
CIRCLE (260, 30), 50, 1
LOCATE 3, 40, 0
PRINT "P";
RETURN

DrawM:
CIRCLE (230, 50), 50, 1
LOCATE 11, 29, 0
PRINT "M";
RETURN

Selection:
i$ = ""
DO UNTIL i$ = "q" OR i$ = "Q"
  i$ = INKEY$
  GOSUB Generate
LOOP
RETURN

Generate:
SELECT CASE i$
  CASE "A", "a"
    IF p% = 0 OR p% = 2 THEN
      GOSUB MaP
      xflag% = 1
      p1$ = " All M are P"
      p% = 1
      GOSUB Prevent
    END IF
  CASE "B", "b"
    IF p% = 0 OR p% = 2 THEN
      GOSUB PaM
      xflag% = 1
      p1$ = " All P are M"
      p% = 1
      GOSUB Prevent
    END IF
  CASE "C", "c"
    IF p% = 0 OR p% = 2 OR p% = 4 THEN
      GOSUB MiPPiM
      p1$ = "Some M are P"
      p% = 3
      GOSUB Prevent
    END IF
  CASE "D", "d"
    IF p% = 0 OR p% = 2 OR p% = 4 THEN
      GOSUB MiPPiM
      p1$ = "Some P are M"
      p% = 3
      GOSUB Prevent
    END IF
  CASE "E", "e"
    IF p% = 0 OR p% = 2 THEN
      GOSUB MeP
      xflag% = 2
      p1$ = "  No M are P"
      p% = 1
      GOSUB Prevent
    END IF
  CASE "F", "f"
    IF p% = 0 OR p% = 2 THEN
      GOSUB PeM
      xflag% = 2
      p1$ = "  No P are M"
      p% = 1
      GOSUB Prevent
    END IF
  CASE "G", "g"
    IF p% = 0 OR p% = 2 OR p% = 4 THEN
      GOSUB MoP
      p1$ = "Some M are not P"
      p% = 3
      GOSUB Prevent
    END IF
  CASE "H", "h"
    IF p% = 0 OR p% = 2 OR p% = 4 THEN
      GOSUB PoM
      p1$ = "Some P are not M"
      p% = 3
      GOSUB Prevent
    END IF
  CASE "I", "i"
    IF p% = 0 OR p% = 1 THEN
      GOSUB MaS
      xflag% = 3
      p2$ = " All M are S"
      p% = 2
      GOSUB Prevent
    END IF
  CASE "J", "j"
    IF p% = 0 OR p% = 1 THEN
      GOSUB SaM
      xflag% = 3
      p2$ = " All S are M"
      p% = 2
      GOSUB Prevent
    END IF
  CASE "K", "k"
    IF p% = 0 OR p% = 1 OR p% = 3 THEN
      GOSUB MiSSiM
      p2$ = "Some M are S"
      p% = 4
      GOSUB Prevent
    END IF
  CASE "L", "l"
    IF p% = 0 OR p% = 1 OR p% = 3 THEN
      GOSUB MiSSiM
      p2$ = "Some S are M"
      p% = 4
      GOSUB Prevent
    END IF
  CASE "M", "m"
    IF p% = 0 OR p% = 1 THEN
      GOSUB MeS
      xflag% = 4
      p2$ = "  No M are S"
      p% = 2
      GOSUB Prevent
    END IF
  CASE "N", "n"
    IF p% = 0 OR p% = 1 THEN
      GOSUB SeM
      xflag% = 4
      p2$ = "  No S are M"
      p% = 2
      GOSUB Prevent
    END IF
  CASE "O", "o"
    IF p% = 0 OR p% = 1 OR p% = 3 THEN
      GOSUB MoS
      p2$ = "Some M are not S"
      p% = 4
      GOSUB Prevent
    END IF
  CASE "P", "p"
    IF p% = 0 OR p% = 1 OR p% = 3 THEN
      GOSUB SoM
      p2$ = "Some S are not M"
      p% = 4
      GOSUB Prevent
    END IF
  CASE "R", "r"
     IF auto% <> 1 THEN
        GOSUB Review
     END IF
  CASE "S", "s"
    score% = 0
    outof% = 0
    auto% = 0
    GOSUB DrawScreen
   CASE "T", "t"
      GOSUB DrawScreen
      GOSUB DoTest
END SELECT
IF c% = 2 THEN
FOR t% = 1 TO 2
   SELECT CASE Premise(t%)
      CASE 1
        GOSUB MiPPiM
      CASE 2
        GOSUB MoP
        GOSUB PoM
      CASE 3
        GOSUB MiSSiM
      CASE 4
        GOSUB MoS
        GOSUB SoM
   END SELECT
NEXT t%
END IF
RETURN

Prevent:
c% = c% + 1
Premise(c%) = xflag%
IF c% = 2 THEN p% = 5
SELECT CASE p%
CASE 1
  LOCATE 13, 1, 0
  PRINT "------------------------------------------------------------> "; p1$
  GOSUB Clr
CASE 2
  LOCATE 14, 1, 0
  PRINT "------------------------------------------------------------> "; p2$
  GOSUB Clr
CASE 3
  LOCATE 13, 1, 0
  PRINT "------------------------------------------------------------> "; p1$
  PRINT "-------------   K=MiS   L=SiM   -------------   O=MoS   P=SoM"
  GOSUB Clr
CASE 4
  LOCATE 13, 1, 0
  PRINT "-------------   C=MiP   D=PiM   -------------   G=MoP   H=PoM"
  PRINT "------------------------------------------------------------> "; p2$
  GOSUB Clr
CASE 5
  LOCATE 13, 1, 0
  PRINT "------------------------------------------------------------> "; p1$
  PRINT "------------------------------------------------------------> "; p2$
  IF auto% <> 1 THEN
     LOCATE 18, 1
     PRINT "              T=Test Your Venn Diagramming Skills                  "
  END IF
END SELECT
RETURN

Menu:
LOCATE 13, 1, 0
PRINT "A=MaP   B=PaM   C=MiP   D=PiM   E=MeP   F=PeM   G=MoP   H=PoM"
PRINT "I=MaS   J=SaM   K=MiS   L=SiM   M=MeS   N=SeM   O=MoS   P=SoM"
PRINT
IF auto% <> 1 THEN
PRINT "S=Start Over        R=Review All Venn Diagrams         Q=Quit"
PRINT
PRINT "               T=Test Your Venn Diagramming Skills"
PRINT
PRINT "To diagram the premises of a syllogism select from letters A through P."
PRINT "NOTE: If there are one universal and one particular premise in the"
PRINT "      syllogism then select the universal premise first."
END IF
RETURN

Clr:
LOCATE 18, 1, 0
IF auto% <> 1 THEN
   PRINT "Press a letter from those remaining to diagram the second premise. "
ELSE
   PRINT STRING$(78, 32)
END IF
PRINT STRING$(78, 32)
PRINT STRING$(78, 32)
PRINT STRING$(78, 32)
PRINT STRING$(78, 32)
RETURN

Review:
GOSUB DrawScreen
outof% = 0
auto% = 1
FOR a% = 1 TO 16
   SELECT CASE a%
   CASE 1, 2, 5, 6
      FOR b% = 9 TO 16
         GOSUB AutoGyro
         IF auto% = 2 THEN
            EXIT FOR
         END IF
      NEXT b%
      IF auto% = 2 THEN
         EXIT FOR
      END IF
   CASE 3, 4, 7, 8
      FOR b% = 11 TO 16
         SELECT CASE b%
         CASE 11, 12, 15, 16
            GOSUB AutoGyro
            IF auto% = 2 THEN
                EXIT FOR
            END IF
         END SELECT
      NEXT b%
   CASE 9, 10, 13, 14
      FOR b% = 1 TO 8
         SELECT CASE b%
         CASE 3, 4, 7, 8
            GOSUB AutoGyro
            IF auto% = 2 THEN
                EXIT FOR
            END IF
         END SELECT
      NEXT b%
   END SELECT
   IF auto% = 2 THEN
      EXIT FOR
   END IF
NEXT a%
auto% = 0
outof% = 0
GOSUB DrawScreen
RETURN

AutoGyro:
i$ = CHR$(a% + 64)
GOSUB Generate
i$ = CHR$(b% + 64)
GOSUB Generate
outof% = outof% + 1
LOCATE 2, 2, 0
PRINT outof%
IF c% = 2 THEN
   LOCATE 16, 1, 0
   PRINT "S=Start Over         SPACE=View Next Diagram           Q=Quit"
   PRINT STRING$(78, 32)
   PRINT STRING$(78, 32)
   DO
      i$ = INKEY$
   LOOP UNTIL i$ = " " OR i$ = "S" OR i$ = "s" OR i$ = "Q" OR i$ = "q"
   IF i$ <> " " THEN
      auto% = 2
   END IF
   GOSUB DrawScreen
END IF
RETURN

MaP:
PAINT (230, 50), 1, 1
PAINT (220, 45), 1, 1
RETURN

PaM:
PAINT (260, 30), 1, 1
PAINT (245, 25), 1, 1
RETURN

SaM:
PAINT (200, 30), 1, 1
PAINT (245, 25), 1, 1
RETURN

MaS:
PAINT (230, 50), 1, 1
PAINT (240, 45), 1, 1
RETURN

MiPPiM:
IF POINT(230, 46) = 0 AND POINT(240, 46) = 0 THEN
  PSET (242, 38), 1
  GOSUB MakeX
ELSEIF POINT(230, 46) = 1 THEN
  LOCATE 6, 33, 0
  PRINT "x";
ELSE
  LOCATE 5, 29, 0
  PRINT "x";
END IF
RETURN

MiSSiM:
IF POINT(230, 46) = 0 AND POINT(220, 46) = 0 THEN
  PSET (214, 38), 0
  GOSUB MakeX
ELSEIF POINT(230, 46) = 1 THEN
  LOCATE 6, 26, 0
  PRINT "x";
ELSE
  LOCATE 5, 29, 0
  PRINT "x";
END IF
RETURN

MeP:
PAINT (240, 45), 1, 1
PAINT (230, 45), 1, 1
RETURN

PeM:
PAINT (240, 45), 1, 1
PAINT (230, 45), 1, 1
RETURN

MeS:
PAINT (220, 45), 1, 1
PAINT (230, 45), 1, 1
RETURN

SeM:
PAINT (220, 45), 1, 1
PAINT (230, 45), 1, 1
RETURN

MoP:
IF POINT(220, 46) = 0 AND POINT(230, 50) = 0 THEN
  LOCATE 7, 26, 0
ELSEIF POINT(220, 46) = 1 THEN
  LOCATE 8, 30, 0
ELSE
  LOCATE 6, 26, 0
END IF
PRINT "x";
RETURN

PoM:
IF POINT(245, 25) = 0 AND POINT(260, 30) = 0 THEN
  LOCATE 3, 31
ELSEIF POINT(245, 25) = 1 THEN
  LOCATE 4, 35, 0
END IF
PRINT "x";
RETURN

MoS:
IF POINT(230, 50) = 0 AND POINT(240, 46) = 0 THEN
  LOCATE 7, 33, 0
ELSEIF POINT(240, 46) = 1 THEN
  LOCATE 8, 30, 0
ELSE
  LOCATE 6, 33, 0
END IF
PRINT "x";
RETURN

SoM:
IF POINT(200, 30) = 0 AND POINT(245, 25) = 0 THEN
  PSET (214, 18)
  GOSUB MakeX
  LOCATE 3, 27, 0
ELSEIF POINT(245, 25) = 1 THEN
  LOCATE 4, 23, 0
  PRINT "x";
END IF
RETURN

DoTest:
auto% = 1
IF INT(RND * 10) + 1 > 4 THEN
  Arg% = INT(RND * 256) + 1
ELSE
   SELECT CASE INT(RND * 24) + 1
   CASE 1
      Arg% = 1
   CASE 2
      Arg% = 9
   CASE 3
      Arg% = 11
   CASE 4
      Arg% = 12
   CASE 5
      Arg% = 22
   CASE 6
      Arg% = 24
   CASE 7
      Arg% = 30
   CASE 8
      Arg% = 32
   CASE 9
      Arg% = 41
   CASE 10
      Arg% = 43
   CASE 11
      Arg% = 62
   CASE 12
      Arg% = 69
   CASE 13
      Arg% = 70
   CASE 14
      Arg% = 77
   CASE 15
      Arg% = 78
   CASE 16
      Arg% = 79
   CASE 17
      Arg% = 80
   CASE 18
      Arg% = 109
   CASE 19
      Arg% = 110
   CASE 20
      Arg% = 111
   CASE 21
      Arg% = 112
   CASE 22
      Arg% = 139
   CASE 23
      Arg% = 140
   CASE 24
      Arg% = 207
   END SELECT
END IF
SELECT CASE MajPrem$(Arg%)
CASE "c", "d", "k", "l", "g", "h", "o", "p"
   i$ = MinPrem$(Arg%)
   GOSUB Generate
   i$ = MajPrem$(Arg%)
   GOSUB Generate
CASE ELSE
   i$ = MajPrem$(Arg%)
   GOSUB Generate
   i$ = MinPrem$(Arg%)
   GOSUB Generate
END SELECT
LOCATE 15, 52, 0
PRINT "Therefore: ";
GOSUB PrintConc
PRINT STRING$(78, 32)
PRINT STRING$(78, 32)
PRINT "Is the above argument valid or invalid?  Press V or I ------> ";
i$ = ""
DO
i$ = INKEY$
LOOP UNTIL i$ = "v" OR i$ = "V" OR i$ = "i" OR i$ = "I"
outof% = outof% + 1
IF i$ = "v" OR i$ = "V" THEN
   PRINT "V"
   IF Valflag(Arg%) = 0 THEN
     PRINT "Wrong.  This "; Form$(Arg%); " argument form is INVALID."
     PRINT "It contains the following fallacies: "; Fall$(Arg%)
   ELSE
     PRINT "Correct!  This "; Form$(Arg%); " argument form is VALID."
     score% = score% + 1
   END IF
ELSE
   PRINT "I"
   IF Valflag(Arg%) = 0 THEN
     PRINT "Correct!  This "; Form$(Arg%); " argument form is INVALID."
     PRINT "It contains the following fallacies: "; Fall$(Arg%)
     score% = score% + 1
   ELSE
     PRINT "Wrong.  This "; Form$(Arg%); " argument form is VALID."
   END IF
END IF
PRINT STRING$(78, 32)
PRINT "Score ="; score%; "correct out of"; outof%;
IF outof% = 1 THEN
   PRINT "try.  ";
ELSE
  PRINT "tries.  ";
END IF
PRINT "That is a success rate of ";
PRINT USING "###"; (score% * 100) / outof%;
PRINT "%"
LOCATE 25, 1, 0
PRINT "Press S to start over, T for another test or Q to quit.";
RETURN

PrintConc:
SELECT CASE Conc(Arg%)
CASE 1
   PRINT " All S are P"
CASE 2
   PRINT "  No S are P"
CASE 3
   PRINT "Some S are P"
CASE 4
   PRINT "Some S are not P"
END SELECT
RETURN

MakeX:
DRAW "C7 H1R1L1F1 C1 F2L1H2F2"
DRAW "BR1 E2 BE1 C7 R2L2BG1 C1 R1G2   "
DRAW "BR1BD1 F1L1H1 BL2 G1L1E1 BG2 C7 R2"

RETURN

LoadData:
FOR t% = 1 TO 256
READ MajPrem$(t%)
READ MinPrem$(t%)
READ Conc(t%)
READ Fall$(t%)
READ Form$(t%)
READ Valflag(t%)
NEXT t%
RETURN

DATA "a","j",1,"","AAA-1",1
DATA "b","j",1,"UNDISTRIBUTED MIDDLE TERM","AAA-2",0
DATA "a","i",1,"UNDISTRIBUTED MINOR TERM","AAA-3",0
DATA "b","i",1,"UNDISTRIBUTED MINOR TERM","AAA-4",0
DATA "a","j",2,"UNBALANCED NEGATION & UNDISTRIBUTED MAJOR TERM","AAE-1",0
DATA "b","j",2,"UNBALANCED NEGATION & UNDISTRIBUTED MIDDLE TERM","AAE-2",0
DATA "a","i",2,"UNBALANCED NEGATION & UNDISTRIBUTED MAJOR/MINOR TERM","AAE-3",0
DATA "b","i",2,"UNBALANCED NEGATION & UNDISTRIBUTED MINOR TERM","AAE-4",0
DATA "a","j",3,"","AAI-1",1
DATA "b","j",3,"UNDISTRIBUTED MIDDLE TERM","AAI-2",0
DATA "a","i",3,"","AAI-3",1
DATA "b","i",3,"","AAI-4",1
DATA "a","j",4,"UNBALANCED NEGATION & UNDISTRIBUTED MAJOR TERM","AAO-1",0
DATA "b","j",4,"UNBALANCED NEGATION & UNDISTRIBUTED MIDDLE TERM","AAO-2",0
DATA "a","i",4,"UNBALANCED NEGATION & UNDISTRIBUTED MAJOR TERM","AAO-3",0
DATA "b","i",4,"UNBALANCED NEGATION","AAO-4",0
DATA "a","n",1,"UNBALANCED NEGATION","AEA-1",0
DATA "b","n",1,"UNBALANCED NEGATION","AEA-2",0
DATA "a","m",1,"UNBALANCED NEGATION","AEA-3",0
DATA "b","m",1,"UNBALANCED NEGATION","AEA-4",0
DATA "a","n",2,"UNDISTRIBUTED MAJOR TERM","AEE-1",0
DATA "b","n",2,"","AEE-2",1
DATA "a","m",2,"UNDISTRIBUTED MAJOR TERM","AEE-3",0
DATA "b","m",2,"","AEE-4",1
DATA "a","n",3,"UNBALANCED NEGATION","AEI-1",0
DATA "b","n",3,"UNBALANCED NEGATION","AEI-2",0
DATA "a","m",3,"UNBALANCED NEGATION","AEI-3",0
DATA "b","m",3,"UNBALANCED NEGATION","AEI-4",0
DATA "a","n",4,"UNDISTRIBUTED MAJOR TERM","AEO-1",0
DATA "b","n",4,"","AEO-2",1
DATA "a","m",4,"UNDISTRIBUTED MAJOR TERM","AEO-3",0
DATA "b","m",4,"","AEO-4",1
DATA "a","l",1,"UNDISTRIBUTED MINOR TERM","AIA-1",0
DATA "b","l",1,"UNDISTRIBUTED MIDDLE TERM","AIA-2",0
DATA "a","k",1,"UNDISTRIBUTED MINOR TERM","AIA-3",0
DATA "b","k",1,"UNDISTRIBUTED MIDDLE TERM","AIA-4",0
DATA "a","l",2,"UNBALANCED NEGATION & UNDISTRIBUTED MAJOR/MINOR TERM","AIE-1",0
DATA "b","l",2,"UNBALANCED NEGATION & UNDISTRIBUTED MIDDLE TERM","AIE-2",0
DATA "a","k",2,"UNBALANCED NEGATION & UNDISTRIBUTED MAJOR/MINOR TERM","AIE-3",0
DATA "b","k",2,"UNBALANCED NEGATION & UNDISTRIBUTED MIDDLE TERM","AIE-4",0
DATA "a","l",3,"","AII-1",1
DATA "b","l",3,"UNDISTRIBUTED MIDDLE TERM","AII-2",0
DATA "a","k",3,"","AII-3",1
DATA "b","k",3,"UNDISTRIBUTED MIDDLE TERM","AII-4",0
DATA "a","l",4,"UNBALANCED NEGATION & UNDISTRIBUTED MAJOR TERM","AIO-1",0
DATA "b","l",4,"UNBALANCED NEGATION & UNDISTRIBUTED MIDDLE TERM","AIO-2",0
DATA "a","k",4,"UNBALANCED NEGATION & UNDISTRIBUTED MAJOR TERM","AIO-3",0
DATA "b","k",4,"UNBALANCED NEGATION & UNDISTRIBUTED MIDDLE TERM","AIO-4",0
DATA "a","p",1,"UNBALANCED NEGATION & UNDISTRIBUTED MINOR TERM","AOA-1",0
DATA "b","p",1,"UNBALANCED NEGATION & UNDISTRIBUTED MINOR TERM","AOA-2",0
DATA "a","o",1,"UNBALANCED NEGATION","AOA-3",0
DATA "b","o",1,"UNBALANCED NEGATION & UNDISTRIBUTED MIDDLE TERM","AOA-4",0
DATA "a","p",2,"UNDISTRIBUTED MAJOR/MINOR TERM","AOE-1",0
DATA "b","p",2,"UNDISTRIBUTED MINOR TERM","AOE-2",0
DATA "a","o",2,"UNDISTRIBUTED MAJOR TERM","AOE-3",0
DATA "b","o",2,"UNDISTRIBUTED MIDDLE TERM","AOE-4",0
DATA "a","p",3,"UNBALANCED NEGATION","AOI-1",0
DATA "b","p",3,"UNBALANCED NEGATION","AOI-2",0
DATA "a","o",3,"UNBALANCED NEGATION","AOI-3",0
DATA "b","o",3,"UNBALANCED NEGATION & UNDISTRIBUTED MIDDLE TERM","AOI-4",0
DATA "a","p",4,"UNDISTRIBUTED MAJOR TERM","AOO-1",0
DATA "b","p",4,"","AOO-2",1
DATA "a","o",4,"UNDISTRIBUTED MAJOR TERM","AOO-3",0
DATA "b","o",4,"UNDISTRIBUTED MIDDLE TERM","AOO-4",0
DATA "e","j",1,"UNBALANCED NEGATION","EAA-1",0
DATA "f","j",1,"UNBALANCED NEGATION","EAA-2",0
DATA "e","i",1,"UNBALANCED NEGATION & UNDISTRIBUTED MINOR TERM","EAA-3",0
DATA "f","i",1,"UNBALANCED NEGATION & UNDISTRIBUTED MINOR TERM","EAA-4",0
DATA "e","j",2,"","EAE-1",1
DATA "f","j",2,"","EAE-2",1
DATA "e","i",2,"UNDISTRIBUTED MINOR TERM","EAE-3",0
DATA "f","i",2,"UNDISTRIBUTED MINOR TERM","EAE-4",0
DATA "e","j",3,"UNBALANCED NEGATION","EAI-1",0
DATA "f","j",3,"UNBALANCED NEGATION","EAI-2",0
DATA "e","i",3,"UNBALANCED NEGATION","EAI-3",0
DATA "f","i",3,"UNBALANCED NEGATION","EAI-4",0
DATA "e","j",4,"","EAO-1",1
DATA "f","j",4,"","EAO-2",1
DATA "e","i",4,"","EAO-3",1
DATA "f","i",4,"","EAO-4",1
DATA "e","n",1,"TOTAL NEGATION","EEA-1",0
DATA "f","n",1,"TOTAL NEGATION","EEA-2",0
DATA "e","m",1,"TOTAL NEGATION","EEA-3",0
DATA "f","m",1,"TOTAL NEGATION","EEA-4",0
DATA "e","n",2,"TOTAL NEGATION","EEE-1",0
DATA "f","n",2,"TOTAL NEGATION","EEE-2",0
DATA "e","m",2,"TOTAL NEGATION","EEE-3",0
DATA "f","m",2,"TOTAL NEGATION","EEE-4",0
DATA "e","n",3,"TOTAL NEGATION","EEI-1",0
DATA "f","n",3,"TOTAL NEGATION","EEI-2",0
DATA "e","m",3,"TOTAL NEGATION","EEI-3",0
DATA "f","m",3,"TOTAL NEGATION","EEI-4",0
DATA "e","n",4,"TOTAL NEGATION","EEO-1",0
DATA "f","n",4,"TOTAL NEGATION","EEO-2",0
DATA "e","m",4,"TOTAL NEGATION","EEO-3",0
DATA "f","m",4,"TOTAL NEGATION","EEO-4",0
DATA "e","l",1,"UNBALANCED NEGATION & UNDISTRIBUTED MINOR TERM","EIA-1",0
DATA "f","l",1,"UNBALANCED NEGATION & UNDISTRIBUTED MINOR TERM","EIA-2",0
DATA "e","k",1,"UNBALANCED NEGATION & UNDISTRIBUTED MINOR TERM","EIA-3",0
DATA "f","k",1,"UNBALANCED NEGATION & UNDISTRIBUTED MINOR TERM","EIA-4",0
DATA "e","l",2,"UNDISTRIBUTED MINOR TERM","EIE-1",0
DATA "f","l",2,"UNDISTRIBUTED MINOR TERM","EIE-2",0
DATA "e","k",2,"UNDISTRIBUTED MINOR TERM","EIE-3",0
DATA "f","k",2,"UNDISTRIBUTED MINOR TERM","EIE-4",0
DATA "e","l",3,"UNBALANCED NEGATION","EII-1",0
DATA "f","l",3,"UNBALANCED NEGATION","EII-2",0
DATA "e","k",3,"UNBALANCED NEGATION","EII-3",0
DATA "f","k",3,"UNBALANCED NEGATION","EII-4",0
DATA "e","l",4,"","EIO-1",1
DATA "f","l",4,"","EIO-2",1
DATA "e","k",4,"","EIO-3",1
DATA "f","k",4,"","EIO-4",1
DATA "e","p",1,"TOTAL NEGATION & UNDISTRIBUTED MINOR TERM","EOA-1",0
DATA "f","p",1,"TOTAL NEGATION & UNDISTRIBUTED MINOR TERM","EOA-2",0
DATA "e","o",1,"TOTAL NEGATION","EOA-3",0
DATA "f","o",1,"TOTAL NEGATION","EOA-4",0
DATA "e","p",2,"TOTAL NEGATION & UNDISTRIBUTED MINOR TERM","EOE-1",0
DATA "f","p",2,"TOTAL NEGATION & UNDISTRIBUTED MINOR TERM","EOE-2",0
DATA "e","o",2,"TOTAL NEGATION","EOE-3",0
DATA "f","o",2,"TOTAL NEGATION","EOE-4",0
DATA "e","p",3,"TOTAL NEGATION","EOI-1",0
DATA "f","p",3,"TOTAL NEGATION","EOI-2",0
DATA "e","o",3,"TOTAL NEGATION","EOI-3",0
DATA "f","o",3,"TOTAL NEGATION","EOI-4",0
DATA "e","p",4,"TOTAL NEGATION","EOO-1",0
DATA "f","p",4,"TOTAL NEGATION","EOO-2",0
DATA "e","o",4,"TOTAL NEGATION","EOO-3",0
DATA "f","o",4,"TOTAL NEGATION","EOO-4",0
DATA "c","j",1,"UNDISTRIBUTED MIDDLE TERM","IAA-1",0
DATA "d","j",1,"UNDISTRIBUTED MIDDLE TERM","IAA-2",0
DATA "c","i",1,"UNDISTRIBUTED MINOR TERM","IAA-3",0
DATA "d","i",1,"UNDISTRIBUTED MINOR TERM","IAA-4",0
DATA "c","j",2,"UNBALANCED NEGATION & UNDISTRIBUTED MIDDLE TERM","IAE-1",0
DATA "d","j",2,"UNBALANCED NEGATION & UNDISTRIBUTED MIDDLE TERM","IAE-2",0
DATA "c","i",2,"UNBALANCED NEGATION & UNDISTRIBUTED MAJOR/MINOR TERM","IAE-3",0
DATA "d","i",2,"UNBALANCED NEGATION & UNDISTRIBUTED MAJOR/MINOR TERM","IAE-4",0
DATA "c","j",3,"UNDISTRIBUTED MIDDLE TERM","IAI-1",0
DATA "d","j",3,"UNDISTRIBUTED MIDDLE TERM","IAI-2",0
DATA "c","i",3,"","IAI-3",1
DATA "d","i",3,"","IAI-4",1
DATA "c","j",4,"UNBALANCED NEGATION & UNDISTRIBUTED MIDDLE TERM","IAO-1",0
DATA "d","j",4,"UNBALANCED NEGATION & UNDISTRIBUTED MIDDLE TERM","IAO-2",0
DATA "c","i",4,"UNBALANCED NEGATION & UNDISTRIBUTED MAJOR TERM","IAO-3",0
DATA "d","i",4,"UNBALANCED NEGATION & UNDISTRIBUTED MAJOR TERM","IAO-4",0
DATA "c","n",1,"UNBALANCED NEGATION","IEA-1",0
DATA "d","n",1,"UNBALANCED NEGATION","IEA-2",0
DATA "c","m",1,"UNBALANCED NEGATION","IEA-3",0
DATA "d","m",1,"UNBALANCED NEGATION","IEA-4",0
DATA "c","n",2,"UNDISTRIBUTED MAJOR TERM","IEE-1",0
DATA "d","n",2,"UNDISTRIBUTED MAJOR TERM","IEE-2",0
DATA "c","m",2,"UNDISTRIBUTED MAJOR TERM","IEE-3",0
DATA "d","m",2,"UNDISTRIBUTED MAJOR TERM","IEE-4",0
DATA "c","n",3,"UNBALANCED NEGATION","IEI-1",0
DATA "d","n",3,"UNBALANCED NEGATION","IEI-2",0
DATA "c","m",3,"UNBALANCED NEGATION","IEI-3",0
DATA "d","m",3,"UNBALANCED NEGATION","IEI-4",0
DATA "c","n",4,"UNDISTRIBUTED MAJOR TERM","IEO-1",0
DATA "d","n",4,"UNDISTRIBUTED MAJOR TERM","IEO-2",0
DATA "c","m",4,"UNDISTRIBUTED MAJOR TERM","IEO-3",0
DATA "d","m",4,"UNDISTRIBUTED MAJOR TERM","IEO-4",0
DATA "c","l",1,"UNDISTRIBUTED MIDDLE TERM","IIA-1",0
DATA "d","l",1,"UNDISTRIBUTED MIDDLE TERM","IIA-2",0
DATA "c","k",1,"UNDISTRIBUTED MIDDLE TERM","IIA-3",0
DATA "d","k",1,"UNDISTRIBUTED MIDDLE TERM","IIA-4",0
DATA "c","l",2,"UNBALANCED NEGATION & UNDISTRIBUTED MIDDLE TERM","IIE-1",0
DATA "d","l",2,"UNBALANCED NEGATION & UNDISTRIBUTED MIDDLE TERM","IIE-2",0
DATA "c","k",2,"UNBALANCED NEGATION & UNDISTRIBUTED MIDDLE TERM","IIE-3",0
DATA "d","k",2,"UNBALANCED NEGATION & UNDISTRIBUTED MIDDLE TERM","IIE-4",0
DATA "c","l",3,"UNDISTRIBUTED MIDDLE TERM","III-1",0
DATA "d","l",3,"UNDISTRIBUTED MIDDLE TERM","III-2",0
DATA "c","k",3,"UNDISTRIBUTED MIDDLE TERM","III-3",0
DATA "d","k",3,"UNDISTRIBUTED MIDDLE TERM","III-4",0
DATA "c","l",4,"UNBALANCED NEGATION & UNDISTRIBUTED MIDDLE TERM","IIO-1",0
DATA "d","l",4,"UNBALANCED NEGATION & UNDISTRIBUTED MIDDLE TERM","IIO-2",0
DATA "c","k",4,"UNBALANCED NEGATION & UNDISTRIBUTED MIDDLE TERM","IIO-3",0
DATA "d","k",4,"UNBALANCED NEGATION & UNDISTRIBUTED MIDDLE TERM","IIO-4",0
DATA "c","p",1,"UNBALANCED NEGATION & UNDISTRIBUTED MINOR TERM","IOA-1",0
DATA "d","p",1,"UNBALANCED NEGATION & UNDISTRIBUTED MINOR TERM","IOA-2",0
DATA "c","o",1,"UNBALANCED NEGATION & UNDISTRIBUTED MIDDLE TERM","IOA-3",0
DATA "d","o",1,"UNBALANCED NEGATION & UNDISTRIBUTED MIDDLE TERM","IOA-4",0
DATA "c","p",2,"UNDISTRIBUTED MAJOR/MINOR TERM","IOE-1",0
DATA "d","p",2,"UNDISTRIBUTED MAJOR/MINOR TERM","IOE-2",0
DATA "c","o",2,"UNDISTRIBUTED MIDDLE TERM","IOE-3",0
DATA "d","o",2,"UNDISTRIBUTED MIDDLE TERM","IOE-4",0
DATA "c","p",3,"UNBALANCED NEGATION","IOI-1",0
DATA "d","p",3,"UNBALANCED NEGATION","IOI-2",0
DATA "c","o",3,"UNBALANCED NEGATION & UNDISTRIBUTED MIDDLE TERM","IOI-3",0
DATA "d","o",3,"UNBALANCED NEGATION & UNDISTRIBUTED MIDDLE TERM","IOI-4",0
DATA "c","p",4,"UNDISTRIBUTED MAJOR TERM","IOO-1",0
DATA "d","p",4,"UNDISTRIBUTED MAJOR TERM","IOO-2",0
DATA "c","o",4,"UNDISTRIBUTED MIDDLE TERM","IOO-3",0
DATA "d","o",4,"UNDISTRIBUTED MIDDLE TERM","IOO-4",0
DATA "g","j",1,"UNBALANCED NEGATION & UNDISTRIBUTED MIDDLE TERM","OAA-1",0
DATA "h","j",1,"UNBALANCED NEGATION","OAA-2",0
DATA "g","i",1,"UNBALANCED NEGATION & UNDISTRIBUTED MINOR TERM","OAA-3",0
DATA "h","i",1,"UNBALANCED NEGATION & UNDISTRIBUTED MINOR TERM","OAA-4",0
DATA "g","j",2,"UNDISTRIBUTED MIDDLE TERM","OAE-1",0
DATA "h","j",2,"UNDISTRIBUTED MAJOR TERM","OAE-2",0
DATA "g","i",2,"UNDISTRIBUTED MINOR TERM","OAE-3",0
DATA "h","i",2,"UNDISTRIBUTED MAJOR/MINOR TERM","OAE-4",0
DATA "g","j",3,"UNBALANCED NEGATION & UNDISTRIBUTED MIDDLE TERM","OAI-1",0
DATA "h","j",3,"UNBALANCED NEGATION","OAI-2",0
DATA "g","i",3,"UNBALANCED NEGATION","OAI-3",0
DATA "h","i",3,"UNBALANCED NEGATION","OAI-4",0
DATA "g","j",4,"UNDISTRIBUTED MIDDLE TERM","OAO-1",0
DATA "h","j",4,"UNDISTRIBUTED MAJOR TERM","OAO-2",0
DATA "g","i",4,"","OAO-3",1
DATA "h","i",4,"UNDISTRIBUTED MAJOR TERM","OAO-4",0
DATA "g","n",1,"TOTAL NEGATION","OEA-1",0
DATA "h","n",1,"TOTAL NEGATION","OEA-2",0
DATA "g","m",1,"TOTAL NEGATION","OEA-3",0
DATA "h","m",1,"TOTAL NEGATION","OEA-4",0
DATA "g","n",2,"TOTAL NEGATION","OEE-1",0
DATA "h","n",2,"TOTAL NEGATION & UNDISTRIBUTED MAJOR TERM","OEE-2",0
DATA "g","m",2,"TOTAL NEGATION","OEE-3",0
DATA "h","m",2,"TOTAL NEGATION & UNDISTRIBUTED MAJOR TERM","OEE-4",0
DATA "g","n",3,"TOTAL NEGATION","OEI-1",0
DATA "h","n",3,"TOTAL NEGATION","OEI-2",0
DATA "g","m",3,"TOTAL NEGATION","OEI-3",0
DATA "h","m",3,"TOTAL NEGATION","OEI-4",0
DATA "g","n",4,"TOTAL NEGATION","OEO-1",0
DATA "h","n",4,"TOTAL NEGATION & UNDISTRIBUTED MAJOR TERM","OEO-2",0
DATA "g","m",4,"TOTAL NEGATION","OEO-3",0
DATA "h","m",4,"TOTAL NEGATION & UNDISTRIBUTED MAJOR TERM","OEO-4",0
DATA "g","l",1,"UNBALANCED NEGATION & UNDISTRIBUTED MIDDLE TERM","OIA-1",0
DATA "h","l",1,"UNBALANCED NEGATION & UNDISTRIBUTED MINOR TERM","OIA-2",0
DATA "g","k",1,"UNBALANCED NEGATION & UNDISTRIBUTED MIDDLE TERM","OIA-3",0
DATA "h","k",1,"UNBALANCED NEGATION & UNDISTRIBUTED MINOR TERM","OIA-4",0
DATA "g","l",2,"UNDISTRIBUTED MIDDLE TERM","OIE-1",0
DATA "h","l",2,"UNDISTRIBUTED MAJOR/MINOR TERM","OIE-2",0
DATA "g","k",2,"UNDISTRIBUTED MIDDLE TERM","OIE-3",0
DATA "h","k",2,"UNDISTRIBUTED MAJOR/MINOR TERM","OIE-4",0
DATA "g","l",3,"UNBALANCED NEGATION & UNDISTRIBUTED MIDDLE TERM","OII-1",0
DATA "h","l",3,"UNBALANCED NEGATION","OII-2",0
DATA "g","k",3,"UNBALANCED NEGATION & UNDISTRIBUTED MIDDLE TERM","OII-3",0
DATA "h","k",3,"UNBALANCED NEGATION","OII-4",0
DATA "g","l",4,"UNDISTRIBUTED MIDDLE TERM","OIO-1",0
DATA "h","l",4,"UNDISTRIBUTED MAJOR TERM","OIO-2",0
DATA "g","k",4,"UNDISTRIBUTED MIDDLE TERM","OIO-3",0
DATA "h","k",4,"UNDISTRIBUTED MAJOR TERM","OIO-4",0
DATA "g","p",1,"TOTAL NEGATION & UNDISTRIBUTED MINOR TERM","OOA-1",0
DATA "h","p",1,"TOTAL NEGATION & UNDISTRIBUTED MINOR TERM","OOA-2",0
DATA "g","o",1,"TOTAL NEGATION & UNDISTRIBUTED MIDDLE TERM","OOA-3",0
DATA "h","o",1,"TOTAL NEGATION","OOA-4",0
DATA "g","p",2,"TOTAL NEGATION & UNDISTRIBUTED MINOR TERM","OOE-1",0
DATA "h","p",2,"TOTAL NEGATION & UNDISTRIBUTED MAJOR/MINOR TERM","OOE-2",0
DATA "g","o",2,"TOTAL NEGATION & UNDISTRIBUTED MIDDLE TERM","OOE-3",0
DATA "h","o",2,"TOTAL NEGATION & UNDISTRIBUTED MAJOR TERM","OOE-4",0
DATA "g","p",3,"TOTAL NEGATION","OOI-1",0
DATA "h","p",3,"TOTAL NEGATION","OOI-2",0
DATA "g","o",3,"TOTAL NEGATION & UNDISTRIBUTED MIDDLE TERM","OOI-3",0
DATA "h","o",3,"TOTAL NEGATION","OOI-4",0
DATA "g","p",4,"TOTAL NEGATION","OOO-1",0
DATA "h","p",4,"TOTAL NEGATION & UNDISTRIBUTED MAJOR TERM","OOO-2",0
DATA "g","o",4,"TOTAL NEGATION & UNDISTRIBUTED MIDDLE TERM","OOO-3",0
DATA "h","o",4,"TOTAL NEGATION & UNDISTRIBUTED MAJOR TERM","OOO-4",0

