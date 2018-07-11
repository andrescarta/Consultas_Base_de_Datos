
/* 1_CONSULTA_Cantidad de registros de la tabla de vuelos:*/
SELECT count(*) FROM flights;

/* 2_CONSULTA_Retraso promedio de salida y llegada según el aeropuerto origen:*/
SELECT Origin, avg(ArrDelay), avg(DepDelay) FROM flights GROUP BY Origin;

/* 3_CONSULTA_Retraso promedio de llegada de los vuelos, por meses y según el 
aeropuerto origen. */
SELECT Origin, colYear, colMonth, avg(ArrDelay) FROM flights GROUP BY Origin, colMonth;

/* 4_CONSULTA_Retraso promedio de llegada de los vuelos, por meses y según el 
aeropuerto origen (misma consulta que antes y con el mismo orden).*/
SELECT usairports.Airport, flights.colYear, flights.colMonth, avg(flights.ArrDelay) 
FROM flights
INNER JOIN usairports ON flights.Origin=usairports.IATA
GROUP BY flights.Origin, flights.colMonth;

/* 5_CONSULTA_Las compañías con más vuelos cancelados. Además, deben estar ordenadas
 de forma que las compañías con más cancelaciones aparezcan las primeras.*/
SELECT carriers.Description, SUM(flights.Cancelled)
FROM flights
INNER JOIN carriers ON flights.UniqueCarrier=carriers.CarrierCode
WHERE flights.Cancelled=1
GROUP BY carriers.Description
ORDER BY SUM(flights.Cancelled) DESC;

/* 6_CONSULTA_El identificador de los 10 aviones que más kilómetros han 
recorrido haciendo vuelos comerciales:*/
SELECT TailNum, SUM(AirTime)
FROM flights
WHERE AirTime!=0 
GROUP BY TailNum
ORDER BY SUM(AirTime) DESC
LIMIT 0, 10;

/* 7_CONSULTA_Compañías con su retraso promedio sólo de aquellas las 
que sus vuelos llegan a su destino con un retraso promedio mayor de 10 minutos.*/
SELECT UniqueCarrier, AVG(ArrDelay)
FROM flights
GROUP BY UniqueCarrier
HAVING AVG(ArrDelay)>10
ORDER BY AVG(ArrDelay);