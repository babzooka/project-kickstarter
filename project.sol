pragma solidity ^0.4.0; contract Project{
    //deklarimi i variablave te projektit
    address public owner; // adresa e qe e bon deploy kontratn ka me u 
sotre ne ket variabel
    string public project_name; // emri i projektit ka me u store ne ket 
variabel
    uint public balance; // bilanci i projektit ka me u store ne ket 
variabel
    uint public constant goal = 13 ether; // goali i projektit qe o 
vlere konstante qe duhet me u arite
    // per me perfundu projekti me sukses
    
    
    struct Investor{
        string name;
        address investor_address;
        uint value;
    }
    //objekti i Investor-it me 3 variabla emrin , adresen , dhe "value" 
shumen qe ka me investu
   
    mapping(address => Investor) investors;
    // mapping i investitorve ku si key kemi me perdore adres ndersa per 
value Investor
    address [] private investor_address;
    // array i tipit address ku kemi me i store vetem adresat e 
investitoreve
  
    function Project(string _name)public{
        owner = msg.sender;
        project_name = _name;
    }
    /* kontruktori Project() ku si parameter pranon emrin e projektit
       dhe variables owner ia jepim adresen e personit qe e ka bo deply 
ket kontrat
    
    */
    function invest(string _name)public payable{
        require(msg.value >= 1 ether);
        balance += msg.value;
        investors[msg.sender] = Investor({
            name : _name,
            investor_address : msg.sender,
            value : msg.value
        });
        investor_address.push(msg.sender);
    }
    /* metoa invest(string _name) metode publike e cila pranon nje 
string si parameter
       dhe eshte payable qe do te thot per me ju qas ksaj metode duhet 
me i dergu nje shume
       te caktuar te etherave prej minimum 1 ether . Nese ky kusht 
pltesohet atehere
       balancit te projektit i shtohet vlera e derguar nga perdoruesi 
dhe aj perdorues behet
       map ne mapping te investitoreve te projektit gjithashtu futet 
edhe ne nje array e cila
       permban vetem adresat e investitoreve
        
      
    */
    function canWithdraw()public view returns(bool){
        if(balance >= goal && msg.sender == owner){
            return true;
        }
        return false;
    }
    /* canWithdraw() metode qe kthen true ose false
       nese projekti e ka mri goalin edhe nese adresa qe po dershiron me 
bo terhekje
       osht adresa e ownerit dmth aj qe e ka bo deply kontraten
    */
    function withdraw()public {
        if(canWithdraw()){
            owner.transfer(balance);
        }
        else {returnInvestments();}
    }
    /* withdraw() metode publike e cila nese metoda canWithdraw() kthen 
true qe do te thot
       projekti e ka mri goal edhe owneri po don me i terhek fondet 
athere
       adreses se ownerit thirja metoden transfer()(metode qe ben 
transferin e etherave)
       dhe dergoja balancin total te grumbulluar te projektit
    
    */
    function hasInvestor(address _address)private returns(bool){
        if(investors[_address].investor_address == _address){
            return true;
        }
        return false;
    }
    // *metoda hasInvestor()*
    //si parameter pranon nje adres dhe kthen true ose false nese aj 
investitor
    //egziston ne mapin e investitoreve ose jo
 
    function returnInvestments()private{
            for(uint i=0 ; i < investor_address.length; i++){
               balance = balance - investors[investor_address[i]].value;
               investor_address[i].transfer(investors[investor_address[i]].value);
    }
    
    /* returnInvestments() *
    kjo metode thiret ne rast se behet withdraw projekt dhe nuk ka mri 
me i mbledh fondet e duhura.
    metode private e cila per funksion ka kthimin e investimeve tek 
invesistoret qe kan investu ne projekt
    me for loop ju qasemi te gjith adresave te investitoreve qe kan 
investu ne projekt
    pastaj tek balanci i projektit e minusojme shumen qe kan investu dhe 
pastaj adreses se investitorit
    ia thirim metoden transfer() duke ia transferuar shumen te cilen e 
kishe investuar ne projekt.
    
    */
    
    }
    
    
}
