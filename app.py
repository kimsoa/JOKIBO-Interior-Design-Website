from flask import Flask, render_template, request, jsonify
from flask_cors import CORS
import json
import os
from datetime import datetime

# Configure Flask to serve static files from the root URL to match Svelte's behavior
app = Flask(__name__, static_url_path='', static_folder='static')
CORS(app)

# Path to leads.json in the project root
LEADS_FILE = 'leads.json'

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/privacy')
def privacy():
    return render_template('privacy.html')

@app.route('/submit', methods=['POST'])
def submit():
    data = request.get_json()
    if not data:
        return jsonify({'error': 'No data provided'}), 400
    
    # Add server-side timestamp if not present
    if 'timestamp' not in data:
        data['timestamp'] = datetime.now().isoformat()
        
    # Save to leads.json
    leads = []
    if os.path.exists(LEADS_FILE):
        try:
            with open(LEADS_FILE, 'r') as f:
                content = f.read()
                if content:
                    leads = json.loads(content)
        except json.JSONDecodeError:
            pass # File might be empty or corrupted
            
    leads.append(data)
    
    try:
        with open(LEADS_FILE, 'w') as f:
            json.dump(leads, f, indent=2)
    except Exception as e:
        return jsonify({'error': str(e)}), 500
        
    return jsonify({'message': 'Lead submitted successfully'}), 200

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8008)
