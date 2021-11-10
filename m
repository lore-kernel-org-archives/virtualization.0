Return-Path: <SRS0=RKVt=P5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5150C433F5
	for <virtualization@archiver.kernel.org>; Wed, 10 Nov 2021 07:12:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5089A60724
	for <virtualization@archiver.kernel.org>; Wed, 10 Nov 2021 07:12:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5089A60724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 05108608FE;
	Wed, 10 Nov 2021 07:12:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CLwlZktZT-o2; Wed, 10 Nov 2021 07:12:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9215D608D4;
	Wed, 10 Nov 2021 07:12:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6904FC0012;
	Wed, 10 Nov 2021 07:12:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8BFCEC000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Nov 2021 07:12:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 62B4140259
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Nov 2021 07:12:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id u58PfINqsH_j
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Nov 2021 07:12:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3952D400DE
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Nov 2021 07:12:44 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10163"; a="230081715"
X-IronPort-AV: E=Sophos;i="5.87,223,1631602800"; 
 d="scan'208,217";a="230081715"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2021 23:12:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,223,1631602800"; 
 d="scan'208,217";a="669693531"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orsmga005.jf.intel.com with ESMTP; 09 Nov 2021 23:12:40 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 9 Nov 2021 23:12:40 -0800
Received: from shsmsx601.ccr.corp.intel.com (10.109.6.141) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 9 Nov 2021 23:12:39 -0800
Received: from shsmsx601.ccr.corp.intel.com ([10.109.6.141]) by
 SHSMSX601.ccr.corp.intel.com ([10.109.6.141]) with mapi id 15.01.2242.012;
 Wed, 10 Nov 2021 15:12:36 +0800
From: "Wang, Wei W" <wei.w.wang@intel.com>
To: "sgarzare@redhat.com" <sgarzare@redhat.com>, "davem@davemloft.net"
 <davem@davemloft.net>, "kuba@kernel.org" <kuba@kernel.org>, Stefan Hajnoczi
 <stefanha@redhat.com>, "mst@redhat.com" <mst@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "kys@microsoft.com" <kys@microsoft.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
Subject: [RFC] hypercall-vsock: add a new vsock transport
Thread-Topic: [RFC] hypercall-vsock: add a new vsock transport
Thread-Index: AdfR7PQwhDKKIu84SJaS6/iA/MsV5g==
Date: Wed, 10 Nov 2021 07:12:36 +0000
Message-ID: <71d7b0463629471e9d4887d7fcef1d8d@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.200.16
x-originating-ip: [10.239.127.36]
MIME-Version: 1.0
Cc: "Yamahata, Isaku" <isaku.yamahata@intel.com>, "Kleen,
 Andi" <andi.kleen@intel.com>
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
Content-Type: multipart/mixed; boundary="===============1182963909694896001=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============1182963909694896001==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_71d7b0463629471e9d4887d7fcef1d8dintelcom_"

--_000_71d7b0463629471e9d4887d7fcef1d8dintelcom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

We plan to add a new vsock transport based on hypercall (e.g. vmcall on Int=
el CPUs).
It transports AF_VSOCK packets between the guest and host, which is similar=
 to
virtio-vsock, vmci-vsock and hyperv-vsock.

Compared to the above listed vsock transports which are designed for high p=
erformance,
the main advantages of hypercall-vsock are:

1)       It is VMM agnostic. For example, one guest working on hypercall-vs=
ock can run on

either KVM, Hyperv, or VMware.

2)       It is simpler. It doesn't rely on any complex bus enumeration

(e.g. virtio-pci based vsock device may need the whole implementation of PC=
I).

An example usage is the communication between MigTD and host (Page 8 at
https://static.sched.com/hosted_files/kvmforum2021/ef/TDX%20Live%20Migratio=
n_Wei%20Wang.pdf).
MigTD communicates to host to assist the migration of the target (user) TD.
MigTD is part of the TCB, so its implementation is expected to be as simple=
 as possible
(e.g. bare mental implementation without OS, no PCI driver support).

Looking forward to your feedbacks.

Thanks,
Wei

--_000_71d7b0463629471e9d4887d7fcef1d8dintelcom_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@SimSun";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin:0cm;
	text-indent:21.0pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle19
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
/* Page Definitions */
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:2105375921;
	mso-list-type:hybrid;
	mso-list-template-ids:-1529155444 -278093444 67698713 67698715 67698703 67=
698713 67698715 67698703 67698713 67698715;}
@list l0:level1
	{mso-level-text:"%1\)";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:18.0pt;
	text-indent:-18.0pt;}
@list l0:level2
	{mso-level-number-format:alpha-lower;
	mso-level-text:"%2\)";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:42.0pt;
	text-indent:-21.0pt;}
@list l0:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:63.0pt;
	text-indent:-21.0pt;}
@list l0:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:84.0pt;
	text-indent:-21.0pt;}
@list l0:level5
	{mso-level-number-format:alpha-lower;
	mso-level-text:"%5\)";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:105.0pt;
	text-indent:-21.0pt;}
@list l0:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:126.0pt;
	text-indent:-21.0pt;}
@list l0:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:147.0pt;
	text-indent:-21.0pt;}
@list l0:level8
	{mso-level-number-format:alpha-lower;
	mso-level-text:"%8\)";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:168.0pt;
	text-indent:-21.0pt;}
@list l0:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:189.0pt;
	text-indent:-21.0pt;}
ol
	{margin-bottom:0cm;}
ul
	{margin-bottom:0cm;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"ZH-CN" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word;text-justify-trim:punctuation">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt">Hi,<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt"><o:p=
>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt">We p=
lan to add a new vsock transport based on hypercall (e.g. vmcall on Intel C=
PUs).<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt">It t=
ransports AF_VSOCK packets between the guest and host, which is similar to<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt">virt=
io-vsock, vmci-vsock and hyperv-vsock.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt"><o:p=
>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt">Comp=
ared to the above listed vsock transports which are designed for high perfo=
rmance,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt">the =
main advantages of hypercall-vsock are:<o:p></o:p></span></p>
<p class=3D"MsoListParagraph" style=3D"margin-left:18.0pt;text-indent:-18.0=
pt;mso-list:l0 level1 lfo2">
<![if !supportLists]><span lang=3D"EN-US" style=3D"font-size:10.5pt"><span =
style=3D"mso-list:Ignore">1)<span style=3D"font:7.0pt &quot;Times New Roman=
&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><span lang=3D"EN-US" style=3D"font-size:10.5=
pt">It is VMM agnostic. For example, one guest working on hypercall-vsock c=
an run on<o:p></o:p></span></p>
<p class=3D"MsoListParagraph" style=3D"margin-left:18.0pt;text-indent:0cm">=
<span lang=3D"EN-US" style=3D"font-size:10.5pt">either KVM, Hyperv, or VMwa=
re.<o:p></o:p></span></p>
<p class=3D"MsoListParagraph" style=3D"margin-left:18.0pt;text-indent:-18.0=
pt;mso-list:l0 level1 lfo2">
<![if !supportLists]><span lang=3D"EN-US" style=3D"font-size:10.5pt"><span =
style=3D"mso-list:Ignore">2)<span style=3D"font:7.0pt &quot;Times New Roman=
&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><span lang=3D"EN-US" style=3D"font-size:10.5=
pt">It is simpler. It doesn&#8217;t rely on any complex bus enumeration<o:p=
></o:p></span></p>
<p class=3D"MsoListParagraph" style=3D"margin-left:18.0pt;text-indent:0cm">=
<span lang=3D"EN-US" style=3D"font-size:10.5pt">(e.g. virtio-pci based vsoc=
k device may need the whole implementation of PCI).<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt"><o:p=
>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt">An e=
xample usage is the communication between MigTD and host (Page 8 at<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt"><a h=
ref=3D"https://static.sched.com/hosted_files/kvmforum2021/ef/TDX%20Live%20M=
igration_Wei%20Wang.pdf">https://static.sched.com/hosted_files/kvmforum2021=
/ef/TDX%20Live%20Migration_Wei%20Wang.pdf</a>).<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt">MigT=
D communicates to host to assist the migration of the target (user) TD.<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt">MigT=
D is part of the TCB, so its implementation is expected to be as simple as =
possible<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt">(e.g=
. bare mental implementation without OS, no PCI driver support).<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt"><o:p=
>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt">Look=
ing forward to your feedbacks.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt"><o:p=
>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt">Than=
ks,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt">Wei<=
o:p></o:p></span></p>
</div>
</body>
</html>

--_000_71d7b0463629471e9d4887d7fcef1d8dintelcom_--

--===============1182963909694896001==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============1182963909694896001==--
