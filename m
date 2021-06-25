Return-Path: <SRS0=LBsv=LT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E5AC2B9F4
	for <virtualization@archiver.kernel.org>; Fri, 25 Jun 2021 15:27:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EFF46193D
	for <virtualization@archiver.kernel.org>; Fri, 25 Jun 2021 15:27:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EFF46193D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CD09E421F1;
	Fri, 25 Jun 2021 15:27:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0ZB3mvJSYos5; Fri, 25 Jun 2021 15:27:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E997D4161D;
	Fri, 25 Jun 2021 15:27:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A50AFC001A;
	Fri, 25 Jun 2021 15:27:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 212F9C000E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Jun 2021 15:27:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0F6714162F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Jun 2021 15:27:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id P3gNukBAOVOh
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Jun 2021 15:27:46 +0000 (UTC)
X-Greylist: delayed 00:25:32 by SQLgrey-1.8.0
Received: from s052d7dde.fastvps-server.com (s052d7dde.fastvps-server.com
 [IPv6:2a03:f480:1:14::7d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C6DE24161D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Jun 2021 15:27:45 +0000 (UTC)
Received: from [37.189.17.205] (helo=LAPTOP-EPOV2LRR)
 by s052d7dde.fastvps-server.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <marle@saisti.eu>) id 1lwmfV-0007op-83
 for virtualization@lists.linux-foundation.org; Fri, 25 Jun 2021 17:18:53 +0300
From: "Maria" <marialemos72@gmail.com>
Subject: ICITS'22 - The 2022 International Conference on Information
 Technology & Systems | Costa Rica
To: virtualization@lists.linux-foundation.org
MIME-Version: 1.0
Date: Fri, 25 Jun 2021 15:18:52 +0100
Message-ID: <205881238706609@gmail-com>
X-Antivirus: AVG (VPS 210625-8, 25/06/2021), Outbound message
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
Reply-To: intercits@gmail.com
Content-Type: multipart/mixed; boundary="===============3610818714619624351=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

This is a multi-part message in MIME format

--===============3610818714619624351==
Content-Type: multipart/alternative; charset=utf-8; boundary="ewOn31keJuGZhlW9=_IIAEQmophpCGpSou"

This is a multi-part message in MIME format

--ewOn31keJuGZhlW9=_IIAEQmophpCGpSou
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

------------------------------    ------------------------------    -------=
-----------------------    ----------------------------- 
ICITS'22 - The 2022 International Conference on Information Technology & Sy=
stems 

San Carlos, Costa Rica, 9 - 11 February 2022 

http://icits.me <https://mkt.saisti.eu/go/74a05119e9b5-236832398-a356825b97=
1c26dff1e813f90-f44ece2OOTeFtTNe1we5rc>

-------------------
 
Scope  

ICITS'22 - The 2022 International Conference on Information Technology & Sy=
stems (http://icits.me <https://mkt.saisti.eu/go/74a05119e9b5-236832398-a35=
6825b971c26dff1e813f90-f44ece2OOTeFtTNe1we5rc>), to be held in Tecnol=C3=B3=
gico de Costa Rica, Campus de San Carlos, Costa Rica, 9 - 11 February 2022,=
 is an international forum for researchers and practitioners to present and=
 discuss the most recent innovations, trends, results, experiences and conc=
erns in the several perspectives of Information Technology & Systems.  

We are pleased to invite you to submit your papers to ICITS'22. They can be=
 written in English, Spanish or Portuguese. All submissions will be reviewe=
d on the basis of relevance, originality, importance and clarity.

  
Topics 

Submitted papers should be related with one or more of the main themes prop=
osed for the Conference:  

A) Information and Knowledge Management (IKM);  

B) Organizational Models and Information Systems (OMIS);  

C) Software and Systems Modeling (SSM);  

D) Software Systems, Architectures, Applications and Tools (SSAAT);  

E) Multimedia Systems and Applications (MSA);  

F) Computer Networks, Mobility and Pervasive Systems (CNMPS);  

G) Intelligent and Decision Support Systems (IDSS);  

H) Big Data Analytics and Applications (BDAA);  

I) Human-Computer Interaction (HCI);  

J) Ethics, Computers and Security (ECS)  

K) Health Informatics (HIS);  

L) Information Technologies in Education (ITE);  

M) Media, Applied Technology and Communication (MATC).

  
Submission and Decision  

Submitted papers written in English (until 10-page limit) must comply with =
the format of the Lecture Notes in Networks and Systems series (see Instruc=
tions for Authors at Springer Website <https://mkt.saisti.eu/go/74a05119e9b=
5-236832398-a356825b971c26dff1e813f90-f44ece2OOTeFtTNe1we5rd>), must not ha=
ve been published before, not be under review for any other conference or p=
ublication and not include any information leading to the authors=E2=80=99 =
identification. Therefore, the authors=E2=80=99 names and affiliations shou=
ld not be included in the version for evaluation by the Scientific Committe=
e. This information should only be included in the camera-ready version, sa=
ved in Word or Latex format and also in PDF format. These files must be acc=
ompanied by the Consent to Publish form <https://mkt.saisti.eu/go/74a05119e=
9b5-236832398-a356825b971c26dff1e813f90-f44ece2OOTeFtTNe1we5rf> filled out,=
 in a ZIP file, and uploaded at the conference management system.  

Submitted papers written in Spanish or Portuguese (until 15-page limit) mus=
t comply with the format of RISTI <https://mkt.saisti.eu/go/74a05119e9b5-23=
6832398-a356825b971c26dff1e813f90-f44ece2OOTeFtTNe1we5rg> - Revista Ib=C3=
=A9rica de Sistemas e Tecnologias de Informa=C3=A7=C3=A3o (download instruc=
tions/template for authors in Spanish <https://mkt.saisti.eu/go/74a05119e9b=
5-236832398-a356825b971c26dff1e813f90-f44ece2OOTeFtTNe1we5rh> or Portuguese=
 <https://mkt.saisti.eu/go/74a05119e9b5-236832398-a356825b971c26dff1e813f90=
-f44ece2OOTeFtTNe1we5ri>), must not have been published before, not be unde=
r review for any other conference or publication and not include any inform=
ation leading to the authors=E2=80=99 identification. Therefore, the author=
s=E2=80=99 names and affiliations should not be included in the version for=
 evaluation by the Scientific Committee. This information should only be in=
cluded in the camera-ready version, saved in Word. These files must be uplo=
aded at the conference management system in a ZIP file.  

All papers will be subjected to a =E2=80=9Cdouble-blind review=E2=80=9D by =
at least two members of the Scientific Committee.  

Based on Scientific Committee evaluation, a paper can be rejected or accept=
ed by the Conference Chairs. In the later case, it can be accepted as paper=
 or poster.  

The authors of papers accepted as posters must build and print a poster to =
be exhibited during the Conference. This poster must follow an A1 or A2 ver=
tical format. The Conference can include Work Sessions where these posters =
are presented and orally discussed, with a 7 minute limit per poster.  

The authors of accepted papers will have 15 minutes to present their work i=
n a Conference Work Session; approximately 5 minutes of discussion will fol=
low each presentation.

  
Publication and Indexing  

Papers accepted as posters are not published; they are only exhibited, pres=
ented and discussed during the conference.  

To ensure that a paper accepted as paper is published, at least one of the =
authors must be fully registered by the 6th of November 2020, and the paper=
 must comply with the suggested layout and page-limit. Additionally, all re=
commended changes must be addressed by the authors before they submit the c=
amera-ready version.  

No more than one paper per registration will be published. An extra fee mus=
t be paid for publication of additional papers, with a maximum of one addit=
ional paper per registration. One registration permits only the participati=
on of one author in the conference.  

Papers written in English and accepted and registered will be published in =
Proceedings by Springer, in a book of the Lecture Notes in Networks and Sys=
tems series, will  be submitted for indexation by SCOPUS, WoS, Google Schol=
ar, SCImago, among others, and will be available in the SpringerLink Digita=
l Library <https://mkt.saisti.eu/go/74a05119e9b5-236832398-a356825b971c26df=
f1e813f90-f44ece2OOTeFtTNe1we5rj>.  

Papers written in Spanish or Portuguese and accepted and registered will be=
 published in a Special Issue of RISTI <https://mkt.saisti.eu/go/74a05119e9=
b5-236832398-a356825b971c26dff1e813f90-f44ece2OOTeFtTNe1we5rk> and will be =
submitted for indexation by SCOPUS, among others.

  
Important Dates  

Paper Submission: September 5, 2021  

Notification of Acceptance: October 17, 2021  

Payment of Registration, to ensure the inclusion of an accepted paper in th=
e conference proceedings: November 5, 2021.  

Camera-ready Submission: November 5, 2021

 
 
Website of ICITS'22: http://icits.me <http://icits.me/>
 
 
ICITS'22 Team
http://icits.me <http://icits.me/>

 
 


-- 
This email has been checked for viruses by AVG.
https://www.avg.com

--ewOn31keJuGZhlW9=_IIAEQmophpCGpSou
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
    <p>------------------------------ 
      <wbr>&nbsp;</wbr>&nbsp;&nbsp;------------------------------ 
      <wbr>&nbsp;</wbr>&nbsp;&nbsp;------------------------------ 
      <wbr>&nbsp;</wbr>&nbsp;&nbsp;----------------------------- 
    </p>
    <p><strong>ICITS'22 - The 2022 International Conference on Information =
Technology &amp; Systems</strong> </p>
    <p>San Carlos, Costa Rica, 9 - 11 February 2022 </p>
    <p><a href=3D"https://mkt.saisti.eu/go/74a05119e9b5-236832398-a356825b9=
71c26dff1e813f90-f44ece2OOTeFtTNe1we5rc" target=3D"_blank" data-saferedirec=
turl=3D"https://www.google.com/url?q=3Dhttps://mkt.saisti.eu/go/74a05119e9b=
5-236832398-a356825b971c26dff1e813f90-f44ece2OOTeFtTNe1we5rc&source=3Dgmail=
&ust=3D1624715539782000&usg=3DAFQjCNHzar1aem9lmDsZIuQndxS84tcMlA">http://ic=
its.me</a></p>
    <div>-------------------<br />&nbsp;</div>
    <p><strong>Scope</strong>&nbsp;&nbsp;</p>
    <p>ICITS'22 - The 2022 International Conference on Information Technolo=
gy &amp; Systems (<a href=3D"https://mkt.saisti.eu/go/74a05119e9b5-23683239=
8-a356825b971c26dff1e813f90-f44ece2OOTeFtTNe1we5rc" target=3D"_blank" data-=
saferedirecturl=3D"https://www.google.com/url?q=3Dhttps://mkt.saisti.eu/go/=
74a05119e9b5-236832398-a356825b971c26dff1e813f90-f44ece2OOTeFtTNe1we5rc&sou=
rce=3Dgmail&ust=3D1624715539782000&usg=3DAFQjCNHzar1aem9lmDsZIuQndxS84tcMlA=
">http://icits.me</a>), to be held in Tecnol&oacute;gico de Costa Rica, Cam=
pus de San Carlos, Costa Rica, 9 - 11 February 2022, is an international fo=
rum for researchers and practitioners to present and discuss the most recen=
t innovations, trends, results, experiences and concerns in the several per=
spectives of Information Technology &amp; Systems.&nbsp;&nbsp;</p>
    <p>We are pleased to invite you to submit your papers to ICITS'22. They=
 can be written in English, Spanish or Portuguese. All submissions will be =
reviewed on the basis of relevance, originality, importance and clarity.</p=
>
    <div>&nbsp;&nbsp;</div>
    <p><strong>Topics</strong>&nbsp;</p>
    <p>Submitted papers should be related with one or more of the main them=
es proposed for the Conference:&nbsp;&nbsp;</p>
    <p>A) Information and Knowledge Management (IKM);&nbsp;&nbsp;</p>
    <p>B) Organizational Models and Information Systems (OMIS);&nbsp;&nbsp;=
</p>
    <p>C) Software and Systems Modeling (SSM);&nbsp;&nbsp;</p>
    <p>D) Software Systems, Architectures, Applications and Tools (SSAAT);&=
nbsp;&nbsp;</p>
    <p>E) Multimedia Systems and Applications (MSA);&nbsp;&nbsp;</p>
    <p>F) Computer Networks, Mobility and Pervasive Systems (CNMPS);&nbsp;&=
nbsp;</p>
    <p>G) Intelligent and Decision Support Systems (IDSS);&nbsp;&nbsp;</p>
    <p>H) Big Data Analytics and Applications (BDAA);&nbsp;&nbsp;</p>
    <p>I) Human-Computer Interaction (HCI);&nbsp;&nbsp;</p>
    <p>J) Ethics, Computers and Security (ECS)&nbsp;&nbsp;</p>
    <p>K) Health Informatics (HIS);&nbsp;&nbsp;</p>
    <p>L) Information Technologies in Education (ITE);&nbsp;&nbsp;</p>
    <p>M) Media, Applied Technology and Communication (MATC).</p>
    <div>&nbsp;&nbsp;</div>
    <p><strong>Submission and Decision</strong>&nbsp;&nbsp;</p>
    <p>Submitted papers written in English (until 10-page limit) must compl=
y with the format of the Lecture Notes in Networks and Systems series (see =
<a href=3D"https://mkt.saisti.eu/go/74a05119e9b5-236832398-a356825b971c26df=
f1e813f90-f44ece2OOTeFtTNe1we5rd" target=3D"_blank" data-saferedirecturl=3D=
"https://www.google.com/url?q=3Dhttps://mkt.saisti.eu/go/74a05119e9b5-23683=
2398-a356825b971c26dff1e813f90-f44ece2OOTeFtTNe1we5rd&source=3Dgmail&ust=3D=
1624715539782000&usg=3DAFQjCNHPvbjkiRbl0roob22axS-UehDRBw">Instructions for=
 Authors at Springer Website</a>), must not have been published before, not=
 be under review for any other conference or publication and not include an=
y information leading to the authors&rsquo; identification. Therefore, the =
authors&rsquo; names and affiliations should not be included in the version=
 for evaluation by the Scientific Committee. This information should only b=
e included in the camera-ready version, saved in Word or Latex format and a=
lso in PDF format. <span lang=3D"en">These files must be accompanied by the=
 <a href=3D"https://mkt.saisti.eu/go/74a05119e9b5-236832398-a356825b971c26d=
ff1e813f90-f44ece2OOTeFtTNe1we5rf" target=3D"_blank" data-saferedirecturl=
=3D"https://www.google.com/url?q=3Dhttps://mkt.saisti.eu/go/74a05119e9b5-23=
6832398-a356825b971c26dff1e813f90-f44ece2OOTeFtTNe1we5rf&source=3Dgmail&ust=
=3D1624715539782000&usg=3DAFQjCNFiTG0_OqUXRLrTr00q_i80AzImDw">Consent to Pu=
blish form</a> filled out,&nbsp;</span><span lang=3D"en"><span lang=3D"en">=
in a ZIP file, and uploaded at the conference management system.</span></sp=
an>&nbsp;&nbsp;</p>
    <p><span lang=3D"en"><span lang=3D"en">Submitted papers written in Span=
ish or Portuguese (until 15-page limit) must comply with the format of <a h=
ref=3D"https://mkt.saisti.eu/go/74a05119e9b5-236832398-a356825b971c26dff1e8=
13f90-f44ece2OOTeFtTNe1we5rg" target=3D"_blank" data-saferedirecturl=3D"htt=
ps://www.google.com/url?q=3Dhttps://mkt.saisti.eu/go/74a05119e9b5-236832398=
-a356825b971c26dff1e813f90-f44ece2OOTeFtTNe1we5rg&source=3Dgmail&ust=3D1624=
715539782000&usg=3DAFQjCNETavw7ZFiMPtyay7jvAhvnLGsYwg">RISTI</a> - Revista =
Ib&eacute;rica de Sistemas e Tecnologias de Informa&ccedil;&atilde;o (downl=
oad instructions/template for authors in <a href=3D"https://mkt.saisti.eu/g=
o/74a05119e9b5-236832398-a356825b971c26dff1e813f90-f44ece2OOTeFtTNe1we5rh" =
target=3D"_blank" data-saferedirecturl=3D"https://www.google.com/url?q=3Dht=
tps://mkt.saisti.eu/go/74a05119e9b5-236832398-a356825b971c26dff1e813f90-f44=
ece2OOTeFtTNe1we5rh&source=3Dgmail&ust=3D1624715539782000&usg=3DAFQjCNEHkSO=
R3py76sKDf68jmo_QLDR1BQ">Spanish</a> or <a href=3D"https://mkt.saisti.eu/go=
/74a05119e9b5-236832398-a356825b971c26dff1e813f90-f44ece2OOTeFtTNe1we5ri" t=
arget=3D"_blank" data-saferedirecturl=3D"https://www.google.com/url?q=3Dhtt=
ps://mkt.saisti.eu/go/74a05119e9b5-236832398-a356825b971c26dff1e813f90-f44e=
ce2OOTeFtTNe1we5ri&source=3Dgmail&ust=3D1624715539782000&usg=3DAFQjCNHAyZ-J=
HU5ZU-lamGJdNITJ0BAGig">Portuguese</a>), must not have been published befor=
e, not be under review for any other conference or publication and not incl=
ude any information leading to the authors&rsquo; identification. Therefore=
, the authors&rsquo; names and affiliations should not be included in the v=
ersion for evaluation by the Scientific Committee. This information should =
only be included in the camera-ready version, saved in Word. <span lang=3D"=
en">These files must be&nbsp;</span><span lang=3D"en"><span lang=3D"en">upl=
oaded at the conference management system in a ZIP file.</span></span></spa=
n></span>&nbsp;&nbsp;</p>
    <p>All papers will be subjected to a &ldquo;double-blind review&rdquo; =
by at least two members of the Scientific Committee.&nbsp;&nbsp;</p>
    <p>Based on Scientific Committee evaluation, a paper can be rejected or=
 accepted by the Conference Chairs. In the later case, it can be accepted a=
s paper or poster.&nbsp;&nbsp;</p>
    <p>The authors of papers accepted as posters must build and print a pos=
ter to be exhibited during the Conference. This poster must follow an A1 or=
 A2 vertical format. The Conference can include Work Sessions where these p=
osters are presented and orally discussed, with a 7 minute limit per poster=
=2E&nbsp;&nbsp;</p>
    <p>The authors of accepted papers will have 15 minutes to present their=
 work in a Conference Work Session; approximately 5 minutes of discussion w=
ill follow each presentation.</p>
    <div>&nbsp;&nbsp;</div>
    <p><strong>Publication and Indexing</strong>&nbsp;&nbsp;</p>
    <p>Papers accepted as posters are not published; they are only exhibite=
d, presented and discussed during the conference.&nbsp;&nbsp;</p>
    <p>To ensure that a paper accepted as paper is published, at least one =
of the authors must be fully registered by the 6th of November 2020, and th=
e paper must comply with the suggested layout and page-limit. Additionally,=
 all recommended changes must be addressed by the authors before they submi=
t the camera-ready version.&nbsp;&nbsp;</p>
    <p>No more than one paper per registration will be published. An extra =
fee must be paid for publication of additional papers, with a maximum of on=
e additional paper per registration. One registration permits only the part=
icipation of one author in the conference.&nbsp;&nbsp;</p>
    <p>Papers written in English and accepted and registered will be publis=
hed in Proceedings by Springer, in a book of the Lecture Notes in Networks =
and Systems series, will &nbsp;be submitted for indexation by SCOPUS, WoS, =
Google Scholar, SCImago, among others, and will be available in the <a href=
=3D"https://mkt.saisti.eu/go/74a05119e9b5-236832398-a356825b971c26dff1e813f=
90-f44ece2OOTeFtTNe1we5rj" target=3D"_blank" data-saferedirecturl=3D"https:=
//www.google.com/url?q=3Dhttps://mkt.saisti.eu/go/74a05119e9b5-236832398-a3=
56825b971c26dff1e813f90-f44ece2OOTeFtTNe1we5rj&source=3Dgmail&ust=3D1624715=
539782000&usg=3DAFQjCNEWkVATsTdWwMgyow_W3dLkoOjLuQ">SpringerLink Digital Li=
brary</a>.&nbsp;&nbsp;</p>
    <p>Papers written in Spanish or Portuguese and accepted and registered =
will be published in a Special Issue of <a href=3D"https://mkt.saisti.eu/go=
/74a05119e9b5-236832398-a356825b971c26dff1e813f90-f44ece2OOTeFtTNe1we5rk" t=
arget=3D"_blank" data-saferedirecturl=3D"https://www.google.com/url?q=3Dhtt=
ps://mkt.saisti.eu/go/74a05119e9b5-236832398-a356825b971c26dff1e813f90-f44e=
ce2OOTeFtTNe1we5rk&source=3Dgmail&ust=3D1624715539782000&usg=3DAFQjCNFcIL3C=
KKbzL_mbXHUF8WRWp66OMA">RISTI</a> and will be submitted for indexation by S=
COPUS, among others.</p>
    <div>&nbsp;&nbsp;</div>
    <p><strong>Important Dates</strong>&nbsp;&nbsp;</p>
    <p>Paper Submission: September 5, 2021&nbsp;&nbsp;</p>
    <p>Notification of Acceptance: October 17, 2021&nbsp;&nbsp;</p>
    <p>Payment of Registration,&nbsp;to ensure the inclusion of an accepted=
 paper in the conference proceedings: November 5, 2021.&nbsp;&nbsp;</p>
    <p>Camera-ready Submission: November 5, 2021</p>
    <div><strong>&nbsp;</strong></div>
    <div><strong>&nbsp;</strong></div>
    <div><strong>Website of ICITS'22</strong>: <a href=3D"http://icits.me/"=
 target=3D"_blank" data-saferedirecturl=3D"https://www.google.com/url?q=3Dh=
ttps://mkt.saisti.eu/go/74a05119e9b5-236832398-a356825b971c26dff1e813f90-f4=
4ece2OOTeFtTNe1we5rc&source=3Dgmail&ust=3D1624715539782000&usg=3DAFQjCNHzar=
1aem9lmDsZIuQndxS84tcMlA">http://icits.me</a></div>
    <div>&nbsp;</div>
    <div>&nbsp;</div>
    <div>ICITS'22 Team</div>
    <div><a href=3D"http://icits.me/" target=3D"_blank" data-saferedirectur=
l=3D"https://www.google.com/url?q=3Dhttps://mkt.saisti.eu/go/74a05119e9b5-2=
36832398-a356825b971c26dff1e813f90-f44ece2OOTeFtTNe1we5rc&source=3Dgmail&us=
t=3D1624715539782000&usg=3DAFQjCNHzar1aem9lmDsZIuQndxS84tcMlA">http://icits=
=2Eme</a><br /></div>
    <div>&nbsp;</div>
    <div>&nbsp;</div>
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

--ewOn31keJuGZhlW9=_IIAEQmophpCGpSou--


--===============3610818714619624351==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============3610818714619624351==--

