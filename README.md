# prometheus exporter to json

first start:  
git clone https://github.com/Evonic4/prometheus_exporter_to_json.git && cd prometheus_exporter_to_json && chmod +rx ./jq_lib.sh && ./jq_lib.sh $A $B  
A - http&port exporter  
B - =1 to change char "{}.:,=-" to "_", =2 jsonp for zabbix metrics, =3 jsonp for zabbix metrics (all values are numeric), =4 jsonp for zabbix metrics (all values are numeric, Exponential Transformation
numbers to integer)  
  
start example:  
./jq_lib.sh "192.168.0.18:9187" 1  
or 
./jq_lib.sh "192.168.0.18:9187" 2  
or 
./jq_lib.sh "192.168.0.18:9187" 3  
or 
./jq_lib.sh "192.168.0.18:9187" 4  
or  
./jq_lib.sh "192.168.0.18:9187"  

json file is 4.txt    
if you need json adjustment, then look at 3.txt and 4.txt  
dependencies: git curl jq  
  