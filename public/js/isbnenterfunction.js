function isbnFunction() {
       var x = document.getElementById("nameList").value;
       document.getElementById("demo").innerHTML = "Enter their names in the boxes below:<br>";
       for (var i = 1; i <= x; i++) {
           var input = document.createElement("input");
           input.type = "text";
           input.name = "text[]";
           input.id = "nameJava";
           
           input.required = true;
           input.placeholder = "Enter ISBN"
           document.getElementById("demo").appendChild(input).value;
       }
}