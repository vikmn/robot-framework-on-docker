FROM microsoft/windowsservercore
ENV chocolateyUseWindowsCompression false

RUN powershell -Command \
    iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'));

WORKDIR /Python27 
RUN cinst -y python2-x86_32 -version 2.7.11
WORKDIR /code
COPY . .

RUN powershell -command "[Environment]::SetEnvironmentVariable('Path', $env:Path + ';/Python27/Scripts', [EnvironmentVariableTarget]::Machine)"

ENV PYTHONIOENCODING UTF-8

RUN python -m pip install -U pip==10.0.1 && \
    pip install wheel

RUN pip install --no-warn-script-location win-unicode-console 
RUN pip install --no-warn-script-location pyparsing
RUN pip install --no-warn-script-location python-dateutil
RUN pip install --no-warn-script-location pyodbc
RUN pip install --no-warn-script-location libxml2_python-2.9.3-cp27-none-win32.whl

RUN pip install --no-warn-script-location six robotframework==3.0.4 robotframework-selenium2library robotframework-seleniumlibrary robotframework-ride==1.5.2.1
RUN pip install --no-warn-script-location -U multi-mechanize

WORKDIR /tests
# ENTRYPOINT run-tests.bat

# RUN pip.exe install matplotlib==1.3.1

# RUN ["powershell",".\wxPython2.8-win32-unicode-2.8.12.1-py27.exe" "/VERYSILENT"]