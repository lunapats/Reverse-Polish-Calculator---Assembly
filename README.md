# Reverse-Polish-Calculator---Assembly

Rolul registrilor:
	- eax, care are rolul de a retine numerele care vor fi apoi introduse in stiva si de a efectua operatii cu ele
	- ebx, care efectueaza citirea caracter cu caracter si aplica operatiile necesare prelucrarii acestuia
	- ecx are rolul de counter in citirea caracter cu caracter
	- edx e folosit la crearea numerelor de mai multe cifre, inmultind rezultatul precedent cu 10

Programul are urmatoarea functionare:
	- se citeste caracter cu caracter sirul cu datele de intrare
	- daca caracterul respectiv este null se efectueaza printarea rezultatului (ultimul numar salvat pe stiva)
	- daca caracterul este space se salveaza numarul in stiva
	- daca caracterul este o operatie se efectueaza operatia respectiva intre ultimele 2 numere salvate pe stiva
	- in special, daca acesta e minus se efectueaza verificarea caracterului urmator pt a determina daca este vorba de un numar negativ sau de operatia minus
	- daca in eax era salvat un numar si caracterul e tot un numar se sare la flag-ul "big_number" unde se inmulteste numarul anterior cu 10 si se adauga caracterul citit pentru a forma numere de mai multe cifre.

Observatii:
	- folosesc imul si idiv in loc de mul, respectiv div pentru a efectua corect matematic operatiile cu numere intregi
	 - cdq dubleaza marimea operandului, e folosit pentru impartiri
	- metoda aleasa pentru a nega numerele este de a scadea din 0 numarul respectiv
- instructiunea "sub reg, 48" are rolul de a scadea 48 din valoarea registrului transformand valoarea unui caracter cifra din char in int 
