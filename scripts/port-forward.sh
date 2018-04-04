## Forward port
forward() {

    local forward_args=$#
    local forward_usage="Usage: $0 {<option>} forward_port [local_port]"
    local forward_address="localhost"
    local forward_port=""
    local forward_host=""
    local forward_host_port="22"
    local local_port=""
    local forward_command=""

    case "$1" in
        wind)
            forward_host="<middle_machine_ip>"
            forward_host_port="22"
            forward_address="<target_machine_ip>"
            ;;
        *)
            echo $forward_usage
            return 1
    esac

    forward_port="$2"
    local_port="$3"

    if [[ $forward_args -eq 1 ]]; then
        echo $forward_usage
        echo "\nERROR: Need forward_port!"
        return 1
    elif [[ $forward_args -eq 2 ]]; then
        echo "Doesn't specify local_port, use forward_port as local_port."
        local_port=$forward_port
    elif [[ $forward_args -gt 3 ]]; then
        echo $forward_usage
        echo "ERROR: Too much arguments!"
        return 1
    fi

    forward_command="ssh -nNf -L $local_port:$forward_address:$forward_port $forward_host -p $forward_host_port"

    {
        pkill -f $forward_command
        eval $forward_command
    } && {
        echo "forward $forward_address($1):$forward_port => localhost:$local_port"
    } || {
        echo "foward failed"
    }
}
##
