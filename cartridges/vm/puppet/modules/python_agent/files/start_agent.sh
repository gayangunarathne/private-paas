#!/bin/bash
value=$(<./payload/launch-params)
echo "$value\n"
IFS=',' read -a array <<< "$value"

for index in "${!array[@]}"
do
    size=${#array[index]}
    if [ "$size" -gt 0 ]
    then 
    	echo "$index ${array[index]}"
        export ${array[index]}
    fi
done

echo "PCA_HOME=${PCA_HOME}" >> /etc/environment

# set CARBON_HOME as APPLICATION_PATH
export APPLICATION_PATH="${CARBON_HOME}"
echo "APPLICATION_PATH=${APPLICATION_PATH}" >> /etc/environment

# mandatory parameters
if [ ! -z "${MB_IP}" ]; then
	sed -i "s/^.*mb.ip.*=.*$/mb.ip = ${MB_IP}/g" ${PCA_HOME}/agent.conf
fi

if [ ! -z "${MB_PORT}" ]; then
	sed -i "s/^.*mb.port.*=.*$/mb.port = ${MB_PORT}/g" ${PCA_HOME}/agent.conf
fi

# parameters that can be empty
# default values have to be set

if [ ! -z "${LISTEN_ADDR}" ]; then
	sed -i "s/^.*listen.address.*=.*$/listen.address = ${LISTEN_ADDR}/g" ${PCA_HOME}/agent.conf
fi

# defaults to the message broker IP if not set
if [ ! -z "${CEP_IP}" ]; then
	sed -i "s/^.*thrift.receiver.ip.*=.*$/thrift.receiver.ip  = ${CEP_IP}/g" ${PCA_HOME}/agent.conf
fi

if [ ! -z "${CEP_PORT}" ]; then
	sed -i "s/^.*thrift.receiver.port.*=.*$/thrift.receiver.port = ${CEP_PORT}/g" ${PCA_HOME}/agent.conf
fi

if [ ! -z "${CEP_USERNAME}" ]; then
	sed -i "s/^.*thrift.server.admin.username.*=.*$/thrift.server.admin.username = ${CEP_USERNAME}/g" ${PCA_HOME}/agent.conf
fi

if [ ! -z "${CEP_PASSWORD}" ]; then
	sed -i "s/^.*thrift.server.admin.password.*=.*$/thrift.server.admin.password = ${CEP_PASSWORD}/g" ${PCA_HOME}/agent.conf
fi

if [ ! -z "${ENABLE_HEALTH_PUBLISHER}" ]; then
	sed -i "s/^.*cep.stats.publisher.enabled.*=.*$/cep.stats.publisher.enabled  = ${ENABLE_HEALTH_PUBLISHER}/g" ${PCA_HOME}/agent.conf
fi

if [ ! -z "${LB_PRIVATE_IP}" ]; then
	sed -i "s/^.*lb.private.ip.*=.*$/lb.private.ip =${LB_PRIVATE_IP} /g" ${PCA_HOME}/agent.conf
fi

if [ ! -z "${LB_PUBLIC_IP}" ]; then
	sed -i "s/^.*lb.public.ip.*=.*$/lb.public.ip = ${LB_PUBLIC_IP}/g" ${PCA_HOME}/agent.conf
fi

if [ ! -z "${ENABLE_ARTFCT_UPDATE}" ]; then
	sed -i "s/^.*enable.artifact.update.*=.*$/enable.artifact.update = ${ENABLE_ARTFCT_UPDATE}/g" ${PCA_HOME}/agent.conf
fi

if [ ! -z "${COMMIT_ENABLED}" ]; then
	sed -i "s/^.*auto.commit.*=.*$/auto.commit = ${COMMIT_ENABLED}/g" ${PCA_HOME}/agent.conf
fi

if [ ! -z "${CHECKOUT_ENABLED}" ]; then
	sed -i "s/^.*auto.checkout.*=.*$/auto.checkout = ${CHECKOUT_ENABLED}/g" ${PCA_HOME}/agent.conf
fi

if [ ! -z "${ARTFCT_UPDATE_INT}" ]; then
	sed -i "s/^.*artifact.update.interval.*=.*$/artifact.update.interval = ${ARTFCT_UPDATE_INT}/g" ${PCA_HOME}/agent.conf
fi

if [ ! -z "${ARTFCT_CLONE_RETRIES}" ]; then
	sed -i "s/^.*artifact.clone.retries.*=.*$/artifact.clone.retries= ${ARTFCT_CLONE_RETRIES}/g" ${PCA_HOME}/agent.conf
fi

if [ ! -z "${ARTFCT_CLONE_INT}" ]; then
	sed -i "s/^.*artifact.clone.interval.*=.*$/artifact.clone.interval= ${ARTFCT_CLONE_INT}/g" ${PCA_HOME}/agent.conf
fi

if [ ! -z "${PORT_CHECK_TIMEOUT}" ]; then
	sed -i "s/^.*port.check.timeout.*=.*$/port.check.timeout = ${PORT_CHECK_TIMEOUT}/g" ${PCA_HOME}/agent.conf
fi

if [ ! -z "${ENABLE_DATA_PUBLISHER}" ]; then
	sed -i "s/^.*enable.data.publisher.*=.*$/enable.data.publisher  = ${ENABLE_DATA_PUBLISHER}/g" ${PCA_HOME}/agent.conf
fi

# defaults to the message broker IP if not set
if [ ! -z "${MONITORING_SERVER_IP}" ]; then
	sed -i "s/^.*monitoring.server.ip.*=.*$/monitoring.server.ip = ${MONITORING_SERVER_IP}/g" ${PCA_HOME}/agent.conf
fi

if [ ! -z "${MONITORING_SERVER_PORT}" ]; then
	sed -i "s/^.*monitoring.server.port.*=.*$/monitoring.server.port = ${MONITORING_SERVER_PORT}/g" ${PCA_HOME}/agent.conf
fi

if [ ! -z "${MONITORING_SERVER_SECURE_PORT}" ]; then
	sed -i "s/^.*monitoring.server.secure.port.*=.*$/monitoring.server.secure.port = ${MONITORING_SERVER_SECURE_PORT}/g" ${PCA_HOME}/agent.conf
fi

if [ ! -z "${MONITORING_SERVER_ADMIN_USERNAME}" ]; then
	sed -i "s/^.*monitoring.server.admin.username.*=.*$/monitoring.server.admin.username = ${MONITORING_SERVER_ADMIN_USERNAME}/g" ${PCA_HOME}/agent.conf
fi

if [ ! -z "${MONITORING_SERVER_ADMIN_PASSWORD}" ]; then
	sed -i "s/^.*monitoring.server.admin.password.*=.*$/monitoring.server.admin.password = ${MONITORING_SERVER_ADMIN_PASSWORD}/g" ${PCA_HOME}/agent.conf
fi

if [ ! -z "${LOG_FILE_PATHS}" ]; then
	sed -i "s/^.*log.file.paths.*=.*$/log.file.paths = ${LOG_FILE_PATHS}/g" ${PCA_HOME}/agent.conf
fi

if [ ! -z "${APPLICATION_PATH}" ]; then
	sed -i "s/^.*APPLICATION_PATH.*=.*$/APPLICATION_PATH = ${APPLICATION_PATH}/g" ${PCA_HOME}/agent.conf
fi

if [ ! -z "${METADATA_SERVICE_URL}" ]; then
	sed -i "s#^.*metadata.service.url.*=.*#metadata.service.url = ${METADATA_SERVICE_URL}#g" ${PCA_HOME}/agent.conf
fi

if [ ! -z "${LOG_LEVEL}" ]; then
	sed -i "s/LOG_LEVEL/${LOG_LEVEL}/g" ${PCA_HOME}/logging.ini
fi

# Start cartridge agent
cd ${PCA_HOME}/
python ./agent.py > /tmp/agent.screen.log 2>&1 &
