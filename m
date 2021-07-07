Return-Path: <SRS0=rr22=L7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A697DC07E95
	for <virtualization@archiver.kernel.org>; Wed,  7 Jul 2021 14:27:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5509561997
	for <virtualization@archiver.kernel.org>; Wed,  7 Jul 2021 14:27:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5509561997
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1D33A606A2;
	Wed,  7 Jul 2021 14:27:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bVWblNFaiEU4; Wed,  7 Jul 2021 14:27:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2A1F560621;
	Wed,  7 Jul 2021 14:27:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E7E1AC0010;
	Wed,  7 Jul 2021 14:27:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E240FC000E
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Jul 2021 14:27:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B5DAB401BB
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Jul 2021 14:27:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LcLQGXWq_qtm
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Jul 2021 14:27:36 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from s052d7dde.fastvps-server.com (s052d7dde.fastvps-server.com
 [IPv6:2a03:f480:1:14::7d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id ECCF74002B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Jul 2021 14:27:35 +0000 (UTC)
Received: from b612.uc.pt ([193.137.201.233] helo=LAPTOP-EPOV2LRR)
 by s052d7dde.fastvps-server.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <marle@saisti.eu>) id 1m17mG-0001lE-SB
 for virtualization@lists.linux-foundation.org; Wed, 07 Jul 2021 16:39:48 +0300
From: "ML" <marialemos72@gmail.com>
Subject: ICITS'22 - The 2022 International Conference on Information
 Technology & Systems | Costa Rica
To: virtualization@lists.linux-foundation.org
MIME-Version: 1.0
Date: Wed, 7 Jul 2021 14:39:49 +0100
Message-ID: <11908428110703@gmail-com>
X-Antivirus: AVG (VPS 210707-0, 7/7/2021), Outbound message
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
Content-Type: multipart/mixed; boundary="===============6363312924797668499=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

This is a multi-part message in MIME format

--===============6363312924797668499==
Content-Type: multipart/alternative; charset=utf-8; boundary="lyTOWP6B7jz3pVi3LbS=_HDEubOfh0Qj5Y"

This is a multi-part message in MIME format

--lyTOWP6B7jz3pVi3LbS=_HDEubOfh0Qj5Y
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

------------------------------  ------------------------------  -----------=
-------------------  -----------------------------
ICITS'22 - The 2022 International Conference on Information Technology & Sy=
stems

San Carlos, Costa Rica, 9 - 11 February 2022

http://icits.me <http://icits.me/>
------------------------------  ------------------------------  -----------=
-------------------  ------------------------------


SCOPE

ICITS'22 - The 2022 International Conference on Information Technology
& Systems (http://icits.me <http://icits.me/>), to be held in Tecnol=C3=B3g=
ico de Costa Rica,
Campus de San Carlos, Costa Rica, 9 - 11 February 2022, is an
international forum for researchers and practitioners to present and
discuss the most recent innovations, trends, results, experiences and
concerns in the several perspectives of Information Technology &
Systems.

We are pleased to invite you to submit your papers to ICITS'22. They
can be written in English, Spanish or Portuguese. All submissions will
be reviewed on the basis of relevance, originality, importance and
clarity.



TOPICS

Submitted papers should be related with one or more of the main themes
proposed for the Conference:

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



SUBMISSION AND DECISION

Submitted papers written in English (until 10-page limit) must comply
with the format of the Lecture Notes in Networks and Systems series
(see Instructions for Authors at Springer Website), must not have been
published before, not be under review for any other conference or
publication and not include any information leading to the authors=E2=80=99=

identification. Therefore, the authors=E2=80=99 names and affiliations shou=
ld
not be included in the version for evaluation by the Scientific
Committee. This information should only be included in the
camera-ready version, saved in Word or Latex format and also in PDF
format. These files must be accompanied by the Consent to Publish form
filled out, in a ZIP file, and uploaded at the conference management
system.

Submitted papers written in Spanish or Portuguese (until 15-page
limit) must comply with the format of RISTI - Revista Ib=C3=A9rica de
Sistemas e Tecnologias de Informa=C3=A7=C3=A3o (download instructions/templ=
ate
for authors in Spanish or Portuguese), must not have been published
before, not be under review for any other conference or publication
and not include any information leading to the authors=E2=80=99
identification. Therefore, the authors=E2=80=99 names and affiliations shou=
ld
not be included in the version for evaluation by the Scientific
Committee. This information should only be included in the
camera-ready version, saved in Word. These files must be uploaded at
the conference management system in a ZIP file.

All papers will be subjected to a =E2=80=9Cdouble-blind review=E2=80=9D by =
at least
two members of the Scientific Committee.

Based on Scientific Committee evaluation, a paper can be rejected or
accepted by the Conference Chairs. In the later case, it can be
accepted as paper or poster.

The authors of papers accepted as posters must build and print a
poster to be exhibited during the Conference. This poster must follow
an A1 or A2 vertical format. The Conference can include Work Sessions
where these posters are presented and orally discussed, with a 7
minute limit per poster.

The authors of accepted papers will have 15 minutes to present their
work in a Conference Work Session; approximately 5 minutes of
discussion will follow each presentation.



PUBLICATION AND INDEXING

Papers accepted as posters are not published; they are only exhibited,
presented and discussed during the conference.

To ensure that a paper accepted as paper is published, at least one of
the authors must be fully registered by the 5th of November 2021, and
the paper must comply with the suggested layout and page-limit.
Additionally, all recommended changes must be addressed by the authors
before they submit the camera-ready version.

No more than one paper per registration will be published. An extra
fee must be paid for publication of additional papers, with a maximum
of one additional paper per registration. One registration permits
only the participation of one author in the conference.

Papers written in English and accepted and registered will be
published in Proceedings by Springer, in a book of the Lecture Notes
in Networks and Systems series, will  be submitted for indexation by
SCOPUS, WoS, Google Scholar, SCImago, among others, and will be
available in the SpringerLink Digital Library.

Papers written in Spanish or Portuguese and accepted and registered
will be published in a Special Issue of RISTI and will be submitted
for indexation by SCOPUS, among others.



IMPORTANT DATES

Paper Submission: September 5, 2021

Notification of Acceptance: October 17, 2021

Payment of Registration, to ensure the inclusion of an accepted paper
in the conference proceedings: November 5, 2021.

Camera-ready Submission: November 5, 2021



Website of ICITS'22: http://icits.me <http://icits.me/>


ICITS'22 Team
http://icits.me <http://icits.me> 
 
 
 


-- 
This email has been checked for viruses by AVG.
https://www.avg.com

--lyTOWP6B7jz3pVi3LbS=_HDEubOfh0Qj5Y
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
    <div class=3D"adn ads" data-legacy-message-id=3D"17a812a84db16fcf" data=
-message-id=3D"#msg-a:r-1499474762405574081">
      <div class=3D"gs">
        <div>
          <div id=3D":19a" class=3D"ii gt">
            <div id=3D":199" class=3D"a3s aiL ">---------------------------=
---
              <wbr>&nbsp;</wbr>------------------------------
              <wbr>&nbsp;</wbr>------------------------------
              <wbr>&nbsp;</wbr>-----------------------------<br />ICITS'22 =
- The 2022 International Conference on Information Technology &amp; Systems=
<br /><br />San Carlos, Costa Rica, 9 - 11 February 2022<br /><br /><a href=
=3D"http://icits.me/" rel=3D"noreferrer" target=3D"_blank" data-saferedirec=
turl=3D"https://www.google.com/url?q=3Dhttp://icits.me&source=3Dgmail&ust=
=3D1625751097078000&usg=3DAFQjCNHZudzUex040ZSHVQt__S5EeuF3hQ">http://icits.=
me</a><br />------------------------------
              <wbr>&nbsp;</wbr>------------------------------
              <wbr>&nbsp;</wbr>------------------------------
              <wbr>&nbsp;</wbr>------------------------------<br /><br /><b=
r />SCOPE<br /><br />ICITS'22 - The 2022 International Conference on Inform=
ation Technology<br />&amp; Systems (<a href=3D"http://icits.me/" rel=3D"no=
referrer" target=3D"_blank" data-saferedirecturl=3D"https://www.google.com/=
url?q=3Dhttp://icits.me&source=3Dgmail&ust=3D1625751097078000&usg=3DAFQjCNH=
ZudzUex040ZSHVQt__S5EeuF3hQ">http://icits.me</a>), to be held in Tecnol&oac=
ute;gico de Costa Rica,<br />Campus de San Carlos, Costa Rica, 9 - 11 Febru=
ary 2022, is an<br />international forum for researchers and practitioners =
to present and<br />discuss the most recent innovations, trends, results, e=
xperiences and<br />concerns in the several perspectives of Information Tec=
hnology &amp;<br />Systems.<br /><br />We are pleased to invite you to subm=
it your papers to ICITS'22. They<br />can be written in English, Spanish or=
 Portuguese. All submissions will<br />be reviewed on the basis of relevanc=
e, originality, importance and<br />clarity.<br /><br /><br /><br />TOPICS<=
br /><br />Submitted papers should be related with one or more of the main =
themes<br />proposed for the Conference:<br /><br />A) Information and Know=
ledge Management (IKM);<br /><br />B) Organizational Models and Information=
 Systems (OMIS);<br /><br />C) Software and Systems Modeling (SSM);<br /><b=
r />D) Software Systems, Architectures, Applications and Tools (SSAAT);<br =
/><br />E) Multimedia Systems and Applications (MSA);<br /><br />F) Compute=
r Networks, Mobility and Pervasive Systems (CNMPS);<br /><br />G) Intellige=
nt and Decision Support Systems (IDSS);<br /><br />H) Big Data Analytics an=
d Applications (BDAA);<br /><br />I) Human-Computer Interaction (HCI);<br /=
><br />J) Ethics, Computers and Security (ECS)<br /><br />K) Health Informa=
tics (HIS);<br /><br />L) Information Technologies in Education (ITE);<br /=
><br />M) Media, Applied Technology and Communication (MATC).<br /><br /><b=
r /><br />SUBMISSION AND DECISION<br /><br />Submitted papers written in En=
glish (until 10-page limit) must comply<br />with the format of the Lecture=
 Notes in Networks and Systems series<br />(see Instructions for Authors at=
 Springer Website), must not have been<br />published before, not be under =
review for any other conference or<br />publication and not include any inf=
ormation leading to the authors&rsquo;<br />identification. Therefore, the =
authors&rsquo; names and affiliations should<br />not be included in the ve=
rsion for evaluation by the Scientific<br />Committee. This information sho=
uld only be included in the<br />camera-ready version, saved in Word or Lat=
ex format and also in PDF<br />format. These files must be accompanied by t=
he Consent to Publish form<br />filled out, in a ZIP file, and uploaded at =
the conference management<br />system.<br /><br />Submitted papers written =
in Spanish or Portuguese (until 15-page<br />limit) must comply with the fo=
rmat of RISTI - Revista Ib&eacute;rica de<br />Sistemas e Tecnologias de In=
forma&ccedil;&atilde;o (download instructions/template<br />for authors in =
Spanish or Portuguese), must not have been published<br />before, not be un=
der review for any other conference or publication<br />and not include any=
 information leading to the authors&rsquo;<br />identification. Therefore, =
the authors&rsquo; names and affiliations should<br />not be included in th=
e version for evaluation by the Scientific<br />Committee. This information=
 should only be included in the<br />camera-ready version, saved in Word. T=
hese files must be uploaded at<br />the conference management system in a Z=
IP file.<br /><br />All papers will be subjected to a &ldquo;double-blind r=
eview&rdquo; by at least<br />two members of the Scientific Committee.<br /=
><br />Based on Scientific Committee evaluation, a paper can be rejected or=
<br />accepted by the Conference Chairs. In the later case, it can be<br />=
accepted as paper or poster.<br /><br />The authors of papers accepted as p=
osters must build and print a<br />poster to be exhibited during the Confer=
ence. This poster must follow<br />an A1 or A2 vertical format. The Confere=
nce can include Work Sessions<br />where these posters are presented and or=
ally discussed, with a 7<br />minute limit per poster.<br /><br />The autho=
rs of accepted papers will have 15 minutes to present their<br />work in a =
Conference Work Session; approximately 5 minutes of<br />discussion will fo=
llow each presentation.<br /><br /><br /><br />PUBLICATION AND INDEXING<br =
/><br />Papers accepted as posters are not published; they are only exhibit=
ed,<br />presented and discussed during the conference.<br /><br />To ensur=
e that a paper accepted as paper is published, at least one of<br />the aut=
hors must be fully registered by the 5th of November 2021, and<br />the pap=
er must comply with the suggested layout and page-limit.<br />Additionally,=
 all recommended changes must be addressed by the authors<br />before they =
submit the camera-ready version.<br /><br />No more than one paper per regi=
stration will be published. An extra<br />fee must be paid for publication =
of additional papers, with a maximum<br />of one additional paper per regis=
tration. One registration permits<br />only the participation of one author=
 in the conference.<br /><br />Papers written in English and accepted and r=
egistered will be<br />published in Proceedings by Springer, in a book of t=
he Lecture Notes<br />in Networks and Systems series, will&nbsp; be submitt=
ed for indexation by<br />SCOPUS, WoS, Google Scholar, SCImago, among other=
s, and will be<br />available in the SpringerLink Digital Library.<br /><br=
 />Papers written in Spanish or Portuguese and accepted and registered<br /=
>will be published in a Special Issue of RISTI and will be submitted<br />f=
or indexation by SCOPUS, among others.<br /><br /><br /><br />IMPORTANT DAT=
ES<br /><br />Paper Submission: September 5, 2021<br /><br />Notification o=
f Acceptance: October 17, 2021<br /><br />Payment of Registration, to ensur=
e the inclusion of an accepted paper<br />in the conference proceedings: No=
vember 5, 2021.<br /><br />Camera-ready Submission: November 5, 2021<br /><=
br /><br /><br />Website of ICITS'22: <a href=3D"http://icits.me/" rel=3D"n=
oreferrer" target=3D"_blank" data-saferedirecturl=3D"https://www.google.com=
/url?q=3Dhttp://icits.me&source=3Dgmail&ust=3D1625751097078000&usg=3DAFQjCN=
HZudzUex040ZSHVQt__S5EeuF3hQ">http://icits.me</a><br /><br /><br />ICITS'22=
 Team<br /><a href=3D"http://icits.me" rel=3D"noreferrer" target=3D"_blank"=
 data-saferedirecturl=3D"https://www.google.com/url?q=3Dhttp://icits.me&sou=
rce=3Dgmail&ust=3D1625751097078000&usg=3DAFQjCNHZudzUex040ZSHVQt__S5EeuF3hQ=
">http://icits.me</a>
            </div>
            <div class=3D"a3s aiL ">&nbsp;</div>
            <div class=3D"a3s aiL ">&nbsp;</div>
            <div class=3D"a3s aiL ">&nbsp;</div>
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

--lyTOWP6B7jz3pVi3LbS=_HDEubOfh0Qj5Y--


--===============6363312924797668499==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============6363312924797668499==--

