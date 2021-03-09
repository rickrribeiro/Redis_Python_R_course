import redis
from flask import Flask, request, render_template

r = redis.Redis()
app = Flask(__name__)

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/get-text', methods=['GET', 'POST'])
def foo():
    login = request.form['test']
    print(r.exists(login))
    if(r.exists(login) == 1):
        time = r.ttl(login)
        return f'Login: {login} expira em {time } segundos'
    else:
        r.set(login,login)
        r.expire(login,30)
        return login

if __name__ == '__main__':
    app.run()
