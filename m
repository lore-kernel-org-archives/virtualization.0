Return-Path: <SRS0=9iyF=FE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD10C64E8A
	for <virtualization@archiver.kernel.org>; Mon, 30 Nov 2020 13:54:29 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EB3320855
	for <virtualization@archiver.kernel.org>; Mon, 30 Nov 2020 13:54:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EB3320855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id BFE88872B2;
	Mon, 30 Nov 2020 13:54:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5f2vS1XmDKnZ; Mon, 30 Nov 2020 13:54:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id BDB1E8729A;
	Mon, 30 Nov 2020 13:54:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A81A7C0859;
	Mon, 30 Nov 2020 13:54:23 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7E4C8C0052
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 13:54:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 6C4EE8729A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 13:54:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RQK+V8RlGc-Z
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 13:54:19 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from s052d7dde.fastvps-server.com (s052d7dde.fastvps-server.com
 [5.45.125.222])
 by hemlock.osuosl.org (Postfix) with ESMTPS id E767487228
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 13:54:18 +0000 (UTC)
Received: from [37.189.17.205] (helo=LAPTOP-EPOV2LRR)
 by s052d7dde.fastvps-server.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <marle@saisti.eu>) id 1kjjBj-0003D3-Le
 for virtualization@lists.linux-foundation.org; Mon, 30 Nov 2020 16:25:55 +0300
From: "Maria Lemos" <marialemos72@gmail.com>
Subject: Doctoral Symposium - CISTI 2021, Chaves, Portugal
To: virtualization@lists.linux-foundation.org
MIME-Version: 1.0
Date: Mon, 30 Nov 2020 13:25:56 +0000
Message-ID: <213521474362171@gmail-com>
X-Antivirus: AVG (VPS 201130-0, 30/11/2020), Outbound message
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
Content-Type: multipart/mixed; boundary="===============4924790537369283971=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

This is a multi-part message in MIME format

--===============4924790537369283971==
Content-Type: multipart/alternative; charset=utf-8; boundary="RIhDtfo3QnljPDxrP=_iKUouIe2bqO1NCI"

This is a multi-part message in MIME format

--RIhDtfo3QnljPDxrP=_iKUouIe2bqO1NCI
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

------------------------------  ------------------------------  -----------=
-------------------  ---------- 
Doctoral Symposium 

CISTI 2021 - 16th Iberian Conference on Information Systems and Technologie=
s, Chaves, Portugal, 23 - 26 June 2021

http://www.cisti.eu/ <http://www.cisti.eu/>

------------------------------  ------------------------------  -----------=
-------------------  --------- 
 

The purpose of CISTI'2021=E2=80=99s Doctoral Symposium is to provide gradua=
te students a setting where they can, informally, expose and discuss their =
work, collecting valuable expert opinions and sharing new ideas, methods an=
d applications. The Doctoral Symposium is an excellent opportunity for PhD =
students to present and discuss their work in a Workshop format. Each prese=
ntation will be evaluated by a panel composed by at least three Information=
 Systems and Technologies experts.

 

Contributions Submission 

The Doctoral Symposium is opened to PhD students whose research area includ=
es the themes proposed for this Conference. Submissions must include an ext=
ended abstract (maximum 4 pages), following the Conference style guide. All=
 selected contributions will be published with the Conference Proceedings i=
n electronic format with ISBN. These contributions will be available in the=
 IEEE Xplore Digital Library and will be sent for indexing in ISI, Scopus, =
EI-Compendex, INSPEC and Google Scholar.

Submissions must include the field, the PhD institution and the number of m=
onths devoted to the development of the work. Additionally, they should inc=
lude in a clear and succinct manner:

   =E2=80=A2    The problem approached and its significance or relevance 
   =E2=80=A2    The research objectives and related investigation topics 
   =E2=80=A2    A brief display of what is already known 
   =E2=80=A2    A proposed solution methodology for the problem 
   =E2=80=A2    Expected results 

 

Important Dates 

Paper submission: February 14, 2021

Notification of acceptance: March 28, 2021

Submission of accepted papers: April 11, 2021

Payment of registration, to ensure the inclusion of an accepted paper in th=
e conference proceedings: April 11, 2021

 

Organizing Committee 

=C3=81lvaro Rocha, ISEG, Universidade de Lisboa

Francisco Garc=C3=ADa-Pe=C3=B1alvo, Universidad de Salamanca

 

Scientific Committee 

Francisco Garc=C3=ADa-Pe=C3=B1alvo, Universidad de Salamanca (Chair)

A. Augusto Sousa, FEUP, Universidade do Porto

Ad=C3=A9rito Fernandes-Marcos, Universidade Aberta

Adolfo Lozano Tello, Universidad de Extremadura

Alicia Garc=C3=ADa Holgado, Universidad de Salamanca

=C3=81lvaro Rocha, ISEG, Universidade de Lisboa

Ana Am=C3=A9lia Carvalho, Universidade de Coimbra

Ant=C3=B3nio Palma do Reis, ISEG, Universidade de Lisboa

Arnaldo Martins, Universidade de Aveiro

Borja Bordel, Universidad Polit=C3=A9cnica de Madrid

Br=C3=A1ulio Alturas, ISCTE - Instituto Universit=C3=A1rio de Lisboa

Carina Soledad Gonz=C3=A1lez, Universidad de La Laguna

Carlos Costa, ISEG, Universidade de Lisboa

Carlos Ferr=C3=A1s Sexto, Universidad de Santiago de Compostela

Cesar Collazos, Universidad del Cauca

Daniel Amo, La Salle, Universidad Ramon Llull

David Fonseca, La Salle, Universitat Ramon Llull

Eduardo S=C3=A1nchez Vila, Universidade de Santiago de Compostela

Fernando Moreira, Universidade Portucalense

Fernando Ramos, Universidade de Aveiro

Francisco Restivo, Universidade Cat=C3=B3lica Portuguesa

Gon=C3=A7alo Paiva Dias, Universidade de Aveiro

Jo=C3=A3o Costa, Universidade de Coimbra

Jo=C3=A3o Manuel R.S. Tavares, FEUP, Universidade do Porto

Jo=C3=A3o Pascoal Faria, FEUP, Universidade do Porto

Jos=C3=A9 Machado, Universidade do Minho

Luis Camarinha-Matos, FCT, Universidade NOVA de Lisboa

Lu=C3=ADs Paulo Reis, FEUP, Universidade do Porto

Marcelo Marciszack, Universidad Tecnol=C3=B3gica Nacional

Marco Painho, NOVA IMS

Mar=C3=ADa J Lado, Universidade de Vigo

Mar=C3=ADa Pilar Mareca Lopez, Universidad Polit=C3=A9cnica de Madrid

M=C3=A1rio Piattini, Universidad de Castilla-La Mancha

Martin Llamas Nistal, Universidad de Vigo

Miguel de Castro Neto, NOVA IMS

Miguel Ram=C3=B3n Gonz=C3=A1lez-Castro, ENCE

Nelson Rocha, Universidade de Aveiro

=C3=93scar Mealha, Universidade de Aveiro

Paulo Pinto, FCT, Universidade Nova de Lisboa

Ramiro Gon=C3=A7alves, Universidade de Tr=C3=A1s-os-Montes e Alto Douro

Tomas San Feliu, Universidad Polit=C3=A9cnica de Madrid

Vitor Santos, NOVA IMS

 

Website of CISTI'2020: http://www.cisti.eu/ <http://www.cisti.eu/>

 

CISTI 2021 Team

http://www.cisti.eu/ <http://www.cisti.eu/>


-- 
This email has been checked for viruses by AVG.
https://www.avg.com

--RIhDtfo3QnljPDxrP=_iKUouIe2bqO1NCI
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
      <wbr>&nbsp;</wbr>----------
    </p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%"><strong>Doctoral Symposium</strong> </p>=

    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">CISTI 2021 - 16th Iberian Conference on =
Information Systems and Technologies, Chaves, Portugal, 23 - 26 June 2021</=
p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%"><a href=3D"http://www.cisti.eu/" target=
=3D"_blank" data-saferedirecturl=3D"https://www.google.com/url?q=3Dhttp://w=
ww.cisti.eu/&source=3Dgmail&ust=3D1606828157836000&usg=3DAFQjCNHYuKquL9ivSq=
eC_9iq3du8iRglzg">http://www.cisti.eu/</a></p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">------------------------------
      <wbr>&nbsp;</wbr>------------------------------
      <wbr>&nbsp;</wbr>------------------------------
      <wbr>&nbsp;</wbr>---------
    </p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">&nbsp;</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">The purpose of CISTI'2021&rsquo;s Doctor=
al Symposium is to provide graduate students a setting where they can, info=
rmally, expose and discuss their work, collecting valuable expert opinions =
and sharing new ideas, methods and applications. The Doctoral Symposium is =
an excellent opportunity for PhD students to present and discuss their work=
 in a Workshop format. Each presentation will be evaluated by a panel compo=
sed by at least three Information Systems and Technologies experts.</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">&nbsp;</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%"><strong>Contributions Submission</strong=
> </p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">The Doctoral Symposium is opened to PhD =
students whose research area includes the themes proposed for this Conferen=
ce. Submissions must include an extended abstract (maximum 4 pages), follow=
ing the Conference style guide. All selected contributions will be publishe=
d with the Conference Proceedings in electronic format with ISBN. These con=
tributions will be available in the IEEE Xplore Digital Library and will be=
 sent for indexing in ISI, Scopus, EI-Compendex, INSPEC and Google Scholar.=
</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">Submissions must include the field, the =
PhD institution and the number of months devoted to the development of the =
work. Additionally, they should include in a clear and succinct manner:</p>=

    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">&nbsp; &nbsp;&bull; &nbsp; &nbsp;The pro=
blem approached and its significance or relevance <br />&nbsp; &nbsp;&bull;=
 &nbsp; &nbsp;The research objectives and related investigation topics <br =
/>&nbsp; &nbsp;&bull; &nbsp; &nbsp;A brief display of what is already known=
 <br />&nbsp; &nbsp;&bull; &nbsp; &nbsp;A proposed solution methodology for=
 the problem <br />&nbsp; &nbsp;&bull; &nbsp; &nbsp;Expected results </p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">&nbsp;</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%"><strong>Important Dates</strong> </p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">Paper submission: February 14, 2021</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">Notification of acceptance: March 28, 20=
21</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">Submission of accepted papers: April 11,=
 2021</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">Payment of registration, to ensure the i=
nclusion of an accepted paper in the conference proceedings: April 11, 2021=
</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">&nbsp;</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%"><strong>Organizing Committee</strong> </=
p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">&Aacute;lvaro Rocha, ISEG, Universidade =
de Lisboa</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">Francisco Garc&iacute;a-Pe&ntilde;alvo, =
Universidad de Salamanca</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">&nbsp;</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%"><strong>Scientific Committee</strong> </=
p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">Francisco Garc&iacute;a-Pe&ntilde;alvo, =
Universidad de Salamanca (Chair)</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">A. Augusto Sousa, FEUP, Universidade do =
Porto</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">Ad&eacute;rito Fernandes-Marcos, Univers=
idade Aberta</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">Adolfo Lozano Tello, Universidad de Extr=
emadura</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">Alicia Garc&iacute;a Holgado, Universida=
d de Salamanca</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">&Aacute;lvaro Rocha, ISEG, Universidade =
de Lisboa</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">Ana Am&eacute;lia Carvalho, Universidade=
 de Coimbra</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">Ant&oacute;nio Palma do Reis, ISEG, Univ=
ersidade de Lisboa</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">Arnaldo Martins, Universidade de Aveiro<=
/p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">Borja Bordel, Universidad Polit&eacute;c=
nica de Madrid</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">Br&aacute;ulio Alturas, ISCTE - Institut=
o Universit&aacute;rio de Lisboa</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">Carina Soledad Gonz&aacute;lez, Universi=
dad de La Laguna</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">Carlos Costa, ISEG, Universidade de Lisb=
oa</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">Carlos Ferr&aacute;s Sexto, Universidad =
de Santiago de Compostela</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">Cesar Collazos, Universidad del Cauca</p=
>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">Daniel Amo, La Salle, Universidad Ramon =
Llull</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">David Fonseca, La Salle, Universitat Ram=
on Llull</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">Eduardo S&aacute;nchez Vila, Universidad=
e de Santiago de Compostela</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">Fernando Moreira, Universidade Portucale=
nse</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">Fernando Ramos, Universidade de Aveiro</=
p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">Francisco Restivo, Universidade Cat&oacu=
te;lica Portuguesa</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">Gon&ccedil;alo Paiva Dias, Universidade =
de Aveiro</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">Jo&atilde;o Costa, Universidade de Coimb=
ra</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">Jo&atilde;o Manuel R.S. Tavares, FEUP, U=
niversidade do Porto</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">Jo&atilde;o Pascoal Faria, FEUP, Univers=
idade do Porto</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">Jos&eacute; Machado, Universidade do Min=
ho</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">Luis Camarinha-Matos, FCT, Universidade =
NOVA de Lisboa</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">Lu&iacute;s Paulo Reis, FEUP, Universida=
de do Porto</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">Marcelo Marciszack, Universidad Tecnol&o=
acute;gica Nacional</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">Marco Painho, NOVA IMS</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">Mar&iacute;a J Lado, Universidade de Vig=
o</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">Mar&iacute;a Pilar Mareca Lopez, Univers=
idad Polit&eacute;cnica de Madrid</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">M&aacute;rio Piattini, Universidad de Ca=
stilla-La Mancha</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">Martin Llamas Nistal, Universidad de Vig=
o</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">Miguel de Castro Neto, NOVA IMS</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">Miguel Ram&oacute;n Gonz&aacute;lez-Cast=
ro, ENCE</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">Nelson Rocha, Universidade de Aveiro</p>=

    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">&Oacute;scar Mealha, Universidade de Ave=
iro</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">Paulo Pinto, FCT, Universidade Nova de L=
isboa</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">Ramiro Gon&ccedil;alves, Universidade de=
 Tr&aacute;s-os-Montes e Alto Douro</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">Tomas San Feliu, Universidad Polit&eacut=
e;cnica de Madrid</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">Vitor Santos, NOVA IMS</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">&nbsp;</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">Website of CISTI'2020: <a href=3D"http:/=
/www.cisti.eu/" target=3D"_blank" data-saferedirecturl=3D"https://www.googl=
e.com/url?q=3Dhttp://www.cisti.eu/&source=3Dgmail&ust=3D1606828157836000&us=
g=3DAFQjCNHYuKquL9ivSqeC_9iq3du8iRglzg">http://www.cisti.eu/</a></p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">&nbsp;</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%">CISTI 2021 Team</p>
    <p style=3D"font-size: 16px; overflow: hidden; font-family: Arial; colo=
r: rgb(109,109,109); padding-bottom: 0px; text-align: left; padding-top: 0p=
x; margin: 0px; line-height: 200%"><a href=3D"http://www.cisti.eu/" target=
=3D"_blank" data-saferedirecturl=3D"https://www.google.com/url?q=3Dhttp://w=
ww.cisti.eu/&source=3Dgmail&ust=3D1606828157836000&usg=3DAFQjCNHYuKquL9ivSq=
eC_9iq3du8iRglzg">http://www.cisti.eu/</a></p>
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

--RIhDtfo3QnljPDxrP=_iKUouIe2bqO1NCI--


--===============4924790537369283971==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============4924790537369283971==--

