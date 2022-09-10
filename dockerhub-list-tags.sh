#-----------------------------------------------------------------------
#
#
# Developed by
#   Youssef <youssef@alaoui.com>
#
# Copyright Youssef
#

#----------------------------------------------------------------------
# Objectives:
# 1. Return all tags for a specified image name from docker hub
# Required:
# 1. Image name
# 2. [optional] (default: true) Get versions with 2 digits instead of 3
#
#-----------------------------------------------------------------------

dockerhub_list_tags()
{
    #local LOCAL_IMAGE LOCAL_GET_TWO_DIGITS_VERSIONS
     
    LOCAL_IMAGE=${1:-null}
    LOCAL_GET_TWO_DIGITS_VERSIONS=${2:-true}


    if [[ $LOCAL_IMAGE == "" || $LOCAL_IMAGE == null ]]
    then
        printf "Image name is required: %s" ${FUNCNAME[0]}; 
        exit 1;
    fi

    #[[ $LOCAL_IMAGE == "" || $LOCAL_IMAGE == null ]] && printf "Image name is required: %s" ${FUNCNAME[0]}; exit 1;

    echo "Listing tags from docker hub for your image '$LOCAL_IMAGE'"
    
    # Check if 2 digits format is requested, otherwise, shoz it is normal format
    
    if [[ "$LOCAL_GET_TWO_DIGITS_VERSIONS" == true ]]; then
        DOCKERHUB_LIST_TAGS=($(curl -L -s "https://registry.hub.docker.com/v2/repositories/$LOCAL_IMAGE/tags?page_size=1024"|jq '."results"[]["name"]' | sed 's/"//g' | sed 's/\.[^.]*$//'))
    else
        DOCKERHUB_LIST_TAGS=($(curl -L -s "https://registry.hub.docker.com/v2/repositories/$LOCAL_IMAGE/tags?page_size=1024"|jq '."results"[]["name"]' | sed 's/"//g'))
    fi

    for TAG in ${DOCKERHUB_LIST_TAGS[@]}
    do
    echo $TAG
    done
}


# Test example
#dockerhub_list_tags "library/nginx" false