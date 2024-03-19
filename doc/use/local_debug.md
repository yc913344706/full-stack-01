
```shell
# debug -- 启动后端
cd ./full-stack-user-management/
/d/program/python3.10/python -m venv ./venv
cd backend/
../venv/Scripts/activate
pip3 install -r requirements.txt
python manage.py runserver 0.0.0.0:8000

# debug -- 启动前端
cd ../frontend
npm i
npm run dev
```