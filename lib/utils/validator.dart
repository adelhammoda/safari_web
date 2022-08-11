

class Validator{


  static String? validTextBox(String? value,{ bool isNumber=false, bool isRequierd =true,
  String? Function()? anyAnotherData}){
    if(isRequierd && (value==null||value == "")){
      return "This field is required";
    }
    if(isNumber ){
      num?  n= num.tryParse(value??'');
      if(n==null) {
        return "This field must be numbers only";
      }
    }
    return anyAnotherData?.call();

  }



}