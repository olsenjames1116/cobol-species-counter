      *      James Olsen
      *      This program reads a file and outputs the counts for various types of animals listed within the file using condition names.
      
       Identification Division.
       Program-ID.  Lab3a.
       
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
       01   EndFileStr      Pic X Value "n".
            88  EndFile         Value "y"
                                When Set to False is "y".
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
       
       Procedure Division.
       000-Main.
           Open Input InFile
           Perform until EndFile
               Read InFile
                   At end 
                       Set EndFile to false
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
           If Amphibian
               Add 1 to AmphibCount
           Else if Bird
               Add 1 to BirdCount
           Else if Mammal
               Add 1 to MamCount
           Else if Reptile
               Add 1 to RepCount
           Else
               Add 1 to OtherCount
           End-If.
                   