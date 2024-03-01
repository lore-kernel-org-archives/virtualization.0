Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DFE6CDD9
	for <virtualization@lists.linux-foundation.org>; Fri,  1 Mar 2024 11:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709294038; cv=fail; b=Ghuo1vttffaiZ9TGrxppyqLcQD+NTXwenYXpTmEhoy26Ayauk1Wx2uIXXHGFMUfK1MBoG+3rc/seOg0FqsIMWCWWNWP1+U4BeqvuPUyN0DnhG95gwkQ4vEe0cRUwgcti+zsvG/NZdNBptiO9kW2yaL15rzP4Dxmsti/dQF5wu4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709294038; c=relaxed/simple;
	bh=e7mMWPQJFP+SvK83AK30ebKr4iTkt/JKNpFx+6MfydI=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=gaG7oQiOYkaj7aSflBOU5eGz6y6QRlBcQ8Db0zwZP8SBRLNb2YcGIkv+uMai+jK52imRueACcoibp9K3PVHrymnUeNjatz+vRs7FCXJCb55eZboFuAmHzOnHHuGSkfnaswnHJPnpUdUkKNZ0EY7/Vo/9FugARIz0wXyRujaubYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=phd.unipi.it header.i=@phd.unipi.it header.b=bMIwU+mz; arc=fail smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=phd.unipi.it header.i=@phd.unipi.it header.b="bMIwU+mz"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4190D4194B
	for <virtualization@lists.linux-foundation.org>; Fri,  1 Mar 2024 11:53:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.002
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cpRY4w8jK6Fb
	for <virtualization@lists.linux-foundation.org>;
	Fri,  1 Mar 2024 11:53:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:111:f403:260e::700; helo=eur03-am7-obe.outbound.protection.outlook.com; envelope-from=alberto.ottimo@phd.unipi.it; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org BE01440471
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none) header.from=phd.unipi.it
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BE01440471
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=phd.unipi.it header.i=@phd.unipi.it header.a=rsa-sha256 header.s=selector1 header.b=bMIwU+mz
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on20700.outbound.protection.outlook.com [IPv6:2a01:111:f403:260e::700])
	by smtp2.osuosl.org (Postfix) with ESMTPS id BE01440471
	for <virtualization@lists.linux-foundation.org>; Fri,  1 Mar 2024 11:53:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KhimMz2Vz0EM259LXdBKGISFedgKSJgcLS8zpn+jVYOu9l0eRcvyWx8pxPVCgHWhZJGji2IYKoTcPdQm68aPQY8ugQ7zH7r7BS2LDLNsCZMoNjWESf1GVxFN6majjRCJfSlHmjohjM8tWt3VNHW2EGVo7hWGGoApsK9X0pjDU/5QuBNECe5b7XJxQJY+ykbpAcDQM8WU7fgXbxfvZsOl43QgC791ULn5OFT522DFfaE3hlWIJm1PUP5yrAET0BsEYKBgEbhp0QHIH4zxGZk/UMEHTB0OgwD+6r2oMm+6+ArNHtlyO6z//mnZLWwbbkif/F2QbYLyPTtPD5rDsBArRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e7mMWPQJFP+SvK83AK30ebKr4iTkt/JKNpFx+6MfydI=;
 b=g+BBl7rhIpR+eQQ8p4F1vKpX0HZIdrbLkhby2GeVbh8N+8kK3dgoz/7SdqChi6fBIGO6kG/UtQlJjlU4h0h9pb2O81zx/dcK6IWGABIN2PkRwSPNxuSKo/XYZqKV20+hq2ScWq0/JZMICUYOn50mjTwcSrijzW/MxbnaslXwcli0yBhmGoiX2KiYjl+FF4bUEa1OosUtdzNgt23ZSmhx6sxoGe7HywBnnqjwW9IFrUy/NRDZqwgq0H51tOcoS8vQpEHyT2GR+j3pItlgx14HgbLfSF6K5xCC6NCFP5FbIyp6T5iZ5b5xc2qlZxw00kpE2GS3cM58pkjKg4WBxYsxTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phd.unipi.it; dmarc=pass action=none header.from=phd.unipi.it;
 dkim=pass header.d=phd.unipi.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phd.unipi.it;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e7mMWPQJFP+SvK83AK30ebKr4iTkt/JKNpFx+6MfydI=;
 b=bMIwU+mz3YVJpnBvivnt5T9U5srLr+kTBUhhiZbUAkaDstrYmce1rEAdIuIyZ2yCTKI+WDjkHlDgGTOFxBk45Nvi0Khak1a4sEB51UQfQcrNc1gNhCOCVPxVZnsBM/nuRTdVh2Sh8sp2y/59MW+yjEbqHx9RBZNeofSw1gf/paA=
Received: from AS1PR07MB8408.eurprd07.prod.outlook.com (2603:10a6:20b:4c4::17)
 by DU0PR07MB8692.eurprd07.prod.outlook.com (2603:10a6:10:315::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Fri, 1 Mar
 2024 11:53:48 +0000
Received: from AS1PR07MB8408.eurprd07.prod.outlook.com
 ([fe80::f49d:54e2:b3e6:f607]) by AS1PR07MB8408.eurprd07.prod.outlook.com
 ([fe80::f49d:54e2:b3e6:f607%2]) with mapi id 15.20.7316.039; Fri, 1 Mar 2024
 11:53:48 +0000
From: Alberto Ottimo <alberto.ottimo@phd.unipi.it>
To: "virtualization@lists.linux-foundation.org"
	<virtualization@lists.linux-foundation.org>
Subject: HPDC 2024: PhD Symposium (Call for Work-in-Progress Papers)
Thread-Topic: HPDC 2024: PhD Symposium (Call for Work-in-Progress Papers)
Thread-Index: AQHaa88evf3lH1K2skGeFbnbKOJw+g==
Date: Fri, 1 Mar 2024 11:53:47 +0000
Message-ID: <3F48E277-9AAC-4413-B7E6-D137A891EEFB@studenti.unipi.it>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3696.120.41.1.1)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phd.unipi.it;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS1PR07MB8408:EE_|DU0PR07MB8692:EE_
x-ms-office365-filtering-correlation-id: 0e112d8c-7066-4eb0-8dd0-08dc39e641c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 NOIpeEgzlehj/eFckSznkEAUR9+FSwWuO5eOLB8K/XWdJiZ5naamFP9zChZK7Lnq9GA0my5YCq8MNQNnbRFZxzF4MjJq6OllwIvmBX3xWz5c+CXZ4Y1WEGhdfQcxrMJKrpiB/dL8NUsF8vuPL2W9woAZtEqjUUCUmYF+3pTzNkY6F9LmB1YwKfo1gB3ZynTWU9r9SHdjM0juN2YO16w6MPF7l8gYXpzJ9gLAGZx2i/0FraNVKrmX2W2SXBM91vVMi6PX5qMfnv3J5q2lwx0Cw4/r/a7qOz0C6qu/1uZze0N98pgC45P0zZAPg6i0lKZaLgesPcuQzIN8XX+VQ7yMYJTjHBXggIuRN2hmcawnYUnCRxTthPQYrjrpqd/8x1WXaVcouKfNpAv9O6I+sKPen4BRDcZYBJmFaZbRg2Z1CttW0ajUHM/v4XRAH4JO8GbphSviDaiMSWDj+kaNnPArnp4Mbq+WZvysNz0O9i0N0vStmaqps6DXH0ts/GqHaPRdZct6/Af33rCiRfPPo1YBdE+6lULsTJ01zqffv6KWWNukfAoNYhEuPkdyzKyxXT1y/kT0ENTI1KXDBbXgajwws4pSeWSjAMo6xyFR7GFmPcFB/RYO0LQO/nI38h9a3Lf6iQ3poIMvF9mtKP4GX7pM0o81d36QEi4XwVjETczFaLQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR07MB8408.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?NHPF+Dxv/mkCGFl2oHdJuwMXnuO4N2hTFPt3K/epFaR9rO2y2yHr43uizA6K?=
 =?us-ascii?Q?hCIOMEqkiD1jvobW0IXaNkA7yTvOIN/l6KRGcCfYF1K0UVCBUI/llaAORlxN?=
 =?us-ascii?Q?4w8LHTjxfu+67Ym6Gky+tjZ3VI6jgWgMGAXSpeGlQI9mxfLy9bxp5qTBpYys?=
 =?us-ascii?Q?aqynZCcghjmqfWE8KbRzSpru/4onNJlYFUIlNl5UhkuKQrgjdBTnMTtgz1w5?=
 =?us-ascii?Q?r7zClI098MzQLuqkBnepQGr1/TQxANC17Qu5XADBKF9vQH7XXBsp5mLynRTs?=
 =?us-ascii?Q?9im5gwyRWX8RpO/wX/3wA5yf3/er3TB08dzszyjFhz63nXdcSG9JuXXwfiOl?=
 =?us-ascii?Q?DduipMdEZnKLRrGYsuW8OEGkZ6PvPElBW3YFwV44MneS2Ir0i07BzCbp42Bo?=
 =?us-ascii?Q?4ju2YHZvauiEa5KXgvBVnGLNICZ8nNI7El4ONGSX/sNqUeOoSDTc7wk1XpP/?=
 =?us-ascii?Q?oJYwKT1gHP72o5gtbxf8JZhS55z4tyTvCstiUFqn8DBLT2P0h2SYe8eLKcu3?=
 =?us-ascii?Q?i4IYIXpGJIWbyGLToroVrInNf3b9rzvVONVVE52CnZqF3uRBwi+byfR6fwYF?=
 =?us-ascii?Q?xeF0suG2rnSLfIIMHUJ4y6h8xJci0JXyhG4QVc6HKGeDy4g+yQ84nUT6UMkE?=
 =?us-ascii?Q?Q+xkrP98J1DLcrhI2DN9676q7tTY2KdSz0cSUDbkkF7Rym2TXarjEAazO3Es?=
 =?us-ascii?Q?2E78bteqQpXvgedlo6M6DyGvWP6VfwuaoWrNQsjZE3YVBVQ2wK7VgRkmRgyd?=
 =?us-ascii?Q?sK7NTLwf70s7xoSkUSIt48gM5AJpNlX1TelKV4E3RWBWfS6iuFPTCceyPHyp?=
 =?us-ascii?Q?9bUAH2S3APjOK1vUd5utuyMDr+tlaE9Faok9hP8hZbqZHHr/EylOX5oOtqP4?=
 =?us-ascii?Q?CeBQu8xdONjS2YLks1VNqY7f/eNQlUqvhk/FB0dkGXFXgtkbG8ekRW4dS7dS?=
 =?us-ascii?Q?7qeBY6UX2KI7qQXb27Lz2HVaJsHOZmGz8TCYqafDZkR2KvZjNZh/LXxtI9Jn?=
 =?us-ascii?Q?nS7cIVdqf5VfiqTKvmXf8h4fCr6j0yLICRbhc7Nmz90/dxi4xEO8Qw3PxTks?=
 =?us-ascii?Q?QsHAUdb9E/em1RpT/3YasTK/VlwwN3aPAL/ou7D1pc+pQNPFI8vzTtmeMqyW?=
 =?us-ascii?Q?1nJmjbPcKBTJMaLxIeUbZsLHlfGzZbGLtMTj/tKQfVKh6Tfo6gZrnUNbUBS/?=
 =?us-ascii?Q?r7832bIQVQjUnspulTlUayixbHF3AxoOKp+Q1GvMC0iNhR1ZUVKNWRDLB527?=
 =?us-ascii?Q?6ULgGQoXvAFjBkQ2S+H4lgHYYMqRqqJ91w+h0COtqaVaOn6nIwq/T01Xhmvj?=
 =?us-ascii?Q?OCnv6EDSzXhPBW8GS/H6QSWvkpKeRyKpfRLqtvAsyHQLaf/UxGlRzQAJNPOe?=
 =?us-ascii?Q?5Kh22ABx4A2JdgwXMbhdE7Ka5Nacgmq+mDvneqeRhFybZAQZa3vdbRCNegE2?=
 =?us-ascii?Q?D0AKxktXDUdchIbUJCGtPPuhUxou7/4lq6or6tpdjGxobwGqD8usJsdKaszt?=
 =?us-ascii?Q?sk4g54JdPRm+zoSb81cxob1LKCmusuz2V1II9gqFsy3qYzcfvGmCUglns/Lh?=
 =?us-ascii?Q?XYcGiTcanD3LEsCRjFt+eNtXc6R+WvUciqIv1CxmzJZb2YsGOkKPw5RyGPtG?=
 =?us-ascii?Q?dDf5r+a0ACWObVFpArBf84TGkIobh2glbk3X6ZHa/kuj?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <227AD5CFE96A0041AFDB7DD476475E25@eurprd07.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e112d8c-7066-4eb0-8dd0-08dc39e641c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2024 11:53:47.8177
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c7456b31-a220-47f5-be52-473828670aa1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QLwIsE/eqjFAnsNxk9H5rlkIbrCshu58tiMeQfa4c/5uRIQ/DL90iDIkIL0xAYQamO7TOkbZcUgoAoTSBo9UHqzuEDxWKZRwCHmK8A4dUMc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR07MB8692

--- Apologies for multiple postings ---=20


************************************************
HPDC 2024 PhD Symposium
Call for Work-in-Progress Papers
In conjunction with the HPDC 2024 conference
Date: 3-7 June 2024
Location: Pisa, Italy
Web: https://www.hpdc.org/2024/calls-phd.html
Sponsored by SIGARCH
In-cooperation with SIGHPC
************************************************

The ACM International Symposium on High-Performance Parallel and Distribute=
d Computing (HPDC) is the premier annual conference for presenting the late=
st research on the design, implementation, evaluation, and use of parallel =
and distributed systems for high-end computing.

The Ph.D. Symposium at HPDC 2024 is intended to offer the possibility to sh=
ow advanced "work in progress" to PhD students working on the HPDC 2024 con=
ference relevant topics in the context of high-performance parallel and dis=
tributed computing.

The selected contributions will appear in a special section of the conferen=
ce proceedings.
HPDC 2024 program will host sessions where authors of accepted contribution=
s will present their work to the entire HPDC conference audience, thus offe=
ring graduate students an opportunity to discuss their research with expert=
s in academia and industry, and to make useful contacts regarding future ca=
reer opportunities.

* Submission Guidelines

Graduate students are invited to submit their paper of at most 4 pages in P=
DF format, including references.

Papers should be formatted in the ACM Proceedings Style (double column form=
at) and submitted via the submission website https://hpdc24-phd.hotcrp.com/

* Important Dates

- Abstract submission: February 19, 2024
- Paper submission: March 1, 2024
- Acceptance notification: March 25, 2024
- Camera-ready version: April 18, 2024
- Conference dates: June 3-7, 2024

* PhD Symposium Chairs
- Valeria Cardellini (Tor Vergata University of Rome)
- Marco Danelutto (University of Pisa)


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Alberto Ottimo
PhD Student
Department of Computer Science
University of Pisa, Italy
E-mail: alberto.ottimo@phd.unipi.it
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
