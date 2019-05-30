attributeOnChange = executionContext =>
    {
        var context = executionContext.getFormContext();
        var countryCodeField = context.getAttribute("ava_countrycode");

const http = new XMLHttpRequest();
const url = "https://restcountries.eu/rest/v2/alpha/" + countryCodeField.getValue();
http.open("GET", url);
http.send();

http.onreadystatechange=(e) =>{
    var countryObject = http.response;
    context.getAttribute("ava_capitalcity").setValue(countryObject.capital);
    context.getAttribute("ava_currency").setValue(countryObject.currencies.code);
    context.getAttribute("ava_nativename").setValue(countryObject.nativename);
    context.getAttribute("ava_population").setValue(countryObject.population);
    context.getAttribute("ava_language").setValue(countryObject.languages.name);
}   
    }

    

