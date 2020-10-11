Return-Path: <SRS0=TNKP=DS=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7704C433DF
	for <virtualization@archiver.kernel.org>; Sun, 11 Oct 2020 12:40:27 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 489BD207E8
	for <virtualization@archiver.kernel.org>; Sun, 11 Oct 2020 12:40:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 489BD207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id E63ED877E7;
	Sun, 11 Oct 2020 12:40:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T5U5kuZaX5oM; Sun, 11 Oct 2020 12:40:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7E053877D1;
	Sun, 11 Oct 2020 12:40:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4787BC0052;
	Sun, 11 Oct 2020 12:40:23 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 695A8C0051
 for <virtualization@lists.linux-foundation.org>;
 Sun, 11 Oct 2020 12:40:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 5646920130
 for <virtualization@lists.linux-foundation.org>;
 Sun, 11 Oct 2020 12:40:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jZE0AhPvGSRp
 for <virtualization@lists.linux-foundation.org>;
 Sun, 11 Oct 2020 12:40:17 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from s052d7dde.fastvps-server.com (s052d7dde.fastvps-server.com
 [5.45.125.222])
 by silver.osuosl.org (Postfix) with ESMTPS id 5717C1FD42
 for <virtualization@lists.linux-foundation.org>;
 Sun, 11 Oct 2020 12:40:17 +0000 (UTC)
Received: from [37.189.17.205] (helo=LAPTOP-EPOV2LRR)
 by s052d7dde.fastvps-server.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <marle@saisti.eu>) id 1kRZpc-0000eT-59
 for virtualization@lists.linux-foundation.org; Sun, 11 Oct 2020 14:48:04 +0300
From: "ML" <marialemos72@gmail.com>
Subject: Call for Workshops Proposals - CISTI'2021, Chaves, Portugal
To: virtualization@lists.linux-foundation.org
MIME-Version: 1.0
Date: Sun, 11 Oct 2020 12:48:03 +0100
Message-ID: <18368230764984@gmail-com>
X-Antivirus: AVG (VPS 201011-0, 11/10/2020), Outbound message
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
Reply-To: cistiforeverer@gmail.com
Content-Type: multipart/mixed; boundary="===============8108181238994324558=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

This is a multi-part message in MIME format

--===============8108181238994324558==
Content-Type: multipart/alternative; charset=utf-8; boundary="0NdzGga=_rYBgSs9opBhFu7kRxI6y7MIxo"

This is a multi-part message in MIME format

--0NdzGga=_rYBgSs9opBhFu7kRxI6y7MIxo
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

* Articles indexed by Scopus, WoS, Inspec, Google Scholar, etc.

* Google Scholar H5-Index =3D 17

* SCImago H-Index =3D 13

 

---------------------------------------------------------------------------=
-----------------------

Call for Workshops Proposals

CISTI'2021 - 16th Iberian Conference on Information Systems and Technologie=
s

23 - 26 June 2021, Chaves, Portugal

http://cisti.eu/ <http://cisti.eu/>

---------------------------------------------------------------------------=
-------------------------

 

Workshop Format

The Information Systems and Technologies research and industrial community =
is invited to submit proposals of Workshops for CISTI 2021 =E2=80=93 16th I=
berian Conference on Information Systems and Technologies to be held at Cha=
ves, Portugal, June 23=E2=80=9326, 2021. Two types of Workshops may be prop=
osed: Regular Workshops and Project Workshops.

Regular Workshops should focus on a specific scientific subject on the scop=
e of CISTI 2021 but not directly included on the main conference areas. Eac=
h regular workshop will be coordinated by an Organizing Committee composed =
of, at least, two researchers in the field, preferably from different insti=
tutions and different countries. The organizers should create an internatio=
nal Program Committee for the Workshop, with recognized researchers within =
the specific Workshop scientific area. Each workshop should have at least 1=
0 submissions and 5 accepted papers in order to be conducted at CISTI.

Project Workshops are intended to promote the dissemination and facilitate =
the future exploitation of EU Latin-American and national project results s=
uch as EU/FP7, EU/Horizon2020, CSIC, FCT, QREN, Portugal 2020, Fund. Gulben=
kian, CYTED, CAPES, CNPq, FINEP and other Projects/funding sources. The res=
ults to be disseminated may be preliminary project results (for unfinished =
projects) or the project final results (for already finished projects). Eac=
h project workshop should be directly related to a Project funded in a comp=
etitive manner by a National/International Science Organization. The Worksh=
op should be coordinated by an Organizing Committee composed by at least tw=
o researchers including the Principal Investigator of the project. Each Wor=
kshop will have 1 article offered for 10 articles with paid registration, 2=
 articles offered for 20 articles with paid registration, and 3 articles of=
fered for 40 articles with paid registration. The selection of Workshops wi=
ll be performed by CISTI 2021 Conference Chairs. Workshops full papers will=
 be published in the conference main proceedings in specific Workshop chapt=
ers. Proceedings will be submitted for indexation by ISI, SCOPUS, EI-Conpen=
dex, INSPEC and Google Scholar. Detailed and up-to-date information may be =
found at CISTI 2021 website: http://www.cisti.eu/ <http://www.cisti.eu/>.

 

Workshop Organization 

The Organizing Committee of each Workshop will be responsible for:

* Producing and distributing the Workshop Call for Papers (CFP); 
* Coordinating the review and selection process for the papers submitted to=
 the Workshop, as Workshop chairs (on the paper submission system installed=
 for all the Workshops); 
* Delivering the final versions of the papers accepted for the Workshop in =
accordance with the guidelines and deadlines defined by CISTI 2021 organize=
rs; 
* Coordinating and chairing the Workshop sessions at the conference. 


CISTI 2021 organizers reserve the right to cancel any Workshop if deadlines=
 are missed or if the number of registered attendees is too low to support =
the costs associated with the Workshop.

 

Proposal Contents

Regular Workshop proposals should contain the following information:

* Workshop title; 
* Brief description of the specific scientific scope of the Workshop; 
* List of topics of interest (max 15 topics); 
* Reasons the Workshop should be held within CISTI=E2=80=992021; 
* Name, postal address, phone and email of all the members of the Workshop =
Organizing Committee; 
* Proposal for the Workshop Program Committee (Names and affiliations). 


Project Workshop proposals should contain the following information:

* Workshop title; 
* Project Title, Reference, Principal Investigator, Funding Organization, T=
otal Funding, Consortium, Abstract and Objectives; 
* Reasons the Workshop should be held within CISTI=E2=80=992021; 
* Name, postal address, phone and email of all the members of the Workshop =
Organizing Committee. 


Proposals should be submitted electronically (in Word or compatible format)=
 at https://easychair.org/conferences/?conf=3Dcisti2021workshops <https://e=
asychair.org/conferences/?conf=3Dcisti2021workshops>, in English, Portugues=
e and/or Spanish, by November 1, 2020.

 

Important Dates

* Deadline for Workshop proposals: November 1, 2020 
* Notification of Workshop acceptance: November 8, 2020 
* Deadline for paper submission: February 28, 2021 
* Notification of paper acceptance: March 28, 2021 
* Deadline for final versions and conference registration: April 11, 2021 
* Deadline for Workshop final papers delivery to CISTI organizers: April 11=
, 2021 
* Conference dates: June 23-26, 2021 


 

Website of CISTI'2021: http://cisti.eu/ <http://cisti.eu/>

 


-- 
This email has been checked for viruses by AVG.
https://www.avg.com

--0NdzGga=_rYBgSs9opBhFu7kRxI6y7MIxo
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
    <p>* Articles indexed by Scopus, WoS, Inspec, Google Scholar, etc.</p>
    <p>* Google Scholar H5-Index =3D 17</p>
    <p>* SCImago H-Index =3D 13</p>
    <p>&nbsp;</p>
    <p>--------------------------------------------------------------------=
------------------------------</p>
    <p>Call for Workshops Proposals</p>
    <p><strong>CISTI'2021 - 16th Iberian Conference on Information Systems =
and Technologies</strong></p>
    <p>23 - 26 June 2021, Chaves, Portugal</p>
    <p><a href=3D"http://cisti.eu/">http://cisti.eu/</a></p>
    <p>--------------------------------------------------------------------=
--------------------------------</p>
    <p>&nbsp;</p>
    <div itemprop=3D"articleBody">
      <p><strong>Workshop Format</strong></p>
      <p>The Information Systems and Technologies research and industrial c=
ommunity is invited to submit proposals of Workshops for CISTI 2021 &ndash;=
 16th Iberian Conference on Information Systems and Technologies to be held=
 at Chaves, Portugal, June 23&ndash;26, 2021. Two types of Workshops may be=
 proposed: Regular Workshops and Project Workshops.</p>
      <p>Regular Workshops should focus on a specific scientific subject on=
 the scope of CISTI 2021 but not directly included on the main conference a=
reas. Each regular workshop will be coordinated by an Organizing Committee =
composed of, at least, two researchers in the field, preferably from differ=
ent institutions and different countries. The organizers should create an i=
nternational Program Committee for the Workshop, with recognized researcher=
s within the specific Workshop scientific area. Each workshop should have a=
t least 10 submissions and 5 accepted papers in order to be conducted at CI=
STI.</p>
      <p>Project Workshops are intended to promote the dissemination and fa=
cilitate the future exploitation of EU Latin-American and national project =
results such as EU/FP7, EU/Horizon2020, CSIC, FCT, QREN, Portugal 2020, Fun=
d. Gulbenkian, CYTED, CAPES, CNPq, FINEP and other Projects/funding sources=
=2E The results to be disseminated may be preliminary project results (for =
unfinished projects) or the project final results (for already finished pro=
jects). Each project workshop should be directly related to a Project funde=
d in a competitive manner by a National/International Science Organization.=
 The Workshop should be coordinated by an Organizing Committee composed by =
at least two researchers including the Principal Investigator of the projec=
t. Each Workshop will have 1 article offered for 10 articles with paid regi=
stration, 2 articles offered for 20 articles with paid registration, and 3 =
articles offered for 40 articles with paid registration. The selection of W=
orkshops will be performed by CISTI 2021 Conference Chairs. Workshops full =
papers will be published in the conference main proceedings in specific Wor=
kshop chapters. Proceedings will be submitted for indexation by ISI, SCOPUS=
, EI-Conpendex, INSPEC and Google Scholar. Detailed and up-to-date informat=
ion may be found at CISTI 2021 website: <a href=3D"http://www.cisti.eu/">ht=
tp://www.cisti.eu/</a>.</p>
      <p>&nbsp;</p>
      <p><strong>Workshop Organization </strong></p>
      <p>The Organizing Committee of each Workshop will be responsible for:=
</p>
      <ul>
        <li>Producing and distributing the Workshop Call for Papers (CFP);<=
/li>
        <li>Coordinating the review and selection process for the papers su=
bmitted to the Workshop, as Workshop chairs (on the paper submission system=
 installed for all the Workshops);</li>
        <li>Delivering the final versions of the papers accepted for the Wo=
rkshop in accordance with the guidelines and deadlines defined by CISTI 202=
1 organizers;</li>
        <li>Coordinating and chairing the Workshop sessions at the conferen=
ce.</li>
      </ul>
      <p>CISTI 2021 organizers reserve the right to cancel any Workshop if =
deadlines are missed or if the number of registered attendees is too low to=
 support the costs associated with the Workshop.</p>
      <p>&nbsp;</p>
      <p><strong>Proposal Contents</strong></p>
      <p>Regular Workshop proposals should contain the following informatio=
n:</p>
      <ul>
        <li>Workshop title;</li>
        <li>Brief description of the specific scientific scope of the Works=
hop;</li>
        <li>List of topics of interest (max 15 topics);</li>
        <li>Reasons the Workshop should be held within CISTI&rsquo;2021;</l=
i>
        <li>Name, postal address, phone and email of all the members of the=
 Workshop Organizing Committee;</li>
        <li>Proposal for the Workshop Program Committee (Names and affiliat=
ions).</li>
      </ul>
      <p>Project Workshop proposals should contain the following informatio=
n:</p>
      <ul>
        <li>Workshop title;</li>
        <li>Project Title, Reference, Principal Investigator, Funding Organ=
ization, Total Funding, Consortium, Abstract and Objectives;</li>
        <li>Reasons the Workshop should be held within CISTI&rsquo;2021;</l=
i>
        <li>Name, postal address, phone and email of all the members of the=
 Workshop Organizing Committee.</li>
      </ul>
      <p>Proposals should be submitted electronically (in Word or compatibl=
e format) at <a href=3D"https://easychair.org/conferences/?conf=3Dcisti2021=
workshops" rel=3D"noopener noreferrer" target=3D"_blank"><strong>https://ea=
sychair.org/conferences/?conf=3Dcisti2021workshops</strong></a>, in English=
, Portuguese and/or Spanish, by November 1, 2020.</p>
      <p>&nbsp;</p>
      <p><strong>Important Dates</strong></p>
      <ul>
        <li>Deadline for Workshop proposals: November 1, 2020</li>
        <li>Notification of Workshop acceptance: November 8, 2020</li>
        <li>Deadline for paper submission: February 28, 2021</li>
        <li>Notification of paper acceptance: March 28, 2021</li>
        <li>Deadline for final versions and conference registration: April =
11, 2021</li>
        <li>Deadline for Workshop final papers delivery to CISTI organizers=
: April 11, 2021</li>
        <li>Conference dates: June 23-26, 2021</li>
      </ul>
    </div>
    <p>&nbsp;</p>
    <p><strong>Website of CISTI'2021</strong>: <a href=3D"http://cisti.eu/"=
>http://cisti.eu/</a></p>
    <p>&nbsp;</p>
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

--0NdzGga=_rYBgSs9opBhFu7kRxI6y7MIxo--


--===============8108181238994324558==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============8108181238994324558==--

