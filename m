Return-Path: <SRS0=H/CR=HL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C73C433E0
	for <virtualization@archiver.kernel.org>; Tue,  9 Feb 2021 22:24:48 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FA4664DDF
	for <virtualization@archiver.kernel.org>; Tue,  9 Feb 2021 22:24:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FA4664DDF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id D4E0386C10;
	Tue,  9 Feb 2021 22:24:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id j7eeYeyPXstd; Tue,  9 Feb 2021 22:24:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6502186927;
	Tue,  9 Feb 2021 22:24:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 490CDC0174;
	Tue,  9 Feb 2021 22:24:43 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0A11FC013A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Feb 2021 22:24:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id EB1CC8725C
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Feb 2021 22:24:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id D3oVeeZhCW2B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Feb 2021 22:24:38 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from s052d7dde.fastvps-server.com (s052d7dde.fastvps-server.com
 [5.45.125.222])
 by hemlock.osuosl.org (Postfix) with ESMTPS id A1BE98712E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Feb 2021 22:24:37 +0000 (UTC)
Received: from bl22-68-231.dsl.telepac.pt ([2.83.68.231] helo=LAPTOP-EPOV2LRR)
 by s052d7dde.fastvps-server.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <marle@saisti.eu>) id 1l9auU-0002ZA-OD
 for virtualization@lists.linux-foundation.org; Wed, 10 Feb 2021 00:51:02 +0300
From: "Lemos" <marialemos72@gmail.com>
Subject: CISTI'2021 - 16th Iberian Conference on IST | Deadline: 21th of
 February
To: virtualization@lists.linux-foundation.org
MIME-Version: 1.0
Date: Tue, 9 Feb 2021 21:51:03 +0000
Message-ID: <2932283613453@gmail-com>
X-Antivirus: AVG (VPS 210209-2, 09/02/2021), Outbound message
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
Reply-To: cistiforever@gmail.com
Content-Type: multipart/mixed; boundary="===============1718362361475615335=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

This is a multi-part message in MIME format

--===============1718362361475615335==
Content-Type: multipart/alternative; charset=utf-8; boundary="eGT9Z=_2msp4N8yokq2a5WkW2Zj9kMoQ2a"

This is a multi-part message in MIME format

--eGT9Z=_2msp4N8yokq2a5WkW2Zj9kMoQ2a
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

* Published by IEEE
* Google Scholar H-Index =3D 17
* SCIMago H-Index =3D 13
* Indexed in Scopus, WoS, Ei-Compendex, Inspec, etc


-------------------------------------     ---------------------------------=
---     ------------------------------ 
CISTI'2021 - 16th Iberian Conference on Information Systems and Technologie=
s
23 - 26 June 2021 | Chaves, Portugal
http://cisti.eu/ <http://cisti.eu/>
-----------------------------------     -----------------------------------=
--     ------------------------------- 


We are pleased to invite the academic and business community to submit thei=
r papers to CISTI'2021 - 16th Iberian Conference on Information Systems and=
 Technologies, to be held in Chaves, Portugal, between the 23th and 26th of=
 June 2021. Authors are encouraged to submit original scientific contributi=
ons such as state-of-art reviews and new research perspectives, groundbreak=
ing ideas and/or architectures, solutions and/or applications for real prob=
lems, empirical and/or evaluation works, case studies, etc., in conformity =
with the themes of this Conference.

Four types of papers can be submitted:

Full paper: Finished or consolidated R&D works, to be included in one of th=
e Conference themes. These papers are assigned  a 6-page limit.

Short paper: Ongoing works with relevant preliminary results, opened to dis=
cussion. These papers are assigned a 4-page limit.

Poster paper: Initial work with relevant ideas, opened to discussion. These=
 papers are assigned a 2-page limit.

Company paper: Companies' papers  that show practical experience, R & D, to=
ols, etc., focused in some topics of the conference. These articles are abs=
tracts with a maximum of 2 pages.

Papers submitted for the Scientific Committee=E2=80=99s evaluation must not=
 include any information leading to the authors=E2=80=99 identification. Th=
erefore, the authors=E2=80=99 names, affiliations and bibliographic referen=
ces should not be included in the early version. This information should on=
ly be included in the final version.

Submitted papers must not have been published and must not be under review =
for any other conference and national or international publication.

Papers must comply with the format standard <http://cisti.eu/2017/images/te=
mplates.zip> and be written in Portuguese, Spanish or English.

All papers will be subjected to a =E2=80=9Cblind review=E2=80=9D by at leas=
t two members of the Scientific Committee.

Full papers can be accepted as short papers or poster papers only. Similarl=
y, short papers can be accepted as poster papers only. In these two cases, =
the authors will be allowed to maintain the original number of pages in the=
 proceedings publication.

The authors of accepted poster papers must also build and print a poster to=
 be exhibited during the Conference. This poster must follow an A1 or A2 ve=
rtical format. The Conference includes Work Sessions where these posters ar=
e presented and orally discussed, with a 5-minute limit per poster.

The authors of accepted full papers will dispose of a 15-minute presentatio=
n in the Conference Work Session, and approximately 5 minutes of discussion=
 will follow each presentation. The authors of accepted short papers and co=
mpany papers will dispose of an 11-minute presentation in the Conference Wo=
rk Session, and approximately 4 minutes of discussion will follow each pres=
entation.

 

Themes

Submitted papers must follow the main themes proposed for the Conference (t=
he topics proposed in each theme constitute a mere framework reference; the=
y are not intended as restrictive):

A) OMIS - Organizational Models and Information Systems

B) KMDSS - Knowledge Management and Decision Support Systems

C) SSAAT - Software Systems, Architectures, Applications and Tools

D) CNMPS - Computer Networks, Mobility and Pervasive Systems

E) HCC - Human Centered Computing

F) HIS - Health Informatics

G) ITE - Information Technologies in Education


H) AEC =E2=80=93 Architecture and Engineering of Construction

 

Publication and Indexing

To ensure that the contribution (full paper, short paper, symposium doctora=
l paper) is published in the Proceedings, at least one of the authors must =
be fully registered by the 11th of April, and the paper must comply with th=
e suggested layout and page-limit. Additionally, all recommended modificati=
ons must be addressed by the authors before they submit the final version.

No more than one paper per registration will be published in the Conference=
 Proceedings. An extra fee must be paid for publication of additional paper=
s, with a maximum of one additional paper per registration.

Full and short papers, including symposium doctoral papers, will be submitt=
ed for inclusion/indexing into IEEE XPlore, ISI, SCOPUS, EI-Compendex, INSP=
EC and Google Scholar.

The best articles will be selected for publication in the following journal=
s and books:

- Journal of Information Systems Engineering & Management (JISEM <http://ww=
w.lectitojournals.com/journal-for-information-systems-engineering-managemen=
t>)

- Journal on Advances in Theoretical and Applied Informatics (JADI <http://=
revista.univem.edu.br/index.php/jadi>)

- International Journal of Information Systems and Software Engineering for=
 Big Companies (IJISEBC <http://www.uajournals.com/ijisebc/>)

- Journal of Information and Operations Management Education (IJIOME <https=
://www.inderscience.com/jhome.php?jcode=3Dijiome>)

- Revista Ib=C3=A9rica de Sistemas e Tecnologias de Informa=C3=A7=C3=A3o (R=
ISTI <http://www.risti.xyz/>)

 

Important Dates

Paper submission: February 21, 2021

Notification of acceptance: March 28, 2021

Submission of accepted papers: April 11, 2021

Payment of registration, to ensure the inclusion of an accepted paper in th=
e conference proceedings: April 11, 2021

 

We are counting on you. Submit your contribution.







Website of CISTI'2021: http://cisti.eu/ <http://cisti.eu/> 


CISTI'2021 Team
http://cisti.eu/ <http://cisti.eu/>
 

 


-- 
This email has been checked for viruses by AVG.
https://www.avg.com

--eGT9Z=_2msp4N8yokq2a5WkW2Zj9kMoQ2a
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
      <div>* Published by&nbsp;IEEE</div>
      <div>* Google Scholar H-Index =3D 17</div>
      <div>* SCIMago H-Index =3D 13</div>
      <div>* Indexed in Scopus, WoS, Ei-Compendex, Inspec, etc</div>
    </div>
    <div dir=3D"ltr"><br /></div>
    <div dir=3D"ltr">------------------------------------- 
      <wbr>&nbsp;</wbr>&nbsp;&nbsp;&nbsp;----------------------------------=
-- 
      <wbr>&nbsp;</wbr>&nbsp;&nbsp;&nbsp;------------------------------ 
    </div>
    <div dir=3D"ltr">CISTI'2021 - 16th Iberian Conference on Information Sy=
stems and Technologies<br />23&nbsp;-&nbsp;26&nbsp;June 2021 | Chaves, Port=
ugal</div>
    <div dir=3D"ltr"><a href=3D"http://cisti.eu/">http://cisti.eu/</a></div=
>
    <div dir=3D"ltr">----------------------------------- 
      <wbr>&nbsp;</wbr>&nbsp;&nbsp;&nbsp;----------------------------------=
--- 
      <wbr>&nbsp;</wbr>&nbsp;&nbsp;&nbsp;------------------------------- 
    </div>
    <div dir=3D"ltr"><br /></div>
    <div dir=3D"ltr" itemprop=3D"articleBody">
      <p>We are pleased to invite the academic and business community to su=
bmit their papers to CISTI'2021 - 16th Iberian Conference on Information Sy=
stems and Technologies, to be held in Chaves, Portugal, between the 23th an=
d 26th of June 2021. Authors are encouraged to submit original scientific c=
ontributions such as state-of-art reviews and new research perspectives, gr=
oundbreaking ideas and/or architectures, solutions and/or applications for =
real problems, empirical and/or evaluation works, case studies, etc., in co=
nformity with the themes of this Conference.</p>
      <p>Four types of papers can be submitted:</p>
      <p>Full paper: Finished or consolidated R&amp;D works, to be included=
 in one of the Conference themes. These papers are assigned&nbsp; a 6-page =
limit.<br /><br />Short paper: Ongoing works with relevant preliminary resu=
lts, opened to discussion. These papers are assigned a 4-page limit.<br /><=
br />Poster paper: Initial work with relevant ideas, opened to discussion. =
These papers are assigned a 2-page limit.<br /><br />Company paper: Compani=
es' papers&nbsp; that show practical experience, R &amp; D, tools, etc., fo=
cused in some topics of the conference. These articles are abstracts with a=
 maximum of 2 pages.</p>
      <p>Papers submitted for the Scientific Committee&rsquo;s evaluation m=
ust not include any information leading to the authors&rsquo; identificatio=
n. Therefore, the authors&rsquo; names, affiliations and bibliographic refe=
rences should not be included in the early version. This information should=
 only be included in the final version.</p>
      <p>Submitted papers must not have been published and must not be unde=
r review for any other conference and national or international publication=
=2E</p>
      <p>Papers must comply with the&nbsp;<strong><a href=3D"http://cisti.e=
u/2017/images/templates.zip" rel=3D"noopener noreferrer" target=3D"_blank">=
format standard</a></strong>&nbsp;and be written in Portuguese, Spanish or =
English.</p>
      <p>All papers will be subjected to a &ldquo;blind review&rdquo; by at=
 least two members of the Scientific Committee.</p>
      <p>Full papers can be accepted as short papers or poster papers only.=
 Similarly, short papers can be accepted as poster papers only. In these tw=
o cases, the authors will be allowed to maintain the original number of pag=
es in the proceedings publication.</p>
      <p>The authors of accepted poster papers must also build and print a =
poster to be exhibited during the Conference. This poster must follow an A1=
 or A2 vertical format. The Conference includes Work Sessions where these p=
osters are presented and orally discussed, with a 5-minute limit per poster=
=2E</p>
      <p>The authors of accepted full papers will dispose of a 15-minute pr=
esentation in the Conference Work Session, and approximately 5 minutes of d=
iscussion will follow each presentation. The authors of accepted short pape=
rs and company papers will dispose of an 11-minute presentation in the Conf=
erence Work Session, and approximately 4 minutes of discussion will follow =
each presentation.</p>
      <p>&nbsp;</p>
      <p><strong>Themes</strong></p>
      <p>Submitted papers must follow the main themes proposed for the Conf=
erence (the topics proposed in each theme constitute a mere framework refer=
ence; they are not intended as restrictive):</p>
      <p><em>A) OMIS - Organizational Models and Information Systems</em></=
p>
      <p><em>B) KMDSS - Knowledge Management and Decision Support Systems</=
em></p>
      <p><em>C) SSAAT - Software Systems, Architectures, Applications and T=
ools</em></p>
      <p><em>D) CNMPS - Computer Networks, Mobility and Pervasive Systems</=
em></p>
      <p><em>E) HCC - Human Centered Computing</em></p>
      <p><em>F) HIS - Health Informatics</em></p>
      <p><em>G) ITE - Information Technologies in Education<br /></em></p>
      <p><em><span lang=3D"EN-US">H) AEC &ndash; Architecture and Engineeri=
ng of Construction</span></em></p>
      <p><strong>&nbsp;</strong></p>
      <p><strong>Publication and Indexing</strong></p>
      <p>To ensure that the contribution (full paper, short paper, symposiu=
m doctoral paper) is published in the Proceedings, at least one of the auth=
ors must be fully registered by the 11th of April, and the paper must compl=
y with the suggested layout and page-limit. Additionally, all recommended m=
odifications must be addressed by the authors before they submit the final =
version.</p>
      <p>No more than one paper per registration will be published in the C=
onference Proceedings. An extra fee must be paid for publication of additio=
nal papers, with a maximum of one additional paper per registration.</p>
      <p>Full and short papers, including symposium doctoral papers, will b=
e submitted for inclusion/indexing into IEEE XPlore, ISI, SCOPUS, EI-Compen=
dex, INSPEC and Google Scholar.</p>
      <p><span lang=3D"en" id=3D"result_box"><span>The best articles will b=
e selected for publication in the following journals and books:</span></spa=
n></p>
      <p>- Journal of Information Systems Engineering &amp; Management (<a =
href=3D"http://www.lectitojournals.com/journal-for-information-systems-engi=
neering-management" rel=3D"noopener noreferrer" target=3D"_blank">JISEM</a>=
)</p>
      <p>- Journal on Advances in Theoretical and Applied Informatics (<a h=
ref=3D"http://revista.univem.edu.br/index.php/jadi" rel=3D"noopener norefer=
rer" target=3D"_blank">JADI</a>)</p>
      <p>-&nbsp;<span lang=3D"EN-US">International Journal of Information S=
ystems and Software Engineering for Big Companies (<a href=3D"http://www.ua=
journals.com/ijisebc/" rel=3D"noopener noreferrer" target=3D"_blank">IJISEB=
C</a>)</span></p>
      <p><span lang=3D"EN-US">- Journal of Information and Operations Manag=
ement Education (<a href=3D"https://www.inderscience.com/jhome.php?jcode=3D=
ijiome" rel=3D"noopener noreferrer" target=3D"_blank">IJIOME</a>)</span></p=
>
      <p>- Revista Ib&eacute;rica de Sistemas e Tecnologias de Informa&cced=
il;&atilde;o (<a href=3D"http://www.risti.xyz/" rel=3D"noopener noreferrer"=
 target=3D"_blank">RISTI</a>)</p>
      <p>&nbsp;</p>
      <p><strong>Important Dates</strong></p>
      <p><span class=3D"hps">Paper</span>&nbsp;<span class=3D"hps">submissi=
on:</span>&nbsp;<span class=3D"hps">February</span> 21, <span class=3D"hps"=
>2021</span><br /><br /><span class=3D"hps">Notification of</span>&nbsp;<sp=
an class=3D"hps">acceptance</span>: March 28,&nbsp;<span class=3D"hps">2021=
</span><br /><br /><span class=3D"hps">Submission of</span>&nbsp;<span clas=
s=3D"hps">accepted</span>&nbsp;<span class=3D"hps">papers</span>: April 11,=
&nbsp;<span class=3D"hps">2021</span><br /><br /><span class=3D"hps">Paymen=
t of</span>&nbsp;<span class=3D"hps">registration</span>,&nbsp;<span class=
=3D"hps">to</span>&nbsp;<span class=3D"hps">ensure</span>&nbsp;<span class=
=3D"hps">the</span>&nbsp;<span class=3D"hps">inclusion</span>&nbsp;<span cl=
ass=3D"hps">of an</span>&nbsp;<span class=3D"hps">accepted paper</span>&nbs=
p;<span class=3D"hps">in the&nbsp;</span><span class=3D"hps">conference</sp=
an>&nbsp;<span class=3D"hps">proceedings</span>: April <span class=3D"hps">=
11</span>,&nbsp;<span class=3D"hps">2021</span></p>
      <p>&nbsp;</p>
      <p><em><strong>We are counting on you. Submit your contribution.</str=
ong></em></p>
    </div>
    <div dir=3D"ltr"><br /></div>
    <div dir=3D"ltr"><br /></div>
    <div dir=3D"ltr"><br /></div>
    <div dir=3D"ltr">Website of CISTI'2021: <a href=3D"http://cisti.eu/">ht=
tp://cisti.eu/</a>&nbsp;<br /><br /></div>
    <div dir=3D"ltr">CISTI'2021 Team</div>
    <div dir=3D"ltr"><a href=3D"http://cisti.eu/">http://cisti.eu/</a></div=
>
    <p>&nbsp;</p>
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

--eGT9Z=_2msp4N8yokq2a5WkW2Zj9kMoQ2a--


--===============1718362361475615335==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============1718362361475615335==--

