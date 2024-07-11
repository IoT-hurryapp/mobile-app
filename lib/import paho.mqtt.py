import paho.mqtt.client as mqtt

def on_connect(client, userdata, flags, rc):
    if rc == 0:
        print("Connected successfully")
    else:
        print(f"Failed to connect, return code {rc}")

broker = "206.81.29.27"  # Replace with your MQTT broker address
port = 1883  # Replace with your MQTT broker port

client = mqtt.Client()
client.on_connect = on_connect

try:
    client.connect(broker, port, 60)
    client.loop_start()
except Exception as e:
    print(f"Failed to connect to the broker: {e}")
