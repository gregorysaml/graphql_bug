
   const createUserMutation= '''mutation CreateMobileUser (\$PK:String!, \$CRAT:String! , \$MBL:String!,){
  CreateMobileUser(input: {
      PK: \$PK, 
      SK: \$PK, 
      ORIP:"", 
      USER: \$PK,
      NAME: "User",
      EML: "", 
      MBL: \$MBL, 
      MT: "", 
      STRPI: "stripeid",
      CRAT: \$CRAT,
      GS3PK: "MOB", 
      GS1SK: \$PK, 
      GS3SK: \$CRAT}) {
      PK
      SK
      ORG
      ORIP
      USER
      NAME
      EML
      MBL
      MT
      STRPI
      CRAT
      GS3PK
      GS1SK
      GS3SK 
  }
} ''';
  

const getUserData ='''query GetMobileUserData( \$PK:String! ) {
  GetMobileUserData(
      PK: \$PK,
      SK: \$PK) {
	items {
      PK
      SK
      ORIP
      USER
      NAME
      EML
      MBL
      MT
      STRPI
      CRAT
      GS3PK
      GS1SK
      GS3SK 
    }
  }
}
    ''';
  