Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314867BAEC
	for <virtualization@lists.linux-foundation.org>; Tue, 12 Mar 2024 15:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710255973; cv=fail; b=TJdPGatH1UfSyxa131XRjUpLyngcAMyMuNNOtfhDdhipb10fSVpLw5Gto0wI8F17xOwZA8esLPLQ+ZdK0VAOvomuxgZJLGFGoqd2cHtcNwf4+90vaL7uDPavHghJaPFqk2MulTsLl9Aa/p+Xi6QKqDVzYzGnRZN/7UcqzlbzIDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710255973; c=relaxed/simple;
	bh=DIeHg/mDTKNYaBZulPyZ2+4AIEwM0ezoeNFERSR6bNI=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=NITZxFQlWKxcTfrXPmTq9DCWzF6b8btHizTu3b923HbZzwRzDadJZPKz6kEyXZWGIl+yNOVXXuF/d40Y+U8u5KKvmgWCDqSHXKfB08s+C22d00mwqSf25ktegPfMnwTv1OzDlo2tPwuyVMoK1DXkv21RA26QRHMv7VcUJXnTBEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=phd.unipi.it header.i=@phd.unipi.it header.b=RSP9UHX0; arc=fail smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=phd.unipi.it header.i=@phd.unipi.it header.b="RSP9UHX0"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8C70F406F5
	for <virtualization@lists.linux-foundation.org>; Tue, 12 Mar 2024 15:06:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.002
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PMG6D271KXmI
	for <virtualization@lists.linux-foundation.org>;
	Tue, 12 Mar 2024 15:06:08 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:111:f400:fe02::713; helo=eur01-db5-obe.outbound.protection.outlook.com; envelope-from=alberto.ottimo@phd.unipi.it; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 49205406E9
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none) header.from=phd.unipi.it
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 49205406E9
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=phd.unipi.it header.i=@phd.unipi.it header.a=rsa-sha256 header.s=selector1 header.b=RSP9UHX0
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on0713.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe02::713])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 49205406E9
	for <virtualization@lists.linux-foundation.org>; Tue, 12 Mar 2024 15:06:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FOYbEoaiHUK/F3Sd3w8U2hFdnhttqYNUSuUGp1XPzsDba5I0n096P44VABv8g/8DEdBl0IsiWd4aMRT3OKmFDOE3bPwjZb6oWeV62fBO9qB4uPoh5AF2D2bYhJxhLhTPfZ01z5/XgF5iq/1c/Hk1mdeove++bn2EeH2UvGnQOWsBdpBbAFDGaXyiC6YlGFglmhRs7/opnV1bYZbdqirF1g55ML00Nuxqy/WCoJQ4zlW/qB3nk+VsTZeNzfWyawNTDqnSQFynEV3Bg4J5C5Y3A6UHiv1Y3tK/e4Nz4iqE4tMITlmNqrIJNJotjFkokQC8eF6bWMtZ4lr1lniJ2/fLPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pPKcXjJt7mKRavMGOsN7Ln6rA1uMLf//4Spy1rnHd/k=;
 b=QbaHGsgK1UrCHSY/rPwl5xr9C8VGPAVAQBiv4PDKWtBYZ1eHadO86oQv15eQibdJtew7hzpoP44Z/JqKsDjQuFL2UlWgxfP8Q2FC3lOTnqXgthyOUmLGgqaZHtMO/BFUX68qHQJmivnCdSd8NQN8rMwtZzMf+C2rwS9DSGMiVBjFoEhyYpOAuE9O36kwLPjErLfHuUljZu+SkzSHjBvRNUX7PdKYITFQKHl3i3DD+65Un7PhdRZyyQKGqZgaVJIAvR7acnfraxXxHP9DAWDQWkaHDT09QU9Saj6lsNBDsd5GXyF5yVJ7cZ8aWRrsoeFn0vexn1caAuDpxuBf+SEiYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phd.unipi.it; dmarc=pass action=none header.from=phd.unipi.it;
 dkim=pass header.d=phd.unipi.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phd.unipi.it;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pPKcXjJt7mKRavMGOsN7Ln6rA1uMLf//4Spy1rnHd/k=;
 b=RSP9UHX0RqhtdKKbBslFu4QBzeY8dWylNmexUe51hb92znlOiSGFhQPxjN6g/rZGJwfWEzSAOS7hKDiziXPqUVoqql0fhkiPBS3iwT/WAGhEfKKT60HFuq7UYbCHapxkGqkAgiydBBF7Q23gtF8RTCDYKh9noXScghGdjqEm3SM=
Received: from AS1PR07MB8408.eurprd07.prod.outlook.com (2603:10a6:20b:4c4::17)
 by PR3PR07MB8184.eurprd07.prod.outlook.com (2603:10a6:102:177::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Tue, 12 Mar
 2024 15:06:01 +0000
Received: from AS1PR07MB8408.eurprd07.prod.outlook.com
 ([fe80::f49d:54e2:b3e6:f607]) by AS1PR07MB8408.eurprd07.prod.outlook.com
 ([fe80::f49d:54e2:b3e6:f607%2]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 15:06:01 +0000
From: Alberto Ottimo <alberto.ottimo@phd.unipi.it>
To: "virtualization@lists.linux-foundation.org"
	<virtualization@lists.linux-foundation.org>
Subject: HPDC 2024: Call for Posters
Thread-Topic: HPDC 2024: Call for Posters
Thread-Index: AQHadI7LFnoa/lHHUEOUK1oJAwUK4w==
Date: Tue, 12 Mar 2024 15:06:01 +0000
Message-ID: <51EE2840-D827-4D44-B9C6-69E96A7B6E4D@studenti.unipi.it>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3696.120.41.1.1)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phd.unipi.it;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS1PR07MB8408:EE_|PR3PR07MB8184:EE_
x-ms-office365-filtering-correlation-id: a09d99c9-2825-470c-eec4-08dc42a5ee5a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 yPsLuSbe3MVMvH88eDgF2l1CHPey5RIteBwTxnlWeUYZNXLhy9Ph1Z1OMyZQf0yhfvimENTQamGukAbEhnjvAvLA0iU2qNYjlon6dMizZyCrZ8vIrVMRPHgQi4cDN9UBN4SyQ7UdPn888gNYCXmvPCOOrlZi+H6JqLx+UDtPYMyyQbBzhcJo+iBPsgSM3poPBylwUhjFZNr6VlHJQC6BU9XkuCVyS70Hbnvedf4SPnQN9u4A9kKS7DO8t38OKRfg7AervSD9c16DrE11okCv8ffxW7v9rGLQ79QDgAY62LOlVklv1UOoUuEBUrzy67qG+6o+VUuLbgSZaLq+wysCSfA+6tQ4I//ksoHit+R4oVF4UeclgkVbD/J+jCcExVWW7wRhcHiMsW3sv7Qoa6rLa7RJ8bVh4Q0fiEVsn0UFb0Rlb7o4Nji27fB7pJRp+MY0QzUfE066DrnV78TU+MlKvsca5EOrB++iEyi/F5e3ETdwziYlkpg7tfV8CSoeKuj/yJJ19KEDWYINXav5B+Iqfd6e6cciHGBURLai6SZRgrITtMVgtMhf9XipTRYdkur8ZaJZLBDKjnoHQUw49AlnOH4cqbP3maV+kuKhHy7Cq7xCmXGy2XoURogsqWLlE6BAHtsMYc1sOt3IJ6ilMaKbUa6pRMiEBREkJGLYMGTggGM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR07MB8408.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?tR3u2Sbsm5lT01FFTrRBuK52pS9WeL/cwsW85wX7EcBi0Vq1uLYJCL0BbxIO?=
 =?us-ascii?Q?2P1nyaizBB2EyAO0fj9V8DctPtzt5OC0/EpYEVzkbxFcm2Htx8E17gASxGyr?=
 =?us-ascii?Q?MFUvpk1H9CAbuzCZZpWw+qPMOvo4wJ8wbyPII0l9M6FyCa7/C/SK3D2rnjPf?=
 =?us-ascii?Q?JeXv/epidUs8Zq4lNNzghfwUIazmIbFRty9ijritQlnDsUGrlzujPOVdSxuh?=
 =?us-ascii?Q?ApHTSpkWkZKMs4hYfaK5TZ4KMXC/foFxXIzLsn0CSv97Xvy/5HxHXQC7WhvC?=
 =?us-ascii?Q?f9GCkMZHEv5gvXG2qbu5jzAb2upWksQg/ZzzNxsqWo7xNLRuoJWVIOFRr9kU?=
 =?us-ascii?Q?QkvBGA/tStDKT2l3jBEQXP7kGgCTRDGC6Ck9cvxQ7TgXFHfLL4MsSmm+kNoH?=
 =?us-ascii?Q?fFW7u5bFs1ucVfbZ8ZPDmSQj3M32LeCCVGc3OCf8AIkzgelBPFkSLeM8bY10?=
 =?us-ascii?Q?x2t8VsXR5MFc3bKnk+AP0MgDlU1z06bGlq1Ysfw7172Q7mHNohjGUWFine5S?=
 =?us-ascii?Q?RaCuyFSqOef9eroNMGmCH/NT1cp8owSsepWnIu+RFq8gKimG54LMX5YfE/QG?=
 =?us-ascii?Q?Xik89tW7/jnq2uXBU0y2S7aNxGvxAK+Us2qpDNdVmtFnCabOvtwlbTRSmiVA?=
 =?us-ascii?Q?/b/GbiPUnmzQ4zSP1b1TaNDjDT7SuDMZAWk3bTvnFU6Lmg82R24w9rdmOVbF?=
 =?us-ascii?Q?mGmTBbtmyXv8MPUhp9f3ib04Tgfpt8OIVGJ25H4BV1rNWo7Qyg7padmWBMTr?=
 =?us-ascii?Q?6Ao2ndBPCK8AZN9TtcT/vTqwg8JUvgCa58oh9WODWgu/24eaGrWwpC0iebuB?=
 =?us-ascii?Q?G49lchYHGG1qUWX7xRJSCmV0EzgXcAJNWT/qPGR6MzYT6qSaZ9P7+d85+W/U?=
 =?us-ascii?Q?UZpz1gpvv5xE9lb6dtVPf6m+w4uD6a5Gwbsw8at+2xJfKVUXLj0blnZCxsKu?=
 =?us-ascii?Q?zmTcF2bOGTZN7/av6IkATtob4xgWGRxxCYYhCq+33eNdrN9IUmLYdDFyXcuQ?=
 =?us-ascii?Q?gabiIWjc3dDQWbvEQuAqRtQmhrEEVE/BM7xORGJX3Bh9r01KdIpvuSRF/I4+?=
 =?us-ascii?Q?E6KItDU2t/B15Nyx0LYWC8FK6PEybOZTLH/J1sm/o8zd8ZXNjBoVCA4bQAh1?=
 =?us-ascii?Q?raBR+SDhygXvip3laBSmV9/sBLc1+wKxgAQxWcPIPok+hXq65d8doofXnYVP?=
 =?us-ascii?Q?wUXEJ1E0bHcec8RZlLaUG50JenR/Ua4z1HCf2GtLl261nsuLcqsAIJ325DS9?=
 =?us-ascii?Q?b2MVs6utgjl+FvvOIPy5mneppaLvJkbprPB4LZ/JYlEqPqvdKC/HeflzLDgQ?=
 =?us-ascii?Q?t4ku3pi2digOZVYeZzX0wOdOB8awyeetMRtNbvkffPWaytvRFPiPlZMB1bjt?=
 =?us-ascii?Q?kTtD0Mdgb9sar/KwZJ0PFX70mm3wE88ARI6/Jji+kZd6tnmVt6up3VbMts2v?=
 =?us-ascii?Q?Bkty1Q6CFVvhG9GVJGoYJAj6x3+t46pZquDy2abdgglcnvVQ/M3ojxHZn3+b?=
 =?us-ascii?Q?d67ZLjwqoxDq2sn4OKKnWDhHr0V4h0as1B/MI3tNzBXiJ7U5qzMa0s/nD1H+?=
 =?us-ascii?Q?Tsd28FUxqxk3e2v9Tb7JBepnLzD0uhYXYPodydJ9Lfhk6Oyy3WoHj8AXIwPb?=
 =?us-ascii?Q?OZwnZJsC6PvCpknqzLatqTW4wiGdmrnfB31RkV09mWKv?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A66C6EF0274C2F479EC2B136E8C8539C@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: phd.unipi.it
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS1PR07MB8408.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a09d99c9-2825-470c-eec4-08dc42a5ee5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2024 15:06:01.4337
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c7456b31-a220-47f5-be52-473828670aa1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qh0sJbDaPjQT48Ct2riaZ5PMKHX1C0YCNCeW9O2zo2DVCXzn5XlWQiLwvFYEeyKGn+eeO3I61jPxaXJG41vqhqGaQIXkbvbJqMvLBAxj1Dw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR07MB8184

--- Apologies for multiple postings ---=20

**********************************************
HPDC 2024: Call for Posters
Date: 3-7 June 2024
Location: Pisa, Italy
Web Site: Web Site: https://www.hpdc.org/2024/
Sponsored by SIGARCH
In-cooperation with SIGHPC
**********************************************

* Call for Posters

The 33rd International Symposium on High-Performance Parallel and Distribut=
ed Computing (HPDC 2024)
Pisa, Italy, June 03 - 07, 2024

* Overview

The ACM International Symposium on High-Performance Parallel and Distribute=
d Computing (HPDC) will include a poster session with an associated 3-page =
extended abstract, which will be included in the HPDC 2024 proceedings. The=
 topics of interest follow the regular paper submission and include (but ar=
e not limited to): Cloud computing, cluster computing, edge computing, Cont=
inuum platforms, big data, massively multicore systems, AI for systems, sys=
tems for AI, distributed computing, hybrid memory systems, disaggregated st=
orage, quantum computing and data management, and extreme-scale computing s=
ystems. Authors of accepted posters will be given the opportunity to presen=
t their work in a dedicated session during the main conference.

* Submission Guidelines

We invite authors to submit poster contributions in the form of a three-pag=
e extended abstract and a poster draft. Abstracts shall be submitted via th=
e poster submission website and should be formatted in the ACM Proceedings =
Style (for Latex, use \documentclass[sigconf]{acmart}, for MS Word  use the=
 template provided by ACM here https://tinyurl.com/bde976ds ). We recommend=
 A1 size for the poster, portrait orientation.

Each submission should include a title, all author names and affiliations, =
notes on whether any of the authors are students, and an indication of whic=
h author is corresponding/presenting the material.=20
Poster abstracts will be reviewed by the poster program committee through a=
 single-blind process and will be evaluated based on the following criteria=
:

1. Submissions must describe new and interesting ideas related to HPDC topi=
cs of interest.
2. Submissions can present work in progress, but authors are strongly encou=
raged to include preliminary experimental results, if available.
3. Student submissions meeting the above criteria will be given preference.

* Poster Chairs

- Janki Bhimani, Florida International University, USA
- Massimo Coppola, National Research Council of Italy (CNR), Italy

* Submission

https://hpdc24-posters.hotcrp.com/

* Deadlines (Times are in AOE)

- Submissions due:                 March 21, 2024
- Author notifications:            April 4th, 2024
- Camera-Ready upload of Extended Abstracts:   April 18, 2024=20
- Conference dates:                June 3-7, 2024



=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Alberto Ottimo
PhD Student
Department of Computer Science
University of Pisa, Italy
E-mail: alberto.ottimo@phd.unipi.it
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
