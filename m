Return-Path: <SRS0=15I4=NC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70DD2C4338F
	for <virtualization@archiver.kernel.org>; Wed, 11 Aug 2021 09:03:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09E3D60FC4
	for <virtualization@archiver.kernel.org>; Wed, 11 Aug 2021 09:03:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 09E3D60FC4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A3E7D83903;
	Wed, 11 Aug 2021 09:03:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3D_kShwH3pCW; Wed, 11 Aug 2021 09:02:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E44DF837C0;
	Wed, 11 Aug 2021 09:02:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 93309C000E;
	Wed, 11 Aug 2021 09:02:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5FA02C001A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 09:02:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3CC8B404F2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 09:02:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xUd8QcJ3mJyH
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 09:02:49 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from s052d7dde.fastvps-server.com (s052d7dde.fastvps-server.com
 [IPv6:2a03:f480:1:14::7d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8A6ED401EF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 09:02:49 +0000 (UTC)
Received: from [37.189.17.205] (helo=LAPTOP-EPOV2LRR)
 by s052d7dde.fastvps-server.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <marle@saisti.eu>) id 1mDjdX-0003X9-Nc
 for virtualization@lists.linux-foundation.org; Wed, 11 Aug 2021 11:30:55 +0300
From: "ML" <marialemos72@gmail.com>
Subject: [WorldCIST'22]: Call for Workshops Proposals
To: virtualization@lists.linux-foundation.org
MIME-Version: 1.0
Date: Wed, 11 Aug 2021 09:30:56 +0100
Message-ID: <201081173628265@gmail-com>
X-Antivirus: AVG (VPS 210810-14, 10/8/2021), Outbound message
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
Content-Type: multipart/mixed; boundary="===============6335896275178784714=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

This is a multi-part message in MIME format

--===============6335896275178784714==
Content-Type: multipart/alternative; charset=utf-8; boundary="nFN7cmn0QjpB=_QOkEqVNfrY3ZyiulKsEi"

This is a multi-part message in MIME format

--nFN7cmn0QjpB=_QOkEqVNfrY3ZyiulKsEi
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

---------------------------------------------

Call for Workshops Proposals 

WorldCist'22 - 10th World Conference on Information Systems and Technologie=
s

Budva, Montenegro, 12 - 14 April 2022

http://worldcist.org/ <http://worldcist.org/>

---------------------------------------------------------------------------=
-----------------------------------------

The Information Systems and Technologies research and industrial community =
is invited to submit proposals for the organization of Workshops at WorldCi=
st'22 - 10th World Conference on Information Systems and Technologies, to b=
e held in Budva, Montenegro, 12-14 April 2022. WorldCist is a global forum =
for researchers and practitioners to present and discuss the most recent in=
novations, trends, results, experiences and concerns in the several perspec=
tives of Information Systems and Technologies.


WORKSHOP FORMAT

Workshops should focus on a specific scientific subject on the scope of Wor=
ldCist'22 but not directly included on the main conference areas. Each work=
shop will be coordinated by an Organizing Committee composed of, at least, =
two researchers in the field, preferably from different institutions and di=
fferent countries. The organizers should create an international Program Co=
mmittee for the Workshop, with recognized researchers within the specific W=
orkshop scientific area. Each workshop should have at least ten submissions=
 and five accepted papers in order to be conducted at WorldCist'22.

The selection of Workshops will be performed by WorldCist'22 Conference/Wor=
kshop Chairs. Each Workshop will have 1 article offered for 10 articles wit=
h paid registration, 2 articles offered for 20 articles with paid registrat=
ion, and 3 articles offered for 40 articles with paid registration.

Workshops full and short papers will be published in the conference main pr=
oceedings in specific Workshop chapters published by Springer in a book of =
the Lecture Notes in Networks and Systems series, will  be submitted for in=
dexation by SCOPUS, WoS, Google Scholar, SCImago, among others, and will be=
 available in the SpringerLink Digital Library. Extended versions of best s=
elected papers will be published in journals indexed by WoS/SCI, SCOPUS and=
 DBLP. Detailed and up-to-date information may be found at WorldCist'22 web=
site: http://worldcist.org/ <http://worldcist.org/>


WORKSHOP ORGANIZATION

The Organizing Committee of each Workshop will be responsible for:

- Producing and distributing the Workshop Call for Papers (CFP);
- Coordinating the review and selection process for the papers submitted to=
 the Workshop, as Workshop chairs (on the paper submission system to be ins=
talled);
- Delivering the final versions of the papers accepted for the Workshop in =
accordance with the guidelines and deadlines defined by WorldCist'22 organi=
zers;
- Coordinating and chairing the Workshop sessions at the conference.

WorldCist'22 organizers reserve the right to cancel any Workshop if deadlin=
es are missed or if the number of registered attendees is too low to suppor=
t the costs associated with the Workshop.


PROPOSAL CONTENT

Workshop proposals should contain the following information:

- Workshop title;
- Brief description of the specific scientific scope of the Workshop;
- List of topics of interest (max 15 topics);
- Reasons the Workshop should be held within WorldCist=E2=80=9922;
- Name, postal address, phone and email of all the members of the Workshop =
Organizing Committee;
- Preliminary proposal for the Workshop Program Committee (Names and affili=
ations).

Proposals should be submitted at https://easychair.org/conferences/?conf=3D=
worldcistworkshops2022 <https://easychair.org/conferences/?conf=3Dworldcist=
workshops2022> in PDF (in English), by September 8, 2021.


IMPORTANT DATES

- Deadline for Workshop proposals: September 8, 2021
- Notification of Workshop acceptance: September 15, 2021
- Workshop Final Information and Program Committee: September 25, 2021
- Deadline for paper submission: November 30, 2021
- Notification of paper acceptance: December 25, 2021
- Deadline for final versions and conference registration: January 8, 2022
- Conference dates: 12-14 April 2022

 

Website of WorldCIST'22: http://worldcist.org/ <http://worldcist.org/>


WorldCIST'22 Team
http://worldcist.org/ <http://worldcist.org/>


-- 
This email has been checked for viruses by AVG.
https://www.avg.com

--nFN7cmn0QjpB=_QOkEqVNfrY3ZyiulKsEi
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
    <p>---------------------------------------------</p>
    <p>Call for Workshops Proposals </p>
    <p>WorldCist'22 - 10th World Conference on Information Systems and Tech=
nologies</p>
    <p>Budva, Montenegro, 12 - 14 April 2022</p>
    <p><a href=3D"http://worldcist.org/">http://worldcist.org/</a></p>
    <p>--------------------------------------------------------------------=
------------------------------------------------</p>
    <p>The Information Systems and Technologies research and industrial com=
munity is invited to submit proposals for the organization of Workshops at =
WorldCist'22 - 10th World Conference on Information Systems and Technologie=
s, to be held in Budva, Montenegro, 12-14 April 2022. WorldCist is a global=
 forum for researchers and practitioners to present and discuss the most re=
cent innovations, trends, results, experiences and concerns in the several =
perspectives of Information Systems and Technologies.</p>
    <p><br />WORKSHOP FORMAT</p>
    <p>Workshops should focus on a specific scientific subject on the scope=
 of WorldCist'22 but not directly included on the main conference areas. Ea=
ch workshop will be coordinated by an Organizing Committee composed of, at =
least, two researchers in the field, preferably from different institutions=
 and different countries. The organizers should create an international Pro=
gram Committee for the Workshop, with recognized researchers within the spe=
cific Workshop scientific area. Each workshop should have at least ten subm=
issions and five accepted papers in order to be conducted at WorldCist'22.<=
/p>
    <p>The selection of Workshops will be performed by WorldCist'22 Confere=
nce/Workshop Chairs. Each Workshop will have 1 article offered for 10 artic=
les with paid registration, 2 articles offered for 20 articles with paid re=
gistration, and 3 articles offered for 40 articles with paid registration.<=
/p>
    <p>Workshops full and short papers will be published in the conference =
main proceedings in specific Workshop chapters published by Springer in a b=
ook of the Lecture Notes in Networks and Systems series, will&nbsp; be subm=
itted for indexation by SCOPUS, WoS, Google Scholar, SCImago, among others,=
 and will be available in the SpringerLink Digital Library. Extended versio=
ns of best selected papers will be published in journals indexed by WoS/SCI=
, SCOPUS and DBLP. Detailed and up-to-date information may be found at Worl=
dCist'22 website: <a href=3D"http://worldcist.org/">http://worldcist.org/</=
a></p>
    <p><br />WORKSHOP ORGANIZATION</p>
    <p>The Organizing Committee of each Workshop will be responsible for:</=
p>
    <p>- Producing and distributing the Workshop Call for Papers (CFP);<br =
/>- Coordinating the review and selection process for the papers submitted =
to the Workshop, as Workshop chairs (on the paper submission system to be i=
nstalled);<br />- Delivering the final versions of the papers accepted for =
the Workshop in accordance with the guidelines and deadlines defined by Wor=
ldCist'22 organizers;<br />- Coordinating and chairing the Workshop session=
s at the conference.</p>
    <p>WorldCist'22 organizers reserve the right to cancel any Workshop if =
deadlines are missed or if the number of registered attendees is too low to=
 support the costs associated with the Workshop.</p>
    <p><br />PROPOSAL CONTENT</p>
    <p>Workshop proposals should contain the following information:</p>
    <p>- Workshop title;<br />- Brief description of the specific scientifi=
c scope of the Workshop;<br />- List of topics of interest (max 15 topics);=
<br />- Reasons the Workshop should be held within WorldCist&rsquo;22;<br /=
>- Name, postal address, phone and email of all the members of the Workshop=
 Organizing Committee;<br />- Preliminary proposal for the Workshop Program=
 Committee (Names and affiliations).</p>
    <p>Proposals should be submitted at <a href=3D"https://easychair.org/co=
nferences/?conf=3Dworldcistworkshops2022">https://easychair.org/conferences=
/?conf=3Dworldcistworkshops2022</a> in PDF (in English), by September 8, 20=
21.</p>
    <p><br />IMPORTANT DATES</p>
    <p>- Deadline for Workshop proposals: September 8, 2021<br />- Notifica=
tion of Workshop acceptance: September 15, 2021<br />- Workshop Final Infor=
mation and Program Committee: September 25, 2021<br />- Deadline for paper =
submission: November 30, 2021<br />- Notification of paper acceptance: Dece=
mber 25, 2021<br />- Deadline for final versions and conference registratio=
n: January 8, 2022<br />- Conference dates: 12-14 April 2022</p>
    <p>&nbsp;</p>
    <p>Website of WorldCIST'22: <a href=3D"http://worldcist.org/">http://wo=
rldcist.org/</a></p>
    <p><br />WorldCIST'22 Team<br /><a href=3D"http://worldcist.org/">http:=
//worldcist.org/</a></p>
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

--nFN7cmn0QjpB=_QOkEqVNfrY3ZyiulKsEi--


--===============6335896275178784714==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============6335896275178784714==--

