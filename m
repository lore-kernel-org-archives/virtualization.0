Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1ADF12FB02
	for <virtualization@lists.linux-foundation.org>; Thu, 22 Feb 2024 14:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708610438; cv=fail; b=HlGblglbl8uLSUdGoVaQryxxvgoJPbKXX9TSDgE1eIW2hFT+bKKpeghXnc/ZAXsqB+4Jd30G6txYBPbKxYgv3IR/r5BJ8J1aaRSpj4Ij2h3EIbyufVmsCQIdAxwk5LiK7i1btLTdvpvWZ8jtdpPReRFy9MTb/zG1o7BQEPS56/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708610438; c=relaxed/simple;
	bh=u71y5Wx2OnI7y82eUGZa5Hqp8WoGxkYgTiCyTDuJN6Y=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=X4tqdD+0JinzuoQ7Pa0FE+EZnXeSURxIDzKJxld9KsNcnz3JumLCLmqdz9Bs2iRqWvHSu+sCFMUQDMHrfYrbkET5CVA1PTVpphBRZbtxJ7J5+TIcVAvOyWbzsy11tpVO1HN4y6fwOCcnIzmvBQngT69f34eaDLg+/MOf8aLGgYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=phd.unipi.it header.i=@phd.unipi.it header.b=iGutL9yb; arc=fail smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=phd.unipi.it header.i=@phd.unipi.it header.b="iGutL9yb"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3220560877
	for <virtualization@lists.linux-foundation.org>; Thu, 22 Feb 2024 14:00:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.002
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 77vn_EdcHt0V
	for <virtualization@lists.linux-foundation.org>;
	Thu, 22 Feb 2024 14:00:34 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:111:f403:2613::701; helo=eur05-vi1-obe.outbound.protection.outlook.com; envelope-from=alberto.ottimo@phd.unipi.it; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org E0F6A606D6
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none) header.from=phd.unipi.it
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E0F6A606D6
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=phd.unipi.it header.i=@phd.unipi.it header.a=rsa-sha256 header.s=selector1 header.b=iGutL9yb
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on20701.outbound.protection.outlook.com [IPv6:2a01:111:f403:2613::701])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E0F6A606D6
	for <virtualization@lists.linux-foundation.org>; Thu, 22 Feb 2024 14:00:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cX0v2mS2xWMLxonfvACOTm3RrStmnEMASZEBv6CRFEON8NXsfhmtKIWfU6ZDfPV5UcsIEVsr+IEKOPqEUY8j/ZSYaGL+Sig84osE/0vuVGDNL6E3PXhhQqCDpdvUtMMUbFLPMUjXP4vH98HivycEFsFfao5X12v0AOR1Km/Kfs5uBYkNOc7iWx9C+y26S7y/9vbOKUAG6V2wwjFgfTF5hEqPl6zn1kJ8oKIL8BUMslusEU/FVM+c2RlQsYFVtU0sOCmuDzqainwt9t+23pG9l6TfyqQmzT4wLK71l3Rw6i74Z22rQCe0kp96ZY2RFRNqmdx61ddYXIv4vOvmjasimA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u71y5Wx2OnI7y82eUGZa5Hqp8WoGxkYgTiCyTDuJN6Y=;
 b=axj5D5YlY2AQ/LUizzXe8kxKJtZ6jr1zU+x1JwuPF2sovkHQCl48Cfeq3lUy3kraSshfUEmi3Qk/Y/V40DdNVQ8wHRlACb6l770+itlrrh/MOS2TMjoIF8MZAx/Gh4ytfMc67eyJSJ31dG0dZuOP6JvsYagyVXfuncA+TdtpSs6iruq/lzPku+PknHE+qMQJfBrvgM70KrchwQvNgNzHm0hgNmRSa/GfwWPqfApLUWO2e5b8P0bSmk7T1Ww4DvNxZzkR+v0uA54bQUd/LO230JyITLHUWkk+LF7xCl3BxI3zxeqPjIv915ZkeMW8kr47jz9ZjKl8fokvaVXh6ws3ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phd.unipi.it; dmarc=pass action=none header.from=phd.unipi.it;
 dkim=pass header.d=phd.unipi.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phd.unipi.it;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u71y5Wx2OnI7y82eUGZa5Hqp8WoGxkYgTiCyTDuJN6Y=;
 b=iGutL9ybKAhWXSt3RsVjaX8Z3OcXrIInkGT6VCRNwql4oZ72b5HR4k/5CnrQ6hQYtCGpxDZT2/M/Wrq3QqQpcQ6Zgfux3ArGWQrY38nlWAgVVDC1sgBGG/Tlhu6yTOVergrYMVwbwDb9SCNBZ1RUsuo/P4/ufhrwEbEa7Kc1r48=
Received: from DU0PR07MB8393.eurprd07.prod.outlook.com (2603:10a6:10:350::17)
 by AM7PR07MB6785.eurprd07.prod.outlook.com (2603:10a6:20b:1c2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Thu, 22 Feb
 2024 14:00:28 +0000
Received: from DU0PR07MB8393.eurprd07.prod.outlook.com
 ([fe80::7eed:cb10:e315:d71b]) by DU0PR07MB8393.eurprd07.prod.outlook.com
 ([fe80::7eed:cb10:e315:d71b%5]) with mapi id 15.20.7270.033; Thu, 22 Feb 2024
 14:00:28 +0000
From: Alberto Ottimo <alberto.ottimo@phd.unipi.it>
To: "virtualization@lists.linux-foundation.org"
	<virtualization@lists.linux-foundation.org>
Subject: HPDC 2024 PhD Symposium work-in-progress papers
Thread-Topic: HPDC 2024 PhD Symposium work-in-progress papers
Thread-Index: AQHaZZd9Qn48IqzDWUiH0OCU6nJYDg==
Date: Thu, 22 Feb 2024 14:00:27 +0000
Message-ID: <15C97399-6B18-49C0-8206-57E3E203DBCE@studenti.unipi.it>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3696.120.41.1.1)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phd.unipi.it;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR07MB8393:EE_|AM7PR07MB6785:EE_
x-ms-office365-filtering-correlation-id: a30c2fbf-9889-4f6a-bc74-08dc33aea01c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 SlCIYmQdMDE4CNGuje/kI6pybm/pf2SJ9Je72dQ8yYPiHqhC3I0uu6ViXDa9o2volGngFb+4FIYG/0yG5I9D1ZbRFyhBSf/N4NDuvm5qK9kmrOBHx6pD+NrQrWk0dMHWtWCDXPY9YU+7OEMnkhwtx0KeOarmcgO/8ndmPg4j3Zfr2n/d1TIAfd8wfh+Cvvg+xudoUss+AuWhSCllKuqP1PsI93CbvJWNhrzSdEogXIA+utBTCxmPsH7iwjjvjrGDPehSTNBAMvBLSsrX3sKAGr0/5TT82nS/Jrfn2oKPbKBHrpZscmRt77pzOkXbogMxgHFmAUmyISe7XwOV6EM+wJAHpYeBhoCepDD+GlPBXEo8ujQXz3TGPwt7qqPmu7W+nJeMIdi05igFvKyWF2jPajiCtIB85GLAWkxPxCkfos1MsIyUlqJP6Wk4g7nPwyiqhWxbFi8SwoEwmkselL6tLPKs420jTlqItJWBJ96TUzUhCaYtxzHLIX70+JW5vEu5TV1SXPkhkDL+lsrleje/QlCeFkGNwY5y/iknPa/j7rUFwEVWtPRreXbg/9LUsq0iwLseerRNfdIF0E4uYRca4HZ123aYBhe6/ZcxuMrfAsQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR07MB8393.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?DH7gZ9K0CMWKxWjFDFQO6tM22UfwjZwLcIaAu0AP9yClOg4OuvXB9jKY2/dn?=
 =?us-ascii?Q?47ICjIXMNBcbw0H50leA/qNBjta68WSfoaq+9U0+NOI01UVVJTefL/AUNzI0?=
 =?us-ascii?Q?/KgsXiinmOsdnmIn/drOalRzD6/WJLU+UhkMkk4Zy5wczAqoJL6c0S+LyFCO?=
 =?us-ascii?Q?TYaMIddNo+6uGmKfWtnZJWEAB+dSUbJ5DdDiZOgcVRuaJKj18xo+Ndg1xbiT?=
 =?us-ascii?Q?Esz1NUXMdi4nMrSy7wOqxfjDQxEP5bsHK1L9xuNYuKg33yE5tk8qMCtNRSqt?=
 =?us-ascii?Q?auCZKZQuOTztB4hc1Py1pTusWDT+9H7i+yuK/YKwIc0dAq7R0zZZHwdLylIq?=
 =?us-ascii?Q?hankl75Fd1VyuOT/bVwdZqbYGG0AA4HF9U2r9R7fIOdDD6HzbS4DR2S+JM1Z?=
 =?us-ascii?Q?Cyl+stLTY8slIZce2djEFsEiAe7H/9jHGrM47XHpC6YDv8SwVUlnyfXDIYDP?=
 =?us-ascii?Q?Mw3i1TmtzHSbffkEAcquiKUtWOpoFO28Nz/VGT/Bu0ymb41q9FPJkyx/7mUw?=
 =?us-ascii?Q?N+7CE8+BZPCp51z8Xi64+vorGDdzo+j7Yak/rREi8XANt6KCm9F3TMg7d7H8?=
 =?us-ascii?Q?kFvfDP2yfgbQ6FSXYUdil4o2OFgCDvMNug6qbzWG00DWR6Q3xwoqO9Jda/3g?=
 =?us-ascii?Q?1Vi2V/Tc5FEOQSynd9YYspQ8+nzi1SBAJiKwR9E55kJR6XuK97me8CqiVQVH?=
 =?us-ascii?Q?R6lZ+4Ha1p7q09/r31S2X7UWsYfuK62h2Y9BMn6czuCMo6HbkrcschnKuIQL?=
 =?us-ascii?Q?6YAMfanXCZEB7Pk2elL56VoAzF+FJaC7euy5bcRls/R/QtE0RlRLjy2CLCU2?=
 =?us-ascii?Q?ON3af+FxohNDMSaC90DABuXsLqmGLqNZ28uNAe1+MTmOie/VSPe8tbEGKC26?=
 =?us-ascii?Q?PC0+ESmCZKRZz7sWzoQVnLdGkyTlXHTYKW2B/CZ5IVqSNysGjIGssOieTUh6?=
 =?us-ascii?Q?HKH0N/okbEg3nPzkBfku3h9AXAL9Uuogwgvj/9PJ5yKgkQJWsVRnlFMsTlWB?=
 =?us-ascii?Q?oNAG9q0xD9AfQqYqS1/hOdbYBTOiBpuNDO8z7aQ9EvRJHS+im2zNGY2GF3gw?=
 =?us-ascii?Q?tDTRFcM4soqrGNloER6ojs5x70xAbZth9JOQash+pfT/fkfEz1SGAkOLbQ2t?=
 =?us-ascii?Q?gqSWK96fDGpG9TMtR+YlybBU8vOAhVixhBnshEj0RqlM9iksL9oHOSPkdD+F?=
 =?us-ascii?Q?tq304uz95SVN1dn1Gw+uCb9sdhA9+03vCBJZ2Qk7Pk8BVm52d5zIMrbrPMBZ?=
 =?us-ascii?Q?G3oU9N9P4XW45miwDQPmdCZ+lZPLTJBI+ld87wJ3hTOfik4wpYP44jqvNTWS?=
 =?us-ascii?Q?KHKBUdqKDxe9dkQ+RiJ56cVTzN7SZL6b7dZHP1C46TKwz3RNr9nI7EZjUtPS?=
 =?us-ascii?Q?Hg5QDZ0HYejE/1a0tdGMJqt4lETzpx00RC4O9QwySCfJ1tpOngATdqmcYO2d?=
 =?us-ascii?Q?kOVpNsd3YsUSHzZijCeACQli2NhMoKiHqm4puKFO1eiVFzFoVf7mEC9sD4Jq?=
 =?us-ascii?Q?pnulK0mODjKOoaWAa8GJN5FP7Hyg+43fBy5Hh6KKt/U0qUYZHHjan8JGMXzL?=
 =?us-ascii?Q?HrWr4yJS8cfMfXh25ieqOenzWxx3CqOjLPW254lFcwRMZ+REeyDiv511yimD?=
 =?us-ascii?Q?Q2oovMx6V0cYSqXBLJPMK9HJRAfJebTlrF+3V4To6clm?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B269ADE112DFDC418FF77B7DF3778793@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: phd.unipi.it
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR07MB8393.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a30c2fbf-9889-4f6a-bc74-08dc33aea01c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2024 14:00:27.9488
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c7456b31-a220-47f5-be52-473828670aa1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SCg+CM59Yp0ucC9GMvl3DdBOsSKAuyQ30v0SIFkOx1KpJOyCyXvkA4nfPe4ukGBOhovmfGqSXtZfoUM+wDwkermrcQ4q5idc1BP6s8niFn0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR07MB6785

--- Apologies for multiple postings ---=20

Dear All,

The PhD Symposium at HPDC 2024 is intended to offer the possibility to show=
 advanced "work in progress" to PhD students working on the HPDC 2024 confe=
rence relevant topics in the context of high-performance parallel and distr=
ibuted computing.

The selected contributions will appear in a special section of the conferen=
ce proceedings.=20
HPDC 2024 programme will host sessions where authors of accepted contributi=
ons will present their work to the entire HPDC conference audience, thus of=
fering to graduate students an opportunity to discuss their research with e=
xperts in academia and industry, and to make useful contacts regarding futu=
re career opportunities.

* Submission Guidelines
Graduate students are invited to submit their paper of maximum 4 pages in P=
DF format, including references.=20
Papers should be formatted in the ACM Proceedings Style (double column form=
at) and submitted via the submission website https://hpdc24-phd.hotcrp.com/

* Important Dates
- Paper submission: March 1st, 2024
- Acceptance notification: March 25th, 2024
- Camera-ready version: April 18th, 2024
- Conference dates: June 3-7, 2024
- April 18th, 2024, Camera ready paper submission

PhD Symposium chairs
- Valeria Cardellini (Tor Vergata University of Rome)
- Marco Danelutto (University of Pisa)

PhD Symposium committee
- To be announced soon

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Alberto Ottimo
PhD Student
Department of Computer Science
University of Pisa, Italy
E-mail: alberto.ottimo@phd.unipi.it
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
