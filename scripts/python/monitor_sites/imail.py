# coding=utf-8

import smtplib, os
from email.MIMEMultipart import MIMEMultipart
from email.MIMEBase import MIMEBase
from email.MIMEText import MIMEText
from email.Utils import COMMASPACE, formatdate
from email import Encoders


def send_mail(text, send_from, send_to, subject, cc_to=[], files=[], server={
    'server': "localhost",
    'port': None,
    'username': '',
    'password': '',
    'ssl': False,
}):
    assert type(send_to) == list
    assert type(files) == list

    msg = MIMEMultipart()
    msg['From'] = send_from
    msg['To'] = COMMASPACE.join(send_to)

    if cc_to:
        assert type(cc_to) == list
        msg['cc'] = COMMASPACE.join(cc_to)
        send_to.extend(cc_to)

    msg['Date'] = formatdate(localtime=True)
    msg['Subject'] = subject

    msg.attach(MIMEText(text))

    for f in files:
        part = MIMEBase('application', "octet-stream")
        part.set_payload(open(f, "rb").read())
        Encoders.encode_base64(part)
        part.add_header('Content-Disposition', 'attachment; filename="%s"' % os.path.basename(f))
        msg.attach(part)

    if server.get('ssl', False):
        smtp = smtplib.SMTP_SSL(server['server'], server.get('port', 465) or 465)
    else:
        smtp = smtplib.SMTP(server['server'], server.get('port', 25) or 25)
    if server.get('username', None):
        smtp.login(server['username'], server.get('password', None))
    smtp.sendmail(send_from, send_to, msg.as_string())
    smtp.close()

