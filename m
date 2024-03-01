Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777376CDB8
	for <virtualization@lists.linux-foundation.org>; Fri,  1 Mar 2024 12:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709294710; cv=fail; b=ZJUChk++ve+mljFLZO2OTgD6aBPQZuXUj5/ZOUDzw0tsnhjMMt2gFyUZ26y0DKSsp1HNtFVfgT9wO7t/4QLjHBAuK6OPxnYGX5AwITfGmSrr+u6p4+j/8If1MGBmqjDpZuYO/tgYFfCxuDDMGrq9uGXhLfKYJhfJQo3l8FVfqP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709294710; c=relaxed/simple;
	bh=gYIJxeJUENp8gfJWhBQLMN1PiqxSEZJZO1DkK4tR8EM=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=lYIyhp/4t7ttvVh5zVBYPEiVKT5iax9gRzNxCuEX4ZTjj4ubnLnAwaJmRL1JjTXAkLMlw1KgdU+SxlODa5tT2tp84hW7H9hvWxteIRXuhHTPOP6EdXR4P7r58ol0GKFFvzeKn7ft9gqJve9dcZqpz6m/J3TJU2T3iFaliRJnPVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=phd.unipi.it header.i=@phd.unipi.it header.b=DjO/ZSPT; arc=fail smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=phd.unipi.it header.i=@phd.unipi.it header.b="DjO/ZSPT"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E48C681452
	for <virtualization@lists.linux-foundation.org>; Fri,  1 Mar 2024 12:05:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.002
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uAx0aPK1GQmO
	for <virtualization@lists.linux-foundation.org>;
	Fri,  1 Mar 2024 12:05:07 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:111:f400:fe02::706; helo=eur01-db5-obe.outbound.protection.outlook.com; envelope-from=alberto.ottimo@phd.unipi.it; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org AFC638144E
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none) header.from=phd.unipi.it
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AFC638144E
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=phd.unipi.it header.i=@phd.unipi.it header.a=rsa-sha256 header.s=selector1 header.b=DjO/ZSPT
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on0706.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe02::706])
	by smtp1.osuosl.org (Postfix) with ESMTPS id AFC638144E
	for <virtualization@lists.linux-foundation.org>; Fri,  1 Mar 2024 12:05:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uxe1bKMRmV/ZBz/zE6LkWSEJuatP1eFRfqiKrc+sU+eYtQes0S/kmysvednLotJJRUhJvyuDri5Rd5CBmZORWXEPkejnv1OZDkjUL0Oc7VW9P4yF1ZgOriI+ZuSaBDu3klN6xDx5yI4EGH7ho1OjscEU4u35LcmlY8vDnhnq4gtblVeb6WTYJrkxZWGAZ/ls+I1436MiR9bXh/8QqvRo3Y+m44cTah93kA09HZ1gu7ztinFZQEDQr1QMT84KR04j4l9K2e6OJFP7PhovhK6E2nXb3i5WHiV0+cS0eRsgx0coDR0eyE4D5/c+Bq4pwkIlrvcDopVX3p5aaxJsubJVHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gYIJxeJUENp8gfJWhBQLMN1PiqxSEZJZO1DkK4tR8EM=;
 b=j3TreDdj6K5VWqFSsIJ/HdmEpCSYrodu5O1K+fjJ/AceJ9misq3Y+11xmTPCUQX0uhKvkT29hrgo7Zr2lK8zDVDqJc0btQfpD6PrteI5+g1peHmI54MbeO287AO9JG+xOX8ZkbBama1c0/uRgkWieoLFeyWy1Yuhl9jO7Bsbwp5pwyrSTPvzXUAI6SF/MK/CNdXg3THinblKU8D/Yv06BU50y+s1Odin39SX67YVpSmkr8ppQ5E5ryA3qX9OqHVfUcArn3DqVPCFvo1r9Mu4Gphi2YWyzzkxOZNrNmWY4+aYrGYIutjDK0ec2juu1p/Iof3FDZu20E+QPurKVp3h7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phd.unipi.it; dmarc=pass action=none header.from=phd.unipi.it;
 dkim=pass header.d=phd.unipi.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phd.unipi.it;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gYIJxeJUENp8gfJWhBQLMN1PiqxSEZJZO1DkK4tR8EM=;
 b=DjO/ZSPTxENqRYoXf96htSwEPcz5xMoFVxERZTCwQl+pndx21Bnx30KfdkgDkBh3JJ76AWpgUkDYSYvf/Ys8XxeDqgZQDC8rfw2Bw/bJrl0L2jQ0xZHQyCNyb/OeOLEmBSkw07um+40LoKFb+qwoaVTUI+B8mXu3QsDWIOKC8Wc=
Received: from AS1PR07MB8408.eurprd07.prod.outlook.com (2603:10a6:20b:4c4::17)
 by DUZPR07MB9909.eurprd07.prod.outlook.com (2603:10a6:10:4dd::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Fri, 1 Mar
 2024 12:05:02 +0000
Received: from AS1PR07MB8408.eurprd07.prod.outlook.com
 ([fe80::f49d:54e2:b3e6:f607]) by AS1PR07MB8408.eurprd07.prod.outlook.com
 ([fe80::f49d:54e2:b3e6:f607%2]) with mapi id 15.20.7316.039; Fri, 1 Mar 2024
 12:05:02 +0000
From: Alberto Ottimo <alberto.ottimo@phd.unipi.it>
To: "virtualization@lists.linux-foundation.org"
	<virtualization@lists.linux-foundation.org>
Subject: HPDC 2024: Special Track on EU Research Projects (Call for
 Work-in-Progress Papers)
Thread-Topic: HPDC 2024: Special Track on EU Research Projects (Call for
 Work-in-Progress Papers)
Thread-Index: AQHaa9CwqH/X5Jrjl0azato4K8qHvg==
Date: Fri, 1 Mar 2024 12:05:01 +0000
Message-ID: <0AEAAFED-5C94-4D46-8611-AF8A55D6421C@studenti.unipi.it>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3696.120.41.1.1)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phd.unipi.it;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS1PR07MB8408:EE_|DUZPR07MB9909:EE_
x-ms-office365-filtering-correlation-id: 3daecca4-489c-4a5d-8955-08dc39e7d33e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 GtRhq6It1YbhCEqLpPv8yaOJ0erfvgHBQ4JRfcOFG9TS0tuNh5ylvQJE9V8uBU8LtYyWLjnlaY1nhQxX8WrtRQ0CQNiHclPfXSFsmcxVZwdzK1Ed3bguMsDZIBp7TAuTudZaeeD/ofYeT7wI6VoxIRg+/MViIwC3AwlElqzrS5ka3VIyjWTX2LAdgcE5/2ks3N7D63PSQ2zsuee4DGPcYYqc3E5neoQbtfMQP/S6DQEa/RMURm/kf2OUOK2WOagVpuvvgSdz5mZe0W7bDmWS/Jigc8wSnPumLKkmLsjiEfWSfnuvazdxZfh3fFbij0wKTUO4Y7eFSALk/zVdBoYMcN3WT85tJAy3Pix3lsxcQM+v/iTQqraelV8BtWYQDMqslkhVf8Qeo+qx+B+Odm+FZkRbNmGQiWnD9Q8SsoDNaax+Y4z7OcMv9yp1hmTekzHKfBonv/9QQsYP/JEcuX9BL8qUe7zQ4yDZFvj17v78KbeDMcNymUjue/7FFoX2PdqmQsSQ4r7xlEpZr14sF1kL1rdkYh2NFSDC0VkhX2jmY6IZH635tsoxcFlVkl8aDI3z3Kit4TSBKDrCYxRuudjlhmR1nsNQfr9hBXKyOlyonZrtzGtR0X0m6PGXh02879mQwJwjmaFdNWtlE9NtRUro9Vl++qZmdjJ4wPk/ZwrM62U=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR07MB8408.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?zqDYSQ4F41n87dxDVmUcPpH3We8rjHOvmH3Cm4jJDRfT57AxgpVguN7VheuY?=
 =?us-ascii?Q?4ARaD1eM9rkohjiPvIp+qa+ofDAGWO2VGR3nyLjc3SyVfPPYufn9sQPZze2u?=
 =?us-ascii?Q?YiEopXEDwe0nO7pUQRZ/YHKPRylDOzbbgEzVLU0a7ELGVMjJQLG5nh9RN0SR?=
 =?us-ascii?Q?iEabbV/Q81ZNseKaeQgaF5YtG7XdWrcfxvQn20XhVaI5T9CpbUJm7jaR4kZI?=
 =?us-ascii?Q?9ghm8lMVWxnhx7ECbOALw36d4piKbgFYrQG3aQFok0Er0E2g+oyqIQ+N6NZL?=
 =?us-ascii?Q?w5JtJwn+ME5dDciP2HBUzyvzEu88HY5c18+HK9o1evBjImliSG1E+VemAbWW?=
 =?us-ascii?Q?ddQmrkNOyCx3E96nelyojiztDGusMzbJg6MCoA8cXGvqoAUp6Xq00eFbbkyM?=
 =?us-ascii?Q?M2JrTLZIQe5OUVQKC2p9s8Npgr9Oql54gj71D0mmg8p8VSZQc3XCdfBgN8yA?=
 =?us-ascii?Q?uuS4aqgtt0n21uXYoQJGgqVcCLHNitOkoL+IixWflIg7DNPvwOdcurkbD+0T?=
 =?us-ascii?Q?eVJDIrKarPazDNemCnEEkISorurJWr2u/sjaDNJsjgDHjXgYqoAaDnfcAOer?=
 =?us-ascii?Q?ulUz1/rtHkZgnSfmVH0hJ7zvMPdQchCTJN7e6Wld7PXHbIkaKIMBdeZK7NFX?=
 =?us-ascii?Q?GaKyVDNiJuFQXLBUkESgxChTVx1v8EAfkqj0djtYtBqAGnRQq0UoiZ7Tc9Yr?=
 =?us-ascii?Q?VL7ARGUmA9g3r0UY+at9sMbd+hKdfFjb9T8lmKOS/UE3CcAuT1XCJrNE62dR?=
 =?us-ascii?Q?QeprPgwDrJcN6pCaPPk8y5xLWzZ/H+dqlSdh7NonNTq8/WkHUZaHy8F0IAuU?=
 =?us-ascii?Q?NEVCy/bqP6W2bh9ZMPK+DLmwhznh0581xPo9U6KxOxRUI5bGCEHUpxKLRNu7?=
 =?us-ascii?Q?MhnhKveC6TttUCfM7HEcyHJQwIuMdrW58/TQgFOAi4C3kPEP3lz5aBTolbLz?=
 =?us-ascii?Q?GJtKEiYJu3czEXSudYOP4TZNyTMMUvJY4mCuMRAZuRlbcFwzjemgI+Nq3+Wh?=
 =?us-ascii?Q?MtK9dXOLBMArZ7S51wRwS/z9xd5DunIAk5e77dUIH9tvI0KIIXMnJC1lck+h?=
 =?us-ascii?Q?nI0XGYdR8SmLj/XzFg+IznK5LmJ3k4A7rk6N77yDhhA5FLlz4EAR2KBgK/k5?=
 =?us-ascii?Q?KrBxSi+4xZbZFgWUotR9rAPUUrNG97wE+LBgykSY54kCE6JEzwHYiItZI3S8?=
 =?us-ascii?Q?awVXlFBS3F2hBlKLSlT+Hnw3mdiXWTxtpRG61XxHublXqoRFFBInrw0AEMAi?=
 =?us-ascii?Q?tMrb+p4TXL48SXBinUil58/Z0vU18QQ7IFQjaYgF0q5lNOL8O2rT5cGVP3ds?=
 =?us-ascii?Q?TqBDKHaqSIwXbE+BRn1MGbOVi4dP6FgNp3yVfMeFGK4cuKeVREA2s04C55va?=
 =?us-ascii?Q?pkW9ajK9TKzF3gHRW8Xw9jmri8oqlR7DpUXmfYueaeCzCGntAjSAyJDUemhh?=
 =?us-ascii?Q?p1gIS82WI7fAHp3EY6Bolt2TqJLeX9I8zpp6T1VockXs4RjPAt4v6jMDApnM?=
 =?us-ascii?Q?dT42jTGN9xz6hVeQwy8CFtSakfXE890TgmzA1guvtw9Ed3+m2wteIrfC2NSM?=
 =?us-ascii?Q?ezFqP1vIAFUi1rYMMFLePTGURgNS3HZsVK4nk2Ylk7zAKhmPdm1dAw0F17I9?=
 =?us-ascii?Q?lvei/KLe4a2hFiBGYRlbuM9RkStlOMMKqTyk3QsmoMhg?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <55531B5624D0B04C86F8EC4499B9BB24@eurprd07.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3daecca4-489c-4a5d-8955-08dc39e7d33e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2024 12:05:01.3460
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c7456b31-a220-47f5-be52-473828670aa1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rYWme+91+WBHJUg45VKTkes1mHRQ6mlUL+Jv4Wzt6+A3LHrE36gNyvO6bqoPYTwvmi3l3Bdub8J2PppUQCwcYoZHQcYYuaSLfDN3KdUECRo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR07MB9909

--- Apologies for multiple postings ---=20


*******************************************************
Special Track on EU Projects
Call for Work-in-Progress Papers
In conjunction with the HPDC 2024 conference
Date: 3-7 June 2024
Location: Pisa, Italy
Web: https://www.hpdc.org/2024/calls-eu.html
Sponsored by SIGARCH
In-cooperation with SIGHPC
*******************************************************

The research community works fervently to address the needs of novel applic=
ations by pushing the boundaries in the field of distributed and high-perfo=
rmance computing. Ongoing projects are pooling resources, and setting ambit=
ious goals in that direction. This Special Track aims to solicit the ongoin=
g works of European research projects in all fields related to distributed =
computing and its applications. The goal is to enable the community to esta=
blish a checkpoint on their research progress and foster the creative devel=
opment of their work through the exchange of ideas among them. The Special =
Track format is particularly tailored to Horizon Europe research projects a=
nd the objective is to provide a platform to foster collaboration between t=
hose projects that share research interests but also cultural and organizat=
ional properties.

Indicative topics
- Cloud-Edge Continuum
- Convergence of Cloud-Edge and HPC Infrastructures
- Novel Programming Models and Architectures for Cloud-Edge Continuum and H=
PC
- Efficient Serverless Computing and FaaS
- Federated and Distributed AI
- AI for Resource Management
- AI for Resource Orchestration
- Energy-Efficient Resource Orchestration
- Hyper-Distributed Applications
- Self-Adaptive Computing Systems
- Software Systems for Blockchains
- RISC-V Based Cloud/Edge Services
- Energy-Aware Software Stack for Exascale and Post-Exascale Supercomputers
- Metrics to Measure the Efficiency of Supercomputers
- Fault Prediction Mechanisms and Tools
- Resilient Software for Multiple Processing Architectures
- Co-Scheduling of Workloads Sharing Heterogeneous Resources

* Submission Guidelines

Interested parties are invited to submit their paper of maximum 4 pages in =
PDF format, including references. Papers should be formatted in the ACM Pro=
ceedings Style (double-column format). Papers will be officially published =
in the ACM portal as work-in-progress papers.

* Submission site

https://hpdc24-projects.hotcrp.com/

* Important Dates

- Submissions due: March 15, 2024
- Acceptance notifications: March 29, 2024
- Camera-Ready version: April 18, 2024
- Conference dates: June 3-7, 2024

* Eu-Projects Track Chairs
- Ana Juan Ferrer, European Commission, Belgium
- Konstantinos Tserpes, National Technical University of Athens, Greece


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Alberto Ottimo
PhD Student
Department of Computer Science
University of Pisa, Italy
E-mail: alberto.ottimo@phd.unipi.it
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
