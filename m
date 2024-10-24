Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A1C145B16
	for <virtualization@lists.linux-foundation.org>; Thu, 24 Oct 2024 02:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729736629; cv=fail; b=idyWM2OPr1mdLSmwev9ZbLQInEi5oNF6CNQcgBr7+u3qyBCoKt6bv65PtQkItZM1irX53TaQAuUaaLxRNXH6gJPqx1PSt04ZdhwG8dRjQ2iLM6wdjUFphPT7WyQCBZ4X5BJgRDC5w9xG9lF2ukLJGj/2UxTT8/bsJPlTDkmXUFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729736629; c=relaxed/simple;
	bh=/+d06qGvzcjQZLV3N/bI3K0sdUnFO7GGCWAGRo13ORU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nG0O4t7bdPLHGwiS91gBSSOqE0BIVj7GVBd4jTDaXc+KKxOMyX258PHMzRMZIlIB+CSzX/2uAr3saN4ymE+KvdzBvRjD68/MJt4rA9oj7E6Q81cg+Ei4jXJ31hIQrbt8ZYrKJDCURrXXPcFUs82xWYT7ks3RpKDzSEeFWpuA2dM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qxs0buJP; arc=fail smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qxs0buJP"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 978ED405EB
	for <virtualization@lists.linux-foundation.org>; Thu, 24 Oct 2024 02:23:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.103
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ity5CPJBtDB6 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Oct 2024 02:23:46 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:111:f403:200a::604; helo=nam12-mw2-obe.outbound.protection.outlook.com; envelope-from=parav@nvidia.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 63CC1405E8
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 63CC1405E8
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=qxs0buJP
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on20604.outbound.protection.outlook.com [IPv6:2a01:111:f403:200a::604])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 63CC1405E8
	for <virtualization@lists.linux-foundation.org>; Thu, 24 Oct 2024 02:23:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SulH28Tz6xguQ7LXgnb8nNug6QbPslkjIKnMbO8l5TnyX0QKpwdyVGq6UG51G301Vr7JXAkcEXa2rt18lLXVMvvUtA0luRnySpmlZzHO2ag2+512UhS3WFHPITv995KNKuTj4anKZZF/fZDEVnJDcG5pyBLe11j6PfidOsenNEzHtU92+AkHLfy3FEDgmxONbPNs2a2KawOmx0ssuqp5hoSfPxmNekBQ+vuRnEPdEC7G3/0suCvfm8mYGnIizfZncZSImgAy+t9NIwMykEt4NcsM0iItUfNaUr7rSjb3Nu97CD/CECrXRuWTrBjoqNVKJxKonG+wapBell7Sb+Cjcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zPGTA3n5RicsQok/J4N0PnkgzAHcR2A53GxYJQHyq+o=;
 b=vuE0LAtxwRoi1ICpIMdSfdntsdE1+IZKtx14+oJzRY8yfAPiMaV9M0QZMU33BWAX1PihgJ0HDGclQKrPX2Ht2j6ifTpIAqzJBf6CTLpS0C4zfd3h/1opC4ZOqppBR94+CIDjAMdX5nN6ujvRTNR+VbvphwCkN0oLVZB9vn8/mkt6oLN2NQ/e0hgocqKRaopzz3qer6TXJKjKr9LEA0cguWiNopW4HFAwc5e342Eyei9zlD4khtEROX67DkTTz2J8twFY4sV1pjlr0DYyEoZDcviLC2LEbnpQBGdeosIPkR/nveuwux3NexGfX2ip4NoPwENeojbX0eAdZVc0NDpZSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zPGTA3n5RicsQok/J4N0PnkgzAHcR2A53GxYJQHyq+o=;
 b=qxs0buJP3QgmolRohCksHmbpiyhJgIZVWPs8Ib7xf0Ytv1M8d/oSGtT/jQSsUFuRSuUiCD6mqnGUzjaQujIZNM3HzMYbj6xrH0ojYqlaSgH2EcXtdSnH+ffBQ9yp9wEMv3srHDuZRLifRkBtIOayHHZf665rCp7OckArv/j+Gjv7uzUQthMwJrbPurEXaGlbMtUjjZ2ZnEdR/lbUY75D6fic2XLdhi9gcNRs5sY6n5WEOVll1c+hx8AxrCyO1qNAoYek33v2efzkZvO8BYYeSyk9Cv8nhzLv9TbqejeLlSdrCiJAdXiECWzkuby/BIkGoxqvQkZS5q3LBXHLygEVyQ==
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by SN7PR12MB6789.namprd12.prod.outlook.com (2603:10b6:806:26b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Thu, 24 Oct
 2024 02:23:39 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd%6]) with mapi id 15.20.8069.027; Thu, 24 Oct 2024
 02:23:39 +0000
From: Parav Pandit <parav@nvidia.com>
To: Parav Pandit <parav@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
	"dverkamp@chromium.org" <dverkamp@chromium.org>, "mst@redhat.com"
	<mst@redhat.com>, "virtualization@lists.linux-foundation.org"
	<virtualization@lists.linux-foundation.org>, "mvaralar@redhat.com"
	<mvaralar@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>,
	"virtio-dev@lists.linux.dev" <virtio-dev@lists.linux.dev>
CC: Oren Duer <oren@nvidia.com>, Nitzan Carmi <nitzanc@nvidia.com>, Ben Walker
	<benwalker@nvidia.com>
Subject: RE: [PATCH v5 1/1] virtio-blk: Add description for blk_size field
Thread-Topic: [PATCH v5 1/1] virtio-blk: Add description for blk_size field
Thread-Index: AQHbJNmbwr9LZ7Et0Ey+Z8Qo57DBgbKVKwnAgAACBPA=
Date: Thu, 24 Oct 2024 02:23:39 +0000
Message-ID:
 <CY8PR12MB71958F66F325688051E93BE0DC4E2@CY8PR12MB7195.namprd12.prod.outlook.com>
References: <20241022232435.20799-1-mgurtovoy@nvidia.com>
 <CY8PR12MB71956ACE2D3290FA267B060BDC4E2@CY8PR12MB7195.namprd12.prod.outlook.com>
In-Reply-To:
 <CY8PR12MB71956ACE2D3290FA267B060BDC4E2@CY8PR12MB7195.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|SN7PR12MB6789:EE_
x-ms-office365-filtering-correlation-id: 5db10ad1-2688-4292-75a7-08dcf3d2df74
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ieqMrh6rOQRtl1m6APaI0GS9SDhmfMq6XSZh0iecY5g/CB8yLJYEN7txj/Sm?=
 =?us-ascii?Q?GxbkrzNp/oTPHSGRPTWPI40pspz/cIXMGYaFmqNtBfkoN8Njj6MqBJUEER0M?=
 =?us-ascii?Q?jkc8FjA1FUqeT5MTM09YIaweCI7rlpFkTiEZlgKvi0mjBy37NjEqk6dLMD6d?=
 =?us-ascii?Q?zL5tb27/AXy26gSbCp2I47EKk/I+Kpi8DMSRKNVrNQNEdZhpj9oQUaZbLbav?=
 =?us-ascii?Q?JcAouubg9Q9RKwzJ75Q5k+Zjbhk9+XLxuvgBVp3hB5wowEvQBq2+nRsE0+ix?=
 =?us-ascii?Q?5dhob2GCG1C7728+mWNuaDRfDdft3t0oI651BepafSHROxq3E/wzR8zWKPoI?=
 =?us-ascii?Q?CKB5fd3uU7+rif9TGLHj3GiQQ1AeDK89DVbDVmCG1ZkrGZN/Xx8rZK0DMR+l?=
 =?us-ascii?Q?pMznbgBRGNEY2+jPLj4NsfBxoma2nC6bK2dqea/EuAWIVRwwDlIha3VwEHAf?=
 =?us-ascii?Q?AkB3hyI7wjkr2QIWo+xg67WLl4xNMMU1gqjN4pXbd6+YLP87hBW3wb0kyFw7?=
 =?us-ascii?Q?W7T0YUczAVSuyLmnYNVfJWJF+OeWFsmKZiC7eOYF3IIJnQSpDQiLDhpuM/jF?=
 =?us-ascii?Q?hNF6165Y5oJg3xJX/jAylxjFfYw68Z9ncsOEGtfvsFi1PREHaqnV7LI01hdf?=
 =?us-ascii?Q?3x3ekzNYyFST31lfHpwycyrA1LZc5U1cI8hoBW93NioJQBHBeEiEWa7p3Igt?=
 =?us-ascii?Q?DuJqxTW1ugh7OCkstWqzxhh5EroELB1GWOTPTeh4V1Jntqz2r0DRxSZBEQbu?=
 =?us-ascii?Q?8pavab2OVc+q1WbdzfEAIqKDhyhBcFqNROZRWIqUBV8QaiteickjQbfwdPgq?=
 =?us-ascii?Q?AA1s/xRPvU7IF1FSjMm0ZpfXuFRfLJvZ+8F7JCkY72GmeAnosrkAqO2nbTvZ?=
 =?us-ascii?Q?yl43w77MPE2MW37IXOkYFDei6BUwkFtKRR9vSMMbiBsFaBzoNOjNnCfZ/dFL?=
 =?us-ascii?Q?UJnpU2tyu5dC3Nqh7dxX0/afaIoxogRgLe2I5jPtFsmmxwFpaCHnn1VQKgtY?=
 =?us-ascii?Q?6dS2b9UMBhsxze2QxJD3GSAEz3KdO+F8GGkuDZIGY5tiahOtX6xxYIQJNV47?=
 =?us-ascii?Q?lgqsRC9zbfXscq04gUDDfh7ScNpU1AiUTEkRKU+retZmBkv9Oue83ONQw70M?=
 =?us-ascii?Q?o4qll6Fo8j+D/Bxv98IBbVgT84j93Dyh4eCEUhV4hy6kxOQwJGQIdRyBggMe?=
 =?us-ascii?Q?A9Mx+UIWcZfR6rHetcv4jdbMNPO7EjnYdGjMsZNgSrQLjEj+1NdP4kziyDjL?=
 =?us-ascii?Q?i0n9xelQU+NYlmrjux7KzJnGQ6+mqW9fHhXQgyVe/9pboOSK22oay9NeQ+d9?=
 =?us-ascii?Q?d0vozsYlH+F0zHEgtHVJlWKRm/9afYaxpZlr+ZHaCyagT8xk0Aa9jLQFvuxb?=
 =?us-ascii?Q?ycjr+cGzyCJmtu9QdjM4/NZzZ9oH?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?QFRyAFRoeJAsx/kXlY6sesSr9fdne5R6pmHa0s6O0SphqYRvTbfSpoJ9czjM?=
 =?us-ascii?Q?XGqZ3Jl7L9n//kHSF4vIPMP90I2rggdSjoDvnH6Hm+F+92pRT3NCz+OHjuoT?=
 =?us-ascii?Q?XlP73koegSLIZTu7mBcIgXZzipdxdvKItmlqLD1zGLtZYiv1Uuvb/PLZ+2dy?=
 =?us-ascii?Q?lPagPUXpY4/u6v0yw2qVZKWnptubJ1fwOJYbE3HDrduN5dlIKvW1h6n2lcvi?=
 =?us-ascii?Q?k718qH4brqv0SDh+MoZYQWENLaKTSk4eyjtciN/gdVoQ5qgZriIUVVn8ppZc?=
 =?us-ascii?Q?TZc04LckIqYFKzbjZNfI84hWTE/DR3J9rH2RTZ+d0tlgam615j+Pzdyp8/d0?=
 =?us-ascii?Q?fNhrJhz73SbxE38gUGCEZcKaY8wMGBZprU+77Vq1+P6FEAP2SJ7hyyRWVlfF?=
 =?us-ascii?Q?kydIJ8871y5jdtbNxjCoUpkJa/r+whTD2Mvq+fn/LF9XN6S9TbNObmRV+QMi?=
 =?us-ascii?Q?s6OT50bgMXL85LBaQ2Ip2STsUmal13lYZ1q7ZcFsVkzocH7kRv+46gFWpODG?=
 =?us-ascii?Q?oWaOdCHss1NTq/ni7vnTEEf3G1JHbVYqj/0v9FqcyJZrq2weElpiqtbwrzzI?=
 =?us-ascii?Q?Bsa9pko1NYistnW/yspnQrJtJhG/B4vQuFFgWPl9QCpz/VODWJZBv3lsjqA3?=
 =?us-ascii?Q?2iR6aRonV0ce3W+4J/EzAj/kubIZoQGpnIE8yKi6Hwz8wC4kCjlp2lVZAVb5?=
 =?us-ascii?Q?gLmMLlrkeR5SkQ0G287aRUv79eA6bZqevdII/WAOKMDDJv/RyUGz6VMLdtSd?=
 =?us-ascii?Q?T2g/QKSjA+Lx9ADsMtuldcJ4Wzgujygzw6Bi4ISdbyESWPQRgIwDvuYyRt1O?=
 =?us-ascii?Q?d2Z3hFEeE2ud51mPo8dR4WSFlgg19iyFKMVG11UWVf3T7hzsmlhhhjOx0knO?=
 =?us-ascii?Q?qVuEvszZXmGlHkVy6DxxVvZb77GoU08/SlO5Jqdhn7UOguslRJ9soEzZtqQC?=
 =?us-ascii?Q?SrOzB+1tW9arEwl96xQjo48xBb6EHcGYNskyl5ZSqS0EBpLfZaO2u73JScwV?=
 =?us-ascii?Q?S+piKmCy4iZ84hcimOKJq/zbidDoLUJvZx9yRMWDiGYh3JqylAe2fa5bRnY8?=
 =?us-ascii?Q?A8a0g8C4DevWGKvxat0slvFlsNaCwiRYVJFDtEDpUQRxDrtoJQMyAG7jIvY3?=
 =?us-ascii?Q?2JH3OgfC+NoJGrmN9zbQ5dIhJci1dck2tudBBG20lNq9YOqL8is0oNl7CKZO?=
 =?us-ascii?Q?7pt1jlu2SUXtqctrwwjQxxfRBoosC4BILngap9Plbrqrvtd9yvocZw15x70e?=
 =?us-ascii?Q?4pJENJwsK3POz4/hI+pVfAIWI6FBkqBmhHW7iJzBv8jrCMI9uRzhEkvLJJZ8?=
 =?us-ascii?Q?xHjva80xPbNRhxKMUTHe7+VmkZXI9Hhvch7InAVBU3DE5oWnCJzrWZPak4li?=
 =?us-ascii?Q?94FagukYTlDpvZA6Dy6MFmcd2JAVGXgiCIusoB2YFhukgG2iNJkiAB3lu/qt?=
 =?us-ascii?Q?SlgnI4kEUoVyfRt023P7W3i0GmNoYDlHXM0DAXejioiAMJzgjr6zW3/VKmER?=
 =?us-ascii?Q?y1Dk8cza+K4JqcrCT96vU9DRnMajXLzidHThmFHlXTFfGGIYkLsPVmgg6Gnv?=
 =?us-ascii?Q?2GW0DTmwg3fx1UzKDDA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7195.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5db10ad1-2688-4292-75a7-08dcf3d2df74
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2024 02:23:39.7059
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fKmJ1/VX1CeAo5VTx/i3NVyygtnaD9Qv8tj9XeJf2UNxNSD3RwsiJIXs/wm8zpFkvnUbEE8FFfzLhkLcL2pZww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6789

> From: Parav Pandit <parav@nvidia.com>
> Sent: Thursday, October 24, 2024 7:49 AM
> To: Max Gurtovoy <mgurtovoy@nvidia.com>; dverkamp@chromium.org;
> mst@redhat.com; virtualization@lists.linux-foundation.org;
> mvaralar@redhat.com; stefanha@redhat.com; virtio-dev@lists.linux.dev
> Cc: Oren Duer <oren@nvidia.com>; Nitzan Carmi <nitzanc@nvidia.com>; Ben
> Walker <benwalker@nvidia.com>
> Subject: RE: [PATCH v5 1/1] virtio-blk: Add description for blk_size fiel=
d
>

Hi Max,

The patch is posted to wrong mailing lists.
It should be posted to virtio-comment@lists.linux.dev only.
Please drop virtio-dev list.

This is already described at https://github.com/oasis-tcs/virtio-spec
Snippet:
" When not to use the virtio-dev mailing list:
    questions and change proposals for the Virtio specification, including =
the specification of basic functionality, transports and devices (please us=
e the virtio-comment mailing list for this)."

Parav
