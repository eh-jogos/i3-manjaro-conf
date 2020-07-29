#!/bin/bash
# Made this with the help of the documentation at:
# https://wiki.archlinux.org/index.php/wacom_tablet#Adjusting_aspect_ratios
# https://wiki.archlinux.org/index.php/wacom_tablet#xrandr_setup

# Please turn this into a function when going back to manjaro i3?? Or just set this script in another location
# To map this into a cintiq button you'll nedd to have a shortcut that executes a script or a function, so maybe it's better to try to go back to i3, as I'm more used to setting 
# strartup configurations and shortcuts there, which in turn would make making a function usefull as I can use them in the setup/shortkey and in any other terminal
# if I want to experiment with values or other monitor setups
# maybe the mfunction could receive the monitor coordinates as different parameters and calculate the rest from there?
# os passos seriam: 
#   - Receber e tratar os parametros em screen_width screen_heigth screen_x screen_y
#   - Restear a Area da caneta
#   - pegar o output do get e separar em offset_x offset_y width heigth
#   - calcular o tablet_h_aspect_ratio fazendo heigth / width
#   - calcular o screen_h_heigth_aspect_ratio fazendo screen_heigth / screen_width
#   - Se o screen aspect ratio eh menor que o tablet aspect ratio
#       - calcular a nova altura da tablet pra width * heigth_aspect_ratio
#       - calcular o offset da nova altura fazendo (altura da tablet - nova altura) / 2
#       - rodar as linhas abaixo passando os seguintes parametros pra Area offset_x offset_y width new_heigth + offset_y e provavelmente trancando eles em int
#   - Se for maior voce tem que limitar a largura da tablet ao inves da altura
#       - eu acho que seria a mesma coisa acima mas aplicado ao width e calculando um tablet_w_aspect_ratio e screen_w_aspect_ratio pra usar no lugar
#       
#   - rodar o map to output pros parametros recebidos na funçao



# Limit stylus to a 16:9 centralized area
xsetwacom set 'Wacom Cintiq 21UX Pen stylus' Area 0 8275 87200 57325
xsetwacom set 'Wacom Cintiq 21UX Pen eraser ' Area 0 8275 87200 57325


# Set Display using coordinates WIDTHxHEIGHT+OFFSET_X+OFFSET_Y
xsetwacom set 'Wacom Cintiq 21UX Pen stylus' MapToOutput 1920x1080+0+0
xsetwacom set 'Wacom Cintiq 21UX Pen eraser' MapToOutput 1920x1080+0+0
