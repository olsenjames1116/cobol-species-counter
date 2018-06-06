      *      James Olsen
      *      This program asks the user for how many records from a file they would like to have species counts of and outputs the counts using
      *      a perform varying loop and an evaluate statement.
      
       Identification Division.
       Program-ID.  Lab3d.
       
       Environment Division.
       Input-Output Section.
       File-Control.
           Select InFile
            Assign to "lab3-in.dat"
            Organization is Line Sequential.
            
       Data Division.
       File Section.
       FD   InFile.
       01       InString    Pic X(28).
       Working-Storage Section.
       01   Names           Pic X(12).
       01   Gender          Pic X(1).
       01   Species         Pic X(15).
            88  Amphibian       Value "Frog" "Newt" "Salamander" 
                                      "Toad".
            88  Bird            Value "Albatross" "Eagle" "Falcon" 
                                      "Hawk" "Pelican" "Vulture".
            88  Mammal          Value "Ape" "Cheetah" "Chimp" "Coyote"
                                  "Lion" "Mongoose" "Otter" "Tiger"
                                  "Wolf".
            88  Reptile         Value "Alligator" "Boa" "Cobra" 
                                      "Komodo" "Turtle" "Viper".
       01   AmphibCount     Pic 9(3).
       01   BirdCount       Pic 9(3).
       01   MamCount        Pic 9(3).
       01   RepCount        Pic 9(3).
       01   OtherCount      Pic 9(3).
       01   AmphibStr       Pic ZZ9.
       01   BirdStr         Pic ZZ9.
       01   MamStr          Pic ZZ9.
       01   RepStr          Pic ZZ9.
       01   OtherStr        Pic ZZ9. 
       01   InStringLength  Pic 99.
       01   UserNum         Pic S9(4) Value 0.
       01   Indx            Pic 999.
       
       Procedure Division.
       000-Main.
           Open Input InFile
           Display "Enter how many lines of the file you would " &
           "like sorted: " With no advancing
           Accept UserNum
           Perform until UserNum>0
                Display "Please enter a number greater than 0"
                Display "Enter how many lines of the file you would" &
                " like counted: " with no advancing
                Accept UserNum
           End-Perform
           Perform varying Indx
                From 0 by 1 until Indx>=UserNum
                    Read InFile
                       At end
                            Exit Perform
                       Not at end
                            Perform 100-SeparateStrings
                            Perform 200-ClassCount
                End-Read
           End-Perform
           Close InFile
           Move AmphibCount to AmphibStr
           Move BirdCount to BirdStr
           Move MamCount to MamStr
           Move RepCount to RepStr
           Move OtherCount to OtherStr
           Display "Amphibian: " Function Trim(AmphibStr)
           Display "Bird: " Function Trim(BirdStr)
           Display "Mammal: " Function Trim(MamStr)
           Display "Reptile: " Function Trim(RepStr)
           Display "Other: " Function Trim(OtherStr)
           Stop Run.
        
       100-SeparateStrings.
           Unstring InString (1:12)
               Into Names
           End-Unstring
           Unstring InString (13:13)
               Into Gender
           End-Unstring
           Move Function Length(InString) to InStringLength
           Unstring InString (14:InStringLength)
               Into Species
           End-Unstring.
            
       200-ClassCount.                
           Evaluate true
               When Amphibian
                   Add 1 to AmphibCount
               When Bird
                   Add 1 to BirdCount
               When Mammal
                   Add 1 to MamCount
               When Reptile
                   Add 1 to RepCount
               When Other
                   Add 1 to OtherCount
           End-Evaluate.
            