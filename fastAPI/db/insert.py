from datetime import datetime
import json 
from id_generator import generate_id



def insert() -> str:
    mail = "Ingen mail"
    password = "Intet password"
    value = st.text_input("Sagsnummer: ", value=0).lower()
    selectbox_tmp_device = st.selectbox("Enhed", options=["Computer (C)", "Bærbar (B)", "Android (A)",
                                          "iPhone (I)", "Tablet (T)", "iPad (iP)", "Stationær (S)",
                                              "USB (U)", "HDD (HDD)", "SSD (SSD)", "Email (EM)", "Server (SSH)"])
    
    # Extract device from selectbox_tmp_device
    device = selectbox_tmp_device.split()[0].lower()

    # Check to see if device == mail or server
    if device == 'email':
        mail = st.text_input('Indsæt e-mail', value=config["default_text"])
        password = st.text_input('Indsæt adgangskode', value=config["default_text"])
    else:
        manufacturer = st.text_input("Mærke: ", config["default_text"])
        model = st.text_input("Model: ", config["default_text"])
        serial_number = st.text_input("Serienummer: ", config["default_text"])
    
    received = st.text_input("Modtaget af: ", config["default_text"])
    responsible = st.text_input("Ansvarlig: ", config["default_text"])
    location = st.text_input("Lokation: ", config["default_text"])
    notes = st.text_input("Eventuelle noter: ", config["default_text"])
    time = datetime.now().strftime("%d-%m-%Y %H:%M")
    case_comment = st.text_input("Sagskommentar: ", config["default_text"])

    new_device_id = generate_id(device, value)
    return value, device, manufacturer, model, serial_number, new_device_id, received, responsible, notes, time, mail, password, location, case_comment