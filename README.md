# family-history-booklet

Branches
+ swift2: This is the original app. I used the NSJSONSerialization object to parse the data, but wrote out the data by hand. The individuals in the tree are all hard-coded.
+ master: 
    - This is the Swift 4 version of the code, not yet released. 
    - The NSJSONSerialization code is replaced with the Codable interface, eliminating hundreds of lines of code. 
    - I am starting to remove the hard-coded individuals.
    - The FamilyTree class no longer contains a bunch of static members. Instead there is a GlobalData object that creates and tracks the one instance of FamilyTree.
    
