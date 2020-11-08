Return-Path: <SRS0=HjFt=EO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D00C388F9
	for <virtualization@archiver.kernel.org>; Sun,  8 Nov 2020 12:47:42 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 949FC206ED
	for <virtualization@archiver.kernel.org>; Sun,  8 Nov 2020 12:47:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 949FC206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 285FF87251;
	Sun,  8 Nov 2020 12:47:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3SLUCgegSPiQ; Sun,  8 Nov 2020 12:47:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1809387236;
	Sun,  8 Nov 2020 12:47:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CAF23C0889;
	Sun,  8 Nov 2020 12:47:36 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C68B7C016F
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Nov 2020 12:47:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id AC35720119
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Nov 2020 12:47:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id na7yZofX4gTn
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Nov 2020 12:47:27 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from s052d7dde.fastvps-server.com (s052d7dde.fastvps-server.com
 [5.45.125.222])
 by silver.osuosl.org (Postfix) with ESMTPS id 6ED042001A
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Nov 2020 12:47:27 +0000 (UTC)
Received: from [37.189.17.205] (helo=LAPTOP-EPOV2LRR)
 by s052d7dde.fastvps-server.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <marle@saisti.eu>) id 1kbjPd-0007QG-UM
 for virtualization@lists.linux-foundation.org; Sun, 08 Nov 2020 15:03:14 +0300
From: "ML" <marialemos72@gmail.com>
Subject: WorldCIST'21, Terceira Island, Azores | Deadline:  November 15
To: virtualization@lists.linux-foundation.org
MIME-Version: 1.0
Date: Sun, 8 Nov 2020 12:03:12 +0000
Message-ID: <203401000435515@gmail-com>
X-Antivirus: AVG (VPS 201108-0, 08/11/2020), Outbound message
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
Reply-To: worldcist@gmail.com
Content-Type: multipart/mixed; boundary="===============5019356659892303324=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

This is a multi-part message in MIME format

--===============5019356659892303324==
Content-Type: multipart/alternative; charset=utf-8; boundary="BbByoOJYRdg7Hl=_aXbOpNTBzSdFdcDWwX"

This is a multi-part message in MIME format

--BbByoOJYRdg7Hl=_aXbOpNTBzSdFdcDWwX
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

* CORE Ranking conference  
* Conference with a Google Scholar H5-Index =3D 19  
* Proceedings published by Springer, in several books of the AISC series  
* Indexed in Scopus, WoS, DBLP, Ei-Compendex, etc.  
* Extended versions of best articles published in JCR/WoS/SCI journals  
  

------------------------------    ------------------------------    -------=
-------------------- 
WorldCIST'21 - 9th World Conference on Information Systems and Technologies=
 
30-31 March to 1-2 April 2021 | Terceira Island, Azores, Portugal 
http://www.worldcist.org/ <http://www.worldcist.org/> 
------------------------------    ------------------------------    -------=
------------------- 

Scope 

The WorldCist'21 - 9th World Conference on Information Systems and Technolo=
gies, to be held in Terceira Island, Azores, Portugal, 30-31 March to 1-2 A=
pril 2021, is a global forum for researchers and practitioners to present a=
nd discuss the most recent innovations, trends, results, experiences and co=
ncerns in the several perspectives of Information Systems and Technologies.=


We are pleased to invite you to submit your papers to WorldCist'21. All sub=
missions will be reviewed on the basis of relevance, originality, importanc=
e and clarity.

 

Themes 

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

M) Technologies for Biomedical Applications (TBA)

N) Information Technologies in Radiocommunications (ITR);

 

Types of Submissions and Decisions 

Four types of papers can be submitted:

Full paper: Finished or consolidated R&D works, to be included in one of th=
e Conference themes. These papers are assigned a 10-page limit.

Short paper: Ongoing works with relevant preliminary results, open to discu=
ssion. These papers are assigned a 7-page limit.

Poster paper: Initial work with relevant ideas, open to discussion. These p=
apers are assigned to a 4-page limit.

Company paper: Companies' papers that show practical experience, R & D, too=
ls, etc., focused on some topics of the conference. These papers are assign=
ed to a 4-page limit.

Submitted papers must comply with the format of Advances in Intelligent Sys=
tems and Computing Series (see Instructions for Authors at Springer Website=
), be written in English, must not have been published before, not be under=
 review for any other conference or publication and not include any informa=
tion leading to the authors=E2=80=99 identification. Therefore, the authors=
=E2=80=99 names, affiliations and bibliographic references should not be in=
cluded in the version for evaluation by the Program Committee. This informa=
tion should only be included in the camera-ready version, saved in Word or =
Latex format and also in PDF format. These files must be accompanied by the=
 Consent to Publish form filled out, in a ZIP file, and uploaded at the con=
ference management system.

All papers will be subjected to a =E2=80=9Cdouble-blind review=E2=80=9D by =
at least two members of the Program Committee.

Based on Program Committee evaluation, a paper can be rejected or accepted =
by the Conference Chairs. In the later case, it can be accepted as the type=
 originally submitted or as another type. Thus, full papers can be accepted=
 as short papers or poster papers only. Similarly, short papers can be acce=
pted as poster papers only.

Poster papers and Company papers are not published in the Conference Procee=
dings, being only presented and discussed. The authors of accepted poster p=
apers should build and print a poster to be exhibited during the Conference=
=2E This poster must follow an A1 or A2 vertical format. The Conference inc=
ludes Work Sessions where these posters are presented and orally discussed,=
 with a 7 minute limit per poster.

The authors of accepted Full papers will have 15 minutes to present their w=
ork in a Conference Work Session; approximately 5 minutes of discussion wil=
l follow each presentation. The authors of accepted Short papers and Compan=
y papers will have 11 minutes to present their work in a Conference Work Se=
ssion; approximately 4 minutes of discussion will follow each presentation.=


 

Publication and Indexing 

To ensure that a full paper or short paper is published, poster paper or co=
mpany paper is published, at least one of the authors must be fully registe=
red by the 2nd of January 2021, and the paper must comply with the suggeste=
d layout and page-limit. Additionally, all recommended changes must be addr=
essed by the authors before they submit the camera-ready version.

No more than one paper per registration will be published. An extra fee mus=
t be paid for publication of additional papers, with a maximum of one addit=
ional paper per registration. One registration permits only the participati=
on of one author in the conference.

Full and Short papers will be published in Proceedings by Springer, in Adva=
nces in Intelligent Systems and Computing series. Poster and company papers=
 will not be published, just presented in the conference.

Published Full and Short papers will be submitted for indexation by ISI, EI=
-Compendex, SCOPUS, DBLP and Google Scholar, among others, and will be avai=
lable in the SpringerLink Digital Library.

The authors of the best selected papers will be invited to extend them for =
publication in international journals indexed by ISI/SCI, SCOPUS and DBLP, =
among others, such as:

- International Journal of Neural Systems (IF: 5.605 / Q1)

- Integrated Computer-Aided Engineering (IF: 4.706 / Q1)

- Computers in Industry (IF: 3.954 / Q1)

- Advanced Engineering Informatics (IF: 3.879 / Q1)

- Informatica - An International Journal (IF: 3.312 / Q1)

- Journal of Medical Systems (IF: 3.058 / Q1)

- Telecommunications Policy (IF: 2.224 / Q2)

- Computational and Mathematical Organization Theory (IF: 1.558 / Q2)

- Expert Systems - Journal of Knowledge Engineering (IF: 1.546 / Q2)

- Journal of Intelligent & Fuzzy Systems (IF: 1.851 / Q3)

- Journal of Computer Information Systems (IF: 1.582 / Q3)

- Computer Science and Information Systems (IF: 0.927 / Q4)

- Data Technologies and Applications (IF: 0.704 / Q4)

- Computer Methods in Biomechanics and Biomedical Engineering - Imaging & V=
isualization (ESCI & SJR: 0.52 / Q2)

- Journal of Information Systems Engineering & Management (DOAJ & ProQuest)=


 

Important Dates 

Paper Submission: November 15, 2020

Notification of Acceptance: December 23, 2020

Payment of Registration, to ensure the inclusion of an accepted paper in th=
e conference proceedings: January 2, 2021.

Camera-ready Submission: January 2, 2021

 

Website of WorldCIST'21: http://www.worldcist.org/ <http://www.worldcist.or=
g/>  


WorldCIST'21 Team  
http://www.worldcist.org/ <http://www.worldcist.org/>  


-- 
This email has been checked for viruses by AVG.
https://www.avg.com

--BbByoOJYRdg7Hl=_aXbOpNTBzSdFdcDWwX
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
x; margin: 0px; line-height: 200%">* CORE Ranking conference&nbsp; <br />* =
Conference with a Google Scholar H5-Index =3D 19&nbsp; <br />* Proceedings =
published by Springer, in several books of the AISC series&nbsp; <br />* In=
dexed in Scopus, WoS, DBLP, Ei-Compendex, etc.&nbsp; <br />* Extended versi=
ons of best articles published in JCR/WoS/SCI journals&nbsp; <br />&nbsp; <=
/p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">------------------------------ 
      <wbr>&nbsp;</wbr>&nbsp;&nbsp;------------------------------ 
      <wbr>&nbsp;</wbr>&nbsp;&nbsp;--------------------------- 
    </p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">WorldCIST'21 - 9th World Conference on I=
nformation Systems and Technologies <br />30-31 March to 1-2 April 2021 | T=
erceira Island, Azores, Portugal <br /><a href=3D"http://www.worldcist.org/=
" target=3D"_blank" data-saferedirecturl=3D"https://www.google.com/url?q=3D=
http://www.worldcist.org/&source=3Dgmail&ust=3D1603101984513000&usg=3DAFQjC=
NGAWV9djnDd92hk4D12eSCiDKm37A">http://www.worldcist.org/</a> <br />--------=
---------------------- 
      <wbr>&nbsp;</wbr>&nbsp;&nbsp;------------------------------ 
      <wbr>&nbsp;</wbr>&nbsp;&nbsp;-------------------------- 
    </p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%"><br /><strong>Scope</strong> </p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">The WorldCist'21 - 9th World Conference =
on Information Systems and Technologies, to be held in Terceira Island, Azo=
res, Portugal, 30-31 March to 1-2 April 2021, is a global forum for researc=
hers and practitioners to present and discuss the most recent innovations, =
trends, results, experiences and concerns in the several perspectives of In=
formation Systems and Technologies.</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">We are pleased to invite you to submit y=
our papers to WorldCist'21. All submissions will be reviewed on the basis o=
f relevance, originality, importance and clarity.</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">&nbsp;</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%"><strong>Themes</strong> </p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">Submitted papers should be related with =
one or more of the main themes proposed for the Conference:</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">A) Information and Knowledge Management =
(IKM);</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">B) Organizational Models and Information=
 Systems (OMIS);</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">C) Software and Systems Modeling (SSM);<=
/p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">D) Software Systems, Architectures, Appl=
ications and Tools (SSAAT);</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">E) Multimedia Systems and Applications (=
MSA);</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">F) Computer Networks, Mobility and Perva=
sive Systems (CNMPS);</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">G) Intelligent and Decision Support Syst=
ems (IDSS);</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">H) Big Data Analytics and Applications (=
BDAA);</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">I) Human-Computer Interaction (HCI);</p>=

    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">J) Ethics, Computers and Security (ECS)<=
/p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">K) Health Informatics (HIS);</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">L) Information Technologies in Education=
 (ITE);</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">M) Technologies for Biomedical Applicati=
ons (TBA)</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">N) Information Technologies in Radiocomm=
unications (ITR);</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">&nbsp;</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%"><strong>Types of Submissions and Decisio=
ns</strong> </p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">Four types of papers can be submitted:</=
p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">Full paper: Finished or consolidated R&a=
mp;D works, to be included in one of the Conference themes. These papers ar=
e assigned a 10-page limit.</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">Short paper: Ongoing works with relevant=
 preliminary results, open to discussion. These papers are assigned a 7-pag=
e limit.</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">Poster paper: Initial work with relevant=
 ideas, open to discussion. These papers are assigned to a 4-page limit.</p=
>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">Company paper: Companies' papers that sh=
ow practical experience, R &amp; D, tools, etc., focused on some topics of =
the conference. These papers are assigned to a 4-page limit.</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">Submitted papers must comply with the fo=
rmat of Advances in Intelligent Systems and Computing Series (see Instructi=
ons for Authors at Springer Website), be written in English, must not have =
been published before, not be under review for any other conference or publ=
ication and not include any information leading to the authors&rsquo; ident=
ification. Therefore, the authors&rsquo; names, affiliations and bibliograp=
hic references should not be included in the version for evaluation by the =
Program Committee. This information should only be included in the camera-r=
eady version, saved in Word or Latex format and also in PDF format. These f=
iles must be accompanied by the Consent to Publish form filled out, in a ZI=
P file, and uploaded at the conference management system.</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">All papers will be subjected to a &ldquo=
;double-blind review&rdquo; by at least two members of the Program Committe=
e.</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">Based on Program Committee evaluation, a=
 paper can be rejected or accepted by the Conference Chairs. In the later c=
ase, it can be accepted as the type originally submitted or as another type=
=2E Thus, full papers can be accepted as short papers or poster papers only=
=2E Similarly, short papers can be accepted as poster papers only.</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">Poster papers and Company papers are not=
 published in the Conference Proceedings, being only presented and discusse=
d. The authors of accepted poster papers should build and print a poster to=
 be exhibited during the Conference. This poster must follow an A1 or A2 ve=
rtical format. The Conference includes Work Sessions where these posters ar=
e presented and orally discussed, with a 7 minute limit per poster.</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">The authors of accepted Full papers will=
 have 15 minutes to present their work in a Conference Work Session; approx=
imately 5 minutes of discussion will follow each presentation. The authors =
of accepted Short papers and Company papers will have 11 minutes to present=
 their work in a Conference Work Session; approximately 4 minutes of discus=
sion will follow each presentation.</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">&nbsp;</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%"><strong>Publication and Indexing</strong=
> </p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">To ensure that a full paper or short pap=
er is published, poster paper or company paper is published, at least one o=
f the authors must be fully registered by the 2nd of January 2021, and the =
paper must comply with the suggested layout and page-limit. Additionally, a=
ll recommended changes must be addressed by the authors before they submit =
the camera-ready version.</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">No more than one paper per registration =
will be published. An extra fee must be paid for publication of additional =
papers, with a maximum of one additional paper per registration. One regist=
ration permits only the participation of one author in the conference.</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">Full and Short papers will be published =
in Proceedings by Springer, in Advances in Intelligent Systems and Computin=
g series. Poster and company papers will not be published, just presented i=
n the conference.</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">Published Full and Short papers will be =
submitted for indexation by ISI, EI-Compendex, SCOPUS, DBLP and Google Scho=
lar, among others, and will be available in the SpringerLink Digital Librar=
y.</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">The authors of the best selected papers =
will be invited to extend them for publication in international journals in=
dexed by ISI/SCI, SCOPUS and DBLP, among others, such as:</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">- International Journal of Neural System=
s (IF: 5.605 / Q1)</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">- Integrated Computer-Aided Engineering =
(IF: 4.706 / Q1)</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">- Computers in Industry (IF: 3.954 / Q1)=
</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">- Advanced Engineering Informatics (IF: =
3.879 / Q1)</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">- Informatica - An International Journal=
 (IF: 3.312 / Q1)</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">- Journal of Medical Systems (IF: 3.058 =
/ Q1)</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">- Telecommunications Policy (IF: 2.224 /=
 Q2)</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">- Computational and Mathematical Organiz=
ation Theory (IF: 1.558 / Q2)</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">- Expert Systems - Journal of Knowledge =
Engineering (IF: 1.546 / Q2)</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">- Journal of Intelligent &amp; Fuzzy Sys=
tems (IF: 1.851 / Q3)</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">- Journal of Computer Information System=
s (IF: 1.582 / Q3)</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">- Computer Science and Information Syste=
ms (IF: 0.927 / Q4)</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">- Data Technologies and Applications (IF=
: 0.704 / Q4)</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">- Computer Methods in Biomechanics and B=
iomedical Engineering - Imaging &amp; Visualization (ESCI &amp; SJR: 0.52 /=
 Q2)</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">- Journal of Information Systems Enginee=
ring &amp; Management (DOAJ &amp; ProQuest)</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">&nbsp;</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%"><strong>Important Dates</strong> </p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">Paper Submission: November 15, 2020</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">Notification of Acceptance: December 23,=
 2020</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">Payment of Registration, to ensure the i=
nclusion of an accepted paper in the conference proceedings: January 2, 202=
1.</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">Camera-ready Submission: January 2, 2021=
</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">&nbsp;</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">Website of WorldCIST'21: <a href=3D"http=
://www.worldcist.org/" target=3D"_blank" data-saferedirecturl=3D"https://ww=
w.google.com/url?q=3Dhttp://www.worldcist.org/&source=3Dgmail&ust=3D1603101=
984513000&usg=3DAFQjCNGAWV9djnDd92hk4D12eSCiDKm37A">http://www.worldcist.or=
g/</a> &nbsp;</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%"><br />WorldCIST'21 Team&nbsp; <br /><a h=
ref=3D"http://www.worldcist.org/" target=3D"_blank" data-saferedirecturl=3D=
"https://www.google.com/url?q=3Dhttp://www.worldcist.org/&source=3Dgmail&us=
t=3D1603101984513000&usg=3DAFQjCNGAWV9djnDd92hk4D12eSCiDKm37A">http://www.w=
orldcist.org/</a>&nbsp; </p>
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

--BbByoOJYRdg7Hl=_aXbOpNTBzSdFdcDWwX--


--===============5019356659892303324==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============5019356659892303324==--

