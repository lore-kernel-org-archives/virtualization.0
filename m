Return-Path: <SRS0=nIFr=BS=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,MPART_ALT_DIFF,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0AFAC433DF
	for <virtualization@archiver.kernel.org>; Sat,  8 Aug 2020 13:23:46 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEAAC20723
	for <virtualization@archiver.kernel.org>; Sat,  8 Aug 2020 13:23:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEAAC20723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 3D72C204E3;
	Sat,  8 Aug 2020 13:23:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4rMiWaM5Zp9s; Sat,  8 Aug 2020 13:23:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 089EA20475;
	Sat,  8 Aug 2020 13:23:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DED69C0733;
	Sat,  8 Aug 2020 13:23:38 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 06E14C0051
 for <virtualization@lists.linux-foundation.org>;
 Sat,  8 Aug 2020 13:23:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id E2E9288BFB
 for <virtualization@lists.linux-foundation.org>;
 Sat,  8 Aug 2020 13:23:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XN+vKp-R7p7T
 for <virtualization@lists.linux-foundation.org>;
 Sat,  8 Aug 2020 13:23:34 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from s052d7dde.fastvps-server.com (s052d7dde.fastvps-server.com
 [5.45.125.222])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 909D7887BE
 for <virtualization@lists.linux-foundation.org>;
 Sat,  8 Aug 2020 13:23:34 +0000 (UTC)
Received: from [37.189.17.205] (helo=LAPTOP-EPOV2LRR)
 by s052d7dde.fastvps-server.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <marle@saisti.eu>) id 1k4OSk-0006so-10
 for virtualization@lists.linux-foundation.org; Sat, 08 Aug 2020 16:00:38 +0300
From: "Lemos" <marialemos72@gmail.com>
Subject: Call for Workshops Proposals - WorldCIST'21, Terceira Island, Azores
To: virtualization@lists.linux-foundation.org
MIME-Version: 1.0
Date: Sat, 8 Aug 2020 14:00:38 +0100
Message-ID: <13096617444265@gmail-com>
X-Antivirus: AVG (VPS 200808-0, 08/08/2020), Outbound message
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
Content-Type: multipart/mixed; boundary="===============7567512787230812344=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

This is a multi-part message in MIME format

--===============7567512787230812344==
Content-Type: multipart/alternative; charset=utf-8; boundary="w1jQ6Pan7OeMrlyRsuPHZ2A=_buME4BhE3"

This is a multi-part message in MIME format

--w1jQ6Pan7OeMrlyRsuPHZ2A=_buME4BhE3
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline



-- 
This email has been checked for viruses by AVG.
https://www.avg.com

--w1jQ6Pan7OeMrlyRsuPHZ2A=_buME4BhE3
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
      <div dir=3D"ltr">* CORE Ranking conference</div>
      <div dir=3D"ltr">* Conference with a Google Scholar H5-Index =3D 19</=
div>
    </div>
    <div dir=3D"ltr">* Proceedings published by Springer, in several books =
of the AISC series</div>
    <div dir=3D"ltr">* Indexed in Scopus, WoS, DBLP, Ei-Compendex, etc</div=
>
    <div dir=3D"ltr">* Extended versions of best articles published in JCR/=
WoS/SCI journals</div>
    <div dir=3D"ltr">&nbsp;</div>
    <div dir=3D"ltr"><br /></div>
    <div dir=3D"ltr">------------------------------ &nbsp;-----------------=
------------ 
      <wbr>&nbsp;</wbr>&nbsp;&nbsp;&nbsp;- &nbsp;--------------------------=
--- 
      <wbr>&nbsp;</wbr>&nbsp;&nbsp;&nbsp;-- 
    </div>
    <p>Call for Workshops Proposals</p>
    <p><span class=3D"il">WorldCIST</span>'21&nbsp;- 9th <span class=3D"il"=
>World</span> Conference on Information Systems and Technologies<br />30-31=
 March to 1-2 April 2021 | Terceira Island, Azores, Portugal<br /><a href=
=3D"http://www.worldcist.org/" target=3D"_blank" data-saferedirecturl=3D"ht=
tps://www.google.com/url?q=3Dhttp://www.worldcist.org/&source=3Dgmail&ust=
=3D1595244885522000&usg=3DAFQjCNFXmEEcY0g07fwEj5ypcaZ1kzw-jA">http://www.<s=
pan class=3D"il">worldcist</span>.org/</a></p>
    <div dir=3D"ltr">------------------------------ &nbsp;-----------------=
------------ 
      <wbr>&nbsp;</wbr>&nbsp;&nbsp;&nbsp;- &nbsp;--------------------------=
--- 
      <wbr>&nbsp;</wbr>&nbsp;&nbsp;&nbsp;----------- 
    </div>
    <div dir=3D"ltr"><br />
      <p>The Information Systems and Technologies research and industrial c=
ommunity is invited to submit proposals for the organization of Workshops a=
t <span class=3D"il">WorldCist</span>'21 - 9th <span class=3D"il">World</sp=
an> Conference on Information Systems and Technologies, to be held at Terce=
ira Island, Azores, Portugal, 30-31 March to 1-2 April 2021. <span class=3D=
"il">WorldCist</span> is a global forum for researchers and practitioners t=
o present and discuss the most recent innovations, trends, results, experie=
nces and concerns in the several perspectives of Information Systems and Te=
chnologies. <br /><br /><br /><strong>WORKSHOP FORMAT</strong><br /><br />W=
orkshops should focus on a specific scientific subject on the scope of <spa=
n class=3D"il">WorldCist</span>'21 but not directly included on the main co=
nference areas. Each workshop will be coordinated by an Organizing Committe=
e composed of, at least, two researchers in the field, preferably from diff=
erent institutions and different countries. The organizers should create an=
 international Program Committee for the Workshop, with recognized research=
ers within the specific Workshop scientific area. Each workshop should have=
 at least ten submissions and five accepted papers in order to be conducted=
 at <span class=3D"il">WorldCist</span>'21.<br /><br />The selection of Wor=
kshops will be performed by <span class=3D"il">WorldCist</span>'21 Conferen=
ce/Workshop Chairs. Each Workshop will have 1 article offered for 10 articl=
es with paid registration, 2 articles offered for 20 articles with paid reg=
istration, and 3 articles offered for 40 articles with paid registration.</=
p>
      <p>Workshops full and short papers will be published in the conferenc=
e main proceedings in specific Workshop chapters published by Springer in a=
 book of the AISC series. Proceedings will be submitted for indexation by I=
SI, SCOPUS, DBLP, EI-Compendex among several other scientific databases. Ex=
tended versions of best selected papers will be published in journals index=
ed by ISI/SCI, SCOPUS and DBLP. Detailed and up-to-date information may be =
found at <span class=3D"il">WorldCist</span>'21 website: <a href=3D"http://=
worldcist.org/" target=3D"_blank" data-saferedirecturl=3D"https://www.googl=
e.com/url?q=3Dhttp://worldcist.org/&source=3Dgmail&ust=3D1595244885522000&u=
sg=3DAFQjCNHEcqDwJFgleRUvuOnARJHBAZ8W5w">http://<span class=3D"il">worldcis=
t</span>.org/</a></p>
      <p><br /><strong>WORKSHOP ORGANIZATION</strong><br /><br />The Organi=
zing Committee of each Workshop will be responsible for:<br /><br />- Produ=
cing and distributing the Workshop Call for Papers (CFP);<br />- Coordinati=
ng the review and selection process for the papers submitted to the Worksho=
p, as Workshop chairs (on the paper submission system to be installed);<br =
/>- Delivering the final versions of the papers accepted for the Workshop i=
n accordance with the guidelines and deadlines defined by <span class=3D"il=
">WorldCist</span>'21 organizers;<br />- Coordinating and chairing the Work=
shop sessions at the conference.<br /><br /><span class=3D"il">WorldCist</s=
pan>'21 organizers reserve the right to cancel any Workshop if deadlines ar=
e missed or if the number of registered attendees is too low to support the=
 costs associated with the Workshop.<br /><br /><br /><strong>PROPOSAL CONT=
ENT</strong><br /><br />Workshop proposals should contain the following inf=
ormation:<br /><br />- Workshop title;<br />- Brief description of the spec=
ific scientific scope of the Workshop;<br />- List of topics of interest (m=
ax 15 topics);<br />- Reasons the Workshop should be held within <span clas=
s=3D"il">WorldCist</span>&rsquo;21;<br />- Name, postal address, phone and =
email of all the members of the Workshop Organizing Committee;<br />- Preli=
minary proposal for the Workshop Program Committee (Names and affiliations)=
=2E<br /><br />Proposals should be submitted at <a href=3D"https://easychai=
r.org/conferences/?conf=3Dworldcistworkshops2021" target=3D"_blank" data-sa=
feredirecturl=3D"https://www.google.com/url?q=3Dhttps://easychair.org/confe=
rences/?conf%3Dworldcistworkshops2021&source=3Dgmail&ust=3D1596974431218000=
&usg=3DAFQjCNERxbtDfMHbjBxGxCkNqBsnZXSagA">https://easychair.org/
          <wbr>&nbsp;</wbr>conferences/?conf=3D
          <wbr>&nbsp;</wbr>worldcistworkshops2021</a> in PDF (in English), =
by August 23, 2020.<br /><br /><br /><strong>IMPORTANT DATES</strong><br />=
<br />- Deadline for Workshop proposals: August 23, 2020<br />- Notificatio=
n of Workshop acceptance: September 4, 2020<br />- Workshop Final Informati=
on and Program Committee: September 25, 2020<br />- Deadline for paper subm=
ission: November 30, 2020<br />- Notification of paper acceptance: December=
 23, 2020<br />- Deadline for final versions and conference registration: J=
anuary 2, 2021<br />- Conference dates: 30-31 March to 1-2 April 2021<br />=

      </p>
    </div>
    <div dir=3D"ltr"><br /></div>
    <div dir=3D"ltr">&nbsp;</div>
    <div dir=3D"ltr">Website of <span class=3D"il">WorldCIST</span>'21: <a =
href=3D"http://www.worldcist.org/" target=3D"_blank" data-saferedirecturl=
=3D"https://www.google.com/url?q=3Dhttp://www.worldcist.org/&source=3Dgmail=
&ust=3D1595244885522000&usg=3DAFQjCNFXmEEcY0g07fwEj5ypcaZ1kzw-jA">http://ww=
w.<span class=3D"il">worldcist</span>.org/</a>&nbsp;</div>
    <div dir=3D"ltr">&nbsp;</div>
    <div dir=3D"ltr"><br /></div>
    <div dir=3D"ltr"><span class=3D"il">WorldCIST</span>'21 Team<br /><a hr=
ef=3D"http://www.worldcist.org/" target=3D"_blank" data-saferedirecturl=3D"=
https://www.google.com/url?q=3Dhttp://www.worldcist.org/&source=3Dgmail&ust=
=3D1595244885522000&usg=3DAFQjCNFXmEEcY0g07fwEj5ypcaZ1kzw-jA">http://www.<s=
pan class=3D"il">worldcist</span>.org/</a></div>
    <p>&nbsp;</p>
    <p>--------------</p>
    <div>
      <p>PS: If you do not wish to receive more notices from&nbsp;<span cla=
ss=3D"il">WorldCIST</span> (<a href=3D"http://www.worldcist.org/" target=3D=
"_blank" data-saferedirecturl=3D"https://www.google.com/url?q=3Dhttp://www.=
worldcist.org/&source=3Dgmail&ust=3D1595244885522000&usg=3DAFQjCNFXmEEcY0g0=
7fwEj5ypcaZ1kzw-jA">http://www.<span class=3D"il">worldcist</span>.org/</a>=
) just reply this message with the word REMOVE in the subject line</p>
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

--w1jQ6Pan7OeMrlyRsuPHZ2A=_buME4BhE3--


--===============7567512787230812344==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============7567512787230812344==--

