Return-Path: <SRS0=hZ5U=FY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C977C4361B
	for <virtualization@archiver.kernel.org>; Sun, 20 Dec 2020 14:51:00 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB96F230FD
	for <virtualization@archiver.kernel.org>; Sun, 20 Dec 2020 14:50:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB96F230FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 553A720396;
	Sun, 20 Dec 2020 14:50:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C8j+d3RWjTEU; Sun, 20 Dec 2020 14:50:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id B5EDC2033B;
	Sun, 20 Dec 2020 14:50:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 974A4C1787;
	Sun, 20 Dec 2020 14:50:52 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B1B9DC0893
 for <virtualization@lists.linux-foundation.org>;
 Sun, 20 Dec 2020 14:50:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 4B0D42037A
 for <virtualization@lists.linux-foundation.org>;
 Sun, 20 Dec 2020 14:50:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Vhm6K+MMiKOd
 for <virtualization@lists.linux-foundation.org>;
 Sun, 20 Dec 2020 14:50:44 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from s052d7dde.fastvps-server.com (s052d7dde.fastvps-server.com
 [5.45.125.222])
 by silver.osuosl.org (Postfix) with ESMTPS id 6F8192033B
 for <virtualization@lists.linux-foundation.org>;
 Sun, 20 Dec 2020 14:50:43 +0000 (UTC)
Received: from [37.189.17.205] (helo=LAPTOP-EPOV2LRR)
 by s052d7dde.fastvps-server.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <marle@saisti.eu>) id 1kqz1e-0008Jr-VG
 for virtualization@lists.linux-foundation.org; Sun, 20 Dec 2020 16:45:31 +0300
From: "Lemos" <marialemos72@gmail.com>
Subject: =?utf-8?B?TUlDUkFEU8K0MjE=?= - The 2021 Multidisciplinary
 International Conference of Research Applied to Defense and Security,
 Cartagena, Colombia
To: virtualization@lists.linux-foundation.org
MIME-Version: 1.0
Date: Sun, 20 Dec 2020 13:45:31 +0000
Message-ID: <1348139071359@gmail-com>
X-Antivirus: AVG (VPS 201220-0, 20/12/2020), Outbound message
X-Antivirus-Status: Clean
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Reply-To: micradsmail@gmail.com
Content-Type: multipart/mixed; boundary="===============2983174866566967811=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

This is a multi-part message in MIME format

--===============2983174866566967811==
Content-Type: multipart/alternative; charset=utf-8; boundary="S9=_RJ1GD9uHMVAnhgvl9jNPXwW5I6Gydb"

This is a multi-part message in MIME format

--S9=_RJ1GD9uHMVAnhgvl9jNPXwW5I6Gydb
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

------------------------------  ------------------------------  -----------=
-------------------  ------------ 
MICRADS=C2=B421 - The 2021 Multidisciplinary International Conference of Re=
search Applied to Defense and Security 

Cartagena, Colombia, 26-28 May 2021

http://www.micrads.org/ <http://www.micrads.org/>

------------------------------  ------------------------------  -----------=
-------------------  ------------- 
 

Scope 

MICRADS=C2=B421 - The 2021 Multidisciplinary International Conference of Re=
search Applied to Defense and Security, to be held at Cartagena, Colombia, =
26-28 May 2021, is an international forum for researchers and practitioners=
 to present and discuss the most recent innovations, trends, results, exper=
iences and concerns in the several perspectives of Defense and Security.

We are pleased to invite you to submit your papers to MICRADS=C2=B421. They=
 can be written in English, Spanish or Portuguese. All submissions will be =
reviewed on the basis of relevance, originality, importance and clarity.

 

Topics 

Submitted papers should be related with one or more of the main themes prop=
osed for the Conference:

 

Area A: Systems, Communication and Defense

A1) Information and Communication Technology in Education 
A2) Simulation and computer vision in military applications 
A3) Analysis and Signal Processing 
A4) Cybersecurity and Cyberdefense 
A5) Computer Networks, Mobility and Pervasive Systems 

 

Area B: Strategy and political-administrative vision in Defense

B1) Safety and Maritime Protection 
B2) Strategy, Geopolitics and Oceanopolitics 
B3) Planning, economy and logistics applied to Defense 
B4) Leadership and e-leadership 
B5) Military Marketing 
B6) Health informatics in military applications 

 

Area C: Engineering and technologies applied to Defense

C1) Wearable Technology and Assistance Devices 
C2) Military Naval Engineering 
C3) Weapons and Combat Systems 
C4) Chemical, Biological and Nuclear Defense 
C5) Defense Engineering (General) 

 

Submission and Decision 

Submitted papers written in English (until 10-page limit) must comply with =
the format of Smart Innovation, Systems and Technologies series (see Instru=
ctions for Authors at Springer Website), must not have been published befor=
e, not be under review for any other conference or publication and not incl=
ude any information leading to the authors=E2=80=99 identification. Therefo=
re, the authors=E2=80=99 names, affiliations and e-mails should not be incl=
uded in the version for evaluation by the Scientific Committee. This inform=
ation should only be included in the camera-ready version, saved in Word or=
 Latex format and also in PDF format. These files must be accompanied by th=
e Consent to Publish form filled out, in a ZIP file, and uploaded at the co=
nference management system.

Submitted papers written in Spanish or Portuguese (until 15-page limit) mus=
t comply with the format of RISTI - Revista Ib=C3=A9rica de Sistemas e Tecn=
ologias de Informa=C3=A7=C3=A3o (download instructions/template for authors=
 in Spanish or Portuguese), must not have been published before, not be und=
er review for any other conference or publication and not include any infor=
mation leading to the authors=E2=80=99 identification. Therefore, the autho=
rs=E2=80=99 names, affiliations and e-mails should not be included in the v=
ersion for evaluation by the Scientific Committee. This information should =
only be included in the camera-ready version, saved in Word. These file mus=
t be uploaded at the conference management system in a ZIP file.

All papers will be subjected to a =E2=80=9Cblind review=E2=80=9D by at leas=
t two members of the Scientific Committee.

Based on Scientific Committee evaluation, a paper can be rejected or accept=
ed by the Conference Chairs. In the later case, it can be accepted as paper=
 or poster.

The authors of papers accepted as posters must build and print a poster to =
be exhibited during the Conference. This poster must follow an A1 or A2 ver=
tical format. The Conference can includes Work Sessions where these posters=
 are presented and orally discussed, with a 7 minute limit per poster.

The authors of accepted papers will have 15 minutes to present their work i=
n a Conference Work Session; approximately 5 minutes of discussion will fol=
low each presentation.

 

Publication and Indexing 

To ensure that an accepted paper is published, at least one of the authors =
must be fully registered by the 19 of February 2021, and the paper must com=
ply with the suggested layout and page-limit (until 10 pages). Additionally=
, all recommended changes must be addressed by the authors before they subm=
it the camera-ready version.

No more than one paper per registration will be published. An extra fee mus=
t be paid for publication of additional papers, with a maximum of one addit=
ional paper per registration. One registration permits only the participati=
on of one author in the conference.

Papers can be written in English, Spanish or Portuguese. Accepted and regis=
tered papers written in English will be published in Proceedings by Springe=
r, in a book of its SIST series, and will be submitted for indexing by ISI,=
 SCOPUS, EI-Compendex, SpringerLink, and Google Scholar.

Papers written in Spanish or Portuguese and registered will be published in=
 a Special Issue of RISTI and will be submitted for indexation by SCOPUS, a=
mong others.

 

Important Dates 

Paper Submission: January 11, 2021

Notification of Acceptance: February 19, 2021

Payment of Registration, to ensure the inclusion of an accepted paper in th=
e conference proceedings: February 26, 2021

Camera-ready Submission: February 26, 2021 

 

Website of MICRADS'21: http://www.micrads.org/ <http://www.micrads.org/> 


-- 
This email has been checked for viruses by AVG.
https://www.avg.com

--S9=_RJ1GD9uHMVAnhgvl9jNPXwW5I6Gydb
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<html>
  <head>
    <title></title>
    <meta content=3D"text/html; charset=3Dutf-8" http-equiv=3D"Content-Type=
" />
  </head>
  <body>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">------------------------------
      <wbr>&nbsp;</wbr>------------------------------
      <wbr>&nbsp;</wbr>------------------------------
      <wbr>&nbsp;</wbr>------------
    </p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%"><strong>MICRADS&acute;21 - The 2021 Mult=
idisciplinary International Conference of Research Applied to Defense and S=
ecurity</strong> </p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">Cartagena, Colombia, 26-28 May 2021</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%"><a href=3D"http://www.micrads.org/" targ=
et=3D"_blank" data-saferedirecturl=3D"https://www.google.com/url?q=3Dhttp:/=
/www.micrads.org/&source=3Dgmail&ust=3D1606489496821000&usg=3DAFQjCNE8rCuFL=
Du7oV2SzePcUgD0OhZVew">http://www.micrads.org/</a></p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">------------------------------
      <wbr>&nbsp;</wbr>------------------------------
      <wbr>&nbsp;</wbr>------------------------------
      <wbr>&nbsp;</wbr>-------------
    </p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">&nbsp;</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%"><strong>Scope</strong> </p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">MICRADS&acute;21 - The 2021 Multidiscipl=
inary International Conference of Research Applied to Defense and Security,=
 to be held at Cartagena, Colombia, 26-28 May 2021, is an international for=
um for researchers and practitioners to present and discuss the most recent=
 innovations, trends, results, experiences and concerns in the several pers=
pectives of Defense and Security.</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">We are pleased to invite you to submit y=
our papers to MICRADS&acute;21. They can be written in English, Spanish or =
Portuguese. All submissions will be reviewed on the basis of relevance, ori=
ginality, importance and clarity.</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">&nbsp;</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%"><strong>Topics</strong> </p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">Submitted papers should be related with =
one or more of the main themes proposed for the Conference:</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">&nbsp;</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">Area A: Systems, Communication and Defen=
se</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">A1) Information and Communication Techno=
logy in Education <br />A2) Simulation and computer vision in military appl=
ications <br />A3) Analysis and Signal Processing <br />A4) Cybersecurity a=
nd Cyberdefense <br />A5) Computer Networks, Mobility and Pervasive Systems=
 </p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">&nbsp;</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">Area B: Strategy and political-administr=
ative vision in Defense</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">B1) Safety and Maritime Protection <br /=
>B2) Strategy, Geopolitics and Oceanopolitics <br />B3) Planning, economy a=
nd logistics applied to Defense <br />B4) Leadership and e-leadership <br /=
>B5) Military Marketing <br />B6) Health informatics in military applicatio=
ns </p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">&nbsp;</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">Area C: Engineering and technologies app=
lied to Defense</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">C1) Wearable Technology and Assistance D=
evices <br />C2) Military Naval Engineering <br />C3) Weapons and Combat Sy=
stems <br />C4) Chemical, Biological and Nuclear Defense <br />C5) Defense =
Engineering (General) </p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">&nbsp;</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%"><strong>Submission and Decision</strong>=
 </p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">Submitted papers written in English (unt=
il 10-page limit) must comply with the format of Smart Innovation, Systems =
and Technologies series (see Instructions for Authors at Springer Website),=
 must not have been published before, not be under review for any other con=
ference or publication and not include any information leading to the autho=
rs&rsquo; identification. Therefore, the authors&rsquo; names, affiliations=
 and e-mails should not be included in the version for evaluation by the Sc=
ientific Committee. This information should only be included in the camera-=
ready version, saved in Word or Latex format and also in PDF format. These =
files must be accompanied by the Consent to Publish form filled out, in a Z=
IP file, and uploaded at the conference management system.</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">Submitted papers written in Spanish or P=
ortuguese (until 15-page limit) must comply with the format of RISTI - Revi=
sta Ib&eacute;rica de Sistemas e Tecnologias de Informa&ccedil;&atilde;o (d=
ownload instructions/template for authors in Spanish or Portuguese), must n=
ot have been published before, not be under review for any other conference=
 or publication and not include any information leading to the authors&rsqu=
o; identification. Therefore, the authors&rsquo; names, affiliations and e-=
mails should not be included in the version for evaluation by the Scientifi=
c Committee. This information should only be included in the camera-ready v=
ersion, saved in Word. These file must be uploaded at the conference manage=
ment system in a ZIP file.</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">All papers will be subjected to a &ldquo=
;blind review&rdquo; by at least two members of the Scientific Committee.</=
p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">Based on Scientific Committee evaluation=
, a paper can be rejected or accepted by the Conference Chairs. In the late=
r case, it can be accepted as paper or poster.</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">The authors of papers accepted as poster=
s must build and print a poster to be exhibited during the Conference. This=
 poster must follow an A1 or A2 vertical format. The Conference can include=
s Work Sessions where these posters are presented and orally discussed, wit=
h a 7 minute limit per poster.</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">The authors of accepted papers will have=
 15 minutes to present their work in a Conference Work Session; approximate=
ly 5 minutes of discussion will follow each presentation.</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">&nbsp;</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%"><strong>Publication and Indexing</strong=
> </p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">To ensure that an accepted paper is publ=
ished, at least one of the authors must be fully registered by the 19 of Fe=
bruary 2021, and the paper must comply with the suggested layout and page-l=
imit (until 10 pages). Additionally, all recommended changes must be addres=
sed by the authors before they submit the camera-ready version.</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">No more than one paper per registration =
will be published. An extra fee must be paid for publication of additional =
papers, with a maximum of one additional paper per registration. One regist=
ration permits only the participation of one author in the conference.</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">Papers can be written in English, Spanis=
h or Portuguese. Accepted and registered papers written in English will be =
published in Proceedings by Springer, in a book of its SIST series, and wil=
l be submitted for indexing by ISI, SCOPUS, EI-Compendex, SpringerLink, and=
 Google Scholar.</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">Papers written in Spanish or Portuguese =
and registered will be published in a Special Issue of RISTI and will be su=
bmitted for indexation by SCOPUS, among others.</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">&nbsp;</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%"><strong>Important Dates</strong> </p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">Paper Submission: January 11, 2021</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">Notification of Acceptance: February 19,=
 2021</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">Payment of Registration, to ensure the i=
nclusion of an accepted paper in the conference proceedings: February 26, 2=
021</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">Camera-ready Submission: February 26, 20=
21 </p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">&nbsp;</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">Website of MICRADS'21: <a href=3D"http:/=
/www.micrads.org/">http://www.micrads.org/</a>&nbsp;</p>
  <div id=3D"DAB4FAD8-2DD7-40BB-A1B8-4E2AA1F9FDF2"><br />
<table style=3D"border-top: 1px solid #D3D4DE;">
	<tr>
        <td style=3D"width: 55px; padding-top: 13px;"><a href=3D"http://www=
=2Eavg.com/email-signature?utm_medium=3Demail&utm_source=3Dlink&utm_campaig=
n=3Dsig-email&utm_content=3Demailclient" target=3D"_blank"><img src=3D"http=
s://ipmcdn.avast.com/images/icons/icon-envelope-tick-green-avg-v1.png" alt=
=3D""  width=3D"46" height=3D"29" style=3D"width: 46px; height: 29px;" /></=
a></td>
		<td style=3D"width: 470px; padding-top: 12px; color: #41424e; font-size: =
13px; font-family: Arial, Helvetica, sans-serif; line-height: 18px;">Virus-=
free. <a href=3D"http://www.avg.com/email-signature?utm_medium=3Demail&utm_=
source=3Dlink&utm_campaign=3Dsig-email&utm_content=3Demailclient" target=3D=
"_blank" style=3D"color: #4453ea;">www.avg.com</a>
		</td>
	</tr>
</table><a href=3D"#DAB4FAD8-2DD7-40BB-A1B8-4E2AA1F9FDF2" width=3D"1" heigh=
t=3D"1"> </a></div></body>
</html>

--S9=_RJ1GD9uHMVAnhgvl9jNPXwW5I6Gydb--


--===============2983174866566967811==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============2983174866566967811==--

