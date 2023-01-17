
import json
import subprocess
import sys
import os
from flask import Flask, jsonify, request, render_template, url_for, redirect

app = Flask(__name__)

@app.route('/', methods=['GET'])
def index():
   return render_template('index.html')

#list packages downloaded 
@app.route('/list', methods=['GET'])
def getPackages():
   packages = []
   count = 0

   for filename in os.scandir("/downloads"):
      if filename.is_file():
         file_name = str(filename.name)
         packages.append(file_name)
         count+=1
   
   packages = sorted(packages)

   json_data = {
      "packages": packages,
      "count": count
   }

   return {
      "isBase64Encoded": False,
      'headers': {
         'Content-Type': 'application/json',
         'Access-Control-Allow-Origin': '*'
      },
      'statusCode': 200,
      'body': json.dumps(json_data)
   }

@app.route('/request', methods=['POST'])
def requestDownload():
   #return in json format
   data = request.form
   package = data['package'] or ""
   version = data['version'] or "" 
   #return jsonify(data)"

   json_data = {
        "message": "Package name or version number is invalid"
    }

   ### If package name is empty return immediately
   if package == "":
      return {
         "isBase64Encoded": False,
         'headers': {
               'Content-Type': 'application/json',
               'Access-Control-Allow-Origin': '*'
         },
         'statusCode': 400,
         'body': json.dumps(json_data)
      }
   
   
   ### Add package name with version number to download
   if version != "":
        package = package+"=="+version

   ### Call OS to download package
   ### *** (TO DO) add catch if package download fails
   process = subprocess.check_call([sys.executable, "-m", "pip", "download", package, "-d", "/downloads"])
   #while process.returncode == None:
   json_data = {
      "package-name": package,
      "version": version
   }

   return {
       "isBase64Encoded": False,
       'headers': {
          'Content-Type': 'application/json',
          'Access-Control-Allow-Origin': '*'
       },
       'statusCode': 200,
       'body': json.dumps(json_data)
    }


### TEST AREA ###

# @app.route('/download')
# def download():
#    return render_template('download.html')

# #things to do
# #1. add function to check if requested package has been downloaded
# @app.route('/download', methods=['POST'])
# def download_post():
#    #return in json format
#    data = request.form
#    package = data['package'] or ""
#    version = data['version'] or "" 
#    #return jsonify(data)"

#    json_data = {
#         "message": "Package name or version number is invalid"
#     }

#    ### If package name is empty return immediately
#    if package == "":
#       return {
#          "isBase64Encoded": False,
#          'headers': {
#                'Content-Type': 'application/json',
#                'Access-Control-Allow-Origin': '*'
#          },
#          'statusCode': 400,
#          'body': json.dumps(json_data)
#       }
   
   
#    ### Add package name with version number to download
#    if version != "":
#         package = package+"=="+version

#    ### Call OS to download package
#    ### *** (TO DO) add catch if package download fails
#    subprocess.check_call([sys.executable, "-m", "pip", "download", package, "-d", "/downloads"])

#    json_data = {
#       "package-name": package,
#       "version": version
#    }

#    return {
#        "isBase64Encoded": False,
#        'headers': {
#           'Content-Type': 'application/json',
#           'Access-Control-Allow-Origin': '*'
#        },
#        'statusCode': 200,
#        'body': json.dumps(json_data)
#     }

#    #return in raw form
#    #package = request.form['package']
#    #version = request.form['version']
#    #requested = package+'=='+version
#    #return requested



if __name__ == "__main__":
   app.run(host='0.0.0.0')
