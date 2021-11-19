include "prolog.inc"

domains
	identificador=integer
	diaentrada=integer
	diasalida=integer
	box=b(identificador, diaentrada, diasalida)
	lbox=box*
	
	actual=integer
	limite=integer
	pila=p(lbox,actual,limite)
	
	almacen=alm(pila,pila,pila,pila,pila)
	columna=string
	
predicates
	solucionar(lbox,almacen)
	move(lbox,almacen,almacen)
	apilar(box,pila,pila)
	pilaInvalida(pila)
	pilaVacia(pila)
	pilaLlena(pila)
	sacarCajas(box,pila,pila,pila)
	calcularPosicion(box,pila,pila,lbox,lbox,pila)
	vaciarListaEnPila(pila,pila,lbox)

clauses
	solucionar(ListaProd,Almacen):-
		move(ListaProd,Almacen,NuevoAlmacen),
		write(NuevoAlmacen,'\n').
		
	move([],Almacen,NuevoAlmacen):-
		Almacen=NuevoAlmacen.
	
	move([H|T],Almacen,NuevoAlmacen):-
		Almacen=alm(Pila1,Pila2,Pila3,Pila4,Pila5),
		apilar(H,Pila1,NuevaPila1),
		not(pilaInvalida(NuevaPila1)),
  		AlmacenTemporal=alm(NuevaPila1,Pila2,Pila3,Pila4,Pila5),
		move(T,AlmacenTemporal,NuevoAlmacen).
		
	move([H|T],Almacen,NuevoAlmacen):-
		Almacen=alm(Pila1,Pila2,Pila3,Pila4,Pila5),
		apilar(H,Pila2,NuevaPila2),
		not(pilaInvalida(NuevaPila2)),
  		AlmacenTemporal=alm(Pila1,NuevaPila2,Pila3,Pila4,Pila5),
		move(T,AlmacenTemporal,NuevoAlmacen).
		
	move([H|T],Almacen,NuevoAlmacen):-
		Almacen=alm(Pila1,Pila2,Pila3,Pila4,Pila5),
		apilar(H,Pila3,NuevaPila3),
		not(pilaInvalida(NuevaPila3)),
  		AlmacenTemporal=alm(Pila1,Pila2,NuevaPila3,Pila4,Pila5),
		move(T,AlmacenTemporal,NuevoAlmacen).
		
	move([H|T],Almacen,NuevoAlmacen):-
		Almacen=alm(Pila1,Pila2,Pila3,Pila4,Pila5),
		apilar(H,Pila4,NuevaPila4),
		not(pilaInvalida(NuevaPila4)),
  		AlmacenTemporal=alm(Pila1,Pila2,Pila3,NuevaPila4,Pila5),
		move(T,AlmacenTemporal,NuevoAlmacen).
		
	move([H|T],Almacen,NuevoAlmacen):-
		Almacen=alm(Pila1,Pila2,Pila3,Pila4,Pila5),
		apilar(H,Pila5,NuevaPila5),
		not(pilaInvalida(NuevaPila5)),
  		AlmacenTemporal=alm(Pila1,Pila2,Pila3,Pila4,NuevaPila5),
		move(T,AlmacenTemporal,NuevoAlmacen).
		
	move([H|T],Almacen,NuevoAlmacen):-
		Almacen=alm(Pila1,Pila2,Pila3,Pila4,Pila5),
		not(pilaLlena(Pila1)),
		sacarCajas(H,Pila1,NuevaPila,PilaFinal),
		AlmacenTemporal=alm(PilaFinal,Pila2,Pila3,Pila4,Pila5),
		move(T,AlmacenTemporal,NuevoAlmacen).
		
	move([H|T],Almacen,NuevoAlmacen):-
		Almacen=alm(Pila1,Pila2,Pila3,Pila4,Pila5),
		not(pilaLlena(Pila2)),
		sacarCajas(H,Pila2,NuevaPila,PilaFinal),
		AlmacenTemporal=alm(Pila1,PilaFinal,Pila3,Pila4,Pila5),
		move(T,AlmacenTemporal,NuevoAlmacen).
		
	move([H|T],Almacen,NuevoAlmacen):-
		Almacen=alm(Pila1,Pila2,Pila3,Pila4,Pila5),
		not(pilaLlena(Pila3)),
		sacarCajas(H,Pila3,NuevaPila,PilaFinal),
		AlmacenTemporal=alm(Pila1,Pila2,PilaFinal,Pila4,Pila5),
		move(T,AlmacenTemporal,NuevoAlmacen).
		
	move([H|T],Almacen,NuevoAlmacen):-
		Almacen=alm(Pila1,Pila2,Pila3,Pila4,Pila5),
		not(pilaLlena(Pila4)),
		sacarCajas(H,Pila4,NuevaPila,PilaFinal),
		AlmacenTemporal=alm(Pila1,Pila2,Pila3,PilaFinal,Pila5),
		move(T,AlmacenTemporal,NuevoAlmacen).
		
	move([H|T],Almacen,NuevoAlmacen):-
		Almacen=alm(Pila1,Pila2,Pila3,Pila4,Pila5),
		not(pilaLlena(Pila5)),
		sacarCajas(H,Pila5,NuevaPila,PilaFinal),
		AlmacenTemporal=alm(Pila1,Pila2,Pila3,Pila4,PilaFinal),
		move(T,AlmacenTemporal,NuevoAlmacen).
		
	sacarCajas(Caja,Pila,NuevaPila,PilaFinal):-
		calcularPosicion(Caja,Pila,NuevaPila,[],NuevaListaSacadas,PilaFinal).
	
	calcularPosicion(Caja,Pila,NuevaPila,ListaSacadas,NuevaListaSacadas,PilaFinal):-
		Pila=p(ListaPila,Actual,Limite),
		ListaPila=[Primera|Resto],
		Caja=b(_,_,DiaSalida),
		Primera=b(_,_,DiaSalidaPrimera),
		DiaSalida<=DiaSalidaPrimera,
		NuevoActual=Actual+1,
		ListaSacadas=NuevaListaSacadas,
		NuevaPila=p([Caja|ListaPila],NuevoActual,Limite),
		vaciarListaEnPila(NuevaPila,PilaTemporal,ListaSacadas),
		PilaFinal=PilaTemporal.
	
	calcularPosicion(Caja,Pila,NuevaPila,ListaSacadas,NuevaListaSacadas,PilaFinal):-
		Pila=p(ListaPila,Actual,Limite),
		not(ListaPila=[]),
		ListaPila=[Primera|Resto],
		%write(Pila,'\n'),
		Caja=b(_,_,DiaSalida),
		Primera=b(_,_,DiaSalidaPrimera),
		DiaSalida>DiaSalidaPrimera,
		ListaSacadasTemporal=[Primera|ListaSacadas],
		%write(ListaSacadasTemporal,'\n'),
		NuevoActual=Actual-1,
		PilaTemporal=p(Resto,NuevoActual,Limite),
		%write(PilaTemporal,'\n'),
		calcularPosicion(Caja,PilaTemporal,NuevaPila,ListaSacadasTemporal,NuevaListaSacadas,PilaFinal).
	
	calcularPosicion(Caja,Pila,NuevaPila,ListaSacadas,NuevaListaSacadas,PilaFinal):-
		Pila=p(ListaPila,Actual,Limite),
		ListaPila=[],
		NuevoActual=Actual+1,
		ListaSacadas=NuevaListaSacadas,
		NuevaPila=p([Caja],NuevoActual,Limite),
		vaciarListaEnPila(NuevaPila,PilaTemporal,ListaSacadas),
		PilaFinal=PilaTemporal.
		
	vaciarListaEnPila(NuevaPila,PilaTemporal,[]):-
		NuevaPila=PilaTemporal.
	
	vaciarListaEnPila(NuevaPila,PilaTemporal,ListaSacadas):-
		ListaSacadas=[P|R],
		NuevaPila=p(Lista,Actual,Limite),
		NuevoActual=Actual+1,
		PilaTemporal1=p([P|Lista],NuevoActual,Limite),
		vaciarListaEnPila(PilaTemporal1,PilaTemporal,R).
			
	apilar(Caja,PilaActual,NuevaPila):-
	  	not(pilaLlena(PilaActual)),
  		PilaActual=p(ListaCajas,Actual,Limite),
  		NuevoActual=Actual+1,
  		NuevaPila=p([Caja|ListaCajas],NuevoActual,Limite).
		
  	pilaInvalida(p([Primera_caja|Otras_cajas],Actual,Limite)):-
  		not(Otras_cajas=[]),
  		Otras_cajas=[Segunda_caja|_],	
  		Primera_caja=b(_,_,Primera_salida),
  		Segunda_caja=b(_,_,Segunda_salida),
  		Segunda_salida < Primera_salida.
		
	pilaVacia(Pila):-
  		Pila=p(_,Actual,_),
  		Actual=0.
  		
  	pilaLlena(p(_, Actual, Limite)):-
  		Actual >= Limite.
  		
goal
	solucionar(
		[b(9,1,17),b(10,1,17),b(11,1,17),b(12,1,17),b(13,1,17),b(14,1,17),b(15,1,17),b(16,1,17),b(17,1,17),b(18,1,17),b(19,1,17),b(20,1,17),b(3,1,17),b(4,1,18),b(5,1,18),
		b(6,1,18),b(7,1,18),b(8,1,18),b(1,1,19),b(2,1,19)],
		alm(p([],0,4),p([],0,4),p([],0,4),p([],0,4),p([],0,4))
	).


