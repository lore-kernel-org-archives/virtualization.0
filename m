Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD5646B5
	for <virtualization@lists.linux-foundation.org>; Sun, 12 Jan 2025 08:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736670625; cv=none; b=lRIWDUuAwRrZSE5EZfk4q1D9gma1MihyzpTyvBrtWPFGWMDjn8AZH8mQMFPJr9Ctr0CGgBnUFPXKtCz14nRNcdhoyVSFYihTJL5xCEjL9QKu7CLB4nok7JDblPL8URPB9606UrQHQQQnmSXZeEWQqvW4SKBkjLJwZkvoOMR9fTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736670625; c=relaxed/simple;
	bh=cNsAJ5Z+S+BBakQmutJQpXGCj/CMJXqvJshLZVo4eoE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QqNYcylnBb6y9yvcpPv9r+HuCQuzM/fURZeEIPaCy1S+PZBLpzJ2t+6PjjwRg6M4HrAveHF649VatNM926PgF8XAWQ5DS+Lbq4xWKYDwOQlNFmUvMD5/Sa4fb0zdPlxBcuXQjz/LDWe/xp910988LvSC83RZqF2KTzSCzpUvBpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=arizona.edu header.i=@arizona.edu header.b=Az5Y3wXn; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arizona.edu header.i=@arizona.edu header.b="Az5Y3wXn"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3F1ED81347
	for <virtualization@lists.linux-foundation.org>; Sun, 12 Jan 2025 08:30:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.79
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xGE_i5YyRKqF for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Jan 2025 08:30:21 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=170.10.153.118; helo=usb-smtp-delivery-118.mimecast.com; envelope-from=sahilhassan@arizona.edu; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 7CD6281344
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=arizona.edu
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7CD6281344
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=arizona.edu header.i=@arizona.edu header.a=rsa-sha256 header.s=mimecast20240207 header.b=Az5Y3wXn
Received: from usb-smtp-delivery-118.mimecast.com (usb-smtp-delivery-118.mimecast.com [170.10.153.118])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7CD6281344
	for <virtualization@lists.linux-foundation.org>; Sun, 12 Jan 2025 08:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arizona.edu;
	s=mimecast20240207; t=1736670620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=84tR6yC2J4BmdPFhBiO8/GYMeTxyWfKjBPbgQgSlT3M=;
	b=Az5Y3wXng18AM58civpXjO7JSkUqU7bYZbtJQtjf1HwbGGZk9fhe0gPtr5bSdTlrAfGUJY
	J/Df7FkQgWHg3LlH5oBgsCqVBmFZ0Ui6EudUrKrgApO7Mr+97q/NzK79ydSIqq2FfMCL60
	9wnWM2FgaLrfyxPpGhKoC4MHYfEAeCd3bDDlRV3wdbuJkpQBB0I3NcZ8/hnBT6kFkEy73+
	xZQReODcb1B7q6RPzABlSF8MdZRJfkpYNU4vbooHVuE0xQtEsXQdJJIBShCtTwjMUotOvB
	5vLk5DEKCJ0LEjEWyM8rTSO/5+cndAq2fNYXcWmQTmM/2fSiIg5fGJsBD7sOeA==
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2042.outbound.protection.outlook.com [104.47.70.42]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id usb-mta-2-SLLEpLRJMLirIty8LSWh6A-1; Sun,
 12 Jan 2025 00:30:14 -0800
X-MC-Unique: SLLEpLRJMLirIty8LSWh6A-1
X-Mimecast-MFC-AGG-ID: SLLEpLRJMLirIty8LSWh6A
Received: from CYYPR19MB8118.namprd19.prod.outlook.com (2603:10b6:930:ba::12)
 by DS0PR19MB7925.namprd19.prod.outlook.com (2603:10b6:8:163::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.17; Sun, 12 Jan
 2025 08:30:10 +0000
Received: from CYYPR19MB8118.namprd19.prod.outlook.com
 ([fe80::aca5:563b:9d89:ef9c]) by CYYPR19MB8118.namprd19.prod.outlook.com
 ([fe80::aca5:563b:9d89:ef9c%3]) with mapi id 15.20.8335.011; Sun, 12 Jan 2025
 08:30:10 +0000
From: "Hassan, Md Sahil - (sahilhassan)" <sahilhassan@arizona.edu>
To: "contiki-developers@lists.sourceforge.net"
	<contiki-developers@lists.sourceforge.net>, "icec@listserver.tue.nl"
	<icec@listserver.tue.nl>, "tccc-announce@comsoc.org"
	<tccc-announce@comsoc.org>, "virtualization@lists.linux-foundation.org"
	<virtualization@lists.linux-foundation.org>
Subject: Call for Papers: Thirty-Fourth IEEE Heterogeneity in Computing
 Workshop (HCW)
Thread-Topic: Call for Papers: Thirty-Fourth IEEE Heterogeneity in Computing
 Workshop (HCW)
Thread-Index: AQHbYwsnKyaGSeWwVE+1XbJtqXr/6Q==
Date: Sun, 12 Jan 2025 08:30:10 +0000
Message-ID: <SA1PR19MB81165562F01E8C2ADAE786A7B91C2@SA1PR19MB8116.namprd19.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR19MB8118:EE_|DS0PR19MB7925:EE_
x-ms-office365-filtering-correlation-id: eb87e2db-062d-49e5-6f9e-08dd32e35411
x-ua-ms: UAConnect365
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|10070799003|38070700018
x-microsoft-antispam-message-info: =?iso-8859-1?Q?oPS3JddMH3EykWNh/0Kp3gXAMHO2/4Qr9lYMh2KX05qUlt/Sxc0iZD1kSh?=
 =?iso-8859-1?Q?+XvSZRza668d6V8LDkcCifD3ZZDvhgUdUSM6og9bTO/vm2ldjrD7HeJLzG?=
 =?iso-8859-1?Q?5DYRgH2dNKY2CsXafSYoSGvNvOZVUvipNnC3jx6luLO2vnIdvXgWKDWVJa?=
 =?iso-8859-1?Q?OVCgupR5L9HJNZqrfXL7wq+7g22V+HYYvwZqA1k/klG+1jlLNtt20wkC1F?=
 =?iso-8859-1?Q?y2mMPogReYRr3oJBDzMIrlgQIHTp4L/qrPZ2tPr19+c03POvTEbSvy1mtW?=
 =?iso-8859-1?Q?oKg/5x+L7eGTrA5v9lMRRRvoOow8Hj6yVOKzdDH8qbBHWoYRIsvxvj4yAy?=
 =?iso-8859-1?Q?2nxYrYXtSZ9VzvaK9CCOgvRJ8MR2vHBzooPU1FW2XLFL6HTeYosvWyBFVN?=
 =?iso-8859-1?Q?329YkjimoL55x97onktXoRoH3CaR4u2z+sxTAIJZ4APhwrCjs2npj8rihW?=
 =?iso-8859-1?Q?NsJiP1TOngNqkfPftuAO8GccQOr+AasG9x3C7v0l/sfqeaBKkr3ut57cGM?=
 =?iso-8859-1?Q?6CSoKukKa51vQw9etH/TeY4spNsmtZ+zkUpfM+W9/jpHCesKhBClbbLvjt?=
 =?iso-8859-1?Q?55mIkZj0F6hwG9AaT8dZa3WH7TFM7wSCJn/Axmr600aehE73j8Kv0SgV96?=
 =?iso-8859-1?Q?O0Sj/bT0E3Mx7TGRAlEoKEbSZ3VX/bCbOHy8nLRzNaQpHyBOwxbuF0xVCk?=
 =?iso-8859-1?Q?T+Cx6my3bDCa9yaz8gCqjbQ5Pjbp5hnK1HzZGh4PXLf7KnGN3EyUZhX+eZ?=
 =?iso-8859-1?Q?uyQ/bgGjdXECQZZ/P0Fn66Kd9T9nKahst1IUHITAD2zf2lp3pgRU0Oeqi/?=
 =?iso-8859-1?Q?CTie+sGqkTLO2ULCuYdnTz9QPfyhP/IyFgYUydHE7hrg56ClC2dPHv7bjL?=
 =?iso-8859-1?Q?dTafZTAAVUZlsMBIr/LthhYLGD7WvjIfqvxD4oBr1lnKhFhPmL3zM23QzZ?=
 =?iso-8859-1?Q?Je0KgJb4r4cWdVfw+/5AosfIIdCBXYLwoCLB0TeS5RwN9yREEEOFwdMauL?=
 =?iso-8859-1?Q?UuvDtbORLmi5e+HSv9yodtkAXYwtB9Eg1N8hVHLpmfgXZcOu7oBfyKWFdZ?=
 =?iso-8859-1?Q?ARG+VWJ5cY9BcpCbEQ2uoR6eMmvkPGvSwkjLh001jI4Ml/7bdXnct9TZM+?=
 =?iso-8859-1?Q?/P84tF1n0vKHK9QB5xD+Gu1bXpqxPbgHUOKSVLqse2VDTS+4f+N8kXRMi1?=
 =?iso-8859-1?Q?jGgtUMaVKVb3zJOjG8ldEj4IehXeEi4K03XqBqQONSpUJ75qwjPA20E9SB?=
 =?iso-8859-1?Q?WShFJu6AdsKMk8j+/RRetJMCCR+ySEiYr6MfaA8nzfdrZUHhVYNnGKuv5N?=
 =?iso-8859-1?Q?MYXwv7Ywz61fkR9KugValC7M3inTiHUFmkKu77Ceud2ArcOSdS2Ueb/HtI?=
 =?iso-8859-1?Q?j4vSpxefyWwA57E86hzpn1DxtUt61mkn9qmpATUvGs3mdYCA10y+ME2Wn7?=
 =?iso-8859-1?Q?VE/u2PxC+DC1GsHT?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR19MB8118.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Ic5VyKTVHJj1ePsdh5Qj5tlhJ+pvPU3T95jhS3irLwCopj2AsPU7LmxgyB?=
 =?iso-8859-1?Q?FUGTIpVogLvT6IlksTEDOx+5E+skiTG8jHbgm/Lst9uKvzCxpefQ8ICZPg?=
 =?iso-8859-1?Q?4cpPyy1Z5ktZjpbM68i1qjget0ZsBi2c8Yl1ktsEzcrcfg/h8F0DG4HpOF?=
 =?iso-8859-1?Q?dWlL1FNWFPMCY5LnOEfxTEIws1SrpsSWk2RlpJ7h9yTvlFe4Nwd1KXxMHx?=
 =?iso-8859-1?Q?Qpr9eUfFCSo/hAOu/ifugjs2M38SGNqnDBditLTXX+jSFWZLsIltezlz10?=
 =?iso-8859-1?Q?sWSjCxES3p5qsIkM5338ATbMMWwlKqPSq4vK4hAn21i/uBYNEEIjofxP83?=
 =?iso-8859-1?Q?7cY3NujmdqIUcwETI+m9gOH6Jt4RguNPaVrFb6BhHoCF1aOiIDgQmcFgGA?=
 =?iso-8859-1?Q?FJ7HsQ/6V2fQr6eml3udGs7xT+gVwz+u98cDPP1fUmVZW6GPx7zvfIsbwl?=
 =?iso-8859-1?Q?y3MrNu1VAv8oUvAhKsGJhzeF9ppg/Hn7Gxg4cdBlndsUJ9V80nmAWBsjWR?=
 =?iso-8859-1?Q?R/Oil3rOozWy4UoEr9HtGm67XIQovm3QgPxIUwkLJYC36JVC4k8PJIm+lv?=
 =?iso-8859-1?Q?BXuvVlULOlsMQtuoNtwv2LdqCvSauYu0fQcf0Qr53I4ADM8hDvPLc/iHhS?=
 =?iso-8859-1?Q?kR/Ryk0C+mIi567o1pqx+BQLU3MSnxbhv2eHYFUkn5ebCMLvAiBLDJiD8e?=
 =?iso-8859-1?Q?v4rnFM2SD33DeAglKZ9Hz5/hCKtJQGZnBTiY18ltlUcz6raAduYd26fWYM?=
 =?iso-8859-1?Q?13L9nGJw7lhevdvM7O/3ejcSkszEMuvphOQRapoUOlTDBuAQTpiIY/KXhx?=
 =?iso-8859-1?Q?Pdft+QGwUKtqN+dwexOFOns8f8EMRLJ9NKJiRa8DkNJP3OvgGye7nemvDn?=
 =?iso-8859-1?Q?QKFuLsYLORDvIzkmceqZTvARpAtKGDKfWdJipJYFrUS6TomWkw1Xjdnkcs?=
 =?iso-8859-1?Q?4bWQumtE5zxm1+xbiyke6av/Un2AK9aRg4MjbiZi6UYjdCGva3P1Mjl95V?=
 =?iso-8859-1?Q?de7BtAANc0ZIt6Xe3LsKs9XfRVCqRYjUZcQ17z3DXCu0NKyfAnSSqyyO5y?=
 =?iso-8859-1?Q?Eso2aQS5thklT0vpELevcAsnmJf14wNAtpuCFZbNzDlFpqqPl+qD9xmV3H?=
 =?iso-8859-1?Q?2XGPG0rOCXuYdwnb1wgYlR/Y1Nu8HFUeLPNTU/ZpUc4bfF+GpDcGttfzhC?=
 =?iso-8859-1?Q?XVfBXdF7NW7+i4SfFmbWm1TYG2AsIxVFQhwIIEZVm3FYdrqSscSsqKry+o?=
 =?iso-8859-1?Q?bZgoPWuVsx6bXgQn1IPovlp97x3OeKfWUAHP5uJA1GZHjZyzQLnGweW1Og?=
 =?iso-8859-1?Q?0FWTGiEOORA/KSJz3xQ5uWaUoVpL1ZM/A71VwHWZ0wVuBgunVcp0Pf1aC7?=
 =?iso-8859-1?Q?PxX6pDU5mgKfE2eWMR0kZcMnuK449/lI36rw/wvTZ1G8qS28egKFUEwpNT?=
 =?iso-8859-1?Q?2tgpd/8T7tcKM0/EcOBXQqVlKDE4zKmfV1XT5whMHQMCtw/ye8PiL4HXxt?=
 =?iso-8859-1?Q?a7NsEjeg2xPsWZjhDzXbvFqitDjz3IoXMKMtHnDEI+imp8Wli2r1eqXv7s?=
 =?iso-8859-1?Q?JJx9QO/1uln50E7hzeDFeCZnNClU6cgfmg2QEgVNVuykcXeMdeiaS8/Y1r?=
 =?iso-8859-1?Q?q0WQSldR/hNOrZxxAZR4aAtN++1DR+fgB9AEr3IBcuGw/f9p8dBhudOPO2?=
 =?iso-8859-1?Q?09PTZsMUQf2dzXyiR5BcHes8uVJKTPbXZg3y53lK?=
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: rA8FJNaIx7fz5vtsw6hwMYaA6QX1WXKodZn9MYw8rN7t/NcAnW+GHlvgYDJ+LV3MgUr6FrwuTAUQeLPCg3kPr7nVBV7iWKK1xCxjeSv43WQkEcm/M4/WvmnFdQ+q9vNrCmKjo4Ua2xZLkrx9VMY1LD0Ohx3MFVIMV7QnnSxSJmoYPg8jrjv1MmBndNYxOsOwXQKEjJQHyxCXbK1HUQBha+RSehn4CnIahVZHa+YhAS+RLuNeKpNhfa7LPLD+zo5CJcam4sfdhpCw8/QxTsdp3umSteQ+5glHOQOx7/doYxcuM1vBN4+HTZXqTj24s3riihw7XQz6grwVlTZGKTyxmYMnwzIngTrggoK2RvrSWTNUn1D5r5MPKwjb00MNgkDkFgaxrqCg7RYwnP10Wz8VYb+5tsI5d5OzAVt99UI1dkKauBwZdTm302cdVGYUsIpQZCGsUzMyyYfVsJ2ySR/TFjqMz0BRACjX7JNAkWXHnzI+I4WAE2X2NC08RKe0VhI0/TK3zy349ZLHnuUg1AQ4SOuGT8KnUMHqz8B+oTHlHbsIU3nlXYIxuFxeiq2CnVv2N3/Knun1SEtsBu9QlWd0ChfqW0z98vV7UeFm6WZCP/a4thXRDVTO3uAG5IzogU8K
X-OriginatorOrg: arizona.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR19MB8118.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb87e2db-062d-49e5-6f9e-08dd32e35411
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2025 08:30:10.5741
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ee35505-eb8e-4929-937d-645df5013288
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8ISA6WbFSply7PEKIqv9AaAMQeV1yTim847HeSFtDONN5o49xmllYXZUkipGoidruCtrYyGVfnjJ8sknPfgcbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR19MB7925
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ia2y0FIVYZRrZAZhvZppCX0w0PDRYONePVmX3FKiB9s_1736670613
X-Mimecast-Originator: arizona.edu
Content-Language: en-US
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable

*** Call for Papers ***=0A=0AHeterogeneity in Computing Workshop (HCW) 2025=
=0AJune 4, 2025            Milan, Italy            hcw-ipdps.org=0A=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=0AMost modern computing=
 systems are heterogeneous, either for organic reasons because components g=
rew independently, as it is the case in desktop grids, or by design to leve=
rage the strength of specific hardware, as it is the case in accelerated sy=
stems. In any case, all computing systems have some form of hardware or sof=
tware heterogeneity that must be managed, leveraged, understood, and exploi=
ted. The Heterogeneity in Computing Workshop (HCW) is a venue to discuss an=
d innovate in all theoretical and practical aspects of heterogeneous comput=
ing: design, programmability, efficient utilization, algorithms, modeling, =
applications, etc. HCW 2025 will be the thirty-fourth annual gathering of t=
his workshop.=0A=0AHCW 2025 will be held in conjunction with the 39th IEEE =
International Parallel and Distributed Processing Symposium (ipdps.org). IE=
EE IPDPS 2025 is sponsored by the IEEE Computer Society through the Technic=
al Committee on Parallel Processing (TCPP).=0A=0A**** Topics ****=0ATopics =
of interest include but are not limited to the following areas:=0A- Heterog=
eneous multicore systems and architectures: Design, exploration, and experi=
mental analysis of heterogeneous computing systems such as Graphics Process=
ing Units, heterogeneous systems-on-chip, Artificial Intelligence chips, Fi=
eld Programmable Gate Arrays, big.LITTLE, and application-specific architec=
tures.=0A- Heterogeneous parallel and distributed systems: Design and analy=
sis of computing grids, cloud systems, hybrid clusters, datacenters, geo-di=
stributed computing systems, and supercomputers.=0A- Deep memory hierarchie=
s: Design and analysis of memory hierarchies with SRAM, DRAM, Flash/SSD, an=
d HDD technologies; NUMA architectures; cache coherence strategies; novel m=
emory systems such as phase-change RAM, magnetic (e.g., STT) RAM, 3D Xpoint=
/crossbars, and memristors.=0A- On-chip, off-chip, and heterogeneous networ=
k architectures: Network-on-chip (NoC) architectures and protocols for hete=
rogeneous multicore applications; energy, latency, reliability, and securit=
y optimizations for NoCs; off-chip (chip-to-chip) network architectures and=
 optimizations; heterogeneous networks (combination of NoC and off-chip) de=
sign, evaluation, and optimizations; large-scale parallel and distributed h=
eterogeneous network design, evaluation, and optimizations.=0A- Programming=
 models and tools: Programming paradigms and tools for heterogeneous system=
s; middleware and runtime systems; performance-abstraction tradeoff; intero=
perability of heterogeneous software environments; workflows; dataflows.=0A=
- Resource management and algorithms for heterogeneous systems: Parallel al=
gorithms for solving problems on heterogeneous systems (e.g., multicores, h=
ybrid clusters, grids, or clouds); strategies for scheduling and allocation=
 on heterogeneous 2D and 3D multicore architectures; static and dynamic sch=
eduling and resource management for large-scale and parallel heterogeneous =
systems.=0A- Modeling, characterization, and optimizations: Performance mod=
els and their use in the design of parallel and distributed algorithms for =
heterogeneous platforms; characterizations and optimizations for improving =
the time to solve a problem (e.g., throughput, latency, runtime); modeling =
and optimizing electricity consumption (e.g., power, energy); modeling for =
failure management (e.g., fault tolerance, recovery, reliability); modeling=
 for security in heterogeneous platforms.=0A- Applications on heterogeneous=
 systems: Case studies; confluence of Big Data systems and heterogeneous sy=
stems; data-intensive computing; scientific computing.=0A=0AThis year we wi=
sh to focus on and expand submissions and presentations in the following "h=
ot topics" areas; therefore, we especially invite submissions in the follow=
ing four areas:=0A- Heterogeneous Integration of Quantum Computing: Design,=
 exploration, and analysis of architectures and software frameworks enablin=
g heterogeneous integration of classical computing and quantum computing (e=
.g., heterogeneous quantum computers, error correction, heterogeneous appli=
cations that use both classical and quantum logic, benchmarks for heterogen=
eous quantum computers).=0A- Heterogeneity and Interoperability in Software=
 & Data Systems: Design, exploration, and analysis of architectures and sof=
tware frameworks for interoperability in software and data systems (e.g., s=
emantic frameworks, interoperability for heterogeneous Internet-of-Things s=
ystems, model-driven frameworks).=0A- Heterogeneous Computing for Machine L=
earning (ML) and Deep Learning (DL): Design, exploration, benchmarking, and=
 analysis of accelerators and software frameworks for ML and DL application=
s on heterogeneous computing systems.=0A- Closing the loop on the design of=
 heterogeneous compilers, runtimes, and hardware: As the needs of heterogen=
eous hardware apply pressure on runtime designers to adjust for the complex=
ities of heterogeneous resource management, runtimes are now applying press=
ure back towards compiler designers to include all relevant information -- =
such as data flow and dependency analysis or hardware-specific representati=
ons of application tasks -- in their binaries to enable resource management=
 policies to arbitrate effectively. Advancements in machine understanding o=
f code are critical in enabling progress here with a holistic view of compi=
lers, runtimes and heterogeneous hardware.=0A=0A**** Important Dates ****=
=0A- Abstract submission (required): January 23, 2025=0A- Paper submission:=
 January 30, 2025=0A- Author notification: February 20, 2025=0A- Camera-rea=
dy submission: March 6, 2025=0A=0A**** Paper Submissions ****=0AManuscripts=
 submitted to HCW 2025 should not have been previously published or be unde=
r review for a different workshop, conference, or journal.=0A=0ASubmissions=
 must use the latest IEEE manuscript templates for conference proceedings (=
http://ieee.org/conferences/publishing/templates.html). Submissions may not=
 exceed a total of ten single-spaced double-column pages using 10-point siz=
e font on 8.5x11 inch pages. The page limit includes figures, tables, and r=
eferences. A single-blind review process will be followed.=0A=0AFiles shoul=
d be submitted by following the instructions at the IPDPS 2025 submission s=
ite (http://ssl.linklings.net/conferences/ipdps).=0A=0ANew this year, we pl=
an to recognize an outstanding HCW 2025 publication with a Best Paper Award=
. The Best Paper Award will be determined by taking into account the recomm=
endations provided by the Technical Program Committee, along with detailed =
evaluations of the paper's originality, significance, and overall quality.=
=0A=0A**** Workshop Organization ****=0A=0AGeneral Co-Chairs: DK Panda and =
Hari Subramoni, The Ohio State University, USA=0A=0ATechnical Program Commi=
ttee Chair: Ali Akoglu, University of Arizona, USA=0A=0AQuestions may be se=
nt to the HCW 2025 General Co-Chairs (DK Panda: panda.2 at osu dot edu, Har=
i Subramoni: subramoni.1 at osu dot edu) or Technical Program Committee Cha=
ir (Ali Akoglu: akoglu at arizona dot edu).=0A=0ATechnical Program Committe=
e:=0A- Shashank Adavally, Micron Technology, USA=0A- Mohsen Amini Salehi, U=
niversity of North Texas, USA=0A- Mehmet Belviranli, Colorado School of Min=
es, USA=0A- Gonzalo Brito Gadeschi, NVIDIA Corporation, Germany=0A- Nick Br=
own, University of Edinburgh, Scotland=0A- Daniel Cordeiro, University of S=
ao Paulo, Brazil=0A- Matthias Diener, University of Illinois, USA=0A- Mural=
i Emani, Argonne National Laboratory, USA=0A- Jiri Filipovic, Masaryk Unive=
rsity, Czech Republic=0A- Abdou Guermouche, University of Bordeaux, France=
=0A- Yanfei Guo, Argonne National Laboratory, USA=0A- Diana Goehringer, Tec=
hnical University Dresden, Germany=0A- Sahil Hassan, University of Arizona,=
 USA=0A- Emmanuel Jeannot, INRIA, France=0A- Krishna Kavi, University of No=
rth Texas, USA=0A- Georgios Keramidas, Aristotle University, Greece=0A- Joo=
ngheon Kim, Korea University, Korea=0A- Joanna Kolodziej, Cracow University=
 of Technology, Poland=0A- Alexey Lastovetsky, University College Dublin, I=
reland=0A- Seyong Lee, Oak Ridge National Laboratory, USA=0A- Laercio Lima =
Pilla, CNRS, France=0A- Hatem Ltaief, King Abdullah University of Science a=
nd Technology, Saudi Arabia=0A- Joshua Mack, Praetorian, USA=20=0A- Joseph =
Manzano, Pacific Northwest National Laboratory, USA=0A- Matthias Mueller, A=
achen University, Germany=0A- Sridhar Radhakrishnan, University of Oklahoma=
, USA=0A- Jose Rufino, Polytechnic Institute of Braganca, Portugal=0A- Marc=
o Domenico Santambrogio, Politecnico di Milano, Italy=0A- Aamir Shafi, The =
Ohio State University, USA=0A- Sameer Shende, University of Oregon; ParaToo=
ls, Inc., USA=0A- Achim Streit, Karlsruhe Institute of Technology, Germany=
=0A- Shubbhi Taneja, Worcester Polytechnic Institute, USA=0A- Samuel Thibau=
lt, University of Bordeaux, France=0A- Claire Vishik, Intel, USA=0A- Logan =
Ward, Argonne National Laboratory, USA=0A=0ASteering Committee:=0A- Kamesh =
Madduri, Pennsylvania State University, USA (Chair)=0A- Behrooz Shirazi, Na=
tional Science Foundation, USA (Immediate Past Chair)=0A- H. J. Siegel, Col=
orado State University, USA (Past Chair)=0A- John Antonio, University of Ok=
lahoma, USA=0A- David Bader, New Jersey Institute of Technology, USA=0A- An=
ne Benoit, ENS Lyon, France=0A- Jack Dongarra, University of Tennessee, USA=
=0A- Alexey Lastovetsky, University College Dublin, UK=0A- Sudeep Pasricha,=
 Colorado State University, USA=0A- Viktor K. Prasanna, University of South=
ern California, USA=0A- Yves Robert, ENS Lyon, France=0A- Erik Saule, Unive=
rsity of North Carolina at Charlotte, USA=0A- Uwe Schwiegelshohn, TU Dortmu=
nd University, Germany=0A

