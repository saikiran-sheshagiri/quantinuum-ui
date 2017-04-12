FROM microsoft/windowsservercore
ENV NPM_CONFIG_LOGLEVEL info
ENV NODE_VERSION 6.10.2
ENV NODE_SHA256 d778ed84685c6604192cfcf40192004e27fb11c9e65c3ce4b283d90703b4192c
RUN powershell -Command \
    $ErrorActionPreference = 'Stop' ; \
    (New-Object System.Net.WebClient).DownloadFile('https://nodejs.org/dist/v%NODE_VERSION%/node-v%NODE_VERSION%-win-x64.zip', 'node.zip') ; \
    if ((Get-FileHash node.zip -Algorithm sha256).Hash -ne $env:NODE_SHA256) {exit 1} ; \
    Expand-Archive node.zip -DestinationPath C:\ ; \
    Rename-Item 'C:\node-v%NODE_VERSION%-win-x64' 'C:\nodejs' ; \
    New-Item '%APPDATA%\npm' ; \
    $env:PATH = 'C:\nodejs;%APPDATA%\npm;' + $env:PATH ; \
    [Environment]::SetEnvironmentVariable('PATH', $env:PATH, [EnvironmentVariableTarget]::Machine) ; \
    Remove-Item -Path node.zip


RUN npm install -g @angular/cli
#RUN npm install

#ADD ./dist /app
#WORKDIR /app

ARG source=./dist
RUN md c:\app
WORKDIR c:/app
COPY $source c:/app

EXPOSE 4200

CMD [ "npm", "start" ]

