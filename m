Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958A4154424
	for <virtualization@lists.linux.dev>; Fri, 29 Mar 2024 13:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711717358; cv=fail; b=N+13CbpGtAs8huHmTzjzXQIgiWirhXQJotGgrmpSrTCu6WzTUEhzbKItbXsfVbq73gHTGXWzIwpTzGzG4ak93BtYdBfn3bVz85XJKIZjdZJkLCqoXeilmgOT1ucWxBP0auJWB8i5CxHDyaQ/hlEcoCGAbKYeJv1tCel6SgFIU8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711717358; c=relaxed/simple;
	bh=ENZu0rGAR7TftbH1s9yP2SJcp+FP1cfd7g/ooC5eRc8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qqDDNgDAdrLgoQpsk5xnsH9w8UceipUNCBORyMqSalRAT8qqWjoG25jSJlU3+Uj/9IFhEBFa1oGiv1NvGDkZU7Sc0PSzlILQWBcmESgm0zPsA5fc9u8wgzwpY7LAQPR0A7njGA6rptmhStAxcie+e02S4wwI0hvWeYz5/nr9hFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=h0p7Ka26; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="h0p7Ka26"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42TCGUTq027498;
	Fri, 29 Mar 2024 06:02:32 -0700
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3x5wgpg4k4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 06:02:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S/K1XkDZvwF8ZqOJVKJDAoXjm3LRYeNq0xJFMPRKeFLhP1ZvPZXcHMU58kyFhTyFuiqjm5QYJJU1DtDtE9Rw+tFtvKyMhXKF5L9LVqlX4PsNhK768WZYUUUdtG63iuP7TaAWcKqsHshUYInMllytro2HDnNqAV0fSrFm5M3gTvjexu+c9WekZ6ISTTFT9Va+bbV/m+xGzVwS532PDzi5gfjqunAnD8HPD8aN3+/zUnvFwkS2KZ+lw17ik3mbZIloMQ8y4jbCSTZrGqImZkf1qnrJEMMibjlzJAH2n9oxzU6DnarM5Qk/721eCzSFPvAxuFIF9JA5Omg6n+RF5dVEjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=klvR8D62Cg3fOk6aqIcMCh1GLjhqFSMYhzZGhhMiVVs=;
 b=G6sR9/Hq/BbekcpbXMhrXbnR8SgfKFjFlfiDZdeT/uKN0fUuPMoryUH9RSQMeaKbTjYCFuw7+Isw2gLGjUmXABLpn1VkWefggTuY5UOaFLR5TUegFwJdVv2DECkBLDjCtQoWH+hdIPbjxL/GN3eYtjhKK2bdvSTQCH9BrMiVLDl0D69Wuns0mTa0GO0HEZi+7fl0tJ0pTABhAwFTbBDeHrrwQvJiVf0iWkKhxJhdqxlUs8yCAttz5yr7OuRzl8vj2BwDxRIILSEj+QVt+h0m/nQEyuoFuUqSKpwXsBTNeJx4ssUbyrXX93caJOP+RsbCSpoDzKCktLjwS3yTXktTCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=klvR8D62Cg3fOk6aqIcMCh1GLjhqFSMYhzZGhhMiVVs=;
 b=h0p7Ka26cvKJhpa1IjGPyK3la+GvxBCpyMuDU7QChoA4SqOzDNeJ4fA321Y+xULvxt4YX1pf9m7sRrE50/It3J2ZR21MfSNSi1rxpee9KzmwGK8RZG/T2SBKOSFGdsdkLlRWRDLtjm27c8BBVc61rq/FvzhjDOLFvn4zvCxDW44=
Received: from DS0PR18MB5368.namprd18.prod.outlook.com (2603:10b6:8:12f::17)
 by SA1PR18MB5966.namprd18.prod.outlook.com (2603:10b6:806:3df::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.40; Fri, 29 Mar
 2024 13:02:29 +0000
Received: from DS0PR18MB5368.namprd18.prod.outlook.com
 ([fe80::9728:b607:b464:a2dc]) by DS0PR18MB5368.namprd18.prod.outlook.com
 ([fe80::9728:b607:b464:a2dc%7]) with mapi id 15.20.7409.039; Fri, 29 Mar 2024
 13:02:28 +0000
From: Srujana Challa <schalla@marvell.com>
To: Stefano Garzarella <sgarzare@redhat.com>
CC: "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
        "mst@redhat.com" <mst@redhat.com>,
        "jasowang@redhat.com"
	<jasowang@redhat.com>,
        "xuanzhuo@linux.alibaba.com"
	<xuanzhuo@linux.alibaba.com>,
        Vamsi Krishna Attunuru <vattunuru@marvell.com>,
        Shijith Thotton <sthotton@marvell.com>,
        Nithin Kumar Dabilpuram
	<ndabilpuram@marvell.com>,
        Jerin Jacob <jerinj@marvell.com>
Subject: RE: [EXTERNAL] Re: [PATCH] virtio: vdpa: vDPA driver for Marvell
 OCTEON DPU devices
Thread-Topic: [EXTERNAL] Re: [PATCH] virtio: vdpa: vDPA driver for Marvell
 OCTEON DPU devices
Thread-Index: AQHagDj2SsvzR050EUWY0iVJi2EC1bFOmnOAgAARb5A=
Date: Fri, 29 Mar 2024 13:02:28 +0000
Message-ID: 
 <DS0PR18MB5368EA931E6FE873DD94A50BA03A2@DS0PR18MB5368.namprd18.prod.outlook.com>
References: <20240327112136.2897479-1-schalla@marvell.com>
 <zuo2dwyz3rzwotgjnml2n5scjjwc563hh6cj5mtz6qieh6sgy7@kxluctu2tayv>
In-Reply-To: <zuo2dwyz3rzwotgjnml2n5scjjwc563hh6cj5mtz6qieh6sgy7@kxluctu2tayv>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR18MB5368:EE_|SA1PR18MB5966:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 DjBQ0XVE7i9Bg9sRFSAMOmShjrGsj3QVM79rOF7kRDS0AaFpsp9XLN7UorB+n416+pv6K4082/8uCRbLcwoOCsioZGC1Qlbx5D+kPFHl8RUdaecFE0VN6njZszp8HxNUu+pc5yjSq7wXrApvt/2474+qgV00JA26CP96+ZhcAlL9Z4ngy1vzQveJX/WXS1fecxv4Xw7RlAAKqi7zoKz8Sxk7x+sN254oHjl26KSflgmbNAcEoPf1xFydrIGwlgg5810xYtfYDkO1PHHl1hrhTJYrPisrfH1U622WILkr8XwwFAO7UErbLwB9UsRm3PAmkwdWXqLxkGomzhpNt3zFhSJ6HX10JTPbkH7edP7JidwamUDqPq86rDp7g6gR/OjAFfV4M9iSyIUD0d37pMz/JNgpDChcalw2v+RtLfJTPxGL21mxt9KxPaY8WtV1jqaC0Qf98lS3ImRluMyZbZ07ZUeKqKIQrSVimSWnZeGq7C8cJzxMEF1onqMsYapVl4o6pcdPmb/GhXGguC8e4J4ce98zqBjnHkWL88/p1gQ59G+ZqAq2VwAXYLmulJiBAACKO4B6CgxhL0saHw5iIiuXmiD1rgQUy1FnXwiVs1FBYd465niPdnbqmDjVgwXzlVEOoF6yuR05ee0fwnv7zKf2BsX6s2x8y9au/D+/LPsFwsY=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR18MB5368.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?4XQN9wuAmDn+9fffLxRQCap0Xr3VmGgWgErRtN848F6oiXOjwPe6u8OZSUnz?=
 =?us-ascii?Q?nPI2fsV8FFX+5IsZQNN5wGRQbl4kTZeLSNcMIXtP3D6Ynk2WyIcJDJMG3efu?=
 =?us-ascii?Q?IifbA6PRzd+YoUJOxl1Z233VE9WFo2OJkJxs+rgwMfjst5p0rQKrFDerzUwP?=
 =?us-ascii?Q?e3erI/alhy6gV1a3JtFrpdFtdsa8MGAnFAof9Pzf00+2mThflIWx3ainTEtR?=
 =?us-ascii?Q?aYblufzBzNM8+nSIYEWkIsWB5Mx3gt7Xc5nRkokTDt22+T2xCMBrxtCRljMg?=
 =?us-ascii?Q?6QZVt1mBj2ZgKy4LlwQZsOffUv/6uhGZcBzrCSnn3n1OHm+TcMevcbC4T+QP?=
 =?us-ascii?Q?vR75sejlWi8w/lKxpDRiacWBmHX/VyyCgx2jMEbWEzjoKzYPHtbVT/L4JJF1?=
 =?us-ascii?Q?IbRZrODSCimldwi28V6Jn8s5ndB2WhdOWc6HFQ2vdqsfndW+pTj8sslhixwe?=
 =?us-ascii?Q?tovp6rVtpQEZ8bfllZwnm4fxE7mvlG1+Bq3TaFnpxQF0nyMLVCe5lTo9agaX?=
 =?us-ascii?Q?jKSAWLf4nJJ+VWTy116vn6vBQ/cElOabbqater40isL/hTbktkJueywGSgyS?=
 =?us-ascii?Q?9rDqaSrSCK85u+1zoHiJoY0JViZ61jk4Uft/NVqhWIdHnGlaXRL1AfNsKp4t?=
 =?us-ascii?Q?5oGjTyCH2gj8JDCctA6UaFydDb1dVuE23zXGq3TXuu3XYpMMv1hPMGCnp7M2?=
 =?us-ascii?Q?xR91QUYwN26UVUxOIH1REFQQnm9owdRJialZqscUU/IZ5YkBimJ/yrwhC1+Z?=
 =?us-ascii?Q?j1SGcABZ6S4JjK7Um2ujLKFpZZOPVHRB5dhzE66X63GohFCigHOnb/tfOHJq?=
 =?us-ascii?Q?TOa9vbLTbI/800cWVeHGZM5dvC9YS3Ot6g3fyh/SRfw0TMSvq/kreKtCQO6a?=
 =?us-ascii?Q?wN72mjkokvP77mLKDvxvAga+EBrwQ/x4nbz3XquNbME9eOkF/3DruppjOxTF?=
 =?us-ascii?Q?paPGiDxC4pVji+JgfgpCeach/b/nQzsSU3Dptr4fKHJZjN536L22hxV8Z2vS?=
 =?us-ascii?Q?Ug+WWNieCbAoxhlcXYf7wjZK88XEEIQAoXVJSAyXlkGQ5ipkdyJTAt7XG5S4?=
 =?us-ascii?Q?FLycZckaMBJiYXEQrSnZKNxJ3GzKM1s+uL6NCzQl8ZSQx4n8pPOKjLq7QLn8?=
 =?us-ascii?Q?l23zlEHLIKzaNnivGWI6Xm/xIDGuW5CJcJehI/8P4clMTjHCluJF+cY25vzZ?=
 =?us-ascii?Q?9bmoKwaOdPvNJr50WaUUaD+PRjGotnMMes9tAdPqztJ4foNahN+PxRgAHV3p?=
 =?us-ascii?Q?SpfX9gobRQZFd0pJb97VdEN/WVQbtqHKxNR7v+odObWBIBq9vw1a0cdcdRu7?=
 =?us-ascii?Q?8Qfw3T44FArmAvAEiuAYde4X/4LdKMIo9qdc4gDzeLBS0dtfJhSSD2vIQCMm?=
 =?us-ascii?Q?wHoUG9L9oRodEY0gnkBANkAnWnFRaad8c+/1bLeKlfxYE/EURe7lBobni5W+?=
 =?us-ascii?Q?P5io8tU1YVA0uLRAOmIr+DzHY3truONYl967Ov5+BhEPj58r8wZQYPKRewwf?=
 =?us-ascii?Q?hgpH/7KQjNBMFuks3EdpYN+TMcOPLwrp3KTVFSQCN+fGr7BjHgq8OBk1tms4?=
 =?us-ascii?Q?NbSK1DQcuZCws2Q6uWs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR18MB5368.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 281f9eb9-0504-400d-c6b5-08dc4ff07d0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2024 13:02:28.8320
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 47Bwp2HCwv/+mfxmYI7G3M3q1026c4piijW433lYjoIvjRYETg+pvM1zQ6GvITJwCJvXYK2hkrGuX3pzyN3waA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR18MB5966
X-Proofpoint-GUID: 3a_Ce2vu6pVOxJOfyNj6FuE_KUOiKfeU
X-Proofpoint-ORIG-GUID: 3a_Ce2vu6pVOxJOfyNj6FuE_KUOiKfeU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-29_13,2024-03-28_01,2023-05-22_02

> Subject: [EXTERNAL] Re: [PATCH] virtio: vdpa: vDPA driver for Marvell OCT=
EON
> DPU devices
>=20
> Prioritize security for external emails: Confirm sender and content safet=
y
> before clicking links or opening attachments
>=20
> ----------------------------------------------------------------------
> On Wed, Mar 27, 2024 at 04:51:36PM +0530, Srujana Challa wrote:
> >This commit introduces a new vDPA driver specifically designed for
> >managing the virtio control plane over the vDPA bus for OCTEON DPU
> >devices. The driver consists of two layers:
> >
> >1. Octep HW Layer (Octeon Endpoint): Responsible for handling hardware
> >operations and configurations related to the DPU device.
> >
> >2. Octep Main Layer: Compliant with the vDPA bus framework, this layer
> >implements device operations for the vDPA bus. It handles device
> >probing, bus attachment, vring operations, and other relevant tasks.
> >
> >Signed-off-by: Srujana Challa <schalla@marvell.com>
> >Signed-off-by: Vamsi Attunuru <vattunuru@marvell.com>
> >Signed-off-by: Shijith Thotton <sthotton@marvell.com>
> >Signed-off-by: Nithin Dabilpuram <ndabilpuram@marvell.com>
> >---
> > MAINTAINERS                              |   5 +
> > drivers/vdpa/Kconfig                     |   9 +
> > drivers/vdpa/Makefile                    |   1 +
> > drivers/vdpa/octeon_ep/Makefile          |   4 +
> > drivers/vdpa/octeon_ep/octep_vdpa.h      |  93 +++
> > drivers/vdpa/octeon_ep/octep_vdpa_hw.c   | 457 ++++++++++++
> > drivers/vdpa/octeon_ep/octep_vdpa_main.c | 903
> +++++++++++++++++++++++
> > 7 files changed, 1472 insertions(+)
> > create mode 100644 drivers/vdpa/octeon_ep/Makefile  create mode
> 100644
> >drivers/vdpa/octeon_ep/octep_vdpa.h
> > create mode 100644 drivers/vdpa/octeon_ep/octep_vdpa_hw.c
> > create mode 100644 drivers/vdpa/octeon_ep/octep_vdpa_main.c
>=20
> Building with C=3D2 I see several warnings, I suggest to take a look:
>=20
> $ make O=3Dbuild M=3Ddrivers/vdpa -j6 W=3D1 C=3D2 modules
Sure, I will fix these warnings in next version.

>    ...
>    CHECK   ../drivers/vdpa/octeon_ep/octep_vdpa_main.c
>    CHECK   ../drivers/vdpa/octeon_ep/octep_vdpa_hw.c
> ../drivers/vdpa/octeon_ep/octep_vdpa_main.c:548:50: warning: cast
> removes address space '__iomem' of expression
> ../drivers/vdpa/octeon_ep/octep_vdpa_main.c:548:47: warning: incorrect
> type in assignment (different address spaces)
> ../drivers/vdpa/octeon_ep/octep_vdpa_main.c:548:47:    expected unsigned
> int [noderef] [usertype] __iomem *cb_notify_addr
> ../drivers/vdpa/octeon_ep/octep_vdpa_main.c:548:47:    got unsigned int
> [usertype] *
> ../drivers/vdpa/octeon_ep/octep_vdpa_main.c:74:66: warning: dereference
> of noderef expression
> ../drivers/vdpa/octeon_ep/octep_vdpa_main.c:75:40: warning: dereference
> of noderef expression
> ../drivers/vdpa/octeon_ep/octep_vdpa_hw.c:339:25: warning: incorrect type
> in initializer (different base types)
> ../drivers/vdpa/octeon_ep/octep_vdpa_hw.c:339:25:    expected unsigned in=
t
> [usertype] length
> ../drivers/vdpa/octeon_ep/octep_vdpa_hw.c:339:25:    got restricted __le3=
2
> [usertype] length
> ../drivers/vdpa/octeon_ep/octep_vdpa_hw.c:340:25: warning: incorrect type
> in initializer (different base types)
> ../drivers/vdpa/octeon_ep/octep_vdpa_hw.c:340:25:    expected unsigned in=
t
> [usertype] offset
> ../drivers/vdpa/octeon_ep/octep_vdpa_hw.c:340:25:    got restricted __le3=
2
> [usertype] offset
> ../drivers/vdpa/octeon_ep/octep_vdpa_hw.c:427:89: warning: restricted
> __le32 degrades to integer
> ../drivers/vdpa/octeon_ep/octep_vdpa_hw.c:449:9: warning: cast removes
> address space '__iomem' of expression
> ../drivers/vdpa/octeon_ep/octep_vdpa_hw.c:450:9: warning: cast removes
> address space '__iomem' of expression
> ../drivers/vdpa/octeon_ep/octep_vdpa_hw.c:451:9: warning: cast removes
> address space '__iomem' of expression
> ../drivers/vdpa/octeon_ep/octep_vdpa_hw.c:452:9: warning: cast removes
> address space '__iomem' of expression
> ../drivers/vdpa/octeon_ep/octep_vdpa_hw.c:454:9: warning: cast removes
> address space '__iomem' of expression
>=20
> >
> >diff --git a/MAINTAINERS b/MAINTAINERS
> >index cfe44a876d8a..539ce209a960 100644
> >--- a/MAINTAINERS
> >+++ b/MAINTAINERS
> >@@ -13127,6 +13127,11 @@ S:	Supported
> > F:	Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
> > F:	drivers/mmc/host/sdhci-xenon*
> >
> >+MARVELL OCTEON ENDPOINT VIRTIO DATA PATH ACCELERATOR
> >+R:	schalla@marvell.com
> >+R:	vattunuru@marvell.com
> >+F:	drivers/vdpa/octeon_ep/
> >+
> > MATROX FRAMEBUFFER DRIVER
> > L:	linux-fbdev@vger.kernel.org
> > S:	Orphan
> >diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig index
> >656c1cb541de..775149fad476 100644
> >--- a/drivers/vdpa/Kconfig
> >+++ b/drivers/vdpa/Kconfig
> >@@ -126,4 +126,13 @@ config PDS_VDPA
> > 	  With this driver, the VirtIO dataplane can be
> > 	  offloaded to an AMD/Pensando DSC device.
> >
> >+config OCTEONEP_VDPA
> >+	tristate "vDPA driver for Octeon DPU devices"
> >+	depends on m
>=20
> Just for curiosity, why restrict it to module-only?

There is an etherent driver for the same class of devices. So,
we made this vDPA driver as module.

>=20
> >+	depends on PCI_MSI
> >+	help
> >+	  vDPA driver for Marvell's Octeon DPU devices.
> >+	  With this driver, the VirtIO dataplane can be
> >+	  offloaded to a Octeon DPU device.
> >+
> > endif # VDPA
> >diff --git a/drivers/vdpa/Makefile b/drivers/vdpa/Makefile index
> >8f53c6f3cca7..5654d36707af 100644
> >--- a/drivers/vdpa/Makefile
> >+++ b/drivers/vdpa/Makefile
> >@@ -8,3 +8,4 @@ obj-$(CONFIG_VP_VDPA)    +=3D virtio_pci/
> > obj-$(CONFIG_ALIBABA_ENI_VDPA) +=3D alibaba/
> > obj-$(CONFIG_SNET_VDPA) +=3D solidrun/
> > obj-$(CONFIG_PDS_VDPA) +=3D pds/
> >+obj-$(CONFIG_OCTEONEP_VDPA) +=3D octeon_ep/
> >diff --git a/drivers/vdpa/octeon_ep/Makefile
> >b/drivers/vdpa/octeon_ep/Makefile new file mode 100644 index
> >000000000000..e23e2ff14f33
> >--- /dev/null
> >+++ b/drivers/vdpa/octeon_ep/Makefile
> >@@ -0,0 +1,4 @@
> >+# SPDX-License-Identifier: GPL-2.0
> >+obj-$(CONFIG_OCTEONEP_VDPA) +=3D octep_vdpa.o
> >+octep_vdpa-$(CONFIG_OCTEONEP_VDPA) +=3D octep_vdpa_main.o
> >+octep_vdpa-$(CONFIG_OCTEONEP_VDPA) +=3D octep_vdpa_hw.o
> >diff --git a/drivers/vdpa/octeon_ep/octep_vdpa.h
> >b/drivers/vdpa/octeon_ep/octep_vdpa.h
> >new file mode 100644
> >index 000000000000..60d2efc8f8b8
> >--- /dev/null
> >+++ b/drivers/vdpa/octeon_ep/octep_vdpa.h
> >@@ -0,0 +1,93 @@
> >+/* SPDX-License-Identifier: GPL-2.0-only
> >+ * Copyright (C) 2024 Marvell.
> >+ */
> >+#ifndef __OCTEP_VDPA_H__
> >+#define __OCTEP_VDPA_H__
> >+
> >+#include <linux/pci.h>
> >+#include <linux/pci_regs.h>
> >+#include <linux/vdpa.h>
> >+#include <linux/virtio_pci_modern.h>
> >+#include <uapi/linux/virtio_net.h>
> >+#include <uapi/linux/virtio_blk.h>
>=20
> It looks like virtio_blk.h is not needed.
> I suggest to check also other includes.
Sure, I will check and fix in next version.
>=20
> >+#include <uapi/linux/virtio_config.h>
> >+#include <uapi/linux/virtio_pci.h>
> >+#include <uapi/linux/vdpa.h>
> >+
> >+#define OCTEP_VDPA_DEVID_CN106K_PF 0xb900 #define
> >+OCTEP_VDPA_DEVID_CN106K_VF 0xb903 #define
> OCTEP_VDPA_DEVID_CN105K_PF
> >+0xba00 #define OCTEP_VDPA_DEVID_CN105K_VF 0xba03 #define
> >+OCTEP_VDPA_DEVID_CN103K_PF 0xbd00 #define
> OCTEP_VDPA_DEVID_CN103K_VF
> >+0xbd03
> >+
> >+#define OCTEP_HW_MBOX_BAR 0
> >+#define OCTEP_HW_CAPS_BAR 4
> >+
> >+#define OCTEP_DEV_READY_SIGNATURE 0xBABABABA
> >+
> >+#define OCTEP_EPF_RINFO(x) (0x000209f0 | ((x) << 25)) #define
> >+OCTEP_VF_MBOX_DATA(x) (0x00010210 | ((x) << 17)) #define
> >+OCTEP_PF_MBOX_DATA(x) (0x00022000 | ((x) << 4))
> >+
> >+#define OCTEP_EPF_RINFO_RPVF(val) (((val) >> 32) & 0xF) #define
> >+OCTEP_EPF_RINFO_NVFS(val) (((val) >> 48) & 0x7F)
> >+
> >+#define OCTEP_FW_READY_SIGNATURE0  0xFEEDFEED #define
> >+OCTEP_FW_READY_SIGNATURE1  0x3355ffaa
> >+
> >+enum octep_vdpa_dev_status {
> >+	OCTEP_VDPA_DEV_STATUS_INVALID,
> >+	OCTEP_VDPA_DEV_STATUS_ALLOC,
> >+	OCTEP_VDPA_DEV_STATUS_WAIT_FOR_BAR_INIT,
> >+	OCTEP_VDPA_DEV_STATUS_INIT,
> >+	OCTEP_VDPA_DEV_STATUS_READY,
> >+	OCTEP_VDPA_DEV_STATUS_UNINIT
> >+};
> >+
> >+struct octep_vring_info {
> >+	struct vdpa_callback cb;
> >+	void __iomem *notify_addr;
> >+	u32 __iomem *cb_notify_addr;
> >+	phys_addr_t notify_pa;
> >+	char msix_name[256];
> >+};
> >+
> >+struct octep_hw {
> >+	struct pci_dev *pdev;
> >+	u8 __iomem *base[PCI_STD_NUM_BARS];
> >+	struct virtio_pci_common_cfg __iomem *common_cfg;
> >+	u8 __iomem *dev_cfg;
> >+	u8 __iomem *isr;
> >+	void __iomem *notify_base;
> >+	phys_addr_t notify_base_pa;
> >+	u32 notify_off_multiplier;
> >+	u8 notify_bar;
> >+	struct octep_vring_info *vqs;
> >+	struct vdpa_callback config_cb;
> >+	u64 features;
> >+	u64 drv_features;
> >+	u16 nr_vring;
> >+	u32 config_size;
> >+	int irq;
> >+};
> >+
> >+u8 octep_hw_get_status(struct octep_hw *oct_hw); void
> >+octep_hw_set_status(struct octep_hw *dev, uint8_t status); void
> >+octep_hw_reset(struct octep_hw *oct_hw); void
> >+octep_write_queue_select(u16 queue_id, struct octep_hw *oct_hw); void
> >+octep_notify_queue(struct octep_hw *oct_hw, u16 qid); void
> >+octep_read_dev_config(struct octep_hw *oct_hw, u64 offset, void *dst,
> >+int length); int octep_set_vq_address(struct octep_hw *oct_hw, u16 qid,
> u64 desc_area, u64 driver_area,
> >+			 u64 device_area);
> >+void octep_set_vq_num(struct octep_hw *oct_hw, u16 qid, u32 num); void
> >+octep_set_vq_ready(struct octep_hw *oct_hw, u16 qid, bool ready); bool
> >+octep_get_vq_ready(struct octep_hw *oct_hw, u16 qid); int
> >+octep_set_vq_state(struct octep_hw *oct_hw, u16 qid, const struct
> >+vdpa_vq_state *state); int octep_get_vq_state(struct octep_hw *oct_hw,
> >+u16 qid, struct vdpa_vq_state *state);
> >+u16 octep_get_vq_size(struct octep_hw *oct_hw); int
> >+octep_hw_caps_read(struct octep_hw *oct_hw, struct pci_dev *pdev);
> >+u64 octep_hw_get_dev_features(struct octep_hw *oct_hw); void
> >+octep_hw_set_drv_features(struct octep_hw *oct_hw, u64 features);
> >+
> >+#endif /* __OCTEP_VDPA_H__ */
> >diff --git a/drivers/vdpa/octeon_ep/octep_vdpa_hw.c
> >b/drivers/vdpa/octeon_ep/octep_vdpa_hw.c
> >new file mode 100644
> >index 000000000000..0a2f1d09c4ab
> >--- /dev/null
> >+++ b/drivers/vdpa/octeon_ep/octep_vdpa_hw.c
> >@@ -0,0 +1,457 @@
> >+// SPDX-License-Identifier: GPL-2.0-only
> >+/* Copyright (C) 2024 Marvell. */
> >+
> >+#include <linux/iopoll.h>
> >+
> >+#include "octep_vdpa.h"
> >+
> >+enum octep_mbox_ids {
> >+	OCTEP_MBOX_MSG_SET_VQ_STATE =3D 1,
> >+	OCTEP_MBOX_MSG_GET_VQ_STATE,
> >+};
> >+
> >+#define OCTEP_HW_TIMEOUT       10000000
> >+
> >+#define MBOX_OFFSET            64
> >+#define MBOX_RSP_MASK          0x00000001
> >+#define MBOX_RC_MASK           0x0000FFFE
> >+
> >+#define MBOX_RSP_TO_ERR(val)   (-(((val) & MBOX_RC_MASK) >> 2))
> >+#define MBOX_AVAIL(val)        (((val) & MBOX_RSP_MASK))
> >+#define MBOX_RSP(val)          ((val) & (MBOX_RC_MASK |
> MBOX_RSP_MASK))
> >+
> >+struct octep_mbox_hdr {
> >+	u8 ver;
> >+	u8 rsvd1;
> >+	u16 id;
> >+	u16 rsvd2;
> >+#define MBOX_REQ_SIG (0xdead)
> >+#define MBOX_RSP_SIG (0xbeef)
> >+	u16 sig;
> >+};
> >+
> >+struct octep_mbox_sts {
> >+	u16 rsp:1;
> >+	u16 rc:15;
> >+	u16 rsvd;
> >+};
> >+
> >+struct octep_mbox {
> >+	struct octep_mbox_hdr hdr;
> >+	struct octep_mbox_sts sts;
> >+	u64 rsvd;
> >+	u32 data[];
> >+};
> >+
> >+static inline struct octep_mbox __iomem *octep_get_mbox(struct
> >+octep_hw *oct_hw) {
> >+	return (struct octep_mbox __iomem *)(oct_hw->dev_cfg +
> MBOX_OFFSET);
> >+}
> >+
> >+static inline int octep_wait_for_mbox_avail(struct octep_mbox __iomem
> >+*mbox) {
> >+	u32 val;
> >+
> >+	return readx_poll_timeout(ioread32, &mbox->sts, val,
> MBOX_AVAIL(val), 10,
> >+				  OCTEP_HW_TIMEOUT);
> >+}
> >+
> >+static inline int octep_wait_for_mbox_rsp(struct octep_mbox __iomem
> >+*mbox) {
> >+	u32 val;
> >+
> >+	return readx_poll_timeout(ioread32, &mbox->sts, val,
> MBOX_RSP(val), 10,
> >+				  OCTEP_HW_TIMEOUT);
> >+}
> >+
> >+static inline void octep_write_hdr(struct octep_mbox __iomem *mbox,
> >+u16 id, u16 sig) {
> >+	iowrite16(id, &mbox->hdr.id);
> >+	iowrite16(sig, &mbox->hdr.sig);
> >+}
> >+
> >+static inline u32 octep_read_sig(struct octep_mbox __iomem *mbox) {
> >+	return ioread16(&mbox->hdr.sig);
> >+}
> >+
> >+static inline void octep_write_sts(struct octep_mbox __iomem *mbox,
> >+u32 sts) {
> >+	iowrite32(sts, &mbox->sts);
> >+}
> >+
> >+static inline u32 octep_read_sts(struct octep_mbox __iomem *mbox) {
> >+	return ioread32(&mbox->sts);
> >+}
> >+
> >+static inline u32 octep_read32_word(struct octep_mbox __iomem *mbox,
> >+u16 word_idx) {
> >+	return ioread32(&mbox->data[word_idx]); }
> >+
> >+static inline void octep_write32_word(struct octep_mbox __iomem *mbox,
> >+u16 word_idx, u32 word) {
> >+	return iowrite32(word, &mbox->data[word_idx]); }
> >+
> >+static int octep_process_mbox(struct octep_hw *oct_hw, u16 id, u16 qid,
> void *buffer,
> >+			      u32 buf_size, bool write)
> >+{
> >+	struct octep_mbox __iomem *mbox =3D octep_get_mbox(oct_hw);
> >+	struct pci_dev *pdev =3D oct_hw->pdev;
> >+	u32 *p =3D (u32 *)buffer;
> >+	u16 data_wds;
> >+	int ret, i;
> >+	u32 val;
> >+
> >+	if (!IS_ALIGNED(buf_size, 4))
> >+		return -EINVAL;
> >+
> >+	/* Make sure mbox space is available */
> >+	ret =3D octep_wait_for_mbox_avail(mbox);
> >+	if (ret) {
> >+		dev_warn(&pdev->dev, "Timeout waiting for previous mbox
> data to be consumed\n");
> >+		return ret;
> >+	}
> >+	data_wds =3D buf_size / 4;
> >+
> >+	if (write) {
> >+		for (i =3D 1; i <=3D data_wds; i++) {
> >+			octep_write32_word(mbox, i, *p);
> >+			p++;
> >+		}
> >+	}
> >+	octep_write32_word(mbox, 0, (u32)qid);
> >+	octep_write_sts(mbox, 0);
> >+
> >+	octep_write_hdr(mbox, id, MBOX_REQ_SIG);
> >+
> >+	ret =3D octep_wait_for_mbox_rsp(mbox);
> >+	if (ret) {
> >+		dev_warn(&pdev->dev, "Timeout waiting for mbox : %d
> response\n", id);
> >+		return ret;
> >+	}
> >+
> >+	val =3D octep_read_sig(mbox);
> >+	if ((val & 0xFFFF) !=3D MBOX_RSP_SIG) {
> >+		dev_warn(&pdev->dev, "Invalid Signature from mbox : %d
> response\n", id);
> >+		return ret;
>=20
> `ret` here is 0, is it right to return 0 in this case?
> If yes, maybe better to return 0 directly.
>=20
> >+	}
> >+
> >+	val =3D octep_read_sts(mbox);
> >+	if (val & MBOX_RC_MASK) {
> >+		ret =3D MBOX_RSP_TO_ERR(val);
> >+		dev_warn(&pdev->dev, "Error while processing mbox : %d, err
> %d\n", id, ret);
> >+		return ret;
> >+	}
> >+
> >+	if (!write)
> >+		for (i =3D 1; i <=3D data_wds; i++)
> >+			*p++ =3D octep_read32_word(mbox, i);
> >+
> >+	return 0;
> >+}
> >+
> >+static void octep_mbox_init(struct octep_mbox __iomem *mbox) {
> >+	iowrite32(1, &mbox->sts);
> >+}
> >+
> >+u8 octep_hw_get_status(struct octep_hw *oct_hw) {
> >+	return ioread8(&oct_hw->common_cfg->device_status);
> >+}
> >+
> >+void octep_hw_set_status(struct octep_hw *oct_hw, u8 status) {
> >+	iowrite8(status, &oct_hw->common_cfg->device_status);
> >+}
> >+
> >+void octep_hw_reset(struct octep_hw *oct_hw) {
> >+	u8 val;
> >+
> >+	octep_hw_set_status(oct_hw, 0 | BIT(7));
> >+	if (readx_poll_timeout(ioread8, &oct_hw->common_cfg-
> >device_status, val, !val, 10,
> >+			       OCTEP_HW_TIMEOUT)) {
> >+		dev_warn(&oct_hw->pdev->dev, "Octeon device reset
> timeout\n");
> >+		return;
> >+	}
> >+}
> >+
> >+u64 octep_hw_get_dev_features(struct octep_hw *oct_hw) {
> >+	u32 features_lo, features_hi;
> >+	u32 val, select;
> >+
> >+	select =3D 0;
> >+	iowrite32(select | BIT(15),
> >+&oct_hw->common_cfg->device_feature_select);
> >+
> >+	if (readx_poll_timeout(ioread32, &oct_hw->common_cfg-
> >device_feature_select, val,
> >+			       val =3D=3D select, 10, OCTEP_HW_TIMEOUT)) {
> >+		dev_warn(&oct_hw->pdev->dev, "Feature select%d write
> timeout\n", select);
> >+		return 0ULL;
>=20
> nit: `return 0;` should be fine too.
>=20
> >+	}
> >+	features_lo =3D ioread32(&oct_hw->common_cfg->device_feature);
> >+
> >+	select =3D 1;
> >+	iowrite32(select | BIT(15),
> >+&oct_hw->common_cfg->device_feature_select);
> >+
> >+	if (readx_poll_timeout(ioread32, &oct_hw->common_cfg-
> >device_feature_select, val,
> >+			       val =3D=3D select, 10, OCTEP_HW_TIMEOUT)) {
> >+		dev_warn(&oct_hw->pdev->dev, "Feature select%d write
> timeout\n", select);
> >+		return 0ULL;
> >+	}
> >+	features_hi =3D ioread32(&oct_hw->common_cfg->device_feature);
> >+
> >+	return ((u64)features_hi << 32) | features_lo; }
> >+
> >+void octep_hw_set_drv_features(struct octep_hw *oct_hw, u64 features)
> >+{
> >+	u32 val, select;
> >+
> >+	select =3D 0;
> >+	iowrite32(select | BIT(15),
> >+&oct_hw->common_cfg->guest_feature_select);
> >+
> >+	if (readx_poll_timeout(ioread32, &oct_hw->common_cfg-
> >guest_feature_select, val,
> >+			       val =3D=3D select, 10, OCTEP_HW_TIMEOUT)) {
> >+		dev_warn(&oct_hw->pdev->dev, "Feature select%d write
> timeout\n", select);
> >+		return;
> >+	}
> >+	iowrite32(features & (BIT_ULL(32) - 1),
> >+&oct_hw->common_cfg->guest_feature);
> >+
> >+	select =3D 1;
> >+	iowrite32(select | BIT(15),
> >+&oct_hw->common_cfg->guest_feature_select);
> >+
> >+	if (readx_poll_timeout(ioread32, &oct_hw->common_cfg-
> >guest_feature_select, val,
> >+			       val =3D=3D select, 10, OCTEP_HW_TIMEOUT)) {
> >+		dev_warn(&oct_hw->pdev->dev, "Feature select%d write
> timeout\n", select);
> >+		return;
> >+	}
> >+	iowrite32(features >> 32, &oct_hw->common_cfg->guest_feature);
> >+}
> >+
> >+void octep_write_queue_select(u16 queue_id, struct octep_hw *oct_hw)
>=20
> In almost all other fuctions, `oct_hw` is the first parameter, I would tr=
y to unify
> that here as well.
>=20
> >+{
> >+	u16 val;
> >+
> >+	iowrite16(queue_id | BIT(15), &oct_hw->common_cfg-
> >queue_select);
> >+
> >+	if (readx_poll_timeout(ioread16, &oct_hw->common_cfg-
> >queue_select, val, val =3D=3D queue_id,
> >+			       10, OCTEP_HW_TIMEOUT)) {
> >+		dev_warn(&oct_hw->pdev->dev, "Queue select write
> timeout\n");
> >+		return;
> >+	}
> >+}
> >+
> >+void octep_notify_queue(struct octep_hw *oct_hw, u16 qid) {
> >+	iowrite16(qid, oct_hw->vqs[qid].notify_addr); }
> >+
> >+void octep_read_dev_config(struct octep_hw *oct_hw, u64 offset, void
> >+*dst, int length) {
> >+	u8 old_gen, new_gen, *p;
> >+	int i;
> >+
> >+	WARN_ON(offset + length > oct_hw->config_size);
>                 ^
> Should we return early in this case?
Yes, I will move this to caller of this function.
>=20
> >+	do {
> >+		old_gen =3D ioread8(&oct_hw->common_cfg-
> >config_generation);
> >+		p =3D dst;
> >+		for (i =3D 0; i < length; i++)
> >+			*p++ =3D ioread8(oct_hw->dev_cfg + offset + i);
> >+
> >+		new_gen =3D ioread8(&oct_hw->common_cfg-
> >config_generation);
> >+	} while (old_gen !=3D new_gen);
> >+}
> >+
> >+int octep_set_vq_address(struct octep_hw *oct_hw, u16 qid, u64
> desc_area, u64 driver_area,
> >+			 u64 device_area)
> >+{
> >+	struct virtio_pci_common_cfg __iomem *cfg =3D oct_hw->common_cfg;
> >+
> >+	octep_write_queue_select(qid, oct_hw);
> >+	vp_iowrite64_twopart(desc_area, &cfg->queue_desc_lo,
> >+			     &cfg->queue_desc_hi);
> >+	vp_iowrite64_twopart(driver_area, &cfg->queue_avail_lo,
> >+			     &cfg->queue_avail_hi);
> >+	vp_iowrite64_twopart(device_area, &cfg->queue_used_lo,
> >+			     &cfg->queue_used_hi);
> >+
> >+	return 0;
> >+}
> >+
> >+int octep_get_vq_state(struct octep_hw *oct_hw, u16 qid, struct
> >+vdpa_vq_state *state) {
> >+	return octep_process_mbox(oct_hw,
> OCTEP_MBOX_MSG_GET_VQ_STATE, qid, state,
> >+				  sizeof(*state), 0);
> >+}
> >+
> >+int octep_set_vq_state(struct octep_hw *oct_hw, u16 qid, const struct
> >+vdpa_vq_state *state) {
> >+	struct vdpa_vq_state q_state;
> >+
> >+	memcpy(&q_state, state, sizeof(struct vdpa_vq_state));
> >+	return octep_process_mbox(oct_hw,
> OCTEP_MBOX_MSG_SET_VQ_STATE, qid, &q_state,
> >+				  sizeof(*state), 1);
> >+}
> >+
> >+void octep_set_vq_num(struct octep_hw *oct_hw, u16 qid, u32 num) {
> >+	struct virtio_pci_common_cfg __iomem *cfg =3D oct_hw->common_cfg;
> >+
> >+	octep_write_queue_select(qid, oct_hw);
> >+	iowrite16(num, &cfg->queue_size);
> >+}
> >+
> >+void octep_set_vq_ready(struct octep_hw *oct_hw, u16 qid, bool ready)
> >+{
> >+	struct virtio_pci_common_cfg __iomem *cfg =3D oct_hw->common_cfg;
> >+
> >+	octep_write_queue_select(qid, oct_hw);
> >+	iowrite16(ready, &cfg->queue_enable); }
> >+
> >+bool octep_get_vq_ready(struct octep_hw *oct_hw, u16 qid) {
> >+	struct virtio_pci_common_cfg __iomem *cfg =3D oct_hw->common_cfg;
> >+
> >+	octep_write_queue_select(qid, oct_hw);
> >+	return ioread16(&cfg->queue_enable);
> >+}
> >+
> >+u16 octep_get_vq_size(struct octep_hw *oct_hw) {
> >+	octep_write_queue_select(0, oct_hw);
> >+	return ioread16(&oct_hw->common_cfg->queue_size);
> >+}
> >+
> >+static u32 octep_get_config_size(struct octep_hw *oct_hw) {
> >+	return sizeof(struct virtio_net_config); }
> >+
> >+static void __iomem *get_cap_addr(struct octep_hw *oct_hw, struct
> >+virtio_pci_cap *cap) {
> >+	struct device *dev =3D &oct_hw->pdev->dev;
> >+	u32 length =3D cap->length;
> >+	u32 offset =3D cap->offset;
>=20
> Should we use le32_to_cpu() to access that fields (lenght, offset)?
>=20
> >+	u8  bar    =3D cap->bar;
> >+	u32 len;
> >+
> >+	if (bar !=3D OCTEP_HW_CAPS_BAR) {
> >+		dev_err(dev, "Invalid bar: %u\n", bar);
> >+		return NULL;
> >+	}
> >+	if (offset + length < offset) {
> >+		dev_err(dev, "offset(%u) + length(%u) overflows\n",
> >+			offset, length);
> >+		return NULL;
> >+	}
> >+	len =3D pci_resource_len(oct_hw->pdev, bar);
> >+	if (offset + length > len) {
> >+		dev_err(dev, "invalid cap: overflows bar space: %u > %u\n",
> >+			offset + length, len);
> >+		return NULL;
> >+	}
> >+	return oct_hw->base[bar] + offset;
> >+}
> >+
> >+static void pci_caps_read(struct octep_hw *oct_hw, void *buf, size_t
> >+len, off_t offset) {
> >+	u8 __iomem *bar =3D oct_hw->base[OCTEP_HW_CAPS_BAR];
> >+	u8 *p =3D buf;
> >+	size_t i;
> >+
> >+	for (i =3D 0; i < len; i++)
> >+		*p++ =3D ioread8(bar + offset + i);
> >+}
> >+
> >+static int pci_signature_verify(struct octep_hw *oct_hw) {
> >+	u32 signature[2];
> >+
> >+	pci_caps_read(oct_hw, &signature, sizeof(signature), 0);
> >+
> >+	if (signature[0] !=3D OCTEP_FW_READY_SIGNATURE0)
> >+		return -1;
> >+
> >+	if (signature[1] !=3D OCTEP_FW_READY_SIGNATURE1)
> >+		return -1;
> >+
> >+	return 0;
> >+}
> >+
> >+int octep_hw_caps_read(struct octep_hw *oct_hw, struct pci_dev *pdev)
> >+{
> >+	struct octep_mbox __iomem *mbox;
> >+	struct device *dev =3D &pdev->dev;
> >+	struct virtio_pci_cap cap;
> >+	int ret;
> >+	u8 pos;
> >+
> >+	oct_hw->pdev =3D pdev;
> >+	ret =3D pci_signature_verify(oct_hw);
> >+	if (ret) {
> >+		dev_err(dev, "Octeon Virtio FW is not initialized\n");
> >+		return -EIO;
> >+	}
> >+
> >+	pci_caps_read(oct_hw, &pos, 1, PCI_CAPABILITY_LIST);
> >+
> >+	while (pos) {
> >+		pci_caps_read(oct_hw, &cap, 2, pos);
> >+
> >+		if (cap.cap_vndr !=3D PCI_CAP_ID_VNDR) {
> >+			dev_err(dev, "Found invalid capability vndr id: %d\n",
> cap.cap_vndr);
> >+			break;
> >+		}
> >+
> >+		pci_caps_read(oct_hw, &cap, sizeof(cap), pos);
> >+
> >+		dev_info(dev, "[%2x] cfg type: %u, bar: %u, offset: %04x, len:
> %u\n",
> >+			 pos, cap.cfg_type, cap.bar, cap.offset, cap.length);
> >+
> >+		switch (cap.cfg_type) {
> >+		case VIRTIO_PCI_CAP_COMMON_CFG:
> >+			oct_hw->common_cfg =3D get_cap_addr(oct_hw, &cap);
> >+			break;
> >+		case VIRTIO_PCI_CAP_NOTIFY_CFG:
> >+			pci_caps_read(oct_hw, &oct_hw-
> >notify_off_multiplier,
> >+				      4, pos + sizeof(cap));
> >+
> >+			oct_hw->notify_base =3D get_cap_addr(oct_hw, &cap);
> >+			oct_hw->notify_bar =3D cap.bar;
> >+			oct_hw->notify_base_pa =3D pci_resource_start(pdev,
> cap.bar) +
> >+cap.offset;
>=20
> Should we use le32_to_cpu() to access cap.offset?
>=20
> >+			break;
> >+		case VIRTIO_PCI_CAP_DEVICE_CFG:
> >+			oct_hw->dev_cfg =3D get_cap_addr(oct_hw, &cap);
> >+			break;
> >+		case VIRTIO_PCI_CAP_ISR_CFG:
> >+			oct_hw->isr =3D get_cap_addr(oct_hw, &cap);
> >+			break;
> >+		}
> >+
> >+		pos =3D cap.cap_next;
> >+	}
> >+	if (!oct_hw->common_cfg || !oct_hw->notify_base ||
> >+	    !oct_hw->dev_cfg    || !oct_hw->isr) {
> >+		dev_err(dev, "Incomplete PCI capabilities");
> >+		return -EIO;
> >+	}
> >+	oct_hw->config_size =3D octep_get_config_size(oct_hw);
> >+
> >+	mbox =3D octep_get_mbox(oct_hw);
> >+	octep_mbox_init(mbox);
> >+
> >+	dev_info(dev, "common cfg mapped at: 0x%016llx\n", (u64)oct_hw-
> >common_cfg);
> >+	dev_info(dev, "device cfg mapped at: 0x%016llx\n", (u64)oct_hw-
> >dev_cfg);
> >+	dev_info(dev, "isr cfg mapped at: 0x%016llx\n", (u64)oct_hw->isr);
> >+	dev_info(dev, "notify base: 0x%016llx, notify off multiplier: %u\n",
> >+		 (u64)oct_hw->notify_base, oct_hw->notify_off_multiplier);
> >+	dev_info(dev, "mbox mapped at: 0x%016llx\n", (u64)mbox);
> >+
> >+	return 0;
> >+}
> >diff --git a/drivers/vdpa/octeon_ep/octep_vdpa_main.c
> >b/drivers/vdpa/octeon_ep/octep_vdpa_main.c
> >new file mode 100644
> >index 000000000000..845fd35368ff
> >--- /dev/null
> >+++ b/drivers/vdpa/octeon_ep/octep_vdpa_main.c
> >@@ -0,0 +1,903 @@
> >+// SPDX-License-Identifier: GPL-2.0-only
> >+/* Copyright (C) 2024 Marvell. */
> >+
> >+#include <linux/interrupt.h>
> >+#include <linux/module.h>
> >+#include <linux/iommu.h>
> >+#include "octep_vdpa.h"
> >+
> >+#define OCTEP_VDPA_DRIVER_NAME "octep_vdpa"
> >+
> >+struct octep_pf {
> >+	u8 __iomem *base[PCI_STD_NUM_BARS];
> >+	struct pci_dev *pdev;
> >+	struct resource res;
> >+	u64 vf_base;
> >+	int enabled_vfs;
> >+	u32 vf_stride;
> >+	u16 vf_devid;
> >+};
> >+
> >+struct octep_vdpa {
> >+	struct vdpa_device vdpa;
> >+	struct octep_hw *oct_hw;
> >+	struct pci_dev *pdev;
> >+};
> >+
> >+struct octep_vdpa_mgmt_dev {
> >+	struct vdpa_mgmt_dev mdev;
> >+	struct octep_hw oct_hw;
> >+	struct pci_dev *pdev;
> >+	/* Work entry to handle device setup */
> >+	struct work_struct setup_task;
> >+	/* Device status */
> >+	atomic_t status;
> >+};
> >+
> >+static int verify_features(u64 features) {
> >+	/* Minimum features to expect */
> >+	if (!(features & BIT_ULL(VIRTIO_F_VERSION_1)))
> >+		return -EOPNOTSUPP;
> >+
> >+	if (!(features & BIT_ULL(VIRTIO_F_NOTIFICATION_DATA)))
> >+		return -EOPNOTSUPP;
> >+
> >+	if (!(features & BIT_ULL(VIRTIO_F_RING_PACKED)))
> >+		return -EOPNOTSUPP;
> >+
> >+	/* Per VIRTIO v1.1 specification, section 5.1.3.1 Feature bit
> >+	 * requirements: "VIRTIO_NET_F_MQ Requires
> VIRTIO_NET_F_CTRL_VQ".
> >+	 */
> >+	if ((features & (BIT_ULL(VIRTIO_NET_F_MQ) |
> BIT_ULL(VIRTIO_NET_F_CTRL_VQ))) =3D=3D
> >+	    BIT_ULL(VIRTIO_NET_F_MQ))
> >+		return -EINVAL;
> >+
> >+	return 0;
> >+}
> >+
> >+static struct octep_hw *vdpa_to_octep_hw(struct vdpa_device *vdpa_dev)
> >+{
> >+	struct octep_vdpa *oct_vdpa;
> >+
> >+	oct_vdpa =3D container_of(vdpa_dev, struct octep_vdpa, vdpa);
> >+
> >+	return oct_vdpa->oct_hw;
> >+}
> >+
> >+static irqreturn_t octep_vdpa_intr_handler(int irq, void *data) {
> >+	struct octep_hw *oct_hw =3D data;
> >+	int i;
> >+
> >+	for (i =3D 0; i < oct_hw->nr_vring; i++) {
> >+		if (oct_hw->vqs[i].cb.callback && *oct_hw-
> >vqs[i].cb_notify_addr) {
> >+			*oct_hw->vqs[i].cb_notify_addr =3D 0;
> >+			oct_hw->vqs[i].cb.callback(oct_hw-
> >vqs[i].cb.private);
> >+		}
> >+	}
> >+
> >+	return IRQ_HANDLED;
> >+}
> >+
> >+static void octep_free_irqs(struct octep_hw *oct_hw) {
> >+	struct pci_dev *pdev =3D oct_hw->pdev;
> >+
> >+	if (oct_hw->irq !=3D -1) {
> >+		devm_free_irq(&pdev->dev, oct_hw->irq, oct_hw);
> >+		oct_hw->irq =3D -1;
> >+	}
> >+	pci_free_irq_vectors(pdev);
> >+}
> >+
> >+static int octep_request_irqs(struct octep_hw *oct_hw) {
> >+	struct pci_dev *pdev =3D oct_hw->pdev;
> >+	int ret, irq;
> >+
> >+	/* Use one ring/interrupt per VF for virtio call interface. */
> >+	ret =3D pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSIX);
> >+	if (ret < 0) {
> >+		dev_err(&pdev->dev, "Failed to alloc msix vector");
> >+		return ret;
> >+	}
> >+
> >+	snprintf(oct_hw->vqs->msix_name, sizeof(oct_hw->vqs-
> >msix_name),
> >+		 OCTEP_VDPA_DRIVER_NAME "-vf-%d", pci_iov_vf_id(pdev));
> >+
> >+	irq =3D pci_irq_vector(pdev, 0);
> >+	ret =3D devm_request_irq(&pdev->dev, irq, octep_vdpa_intr_handler, 0,
> >+			       oct_hw->vqs->msix_name, oct_hw);
> >+	if (ret) {
> >+		dev_err(&pdev->dev, "Failed to register interrupt handler\n");
> >+		goto free_irq_vec;
> >+	}
> >+	oct_hw->irq =3D irq;
> >+
> >+	return 0;
> >+
> >+free_irq_vec:
> >+	pci_free_irq_vectors(pdev);
> >+	return ret;
> >+}
> >+
> >+static u64 octep_vdpa_get_device_features(struct vdpa_device
> >+*vdpa_dev) {
> >+	struct octep_hw *oct_hw =3D vdpa_to_octep_hw(vdpa_dev);
> >+
> >+	return oct_hw->features;
> >+}
> >+
> >+static int octep_vdpa_set_driver_features(struct vdpa_device
> >+*vdpa_dev, u64 features) {
> >+	struct octep_hw *oct_hw =3D vdpa_to_octep_hw(vdpa_dev);
> >+	int ret;
> >+
> >+	pr_debug("Driver Features: %llx\n", features);
> >+	ret =3D verify_features(features);
> >+	if (ret)
> >+		return ret;
> >+
> >+	octep_hw_set_drv_features(oct_hw, features);
> >+	oct_hw->drv_features =3D features;
> >+
> >+	return 0;
> >+}
> >+
> >+static u64 octep_vdpa_get_driver_features(struct vdpa_device
> >+*vdpa_dev) {
> >+	struct octep_hw *oct_hw =3D vdpa_to_octep_hw(vdpa_dev);
> >+
> >+	return oct_hw->features & oct_hw->drv_features; }
> >+
> >+static u8 octep_vdpa_get_status(struct vdpa_device *vdpa_dev) {
> >+	struct octep_hw *oct_hw =3D vdpa_to_octep_hw(vdpa_dev);
> >+
> >+	return octep_hw_get_status(oct_hw);
> >+}
> >+
> >+static void octep_vdpa_set_status(struct vdpa_device *vdpa_dev, u8
> >+status) {
> >+	struct octep_hw *oct_hw =3D vdpa_to_octep_hw(vdpa_dev);
> >+	u8 status_old;
> >+
> >+	status_old =3D octep_hw_get_status(oct_hw);
> >+
> >+	if (status_old =3D=3D status)
> >+		return;
> >+
> >+	if ((status & VIRTIO_CONFIG_S_DRIVER_OK) &&
> >+	    !(status_old & VIRTIO_CONFIG_S_DRIVER_OK)) {
> >+		if (octep_request_irqs(oct_hw))
> >+			status =3D status_old | VIRTIO_CONFIG_S_FAILED;
> >+	}
> >+	octep_hw_set_status(oct_hw, status);
> >+}
> >+
> >+static int octep_vdpa_reset(struct vdpa_device *vdpa_dev) {
> >+	struct octep_hw *oct_hw =3D vdpa_to_octep_hw(vdpa_dev);
> >+	u8 status =3D octep_hw_get_status(oct_hw);
> >+	u16 qid;
> >+
> >+	if (status =3D=3D 0)
> >+		return 0;
> >+
> >+	for (qid =3D 0; qid < oct_hw->nr_vring; qid++) {
> >+		oct_hw->vqs[qid].cb.callback =3D NULL;
> >+		oct_hw->vqs[qid].cb.private =3D NULL;
> >+		oct_hw->config_cb.callback =3D NULL;
> >+		oct_hw->config_cb.private =3D NULL;
> >+	}
> >+	octep_hw_reset(oct_hw);
> >+
> >+	if (status & VIRTIO_CONFIG_S_DRIVER_OK)
> >+		octep_free_irqs(oct_hw);
> >+
> >+	return 0;
> >+}
> >+
> >+static u16 octep_vdpa_get_vq_num_max(struct vdpa_device *vdpa_dev) {
> >+	struct octep_hw *oct_hw =3D vdpa_to_octep_hw(vdpa_dev);
> >+
> >+	return octep_get_vq_size(oct_hw);
> >+}
> >+
> >+static int octep_vdpa_get_vq_state(struct vdpa_device *vdpa_dev, u16 qi=
d,
> >+				   struct vdpa_vq_state *state)
> >+{
> >+	struct octep_hw *oct_hw =3D vdpa_to_octep_hw(vdpa_dev);
> >+
> >+	return octep_get_vq_state(oct_hw, qid, state); }
> >+
> >+static int octep_vdpa_set_vq_state(struct vdpa_device *vdpa_dev, u16 qi=
d,
> >+				   const struct vdpa_vq_state *state) {
> >+	struct octep_hw *oct_hw =3D vdpa_to_octep_hw(vdpa_dev);
> >+
> >+	return octep_set_vq_state(oct_hw, qid, state); }
> >+
> >+static void octep_vdpa_set_vq_cb(struct vdpa_device *vdpa_dev, u16
> >+qid, struct vdpa_callback *cb) {
> >+	struct octep_hw *oct_hw =3D vdpa_to_octep_hw(vdpa_dev);
> >+
> >+	oct_hw->vqs[qid].cb =3D *cb;
> >+}
> >+
> >+static void octep_vdpa_set_vq_ready(struct vdpa_device *vdpa_dev, u16
> >+qid, bool ready) {
> >+	struct octep_hw *oct_hw =3D vdpa_to_octep_hw(vdpa_dev);
> >+
> >+	octep_set_vq_ready(oct_hw, qid, ready); }
> >+
> >+static bool octep_vdpa_get_vq_ready(struct vdpa_device *vdpa_dev, u16
> >+qid) {
> >+	struct octep_hw *oct_hw =3D vdpa_to_octep_hw(vdpa_dev);
> >+
> >+	return octep_get_vq_ready(oct_hw, qid); }
> >+
> >+static void octep_vdpa_set_vq_num(struct vdpa_device *vdpa_dev, u16
> >+qid, u32 num) {
> >+	struct octep_hw *oct_hw =3D vdpa_to_octep_hw(vdpa_dev);
> >+
> >+	octep_set_vq_num(oct_hw, qid, num);
> >+}
> >+
> >+static int octep_vdpa_set_vq_address(struct vdpa_device *vdpa_dev, u16
> qid, u64 desc_area,
> >+				     u64 driver_area, u64 device_area) {
> >+	struct octep_hw *oct_hw =3D vdpa_to_octep_hw(vdpa_dev);
> >+
> >+	pr_debug("qid[%d]: desc_area: %llx\n", qid, desc_area);
> >+	pr_debug("qid[%d]: driver_area: %llx\n", qid, driver_area);
> >+	pr_debug("qid[%d]: device_area: %llx\n\n", qid, device_area);
> >+
> >+	return octep_set_vq_address(oct_hw, qid, desc_area, driver_area,
> >+device_area); }
> >+
> >+static void octep_vdpa_kick_vq(struct vdpa_device *vdpa_dev, u16 qid)
> >+{
> >+	struct octep_hw *oct_hw =3D vdpa_to_octep_hw(vdpa_dev);
> >+
> >+	octep_notify_queue(oct_hw, qid);
> >+}
> >+
> >+static void octep_vdpa_kick_vq_with_data(struct vdpa_device *vdpa_dev,
> >+u32 data) {
> >+	struct octep_hw *oct_hw =3D vdpa_to_octep_hw(vdpa_dev);
> >+	u16 idx =3D data & 0xFFFF;
> >+
> >+	vp_iowrite32(data, oct_hw->vqs[idx].notify_addr); }
> >+
> >+static u32 octep_vdpa_get_generation(struct vdpa_device *vdpa_dev) {
> >+	struct octep_hw *oct_hw =3D vdpa_to_octep_hw(vdpa_dev);
> >+
> >+	return vp_ioread8(&oct_hw->common_cfg->config_generation);
> >+}
> >+
> >+static u32 octep_vdpa_get_device_id(struct vdpa_device *vdpa_dev) {
> >+	return VIRTIO_ID_NET;
> >+}
> >+
> >+static u32 octep_vdpa_get_vendor_id(struct vdpa_device *vdpa_dev) {
> >+	return PCI_VENDOR_ID_CAVIUM;
> >+}
> >+
> >+static u32 octep_vdpa_get_vq_align(struct vdpa_device *vdpa_dev) {
> >+	return PAGE_SIZE;
> >+}
> >+
> >+static size_t octep_vdpa_get_config_size(struct vdpa_device *vdpa_dev)
> >+{
> >+	struct octep_hw *oct_hw =3D vdpa_to_octep_hw(vdpa_dev);
> >+
> >+	return oct_hw->config_size;
> >+}
> >+
> >+static void octep_vdpa_get_config(struct vdpa_device *vdpa_dev, unsigne=
d
> int offset, void *buf,
> >+				  unsigned int len)
> >+{
> >+	struct octep_hw *oct_hw =3D vdpa_to_octep_hw(vdpa_dev);
> >+
> >+	octep_read_dev_config(oct_hw, offset, buf, len); }
> >+
> >+static void octep_vdpa_set_config(struct vdpa_device *vdpa_dev, unsigne=
d
> int offset,
> >+				  const void *buf, unsigned int len) {
> >+	/* Not supported */
> >+}
> >+
> >+static void octep_vdpa_set_config_cb(struct vdpa_device *vdpa_dev,
> >+struct vdpa_callback *cb) {
> >+	struct octep_hw *oct_hw =3D vdpa_to_octep_hw(vdpa_dev);
> >+
> >+	oct_hw->config_cb.callback =3D cb->callback;
> >+	oct_hw->config_cb.private =3D cb->private; }
> >+
> >+static struct vdpa_notification_area octep_get_vq_notification(struct
> vdpa_device *vdpa_dev,
> >+							       u16 idx)
> >+{
> >+	struct octep_hw *oct_hw =3D vdpa_to_octep_hw(vdpa_dev);
> >+	struct vdpa_notification_area area;
> >+
> >+	area.addr =3D oct_hw->vqs[idx].notify_pa;
> >+	area.size =3D PAGE_SIZE;
> >+
> >+	return area;
> >+}
> >+
> >+static int octep_vdpa_set_map(struct vdpa_device *vdev, unsigned int as=
id,
> >+			      struct vhost_iotlb *iotlb)
> >+{
> >+	return 0;
> >+}
> >+
> >+static struct vdpa_config_ops octep_vdpa_ops =3D {
> >+	.get_device_features =3D octep_vdpa_get_device_features,
> >+	.set_driver_features =3D octep_vdpa_set_driver_features,
> >+	.get_driver_features =3D octep_vdpa_get_driver_features,
> >+	.get_status	=3D octep_vdpa_get_status,
> >+	.set_status	=3D octep_vdpa_set_status,
> >+	.reset		=3D octep_vdpa_reset,
> >+	.get_vq_num_max	=3D octep_vdpa_get_vq_num_max,
> >+	.get_vq_state	=3D octep_vdpa_get_vq_state,
> >+	.set_vq_state	=3D octep_vdpa_set_vq_state,
> >+	.set_vq_cb	=3D octep_vdpa_set_vq_cb,
> >+	.set_vq_ready	=3D octep_vdpa_set_vq_ready,
> >+	.get_vq_ready	=3D octep_vdpa_get_vq_ready,
> >+	.set_vq_num	=3D octep_vdpa_set_vq_num,
> >+	.set_vq_address	=3D octep_vdpa_set_vq_address,
> >+	.get_vq_irq	=3D NULL,
> >+	.kick_vq	=3D octep_vdpa_kick_vq,
> >+	.kick_vq_with_data	=3D octep_vdpa_kick_vq_with_data,
> >+	.get_generation	=3D octep_vdpa_get_generation,
> >+	.get_device_id	=3D octep_vdpa_get_device_id,
> >+	.get_vendor_id	=3D octep_vdpa_get_vendor_id,
> >+	.get_vq_align	=3D octep_vdpa_get_vq_align,
> >+	.get_config_size	=3D octep_vdpa_get_config_size,
> >+	.get_config	=3D octep_vdpa_get_config,
> >+	.set_config	=3D octep_vdpa_set_config,
> >+	.set_config_cb  =3D octep_vdpa_set_config_cb,
> >+	.get_vq_notification =3D octep_get_vq_notification, };
> >+
> >+static int octep_iomap_region(struct pci_dev *pdev, u8 __iomem **tbl,
> >+u8 bar) {
> >+	int ret;
> >+
> >+	ret =3D pci_request_region(pdev, bar, OCTEP_VDPA_DRIVER_NAME);
> >+	if (ret) {
> >+		dev_err(&pdev->dev, "Failed to request BAR:%u region\n",
> bar);
> >+		return ret;
> >+	}
> >+
> >+	tbl[bar] =3D pci_iomap(pdev, bar, pci_resource_len(pdev, bar));
> >+	if (!tbl[bar]) {
> >+		dev_err(&pdev->dev, "Failed to iomap BAR:%u\n", bar);
> >+		pci_release_region(pdev, bar);
> >+		ret =3D -ENOMEM;
> >+	}
> >+
> >+	return ret;
> >+}
> >+
> >+static void octep_iounmap_region(struct pci_dev *pdev, u8 __iomem
> >+**tbl, u8 bar) {
> >+	pci_iounmap(pdev, tbl[bar]);
> >+	pci_release_region(pdev, bar);
> >+}
> >+
> >+static void octep_vdpa_pf_bar_shrink(struct octep_pf *octpf) {
> >+	struct pci_dev *pf_dev =3D octpf->pdev;
> >+	struct resource *res =3D pf_dev->resource + PCI_STD_RESOURCES + 4;
> >+	struct pci_bus_region bus_region;
> >+
> >+	octpf->res.start =3D res->start;
> >+	octpf->res.end =3D res->end;
> >+	octpf->vf_base =3D res->start;
> >+
> >+	bus_region.start =3D res->start;
> >+	bus_region.end =3D res->start - 1;
> >+
> >+	pcibios_bus_to_resource(pf_dev->bus, res, &bus_region); }
> >+
> >+static void octep_vdpa_pf_bar_expand(struct octep_pf *octpf) {
> >+	struct pci_dev *pf_dev =3D octpf->pdev;
> >+	struct resource *res =3D pf_dev->resource + PCI_STD_RESOURCES + 4;
> >+	struct pci_bus_region bus_region;
> >+
> >+	bus_region.start =3D octpf->res.start;
> >+	bus_region.end =3D octpf->res.end;
> >+
> >+	pcibios_bus_to_resource(pf_dev->bus, res, &bus_region); }
> >+
> >+static void octep_vdpa_remove_pf(struct pci_dev *pdev) {
> >+	struct octep_pf *octpf =3D pci_get_drvdata(pdev);
> >+
> >+	pci_disable_sriov(pdev);
> >+
> >+	if (octpf->base[OCTEP_HW_CAPS_BAR])
> >+		octep_iounmap_region(pdev, octpf->base,
> OCTEP_HW_CAPS_BAR);
> >+
> >+	if (octpf->base[OCTEP_HW_MBOX_BAR])
> >+		octep_iounmap_region(pdev, octpf->base,
> OCTEP_HW_MBOX_BAR);
> >+
> >+	octep_vdpa_pf_bar_expand(octpf);
> >+}
> >+
> >+static void octep_vdpa_vf_bar_shrink(struct pci_dev *pdev) {
> >+	struct resource *vf_res =3D pdev->resource + PCI_STD_RESOURCES + 4;
> >+
> >+	memset(vf_res, 0, sizeof(*vf_res));
> >+}
> >+
> >+static void octep_vdpa_remove_vf(struct pci_dev *pdev) {
> >+	struct octep_vdpa_mgmt_dev *mgmt_dev =3D pci_get_drvdata(pdev);
> >+	struct octep_hw *oct_hw;
> >+	int status;
> >+
> >+	oct_hw =3D &mgmt_dev->oct_hw;
> >+	status =3D atomic_read(&mgmt_dev->status);
> >+	atomic_set(&mgmt_dev->status,
> OCTEP_VDPA_DEV_STATUS_UNINIT);
> >+
> >+	if (status =3D=3D OCTEP_VDPA_DEV_STATUS_WAIT_FOR_BAR_INIT) {
> >+		cancel_work_sync(&mgmt_dev->setup_task);
> >+	} else if (status =3D=3D OCTEP_VDPA_DEV_STATUS_READY) {
> >+		vdpa_mgmtdev_unregister(&mgmt_dev->mdev);
> >+		kfree(mgmt_dev->oct_hw.vqs);
> >+	}
> >+
> >+	if (oct_hw->base[OCTEP_HW_CAPS_BAR])
> >+		octep_iounmap_region(pdev, oct_hw->base,
> OCTEP_HW_CAPS_BAR);
> >+
> >+	if (oct_hw->base[OCTEP_HW_MBOX_BAR])
> >+		octep_iounmap_region(pdev, oct_hw->base,
> OCTEP_HW_MBOX_BAR);
> >+
> >+	octep_vdpa_vf_bar_shrink(pdev);
> >+}
> >+
> >+static void octep_vdpa_remove(struct pci_dev *pdev) {
> >+	if (pdev->is_virtfn)
> >+		octep_vdpa_remove_vf(pdev);
> >+	else
> >+		octep_vdpa_remove_pf(pdev);
> >+}
> >+
> >+static int octep_vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char
> *name,
> >+			      const struct vdpa_dev_set_config *config) {
> >+	struct octep_vdpa_mgmt_dev *mgmt_dev =3D container_of(mdev,
> struct octep_vdpa_mgmt_dev, mdev);
> >+	struct octep_hw *oct_hw =3D &mgmt_dev->oct_hw;
> >+	struct pci_dev *pdev =3D oct_hw->pdev;
> >+	struct vdpa_device *vdpa_dev;
> >+	struct octep_vdpa *oct_vdpa;
> >+	u64 device_features;
> >+	u16 notify_off;
> >+	int i, ret;
> >+
> >+	oct_vdpa =3D vdpa_alloc_device(struct octep_vdpa, vdpa, &pdev->dev,
> &octep_vdpa_ops, 1, 1,
> >+				     NULL, false);
> >+	if (IS_ERR(oct_vdpa)) {
> >+		dev_err(&pdev->dev, "Failed to allocate vDPA structure for
> octep vdpa device");
> >+		return PTR_ERR(oct_vdpa);
> >+	}
> >+
> >+	oct_vdpa->pdev =3D pdev;
> >+	oct_vdpa->vdpa.dma_dev =3D &pdev->dev;
> >+	oct_vdpa->vdpa.mdev =3D mdev;
> >+	oct_vdpa->oct_hw =3D oct_hw;
> >+	vdpa_dev =3D &oct_vdpa->vdpa;
> >+
> >+	device_features =3D oct_hw->features;
> >+	if (config->mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES)) {
> >+		if (config->device_features & ~device_features) {
> >+			dev_err(&pdev->dev, "The provisioned features 0x%llx
> are not supported by this device with features 0x%llx\n",
> >+				config->device_features, device_features);
> >+			return -EINVAL;
> >+		}
> >+		device_features &=3D config->device_features;
> >+	}
> >+
> >+	oct_hw->features =3D device_features;
> >+
> >+	if (verify_features(device_features)) {
> >+		dev_warn(mdev->device,
> >+			 "Must provision minimum features 0x%llx for this
> device",
> >+			 BIT_ULL(VIRTIO_F_VERSION_1) |
> BIT_ULL(VIRTIO_F_ACCESS_PLATFORM) |
> >+			 BIT_ULL(VIRTIO_F_NOTIFICATION_DATA) |
> BIT_ULL(VIRTIO_F_IN_ORDER));
> >+		return -EOPNOTSUPP;
>=20
> What about returning the return value of verify_features()?
Yes, anything would be fine.
>=20
> >+	}
> >+
> >+	oct_hw->vqs =3D kcalloc(oct_hw->nr_vring, sizeof(*oct_hw->vqs),
> >+GFP_KERNEL);
>=20
> What about using devm_kcalloc()?
> Memory allocated with that should be automatically freed on driver detach=
.
Sure, I will change it to devm_kcalloc.

>=20
> >+	if (!oct_hw->vqs)
> >+		return -ENOMEM;
> >+
> >+	oct_hw->irq =3D -1;
> >+
> >+	dev_info(&pdev->dev, "Device features : %llx\n", oct_hw->features);
> >+	dev_info(&pdev->dev, "Maximum queues : %u\n", oct_hw-
> >nr_vring);
> >+
> >+	for (i =3D 0; i < oct_hw->nr_vring; i++) {
> >+		octep_write_queue_select(i, oct_hw);
> >+		notify_off =3D vp_ioread16(&oct_hw->common_cfg-
> >queue_notify_off);
> >+		oct_hw->vqs[i].notify_addr =3D oct_hw->notify_base +
> >+			notify_off * oct_hw->notify_off_multiplier;
> >+		oct_hw->vqs[i].cb_notify_addr =3D (u32 *)oct_hw-
> >vqs[i].notify_addr + 1;
> >+		oct_hw->vqs[i].notify_pa =3D oct_hw->notify_base_pa +
> >+			notify_off * oct_hw->notify_off_multiplier;
> >+	}
> >+
> >+	if (name)
> >+		ret =3D dev_set_name(&vdpa_dev->dev, "%s", name);
> >+	else
> >+		ret =3D dev_set_name(&vdpa_dev->dev, "vdpa%u", vdpa_dev-
> >index);
> >+
> >+	ret =3D _vdpa_register_device(&oct_vdpa->vdpa, oct_hw->nr_vring);
> >+	if (ret) {
> >+		dev_err(&pdev->dev, "Failed to register to vDPA bus");
> >+		goto free_vqs;
> >+	}
> >+	return 0;
> >+
> >+free_vqs:
> >+	put_device(&oct_vdpa->vdpa.dev);
> >+	kfree(oct_hw->vqs);
> >+	return ret;
> >+}
> >+
> >+static void octep_vdpa_dev_del(struct vdpa_mgmt_dev *mdev, struct
> >+vdpa_device *dev) {
> >+	_vdpa_unregister_device(dev);
> >+}
> >+
> >+static const struct vdpa_mgmtdev_ops octep_vdpa_mgmt_dev_ops =3D {
> >+	.dev_add =3D octep_vdpa_dev_add,
> >+	.dev_del =3D octep_vdpa_dev_del
> >+};
> >+
> >+static bool get_device_ready_status(u8 __iomem *addr) {
> >+	u64 signature =3D readq(addr + OCTEP_VF_MBOX_DATA(0));
> >+
> >+	if (signature =3D=3D OCTEP_DEV_READY_SIGNATURE) {
> >+		writeq(0, addr + OCTEP_VF_MBOX_DATA(0));
> >+		return true;
> >+	}
> >+
> >+	return false;
> >+}
> >+
> >+static struct virtio_device_id id_table[] =3D {
> >+	{ VIRTIO_ID_NET, VIRTIO_DEV_ANY_ID },
> >+	{ 0 },
> >+};
> >+
> >+static void octep_vdpa_setup_task(struct work_struct *work) {
> >+	struct octep_vdpa_mgmt_dev *mgmt_dev =3D container_of(work,
> struct octep_vdpa_mgmt_dev,
> >+							    setup_task);
> >+	struct pci_dev *pdev =3D mgmt_dev->pdev;
> >+	struct device *dev =3D &pdev->dev;
> >+	struct octep_hw *oct_hw;
> >+	unsigned long timeout;
> >+	int ret;
> >+
> >+	oct_hw =3D &mgmt_dev->oct_hw;
> >+
> >+	atomic_set(&mgmt_dev->status,
> >+OCTEP_VDPA_DEV_STATUS_WAIT_FOR_BAR_INIT);
> >+
> >+	/* Wait for a maximum of 5 sec */
> >+	timeout =3D jiffies + msecs_to_jiffies(5000);
> >+	while (!time_after(jiffies, timeout)) {
> >+		if (get_device_ready_status(oct_hw-
> >base[OCTEP_HW_MBOX_BAR])) {
> >+			atomic_set(&mgmt_dev->status,
> OCTEP_VDPA_DEV_STATUS_INIT);
> >+			break;
> >+		}
> >+
> >+		if (atomic_read(&mgmt_dev->status) >=3D
> OCTEP_VDPA_DEV_STATUS_READY) {
> >+			dev_info(dev, "Stopping vDPA setup task.\n");
> >+			return;
> >+		}
> >+
> >+		usleep_range(1000, 1500);
> >+	}
> >+
> >+	if (atomic_read(&mgmt_dev->status) !=3D
> OCTEP_VDPA_DEV_STATUS_INIT) {
> >+		dev_err(dev, "BAR initialization is timed out\n");
> >+		return;
> >+	}
> >+
> >+	ret =3D octep_iomap_region(pdev, oct_hw->base,
> OCTEP_HW_CAPS_BAR);
> >+	if (ret)
> >+		return;
> >+
> >+	ret =3D octep_hw_caps_read(oct_hw, pdev);
> >+	if (ret < 0)
> >+		goto unmap_region;
> >+
> >+	oct_hw->features =3D octep_hw_get_dev_features(oct_hw);
> >+	ret =3D verify_features(oct_hw->features);
> >+	if (ret) {
> >+		dev_err(&pdev->dev, "Octeon Virtio FW is not initialized\n");
> >+		goto unmap_region;
> >+	}
> >+	oct_hw->nr_vring =3D vp_ioread16(&oct_hw->common_cfg-
> >num_queues);
> >+
> >+	mgmt_dev->mdev.ops =3D &octep_vdpa_mgmt_dev_ops;
> >+	mgmt_dev->mdev.id_table =3D id_table;
> >+	mgmt_dev->mdev.max_supported_vqs =3D oct_hw->nr_vring;
> >+	mgmt_dev->mdev.supported_features =3D oct_hw->features;
> >+	mgmt_dev->mdev.config_attr_mask =3D (1 <<
> VDPA_ATTR_DEV_FEATURES);
> >+	mgmt_dev->mdev.device =3D dev;
> >+
> >+	ret =3D vdpa_mgmtdev_register(&mgmt_dev->mdev);
> >+	if (ret) {
> >+		dev_err(dev, "Failed to register vdpa management
> interface\n");
> >+		goto unmap_region;
> >+	}
> >+
> >+	atomic_set(&mgmt_dev->status,
> OCTEP_VDPA_DEV_STATUS_READY);
> >+
> >+	return;
> >+
> >+unmap_region:
> >+	octep_iounmap_region(pdev, oct_hw->base, OCTEP_HW_CAPS_BAR);
> >+	oct_hw->base[OCTEP_HW_CAPS_BAR] =3D NULL; }
> >+
> >+static int octep_vdpa_probe_vf(struct pci_dev *pdev) {
> >+	struct octep_vdpa_mgmt_dev *mgmt_dev;
> >+	struct device *dev =3D &pdev->dev;
> >+	struct iommu_domain *domain;
> >+	int ret;
> >+
> >+	ret =3D pcim_enable_device(pdev);
> >+	if (ret) {
> >+		dev_err(dev, "Failed to enable device\n");
> >+		return ret;
> >+	}
> >+
> >+	ret =3D dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
> >+	if (ret) {
> >+		dev_err(dev, "No usable DMA configuration\n");
> >+		return ret;
> >+	}
> >+	pci_set_master(pdev);
> >+
> >+	domain =3D iommu_get_domain_for_dev(dev);
> >+	if (!domain || domain->type =3D=3D IOMMU_DOMAIN_IDENTITY) {
> >+		dev_info(dev, "NO-IOMMU\n");
> >+		octep_vdpa_ops.set_map =3D octep_vdpa_set_map;
> >+	}
> >+
> >+	mgmt_dev =3D devm_kzalloc(dev, sizeof(struct octep_vdpa_mgmt_dev),
> GFP_KERNEL);
> >+	if (!mgmt_dev)
> >+		return -ENOMEM;
> >+
> >+	ret =3D octep_iomap_region(pdev, mgmt_dev->oct_hw.base,
> OCTEP_HW_MBOX_BAR);
> >+	if (ret)
> >+		return ret;
> >+
> >+	mgmt_dev->pdev =3D pdev;
> >+	pci_set_drvdata(pdev, mgmt_dev);
> >+
> >+	atomic_set(&mgmt_dev->status, OCTEP_VDPA_DEV_STATUS_ALLOC);
> >+	INIT_WORK(&mgmt_dev->setup_task, octep_vdpa_setup_task);
> >+	schedule_work(&mgmt_dev->setup_task);
> >+	dev_info(&pdev->dev, "octep vdpa mgmt device setup task is
> >+queued\n");
> >+
> >+	return 0;
> >+}
> >+
> >+static void octep_vdpa_assign_barspace(struct pci_dev *vf_dev, struct
> >+pci_dev *pf_dev, u8 idx) {
> >+	struct resource *vf_res =3D vf_dev->resource + PCI_STD_RESOURCES + 4;
> >+	struct resource *pf_res =3D pf_dev->resource + PCI_STD_RESOURCES +
> 4;
> >+	struct octep_pf *pf =3D pci_get_drvdata(pf_dev);
> >+	struct pci_bus_region bus_region;
> >+
> >+	vf_res->name =3D pci_name(vf_dev);
> >+	vf_res->flags =3D pf_res->flags;
> >+	vf_res->parent =3D (pf_dev->resource + PCI_STD_RESOURCES)->parent;
> >+
> >+	bus_region.start =3D pf->vf_base + idx * pf->vf_stride;
> >+	bus_region.end =3D bus_region.start + pf->vf_stride - 1;
> >+	pcibios_bus_to_resource(vf_dev->bus, vf_res, &bus_region); }
> >+
> >+static int octep_vdpa_sriov_configure(struct pci_dev *pdev, int
> >+num_vfs) {
> >+	struct octep_pf *pf =3D pci_get_drvdata(pdev);
> >+	u8 __iomem *addr =3D pf->base[OCTEP_HW_MBOX_BAR];
> >+	int ret, i;
> >+
> >+	if (num_vfs > 0) {
> >+		struct pci_dev *vf_pdev =3D NULL;
> >+		bool done =3D false;
> >+		int index =3D 0;
> >+
> >+		ret =3D pci_enable_sriov(pdev, num_vfs);
> >+		if (ret)
> >+			return ret;
> >+
> >+		pf->enabled_vfs =3D num_vfs;
> >+
> >+		while ((vf_pdev =3D pci_get_device(PCI_VENDOR_ID_CAVIUM,
> PCI_ANY_ID, vf_pdev))) {
> >+			if (vf_pdev->device !=3D pf->vf_devid)
> >+				continue;
> >+
> >+			octep_vdpa_assign_barspace(vf_pdev, pdev, index);
> >+			if (++index =3D=3D num_vfs) {
> >+				done =3D true;
> >+				break;
> >+			}
> >+		}
> >+
> >+		if (done) {
> >+			for (i =3D 0; i < pf->enabled_vfs; i++)
> >+				writeq(OCTEP_DEV_READY_SIGNATURE, addr
> + OCTEP_PF_MBOX_DATA(i));
> >+		}
> >+	} else {
>=20
> I suggest moving the smaller branch to the top and possibly returning ear=
lier.
>=20
> >+		if (!pci_num_vf(pdev))
> >+			return 0;
> >+
> >+		pci_disable_sriov(pdev);
> >+		pf->enabled_vfs =3D 0;
> >+	}
> >+
> >+	return num_vfs;
> >+}
> >+
> >+static u16 octep_get_vf_devid(struct pci_dev *pdev) {
> >+	u16 did;
> >+
> >+	switch (pdev->device) {
> >+	case OCTEP_VDPA_DEVID_CN106K_PF:
> >+		did =3D OCTEP_VDPA_DEVID_CN106K_VF;
> >+		break;
> >+	case OCTEP_VDPA_DEVID_CN105K_PF:
> >+		did =3D OCTEP_VDPA_DEVID_CN105K_VF;
> >+		break;
> >+	case OCTEP_VDPA_DEVID_CN103K_PF:
> >+		did =3D OCTEP_VDPA_DEVID_CN103K_VF;
> >+		break;
> >+	default:
> >+		did =3D 0xFFFF;
> >+		break;
> >+	}
> >+
> >+	return did;
> >+}
> >+
> >+static int octep_vdpa_pf_setup(struct octep_pf *octpf) {
> >+	u8 __iomem *addr =3D octpf->base[OCTEP_HW_MBOX_BAR];
> >+	struct pci_dev *pdev =3D octpf->pdev;
> >+	int totalvfs;
> >+	u64 val, len;
> >+
> >+	totalvfs =3D pci_sriov_get_totalvfs(pdev);
> >+	if (unlikely(!totalvfs)) {
> >+		dev_info(&pdev->dev, "Total VFs are %d in PF sriov
> configuration\n", totalvfs);
> >+		return 0;
> >+	}
> >+
> >+	addr =3D octpf->base[OCTEP_HW_MBOX_BAR];
> >+	val =3D readq(addr + OCTEP_EPF_RINFO(0));
> >+	if (val =3D=3D 0) {
> >+		dev_err(&pdev->dev, "Invalid device configuration\n");
> >+		return -EINVAL;
> >+	}
> >+
> >+	if (OCTEP_EPF_RINFO_RPVF(val) !=3D BIT_ULL(0)) {
> >+		val &=3D ~GENMASK_ULL(35, 32);
> >+		val |=3D BIT_ULL(32);
> >+		writeq(val, addr + OCTEP_EPF_RINFO(0));
> >+	}
> >+
> >+	len =3D pci_resource_len(pdev, OCTEP_HW_CAPS_BAR);
> >+
> >+	octpf->vf_stride =3D len / totalvfs;
> >+	octpf->vf_devid =3D octep_get_vf_devid(pdev);
> >+
> >+	octep_vdpa_pf_bar_shrink(octpf);
> >+
> >+	return 0;
> >+}
> >+
> >+static int octep_vdpa_probe_pf(struct pci_dev *pdev) {
> >+	struct device *dev =3D &pdev->dev;
> >+	struct octep_pf *octpf;
> >+	int ret;
> >+
> >+	ret =3D pcim_enable_device(pdev);
> >+	if (ret) {
> >+		dev_err(dev, "Failed to enable device\n");
> >+		return ret;
> >+	}
> >+
> >+	ret =3D dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
> >+	if (ret) {
> >+		dev_err(dev, "No usable DMA configuration\n");
> >+		return ret;
> >+	}
> >+	octpf =3D devm_kzalloc(dev, sizeof(*octpf), GFP_KERNEL);
> >+	if (!octpf)
> >+		return -ENOMEM;
> >+
> >+	ret =3D octep_iomap_region(pdev, octpf->base,
> OCTEP_HW_MBOX_BAR);
> >+	if (ret)
> >+		return ret;
> >+
> >+	pci_set_master(pdev);
> >+	pci_set_drvdata(pdev, octpf);
> >+	octpf->pdev =3D pdev;
> >+
> >+	ret =3D octep_vdpa_pf_setup(octpf);
> >+	if (ret)
> >+		goto unmap_region;
> >+
> >+	return 0;
> >+
> >+unmap_region:
> >+	octep_iounmap_region(pdev, octpf->base, OCTEP_HW_MBOX_BAR);
> >+	return ret;
> >+}
> >+
> >+static int octep_vdpa_probe(struct pci_dev *pdev, const struct
> >+pci_device_id *id) {
> >+	if (pdev->is_virtfn)
> >+		return octep_vdpa_probe_vf(pdev);
> >+	else
> >+		return octep_vdpa_probe_pf(pdev);
> >+}
> >+
> >+static struct pci_device_id octep_pci_vdpa_map[] =3D {
> >+	{ PCI_DEVICE(PCI_VENDOR_ID_CAVIUM,
> OCTEP_VDPA_DEVID_CN106K_PF) },
> >+	{ PCI_DEVICE(PCI_VENDOR_ID_CAVIUM,
> OCTEP_VDPA_DEVID_CN106K_VF) },
> >+	{ PCI_DEVICE(PCI_VENDOR_ID_CAVIUM,
> OCTEP_VDPA_DEVID_CN105K_PF) },
> >+	{ PCI_DEVICE(PCI_VENDOR_ID_CAVIUM,
> OCTEP_VDPA_DEVID_CN105K_VF) },
> >+	{ PCI_DEVICE(PCI_VENDOR_ID_CAVIUM,
> OCTEP_VDPA_DEVID_CN103K_PF) },
> >+	{ PCI_DEVICE(PCI_VENDOR_ID_CAVIUM,
> OCTEP_VDPA_DEVID_CN103K_VF) },
> >+	{ 0 },
> >+};
> >+
> >+static struct pci_driver octep_pci_vdpa =3D {
> >+	.name     =3D OCTEP_VDPA_DRIVER_NAME,
> >+	.id_table =3D octep_pci_vdpa_map,
> >+	.probe    =3D octep_vdpa_probe,
> >+	.remove   =3D octep_vdpa_remove,
> >+	.sriov_configure =3D octep_vdpa_sriov_configure };
> >+
> >+module_pci_driver(octep_pci_vdpa);
> >+
> >+MODULE_AUTHOR("Marvell");
> >+MODULE_DESCRIPTION("Marvell Octeon PCIe endpoint vDPA driver");
> >+MODULE_LICENSE("GPL");
> >--
> >2.25.1
> >
> >

Thanks.
