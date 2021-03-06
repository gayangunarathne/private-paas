Python Cartridge Agent (PCA)
============================

Cartridge agent manages cartridge instance lifecycle and publishes its health statistics
to Complex Event Processor (CEP). It provides a set of extension points for implementing
logic required for configuring the server.

Why PCA has been forked?
------------------------
- PCA message broker HA support has broken backward compatibility of cartridges in [Apache Stratos 4.1.5 release](https://issues.apache.org/jira/browse/STRATOS-1645).
- [High CPU usage issue](https://issues.apache.org/jira/browse/STRATOS-1644) was fixed in WSO2 Private PaaS and still not merged to Apache Stratos and released.
- Once above fixes are moved to Apache Stratos this fork will be removed.

How to run Live Tests?
----------------------
1. Install following packages

   apt-get install -y git python python-pip python-dev gcc zip 

2. Install dependent python modules:
   ```
   pip install paho-mqtt
   pip install psutil
   pip install pexpect
   pip install pycrypto
   pip install gitpython
   pip install yapsy
   ```

3. Start ActiveMQ:
   ```
   <activemq-home>/bin/activemq start
   ```

4. Run python cartridge agent live tests:
   ```
   mvn clean install -Plive
   ```
