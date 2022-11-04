#!/bin/bash

set -o nounset
set -o errexit
# trace each command execute, same as `bash -v myscripts.sh`
#set -o verbose
# trace each command execute with attachment infomations, same as `bash -x myscripts.sh`
#set -o xtrace

#set -o
set -e
#set -x

export LIBSHELL_ROOT_PATH=${PWD}/libShell
. ${LIBSHELL_ROOT_PATH}/echo_color.lib
. ${LIBSHELL_ROOT_PATH}/utils.lib
. ${LIBSHELL_ROOT_PATH}/sysEnv.lib

# Checking environment setup symbolic link and its file exists
if [ -L ".env_setup" ] && [ -f ".env_setup" ]
then
#    echoG "Symbolic .env_setup exists."
    . ./.env_setup
else
    echoR "Setup environment informations by making .env_setup symbolic link to specific .env_setup_xxx file(eg: .env_setup_amd64_ubt_1804) ."
    exit 1
fi



SUPPORTED_CMD="deploy"
SUPPORTED_TARGETS="bookstack_frps"

EXEC_CMD=""
EXEC_ITEMS_LIST=""

DEPLOY_ROOT=${HOME}/servers
BOOKSTACK_FRPS_DIR=bookstack_frps
BOOKSTACK_FRPS_HOME=${DEPLOY_ROOT}/${BOOKSTACK_FRPS_DIR}

deploy_bookstack_frps()
{
    if [ ! -d ${DEPLOY_ROOT} ]
    then
        echoR "Deploy root path:${DEPLOY_ROOT} does not exsist, create it manully first!!!"
        exit 1
    elif [ -d ${BOOKSTACK_FRPS_HOME} ]
    then
        echoY "Already deployed bookstack_frps in ${BOOKSTACK_FRPS_HOME}, check it there first!"
        exit 1
    else
        echoY "Deploying bookstack_frps..."
        cp -a ./src ${BOOKSTACK_FRPS_HOME}
        echoG "bookstack_frps has been deployed to ${BOOKSTACK_FRPS_HOME} successfully."
        cat ./src/README.md
    fi
}

usage_func()
{

    echoY "Usage:"
    echoY './run.sh -c <cmd> -l "<item list>"'
    echoY "eg:\n./run.sh -c deploy -l \"bookstack_frps\""

    echoC "Supported cmd:"
    echo "${SUPPORTED_CMD}"
    echoC "Supported items:"
    echo "${SUPPORTED_TARGETS}"
    
}

no_args="true"
while getopts "c:l:" opts
do
    case $opts in
        c)
              # cmd
              EXEC_CMD=$OPTARG
              ;;
        l)
              # items list
              EXEC_ITEMS_LIST=$OPTARG
              ;;
        :)
            echo "The option -$OPTARG requires an argument."
            exit 1
            ;;
        ?)
            echo "Invalid option: -$OPTARG"
            usage_func
            exit 2
            ;;
        *)    #unknown error?
              echoR "unkonw error."
              usage_func
              exit 1
              ;;
    esac
    no_args="false"
done

[[ "$no_args" == "true" ]] && { usage_func; exit 1; }
#[ $# -lt 1 ] && echoR "Invalid args count:$# " && usage_func && exit 1


case ${EXEC_CMD} in
    "deploy")
        deploy_items ${EXEC_CMD} ${EXEC_ITEMS_LIST}
        ;;
    "*")
        echoR "Unsupport cmd:${EXEC_CMD}"
        ;;
esac



