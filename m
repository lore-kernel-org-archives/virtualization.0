Return-Path: <SRS0=8Uya=NJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 719EBC4338F
	for <virtualization@archiver.kernel.org>; Wed, 18 Aug 2021 13:17:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21F266108E
	for <virtualization@archiver.kernel.org>; Wed, 18 Aug 2021 13:17:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 21F266108E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DAEBC6074F;
	Wed, 18 Aug 2021 13:17:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NTCBiVKjVcjh; Wed, 18 Aug 2021 13:17:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D18D4606B1;
	Wed, 18 Aug 2021 13:17:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A3672C001A;
	Wed, 18 Aug 2021 13:17:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ED6ECC000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Aug 2021 13:17:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CE326401C7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Aug 2021 13:17:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wRy0E85Zv4_Q
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Aug 2021 13:17:00 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from s052d7dde.fastvps-server.com (s052d7dde.fastvps-server.com
 [IPv6:2a03:f480:1:14::7d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 01FF340101
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Aug 2021 13:16:59 +0000 (UTC)
Received: from [37.189.17.205] (helo=LAPTOP-EPOV2LRR)
 by s052d7dde.fastvps-server.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <marle@saisti.eu>) id 1mGKtK-0008Em-7I
 for virtualization@lists.linux-foundation.org; Wed, 18 Aug 2021 15:41:58 +0300
From: "ML" <marialemos72@gmail.com>
Subject: ICITS'22 - The 2022 International Conference on Information
 Technology & Systems | Costa Rica
To: virtualization@lists.linux-foundation.org
MIME-Version: 1.0
Date: Wed, 18 Aug 2021 13:41:58 +0100
Message-ID: <7924518627203@gmail-com>
X-Antivirus: AVG (VPS 210816-2, 16/8/2021), Outbound message
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
Content-Type: multipart/mixed; boundary="===============8866488840977216690=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

This is a multi-part message in MIME format

--===============8866488840977216690==
Content-Type: multipart/alternative; charset=utf-8; boundary="ZM43L69OLRKDfN7O1zag=_WJboXeNKfwOz"

This is a multi-part message in MIME format

--ZM43L69OLRKDfN7O1zag=_WJboXeNKfwOz
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

---------------------------------------------------------------------------=
-----------------------------------------
ICITS'22 - The 2022 International Conference on Information Technology & Sy=
stems
San Carlos, Costa Rica, 9 - 11 February 2022
http://icits.me <http://icits.me>
---------------------------------------------------------------------------=
-----------------------------------------
 
SCOPE
 
ICITS'22 - The 2022 International Conference on Information Technology & Sy=
stems (http://icits.me <http://icits.me>), to be held in Tecnol=C3=B3gico d=
e Costa Rica, Campus de San Carlos, Costa Rica, 9 - 11 February 2022, is an=
 international forum for researchers and practitioners to present and discu=
ss the most recent innovations, trends, results, experiences and concerns i=
n the several perspectives of Information Technology & Systems.  
 
We are pleased to invite you to submit your papers to ICITS'22. They can be=
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
M) Media, Applied Technology and Communication (MATC).
 
 
SUBMISSION and DECISION
 
Submitted papers written in English (until 10-page limit) must comply with =
the format of the Lecture Notes in Networks and Systems series (see Instruc=
tions for Authors at Springer Website), must not have been published before=
, not be under review for any other conference or publication and not inclu=
de any information leading to the authors=E2=80=99 identification. Therefor=
e, the authors=E2=80=99 names and affiliations should not be included in th=
e version for evaluation by the Scientific Committee. This information shou=
ld only be included in the camera-ready version, saved in Word or Latex for=
mat and also in PDF format. These files must be accompanied by the Consent =
to Publish form filled out, in a ZIP file, and uploaded at the conference m=
anagement system.
  
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
 
 
PUBLICATION and INDEXING  
 
Papers accepted as posters are not published; they are only exhibited, pres=
ented and discussed during the conference.  
 
To ensure that a paper accepted as paper is published, at least one of the =
authors must be fully registered by the 5th of November 2021, and the paper=
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
l Library.  
 
Papers written in Spanish or Portuguese and accepted and registered will be=
 published in a Special Issue of RISTI and will be submitted for indexation=
 by SCOPUS, among others.
 
 
IMPORTANT DATES
 
Paper Submission: September 5, 2021  
 
Notification of Acceptance: October 17, 2021  
 
Payment of Registration, to ensure the inclusion of an accepted paper in th=
e conference proceedings: November 5, 2021.  
 
Camera-ready Submission: November 5, 2021
 
 
Website of ICITS'22: http://icits.me <http://icits.me>
 
 
ICITS'22 Team
http://icits.me <http://icits.me>


-- 
This email has been checked for viruses by AVG.
https://www.avg.com

--ZM43L69OLRKDfN7O1zag=_WJboXeNKfwOz
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
    <div class=3D"adn ads" data-message-id=3D"#msg-a:r-1499474762405574081"=
 data-legacy-message-id=3D"17a812a84db16fcf">
      <div class=3D"gs">
        <div>
          <div id=3D":19a" class=3D"ii gt">
            <div id=3D":199" class=3D"a3s aiL ">---------------------------=
---------------------------------------------------------------------------=
--------------</div>
            <div class=3D"a3s aiL ">ICITS'22 - The 2022 International Confe=
rence on Information Technology &amp; Systems</div>
            <div class=3D"a3s aiL ">San Carlos, Costa Rica, 9 - 11 February=
 2022</div>
            <div class=3D"a3s aiL "><a href=3D"http://icits.me">http://icit=
s.me</a><br />-------------------------------------------------------------=
-------------------------------------------------------<br />&nbsp;</div>
            <div class=3D"a3s aiL ">SCOPE</div>
            <div class=3D"a3s aiL ">&nbsp;</div>
            <div class=3D"a3s aiL ">ICITS'22 - The 2022 International Confe=
rence on Information Technology &amp; Systems (<a href=3D"http://icits.me">=
http://icits.me</a>), to be held in Tecnol&oacute;gico de Costa Rica, Campu=
s de San Carlos, Costa Rica, 9 - 11 February 2022, is an international foru=
m for researchers and practitioners to present and discuss the most recent =
innovations, trends, results, experiences and concerns in the several persp=
ectives of Information Technology &amp; Systems.&nbsp; </div>
            <div class=3D"a3s aiL ">&nbsp;</div>
            <div class=3D"a3s aiL ">We are pleased to invite you to submit =
your papers to ICITS'22. They can be written in English, Spanish or Portugu=
ese. All submissions will be reviewed on the basis of relevance, originalit=
y, importance and clarity.<br />&nbsp;</div>
            <div class=3D"a3s aiL ">&nbsp;</div>
            <div class=3D"a3s aiL ">TOPICS</div>
            <div class=3D"a3s aiL ">&nbsp;</div>
            <div class=3D"a3s aiL ">Submitted papers should be related with=
 one or more of the main themes proposed for the Conference:&nbsp; </div>
            <div class=3D"a3s aiL ">&nbsp;</div>
            <div class=3D"a3s aiL ">A) Information and Knowledge Management=
 (IKM);&nbsp; </div>
            <div class=3D"a3s aiL ">B) Organizational Models and Informatio=
n Systems (OMIS);&nbsp; </div>
            <div class=3D"a3s aiL ">C) Software and Systems Modeling (SSM);=
&nbsp; </div>
            <div class=3D"a3s aiL ">D) Software Systems, Architectures, App=
lications and Tools (SSAAT);&nbsp; </div>
            <div class=3D"a3s aiL ">E) Multimedia Systems and Applications =
(MSA);&nbsp; </div>
            <div class=3D"a3s aiL ">F) Computer Networks, Mobility and Perv=
asive Systems (CNMPS);&nbsp; </div>
            <div class=3D"a3s aiL ">G) Intelligent and Decision Support Sys=
tems (IDSS);&nbsp; </div>
            <div class=3D"a3s aiL ">H) Big Data Analytics and Applications =
(BDAA);&nbsp; </div>
            <div class=3D"a3s aiL ">I) Human-Computer Interaction (HCI);&nb=
sp; </div>
            <div class=3D"a3s aiL ">J) Ethics, Computers and Security (ECS)=
&nbsp; </div>
            <div class=3D"a3s aiL ">K) Health Informatics (HIS);&nbsp; </di=
v>
            <div class=3D"a3s aiL ">L) Information Technologies in Educatio=
n (ITE);&nbsp; </div>
            <div class=3D"a3s aiL ">M) Media, Applied Technology and Commun=
ication (MATC).<br />&nbsp;</div>
            <div class=3D"a3s aiL ">&nbsp;</div>
            <div class=3D"a3s aiL ">SUBMISSION and DECISION</div>
            <div class=3D"a3s aiL ">&nbsp;</div>
            <div class=3D"a3s aiL ">Submitted papers written in English (un=
til 10-page limit) must comply with the format of the Lecture Notes in Netw=
orks and Systems series (see Instructions for Authors at Springer Website),=
 must not have been published before, not be under review for any other con=
ference or publication and not include any information leading to the autho=
rs&rsquo; identification. Therefore, the authors&rsquo; names and affiliati=
ons should not be included in the version for evaluation by the Scientific =
Committee. This information should only be included in the camera-ready ver=
sion, saved in Word or Latex format and also in PDF format. These files mus=
t be accompanied by the Consent to Publish form filled out, in a ZIP file, =
and uploaded at the conference management system.</div>
            <div class=3D"a3s aiL ">&nbsp; </div>
            <div class=3D"a3s aiL ">Submitted papers written in Spanish or =
Portuguese (until 15-page limit) must comply with the format of RISTI - Rev=
ista Ib&eacute;rica de Sistemas e Tecnologias de Informa&ccedil;&atilde;o (=
download instructions/template for authors in Spanish or Portuguese), must =
not have been published before, not be under review for any other conferenc=
e or publication and not include any information leading to the authors&rsq=
uo; identification. Therefore, the authors&rsquo; names and affiliations sh=
ould not be included in the version for evaluation by the Scientific Commit=
tee. This information should only be included in the camera-ready version, =
saved in Word. These files must be uploaded at the conference management sy=
stem in a ZIP file.</div>
            <div class=3D"a3s aiL ">&nbsp; </div>
            <div class=3D"a3s aiL ">All papers will be subjected to a &ldqu=
o;double-blind review&rdquo; by at least two members of the Scientific Comm=
ittee.&nbsp; </div>
            <div class=3D"a3s aiL ">Based on Scientific Committee evaluatio=
n, a paper can be rejected or accepted by the Conference Chairs. In the lat=
er case, it can be accepted as paper or poster.</div>
            <div class=3D"a3s aiL ">&nbsp; </div>
            <div class=3D"a3s aiL ">The authors of papers accepted as poste=
rs must build and print a poster to be exhibited during the Conference. Thi=
s poster must follow an A1 or A2 vertical format. The Conference can includ=
e Work Sessions where these posters are presented and orally discussed, wit=
h a 7 minute limit per poster.</div>
            <div class=3D"a3s aiL ">&nbsp; </div>
            <div class=3D"a3s aiL ">The authors of accepted papers will hav=
e 15 minutes to present their work in a Conference Work Session; approximat=
ely 5 minutes of discussion will follow each presentation.<br />&nbsp;</div=
>
            <div class=3D"a3s aiL ">&nbsp;</div>
            <div class=3D"a3s aiL ">PUBLICATION and INDEXING&nbsp; </div>
            <div class=3D"a3s aiL ">&nbsp;</div>
            <div class=3D"a3s aiL ">Papers accepted as posters are not publ=
ished; they are only exhibited, presented and discussed during the conferen=
ce.&nbsp; </div>
            <div class=3D"a3s aiL ">&nbsp;</div>
            <div class=3D"a3s aiL ">To ensure that a paper accepted as pape=
r is published, at least one of the authors must be fully registered by the=
 5th of November 2021, and the paper must comply with the suggested layout =
and page-limit. Additionally, all recommended changes must be addressed by =
the authors before they submit the camera-ready version.&nbsp; </div>
            <div class=3D"a3s aiL ">No more than one paper per registration=
 will be published. An extra fee must be paid for publication of additional=
 papers, with a maximum of one additional paper per registration. One regis=
tration permits only the participation of one author in the conference.&nbs=
p; </div>
            <div class=3D"a3s aiL ">&nbsp;</div>
            <div class=3D"a3s aiL ">Papers written in English and accepted =
and registered will be published in Proceedings by Springer, in a book of t=
he Lecture Notes in Networks and Systems series, will&nbsp; be submitted fo=
r indexation by SCOPUS, WoS, Google Scholar, SCImago, among others, and wil=
l be available in the SpringerLink Digital Library.&nbsp; </div>
            <div class=3D"a3s aiL ">&nbsp;</div>
            <div class=3D"a3s aiL ">Papers written in Spanish or Portuguese=
 and accepted and registered will be published in a Special Issue of RISTI =
and will be submitted for indexation by SCOPUS, among others.<br />&nbsp;</=
div>
            <div class=3D"a3s aiL ">&nbsp;</div>
            <div class=3D"a3s aiL ">IMPORTANT DATES</div>
            <div class=3D"a3s aiL ">&nbsp;</div>
            <div class=3D"a3s aiL ">Paper Submission: September 5, 2021&nbs=
p; </div>
            <div class=3D"a3s aiL ">&nbsp;</div>
            <div class=3D"a3s aiL ">Notification of Acceptance: October 17,=
 2021&nbsp; </div>
            <div class=3D"a3s aiL ">&nbsp;</div>
            <div class=3D"a3s aiL ">Payment of Registration, to ensure the =
inclusion of an accepted paper in the conference proceedings: November 5, 2=
021.&nbsp; </div>
            <div class=3D"a3s aiL ">&nbsp;</div>
            <div class=3D"a3s aiL ">Camera-ready Submission: November 5, 20=
21<br />&nbsp;<br />&nbsp;<br />Website of ICITS'22: <a href=3D"http://icit=
s.me">http://icits.me</a><br />&nbsp;<br />&nbsp;<br />ICITS'22 Team<br /><=
a href=3D"http://icits.me">http://icits.me</a></div>
          </div>
        </div>
      </div>
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

--ZM43L69OLRKDfN7O1zag=_WJboXeNKfwOz--


--===============8866488840977216690==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============8866488840977216690==--

