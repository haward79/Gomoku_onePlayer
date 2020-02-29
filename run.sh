echo "Welcome to Gomoku guide."
read -p "Please input your name: " username
export output_filename="$(date "+%Y%m%d")_$(date "+%H%M%S")_$username.log"
./application.linux64/Gomoku_onePlayer > ./records/$output_filename
echo "Record outputed to \"$output_filename\".";
echo "End of the script."
