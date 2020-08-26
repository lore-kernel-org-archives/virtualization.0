Return-Path: <SRS0=/kjp=CE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F80CC433E1
	for <virtualization@archiver.kernel.org>; Wed, 26 Aug 2020 20:24:26 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BFFA2076C
	for <virtualization@archiver.kernel.org>; Wed, 26 Aug 2020 20:24:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BFFA2076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1BEE785D37;
	Wed, 26 Aug 2020 20:24:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WWmHhtr5e1cF; Wed, 26 Aug 2020 20:24:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2A07785C4A;
	Wed, 26 Aug 2020 20:24:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1CAD8C016F;
	Wed, 26 Aug 2020 20:24:22 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 40DC8C0051
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Aug 2020 20:24:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 3AA9D86233
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Aug 2020 20:24:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YXLDtkjL2zSr
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Aug 2020 20:24:16 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from s052d7dde.fastvps-server.com (s052d7dde.fastvps-server.com
 [5.45.125.222])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 7F09B86146
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Aug 2020 20:24:16 +0000 (UTC)
Received: from [37.189.17.205] (helo=LAPTOP-EPOV2LRR)
 by s052d7dde.fastvps-server.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <marle@saisti.eu>) id 1kB0vM-0007I3-11
 for virtualization@lists.linux-foundation.org; Wed, 26 Aug 2020 22:17:32 +0300
From: "MariaL" <marialemos72@gmail.com>
Subject: ICITS'21 - 4th Int. Conference on Information Technology & Systems,
 Santa Elena, Ecuador
To: virtualization@lists.linux-foundation.org
MIME-Version: 1.0
Date: Wed, 26 Aug 2020 20:17:30 +0100
Message-ID: <2868329633625@gmail-com>
X-Antivirus: AVG (VPS 200825-2, 25/08/2020), Outbound message
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
Content-Type: multipart/mixed; boundary="===============4982636446264089392=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

This is a multi-part message in MIME format

--===============4982636446264089392==
Content-Type: multipart/alternative; charset=utf-8; boundary="4A5l7DZJxB5uBTpgDspNl1i6Vf=_3DzUwo"

This is a multi-part message in MIME format

--4A5l7DZJxB5uBTpgDspNl1i6Vf=_3DzUwo
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

* Published by Springer in a book of the AISC series
* SCIMago H-Index =3D 34

* Indexed in Scopus, WoS, DBLP, Ei-Compendex, etc


-------------------------------------    ----------------------------------=
--    ----------- 
ICITS'21 - 4th International Conference on Information Technology & Systems=

4 - 6 February 2021 | Peninsula de Santa Elena, Ecuador
http://www.icits.me/ <http://www.icits.me/>

-----------------------------------    ------------------------------------=
-    ------------------------- 

ICITS'21 - The 2021 International Conference on Information Technology & Sy=
stems, to be held in Pen=C3=ADnsula de Santa Elena, Ecuador, 4 - 6 February=
 2021, is an international forum for researchers and practitioners to prese=
nt and discuss the most recent innovations, trends, results, experiences an=
d concerns in the several perspectives of Information Technology & Systems.=
 

We are pleased to invite you to submit your papers to ICITS'21. They can be=
 written in English, Spanish or Portuguese. All submissions will be reviewe=
d on the basis of relevance, originality, importance and clarity. 





TOPICS


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
 

SUBMISSION AND DECISION 

Submitted papers written in English (until 10-page limit) must comply with =
the format of Advances in Intelligent Systems and Computing series (see Ins=
tructions for Authors at Springer Website), must not have been published be=
fore, not be under review for any other conference or publication and not i=
nclude any information leading to the authors=E2=80=99 identification. Ther=
efore, the authors=E2=80=99 names and affiliations should not be included i=
n the version for evaluation by the Scientific Committee. This information =
should only be included in the camera-ready version, saved in Word or Latex=
 format and also in PDF format. These files must be accompanied by the Cons=
ent to Publish form filled out, in a ZIP file, and uploaded at the conferen=
ce management system. 

Submitted papers written in Spanish or Portuguese (until 15-page limit) mus=
t comply with the format of RISTI - Revista Ib=C3=A9rica de Sistemas e Tecn=
ologias de Informa=C3=A7=C3=A3o (download instructions/template for authors=
 in Spanish or Portuguese), must not have been published before, not be und=
er review for any other conference or publication and not include any infor=
mation leading to the authors=E2=80=99 identification. Therefore, the autho=
rs=E2=80=99 names and affiliations should not be included in the version fo=
r evaluation by the Scientific Committee. This information should only be i=
ncluded in the camera-ready version, saved in Word. These files must be upl=
oaded at the conference management system in a ZIP file. 

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


PUBLICATION AND INDEXING

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
Proceedings by Springer, in a book of the Advances in Intelligent Systems a=
nd Computing series, will  be submitted for indexation by ISI, EI-Compendex=
, SCOPUS and DBLP, among others, and will be available in the SpringerLink =
Digital Library. 

Papers written in Spanish or Portuguese and accepted and registered will be=
 published in a Special Issue of RISTI and will be submitted for indexation=
 by SCOPUS, among others. 


IMPORTANT DATES

Paper Submission: September 6, 2020 

Notification of Acceptance: October 18, 2020 

Payment of Registration, to ensure the inclusion of an accepted paper in th=
e conference proceedings: November 6, 2020. 

Camera-ready Submission: November 6, 2020





Website of ICITS'21: http://www.icits.me/ <http://www.icits.me/> 

ICITS'21 Team
http://www.icits.me/ <http://www.icits.me/> 
 

--------------

PS: If you do not wish to receive more notices from ICITS (http://icits.me =
<http://icits.me/>) just reply this message with the word REMOVE in the sub=
ject line


-- 
This email has been checked for viruses by AVG.
https://www.avg.com

--4A5l7DZJxB5uBTpgDspNl1i6Vf=_3DzUwo
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
    <div dir=3D"ltr">
      <div>
        <div>* Published by Springer in&nbsp;a book of the AISC series</div=
>
        <div>* SCIMago H-Index =3D 34<br /></div>
        <div>* Indexed in Scopus, WoS, DBLP, Ei-Compendex, etc</div>
      </div>
      <div><br /></div>
      <div>------------------------------------- 
        <wbr>&nbsp;</wbr>&nbsp;&nbsp;------------------------------------ 
        <wbr>&nbsp;</wbr>&nbsp;&nbsp;----------- 
      </div>ICITS'21 - 4th International Conference on Information Technolo=
gy &amp; Systems<br />4 - 6 February 2021 | Peninsula de Santa Elena, Ecuad=
or<br /><a href=3D"http://www.icits.me/" target=3D"_blank" data-saferedirec=
turl=3D"https://www.google.com/url?q=3Dhttp://www.icits.me/&source=3Dgmail&=
ust=3D1594645922276000&usg=3DAFQjCNG72Fdl_4RlHj0rqlAgkSrBbssDNw">http://www=
=2Eicits.me/</a><br />
      <div>----------------------------------- 
        <wbr>&nbsp;</wbr>&nbsp;&nbsp;------------------------------------- =

        <wbr>&nbsp;</wbr>&nbsp;&nbsp;------------------------- 
      </div><br />ICITS'21 - The 2021 International Conference on Informati=
on Technology &amp; Systems, to be held in Pen&iacute;nsula de Santa Elena,=
 Ecuador, 4 - 6 February 2021, is an international forum for researchers an=
d practitioners to present and discuss the most recent innovations, trends,=
 results, experiences and concerns in the several perspectives of Informati=
on Technology &amp; Systems. <br /><br />We are pleased to invite you to su=
bmit your papers to ICITS'21. They can be written in English, Spanish or Po=
rtuguese. All submissions will be reviewed on the basis of relevance, origi=
nality, importance and clarity. <br />
      <div><br /></div>
      <div><br /></div>
      <div>TOPICS</div>
      <div><br /></div>
      <div>Submitted papers should be related with one or more of the main =
themes proposed for the Conference:</div><br />A) Information and Knowledge=
 Management (IKM); <br />B) Organizational Models and Information Systems (=
OMIS); <br />C) Software and Systems Modeling (SSM); <br />D) Software Syst=
ems, Architectures, Applications and Tools (SSAAT); <br />E) Multimedia Sys=
tems and Applications (MSA); <br />F) Computer Networks, Mobility and Perva=
sive Systems (CNMPS); <br />G) Intelligent and Decision Support Systems (ID=
SS); <br />H) Big Data Analytics and Applications (BDAA); <br />I) Human-Co=
mputer Interaction (HCI); <br />J) Ethics, Computers and Security (ECS) <br=
 />K) Health Informatics (HIS); <br />L) Information Technologies in Educat=
ion (ITE); <br />&nbsp;<br /><br />SUBMISSION AND DECISION <br /><br />Subm=
itted papers written in English (until 10-page limit) must comply with the =
format of Advances in Intelligent Systems and Computing series (see Instruc=
tions for Authors at Springer Website), must not have been published before=
, not be under review for any other conference or publication and not inclu=
de any information leading to the authors&rsquo; identification. Therefore,=
 the authors&rsquo; names and affiliations should not be included in the ve=
rsion for evaluation by the Scientific Committee. This information should o=
nly be included in the camera-ready version, saved in Word or Latex format =
and also in PDF format. These files must be accompanied by the Consent to P=
ublish form filled out, in a ZIP file, and uploaded at the conference manag=
ement system. <br /><br />Submitted papers written in Spanish or Portuguese=
 (until 15-page limit) must comply with the format of RISTI - Revista Ib&ea=
cute;rica de Sistemas e Tecnologias de Informa&ccedil;&atilde;o (download i=
nstructions/template for authors in Spanish or Portuguese), must not have b=
een published before, not be under review for any other conference or publi=
cation and not include any information leading to the authors&rsquo; identi=
fication. Therefore, the authors&rsquo; names and affiliations should not b=
e included in the version for evaluation by the Scientific Committee. This =
information should only be included in the camera-ready version, saved in W=
ord. These files must be uploaded at the conference management system in a =
ZIP file. <br /><br />All papers will be subjected to a &ldquo;double-blind=
 review&rdquo; by at least two members of the Scientific Committee. <br /><=
br />Based on Scientific Committee evaluation, a paper can be rejected or a=
ccepted by the Conference Chairs. In the later case, it can be accepted as =
paper or poster. <br /><br />The authors of papers accepted as posters must=
 build and print a poster to be exhibited during the Conference. This poste=
r must follow an A1 or A2 vertical format. The Conference can include Work =
Sessions where these posters are presented and orally discussed, with a 7 m=
inute limit per poster. <br /><br />The authors of accepted papers will hav=
e 15 minutes to present their work in a Conference Work Session; approximat=
ely 5 minutes of discussion will follow each presentation. <br /><br /><br =
/>PUBLICATION AND INDEXING<br /><br />Papers accepted as posters are not pu=
blished; they are only exhibited, presented and discussed during the confer=
ence. <br /><br />To ensure that a paper accepted as paper is published, at=
 least one of the authors must be fully registered by the 6th of November 2=
020, and the paper must comply with the suggested layout and page-limit. Ad=
ditionally, all recommended changes must be addressed by the authors before=
 they submit the camera-ready version. <br /><br />No more than one paper p=
er registration will be published. An extra fee must be paid for publicatio=
n of additional papers, with a maximum of one additional paper per registra=
tion. One registration permits only the participation of one author in the =
conference. <br /><br />Papers written in English and accepted and register=
ed will be published in Proceedings by Springer, in a book of the Advances =
in Intelligent Systems and Computing series, will &nbsp;be submitted for in=
dexation by ISI, EI-Compendex, SCOPUS and DBLP, among others, and will be a=
vailable in the SpringerLink Digital Library. <br /><br />Papers written in=
 Spanish or Portuguese and accepted and registered will be published in a S=
pecial Issue of RISTI and will be submitted for indexation by SCOPUS, among=
 others. <br /><br /><br />IMPORTANT DATES<br /><br />Paper Submission: Sep=
tember 6, 2020 <br /><br />Notification of Acceptance: October 18, 2020 <br=
 /><br />Payment of Registration, to ensure the inclusion of an accepted pa=
per in the conference proceedings: November 6, 2020. <br /><br />Camera-rea=
dy Submission: November 6, 2020<br />
      <div><br /></div>
      <div><br /></div>Website of ICITS'21: <a href=3D"http://www.icits.me/=
" target=3D"_blank" data-saferedirecturl=3D"https://www.google.com/url?q=3D=
http://www.icits.me/&source=3Dgmail&ust=3D1594645922276000&usg=3DAFQjCNG72F=
dl_4RlHj0rqlAgkSrBbssDNw">http://www.icits.me/</a> <br /><br />ICITS'21 Tea=
m<br /><a href=3D"http://www.icits.me/" target=3D"_blank" data-saferedirect=
url=3D"https://www.google.com/url?q=3Dhttp://www.icits.me/&source=3Dgmail&u=
st=3D1594645922276000&usg=3DAFQjCNG72Fdl_4RlHj0rqlAgkSrBbssDNw">http://www.=
icits.me/</a> 
    </div>
    <p>&nbsp;</p>
    <p>--------------</p>
    <div itemprop=3D"articleBody">
      <p>PS: If you do not wish to receive more notices from ICITS (<a href=
=3D"http://icits.me/">http://icits.me</a>) just reply this message with the=
 word REMOVE in the subject line</p>
    </div>
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

--4A5l7DZJxB5uBTpgDspNl1i6Vf=_3DzUwo--


--===============4982636446264089392==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============4982636446264089392==--

