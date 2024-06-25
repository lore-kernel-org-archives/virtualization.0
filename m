Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BE21DA22
	for <virtualization@lists.linux.dev>; Tue, 25 Jun 2024 05:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719294389; cv=fail; b=qn04bW4XBom0WoG7LAjnxl4MZV6U4Je57uWRxBcckHic0gpYvnv+ao6SrHwPImjpvG77uwvAA6XuRNBCsX/HblRyzBzRcucJcAMvt1geL/wzMwW7I5Zb679GQKQIWbRMIdLTrY/wN1rMZx1p07vUI27UGzshzQ1/1qqWf24YpDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719294389; c=relaxed/simple;
	bh=J0BfT7ydYmowqFZMsNN6082GeOMnP+S0S7wNRaG5bqc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ExjAGZ0fLDjalT/Dtb/83GBCJxfU+cNUFXqepC0l94IdLMwDY/bK/rsbG6WEOMcUXsCP1kx+KvbmPavId55zg2LUjez9qoAs7Uy2Sl/ozFMoECuUHtdn9lMtzMLRAakMQKVI7Ltox9blg4ZbmxTPdq2SYWFEEwKBV7vJXLAEKsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=f7XPtMMK; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="f7XPtMMK"
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45OMncZx003137;
	Mon, 24 Jun 2024 22:46:17 -0700
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3ywx4gfust-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 22:46:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CwvADr6M/ZqrY0XzBurLN/1guwFdEMVbidOo0DZ6dBI0v6WF2yT0++rF2R0KjjuiICrgc6kaw3y/wpS/2HPQao/PCtFgmEAsti3hYdEB7GQPxyzbxQ/+zQK9oIxsbTTElnsvWFCcZGGruxHrmRtsH2gng37RtJE7WAbYnh3WBgaR8Jx0DFxvlkk/uqnnMP+YTnEO7W4JNpY4BGOfZus4W5VJ4uWZeo/HsYl3/uCQU2v8q+j9pa/VreX/Wq/38sBkBYXb+SEo4DVGBvT+7FlPOcq8wVLAViyIV041YRjd9eIQ8YutNXJhRI1FBIeS6OFc8ywZFDIIeK5Ws4iH3nAUfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3oxb1Qftmn4SI09R4rEThGYR12bmWI3E0CKKv/yk7WI=;
 b=bxtJYRZuBm9gyx1nABSo2ydMZyriT89H5pbbVyJt6MHJd7zoQeTrR74EdwqF4bJspHuZY3vJ9V3NCOWdiGJ+7l5ZC0djygunqmQmtY9a+n4q7poobiUdVqlKJJrmW1//yBD0Bm/a0n1cCOdkaBfR+f/if0Z4Wzu0FUvF/eMSejE7VwFtSJ8bNd4PiGCe/CoC5dcE5hpo/lvDYNRVpDXyNRqdvf3yc6jafNI8i8vaUsWMfXXTGWm3+y86XcgxMa1wtJv8VzewRtO9NrWhAWcgr4zUzlpouL/GHNhlU/8xWS7Ftw82hXecIVPGaucFvxxRbI5okuhWVZ/J4/XdatgVpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3oxb1Qftmn4SI09R4rEThGYR12bmWI3E0CKKv/yk7WI=;
 b=f7XPtMMKc1CGyAogPEBUN9rUh2N2DdAWPV6N0UTtFIFOE0cfymUCyaH1+K7+C0Rnw/guK634CNudWbNr+ZBJV0+jSkqGf7b78h5IyHnw6Zuf2z0LQ/ATnycfyl1/92u5m3fhx7adZNvacwhlrOaud+LY4IQMNrZCghhP4Kzo+6U=
Received: from DS0PR18MB5368.namprd18.prod.outlook.com (2603:10b6:8:12f::17)
 by LV8PR18MB5939.namprd18.prod.outlook.com (2603:10b6:408:228::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Tue, 25 Jun
 2024 05:46:13 +0000
Received: from DS0PR18MB5368.namprd18.prod.outlook.com
 ([fe80::ad53:bef2:cc17:13ac]) by DS0PR18MB5368.namprd18.prod.outlook.com
 ([fe80::ad53:bef2:cc17:13ac%3]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 05:46:13 +0000
From: Srujana Challa <schalla@marvell.com>
To: Srujana Challa <schalla@marvell.com>,
        "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>,
        "mst@redhat.com" <mst@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>
CC: "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
        Vamsi Krishna
 Attunuru <vattunuru@marvell.com>,
        Shijith Thotton <sthotton@marvell.com>,
        Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>,
        Jerin Jacob
	<jerinj@marvell.com>
Subject: RE: [PATCH v6] virtio: vdpa: vDPA driver for Marvell OCTEON DPU
 devices
Thread-Topic: [PATCH v6] virtio: vdpa: vDPA driver for Marvell OCTEON DPU
 devices
Thread-Index: AQHavmm7Zajku3dNX02gVVqcYg5g27HYCBOQ
Date: Tue, 25 Jun 2024 05:46:12 +0000
Message-ID: 
 <DS0PR18MB53682E4FEF5DCCAA4FE0D5A0A0D52@DS0PR18MB5368.namprd18.prod.outlook.com>
References: <20240614144659.1776067-1-schalla@marvell.com>
In-Reply-To: <20240614144659.1776067-1-schalla@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR18MB5368:EE_|LV8PR18MB5939:EE_
x-ms-office365-filtering-correlation-id: cdce550b-2d59-4c10-71a8-08dc94da1f66
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|376011|1800799021|366013|38070700015;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?dOOkO348x7ofh1cyEMglnw+qZUpzMKJmpWXo3QuUy03WwuqvHsSvpdH69LnH?=
 =?us-ascii?Q?kqV4d0Wp4KAtxwAqDZyqJhXI8tXlJVVaJKhmq+D5zelRrCWJnT6tOc8TbQOj?=
 =?us-ascii?Q?mPsWs+glEIjQ1PC2DOaTZ2ENCYGyZD8y7dpCas4QxUAVWaeTemKZBGwtdvMK?=
 =?us-ascii?Q?wDR9m/Y+5oqNykD+Q1ZslQY9qFfbsM9NgoRLV94L8CT0DhI1nei8WnX1GEza?=
 =?us-ascii?Q?cnmVDccw0qx+79kpT5R1j9uxaNaSrZ14z7C6sLy36jZF3H05ClzyQ/fWIe9D?=
 =?us-ascii?Q?zZjczNhla+AussPpEDeoQasdS2oMlRIJePL60fIc8RiOHV8Z2F1y6JoMbKBJ?=
 =?us-ascii?Q?0AlDxLAMs5kguoUlDGKhRL3l1UE7rCksnn3QqgRzu/NkMY4DbTx6G2flH9sP?=
 =?us-ascii?Q?mB0dYl4CNq4h/5hg+6GdyzDpmg1elWsqzJ4ZYoJI1pLOP+Ds+6DZ8L7sq3ow?=
 =?us-ascii?Q?2StF0HEw5Xl8N4sC98tSJD+yP2I5mED4Y+qy3E9r6mYeCkbR1MS9LblkQJhC?=
 =?us-ascii?Q?kFDwhEz42LP8Tl1HtSihqjl5u3czYYJUYLyv5YXahi+2gbwXtrRpjP3thni/?=
 =?us-ascii?Q?U+RHMDkMspSqP1Gfmyw8hYEeVvKgS1ABd2p69tc/lI5bu+2zzvFvK8S20y5X?=
 =?us-ascii?Q?Hc/+eNvoLlwt94FarvJ3P5vqg0h7nb5bhrUJcClenQzcrD1/RpTUJBXecXi1?=
 =?us-ascii?Q?BQDY6fxyUsyn6wNGKUB9F6gAI+7jNYylokRlK7vXv9hNckOpDlciWqcCwvCA?=
 =?us-ascii?Q?3rHCNrDKn0KSEXPYardvhNqpPHXhMD0dueqqCm3yJc0CZhBx7UhaKk09+uMK?=
 =?us-ascii?Q?F0yyKRH+o7gtYO1eQwTAA/P5i2606nLdMRcQHH/NSMTc9LOoQxMVVWzJxc0L?=
 =?us-ascii?Q?7JzEnJ2aNBek19ZDC/6NcICihHstR+M5vyZ+vzN9F0InBY+jub03uzztZH5q?=
 =?us-ascii?Q?b6d/WOWkQrNsmDrjbG5KogBsUdq3db79VHhZZBjG4llNBgFVH6WGBi5g6ly6?=
 =?us-ascii?Q?kiRR6QTXPqdQtwsvfqZV399BMoP42NkuOeix57vB45ahbHfkW3va0xLuP6oL?=
 =?us-ascii?Q?6vTC3JLwR/p9pCQc0XArjCvgCAZV5QwVyUVHcV4PHOrfnU30rr/tn9bQKMDD?=
 =?us-ascii?Q?hcHq6NJ1v8Us7S3/V3yGCjTtKxnOL3dwWZm7yYCGeD3LmykrQbaD702u+T3E?=
 =?us-ascii?Q?mqnDwlxtLfutpk/Mc+sfqbJpmAHGDkhQ1GlrBC2MYC1wCR1K/Uw0hSIJdfQk?=
 =?us-ascii?Q?im2ym85JrpvcBK2cQ9daX2DcAJgkNG8URd2O8cDuSjKCc4S3Eb/Jo0e4RISg?=
 =?us-ascii?Q?cHv16GBJaDZh6E2+tdjnB0Mo0XCOCDVjp23tIVhuz/RcZH2bo+sA2ADwF3yX?=
 =?us-ascii?Q?QDjFLx0=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR18MB5368.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013)(38070700015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?aPH1D/IZhVUcXkdV1SSFO5ALKXWZCrpsoBe4DeOsLgrFbQi/LwFSRrNeTn/S?=
 =?us-ascii?Q?ILbh/l2LlGHWzhS9d/nmR0lOsCpilI/RNpb4Yamrifb1pUTotAkPFW1E7k2u?=
 =?us-ascii?Q?OtYvbV2I7yG2WBuNBsGq2hu2nSMZ63JJ3fEkuBI44jMdR4rXwMIKBQwpEdat?=
 =?us-ascii?Q?2oHERtd/kxlZi6Nl4UMci4UyYX2JyCXv9/7m69ImVFgAgrJ9y5+EEXC05nfr?=
 =?us-ascii?Q?wpf9hAyOdgBOVq9x8ZHgEi44OdOBfEIuT48ca0VJjtqo/S1l/2V0Xb935MzO?=
 =?us-ascii?Q?c0e38iGkKgTeFvMGfLgIswrtVzlVjkL3wHjpWffKu6I4lPYTmQrPfEbdv34L?=
 =?us-ascii?Q?rz/9Ukpl1v4crNAM9/PAb+2QOvH8R6ZOf8NmU/WNqnvjDxi4QWxavxW1BQBB?=
 =?us-ascii?Q?obKg1636stmXm0tfSmlBOoy7TxLtFrUGiq09KAqhJNG5cpVTxqXak+/s2nqc?=
 =?us-ascii?Q?jUhO7dc2KZ4lX9/2uaRtbKimyNHRMs9Y8VsMz+Vg5wrsIxfosxs6C7MSrtPr?=
 =?us-ascii?Q?n9o0Kdjtm67Y+ftvL14y4JHmVtyv0sijyCUcRhaQy2hoMOzXtAzGH6qqM2nM?=
 =?us-ascii?Q?ivCdzpqI+yKALwExrphAz+DNxqDEy6YTaNYXT85eq/hMJQ1uYcKEuRBEYaF2?=
 =?us-ascii?Q?uqC5QEVp2vxFMQPbCvgLLYeQDt/vS9A2uTu6+ekIhE6uthCylC0DfbCn+35R?=
 =?us-ascii?Q?/9WmoH3a3sxEhn59Ut+JWHmqv8Z0LGAoT7srXT2XyyGkQvnTn2aKZ4rpudsQ?=
 =?us-ascii?Q?VZ4SYd6xeyNl0w0pLQLe6xaMTIVupfvUhAVR/1R0d8VuTlhzqs85bZDJWTie?=
 =?us-ascii?Q?EIfHpNof0eWlUSov7kWKcChvoqXT/fxToXDAYm/nYBggaaXQ6PUgMBbm2RL+?=
 =?us-ascii?Q?KxpZciOzcVMV7T+lYu26JvQAJwZV01m3iZqwFM0djL2yuKE2HEVPpge56pUj?=
 =?us-ascii?Q?5B30z3FqIhDLwYqiLvtlFUCF9jB7koYyT73Yw118TatdbjYxGH4S56MonwGR?=
 =?us-ascii?Q?Obz2sqwdx2XMY7MD2Jsb5J1wd3z+vax7067XTcmps9MWOFuG6IUoiMoexR54?=
 =?us-ascii?Q?6BpSUvrJylp2Y3TmoDx7L8X9znXbgE4g7qWYLYQqhJIAaql4r7nuVoSa44Ax?=
 =?us-ascii?Q?TxldtbwSwGHnExzsgTPWW3khsQ1aoyG4LoVDGODKjEdYlPu84MpIp0y7nzjn?=
 =?us-ascii?Q?GbkHe0bn5W5i5OipqAruGHQyNXtDsg04BaHhloWvlTxNXhiQ+7XMkAwbjjbv?=
 =?us-ascii?Q?Gtbz1CBX87jZHqsNSj5lhN/d++/D3ocvLm9D64cuWr1yKYl6avCEvGHi9Isu?=
 =?us-ascii?Q?SEiJ2JH6sU/gnlJegZfEmJ04WPXtDde8JofO3KH3J/pnuy51UQlMNqMjMBtf?=
 =?us-ascii?Q?dcHHtvXF3eZVNazxMmrQf6nCWdY+4S+wrzjBKxf8Iyx+utkl4ofH6sIKJUO8?=
 =?us-ascii?Q?81pJcGhLzTAa/ruxF/wq2act5ZiPqS2z7eDRo1F2tlLyeDoNlnNq+Tjzs0BX?=
 =?us-ascii?Q?DuYH4nBTbCwbJcUIQkg8sqUNsMGNktNogq7AonoQKcIpyh3VZOV8B3dYCHqu?=
 =?us-ascii?Q?lwO0dGEL6ioIHwMSloU=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cdce550b-2d59-4c10-71a8-08dc94da1f66
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2024 05:46:12.9805
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w0qvjFohV3iddrz2KVNTu9+delS+UgAMdFi0f+U7uLfr8z+RjfPpL+BLBruE5y/MPWRNnE5Azd02pOzSSPfxjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR18MB5939
X-Proofpoint-GUID: bxw4uxCB03QBPSw3zmocH6GC7SR4bZDD
X-Proofpoint-ORIG-GUID: bxw4uxCB03QBPSw3zmocH6GC7SR4bZDD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_02,2024-06-24_01,2024-05-17_01

Ping.

> -----Original Message-----
> From: Srujana Challa <schalla@marvell.com>
> Sent: Friday, June 14, 2024 8:17 PM
> To: virtualization@lists.linux.dev; mst@redhat.com; jasowang@redhat.com
> Cc: xuanzhuo@linux.alibaba.com; Srujana Challa <schalla@marvell.com>;
> Vamsi Krishna Attunuru <vattunuru@marvell.com>; Shijith Thotton
> <sthotton@marvell.com>; Nithin Kumar Dabilpuram
> <ndabilpuram@marvell.com>; Jerin Jacob <jerinj@marvell.com>
> Subject: [PATCH v6] virtio: vdpa: vDPA driver for Marvell OCTEON DPU devi=
ces
>=20
> This commit introduces a new vDPA driver specifically designed for managi=
ng
> the virtio control plane over the vDPA bus for OCTEON DPU devices. The dr=
iver
> consists of two layers:
>=20
> 1. Octep HW Layer (Octeon Endpoint): Responsible for handling hardware
> operations and configurations related to the DPU device.
>=20
> 2. Octep Main Layer: Compliant with the vDPA bus framework, this layer
> implements device operations for the vDPA bus. It handles device probing,=
 bus
> attachment, vring operations, and other relevant tasks.
>=20
> Signed-off-by: Srujana Challa <schalla@marvell.com>
> Signed-off-by: Vamsi Attunuru <vattunuru@marvell.com>
> Signed-off-by: Shijith Thotton <sthotton@marvell.com>
> Signed-off-by: Nithin Dabilpuram <ndabilpuram@marvell.com>
> Acked-by: Jason Wang <jasowang@redhat.com>
> ---
> v2:
> * Addressed review comments
> v3:
> * Enhanced a few error logs based on the suggestions provided.
> v4:
> * Addressed kbuild failures on mips.
> v5:
> * Addressed kbuild failures for 32bit arch.
> v6:
> * Addressed the review comments on v5.
>=20
>  MAINTAINERS                              |   5 +
>  drivers/vdpa/Kconfig                     |  11 +
>  drivers/vdpa/Makefile                    |   1 +
>  drivers/vdpa/octeon_ep/Makefile          |   4 +
>  drivers/vdpa/octeon_ep/octep_vdpa.h      |  94 +++
>  drivers/vdpa/octeon_ep/octep_vdpa_hw.c   | 517 ++++++++++++++
>  drivers/vdpa/octeon_ep/octep_vdpa_main.c | 857
> +++++++++++++++++++++++
>  7 files changed, 1489 insertions(+)
>  create mode 100644 drivers/vdpa/octeon_ep/Makefile  create mode 100644
> drivers/vdpa/octeon_ep/octep_vdpa.h
>  create mode 100644 drivers/vdpa/octeon_ep/octep_vdpa_hw.c
>  create mode 100644 drivers/vdpa/octeon_ep/octep_vdpa_main.c
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cfe44a876d8a..539ce209a960 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13127,6 +13127,11 @@ S:	Supported
>  F:	Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
>  F:	drivers/mmc/host/sdhci-xenon*
>=20
> +MARVELL OCTEON ENDPOINT VIRTIO DATA PATH ACCELERATOR
> +R:	schalla@marvell.com
> +R:	vattunuru@marvell.com
> +F:	drivers/vdpa/octeon_ep/
> +
>  MATROX FRAMEBUFFER DRIVER
>  L:	linux-fbdev@vger.kernel.org
>  S:	Orphan
> diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig index
> 656c1cb541de..5265d09fc1c4 100644
> --- a/drivers/vdpa/Kconfig
> +++ b/drivers/vdpa/Kconfig
> @@ -126,4 +126,15 @@ config PDS_VDPA
>  	  With this driver, the VirtIO dataplane can be
>  	  offloaded to an AMD/Pensando DSC device.
>=20
> +config OCTEONEP_VDPA
> +	tristate "vDPA driver for Octeon DPU devices"
> +	depends on m
> +	depends on PCI_MSI
> +	help
> +	  This is a vDPA driver designed for Marvell's Octeon DPU devices.
> +	  This driver enables the offloading of the VirtIO dataplane to an
> +	  Octeon DPU device.
> +	  Please note that this driver must be built as a module and it
> +	  cannot be loaded until the Octeon emulation software is running.
> +
>  endif # VDPA
> diff --git a/drivers/vdpa/Makefile b/drivers/vdpa/Makefile index
> 8f53c6f3cca7..5654d36707af 100644
> --- a/drivers/vdpa/Makefile
> +++ b/drivers/vdpa/Makefile
> @@ -8,3 +8,4 @@ obj-$(CONFIG_VP_VDPA)    +=3D virtio_pci/
>  obj-$(CONFIG_ALIBABA_ENI_VDPA) +=3D alibaba/
>  obj-$(CONFIG_SNET_VDPA) +=3D solidrun/
>  obj-$(CONFIG_PDS_VDPA) +=3D pds/
> +obj-$(CONFIG_OCTEONEP_VDPA) +=3D octeon_ep/
> diff --git a/drivers/vdpa/octeon_ep/Makefile
> b/drivers/vdpa/octeon_ep/Makefile new file mode 100644 index
> 000000000000..e23e2ff14f33
> --- /dev/null
> +++ b/drivers/vdpa/octeon_ep/Makefile
> @@ -0,0 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
> +obj-$(CONFIG_OCTEONEP_VDPA) +=3D octep_vdpa.o
> +octep_vdpa-$(CONFIG_OCTEONEP_VDPA) +=3D octep_vdpa_main.o
> +octep_vdpa-$(CONFIG_OCTEONEP_VDPA) +=3D octep_vdpa_hw.o
> diff --git a/drivers/vdpa/octeon_ep/octep_vdpa.h
> b/drivers/vdpa/octeon_ep/octep_vdpa.h
> new file mode 100644
> index 000000000000..046710ec4d42
> --- /dev/null
> +++ b/drivers/vdpa/octeon_ep/octep_vdpa.h
> @@ -0,0 +1,94 @@
> +/* SPDX-License-Identifier: GPL-2.0-only
> + * Copyright (C) 2024 Marvell.
> + */
> +#ifndef __OCTEP_VDPA_H__
> +#define __OCTEP_VDPA_H__
> +
> +#include <linux/pci.h>
> +#include <linux/pci_regs.h>
> +#include <linux/vdpa.h>
> +#include <linux/virtio_pci_modern.h>
> +#include <uapi/linux/virtio_net.h>
> +#include <uapi/linux/virtio_blk.h>
> +#include <uapi/linux/virtio_config.h>
> +#include <uapi/linux/virtio_pci.h>
> +#include <uapi/linux/vdpa.h>
> +
> +#define OCTEP_VDPA_DEVID_CN106K_PF 0xb900 #define
> +OCTEP_VDPA_DEVID_CN106K_VF 0xb903 #define
> OCTEP_VDPA_DEVID_CN105K_PF
> +0xba00 #define OCTEP_VDPA_DEVID_CN105K_VF 0xba03 #define
> +OCTEP_VDPA_DEVID_CN103K_PF 0xbd00 #define
> OCTEP_VDPA_DEVID_CN103K_VF
> +0xbd03
> +
> +#define OCTEP_HW_MBOX_BAR 0
> +#define OCTEP_HW_CAPS_BAR 4
> +
> +#define OCTEP_DEV_READY_SIGNATURE 0xBABABABA
> +
> +#define OCTEP_EPF_RINFO(x) (0x000209f0 | ((x) << 25)) #define
> +OCTEP_VF_MBOX_DATA(x) (0x00010210 | ((x) << 17)) #define
> +OCTEP_PF_MBOX_DATA(x) (0x00022000 | ((x) << 4))
> +
> +#define OCTEP_EPF_RINFO_RPVF(val) (((val) >> 32) & 0xF) #define
> +OCTEP_EPF_RINFO_NVFS(val) (((val) >> 48) & 0x7F)
> +
> +#define OCTEP_FW_READY_SIGNATURE0  0xFEEDFEED #define
> +OCTEP_FW_READY_SIGNATURE1  0x3355ffaa
> +
> +enum octep_vdpa_dev_status {
> +	OCTEP_VDPA_DEV_STATUS_INVALID,
> +	OCTEP_VDPA_DEV_STATUS_ALLOC,
> +	OCTEP_VDPA_DEV_STATUS_WAIT_FOR_BAR_INIT,
> +	OCTEP_VDPA_DEV_STATUS_INIT,
> +	OCTEP_VDPA_DEV_STATUS_READY,
> +	OCTEP_VDPA_DEV_STATUS_UNINIT
> +};
> +
> +struct octep_vring_info {
> +	struct vdpa_callback cb;
> +	void __iomem *notify_addr;
> +	u32 __iomem *cb_notify_addr;
> +	phys_addr_t notify_pa;
> +	char msix_name[256];
> +};
> +
> +struct octep_hw {
> +	struct pci_dev *pdev;
> +	u8 __iomem *base[PCI_STD_NUM_BARS];
> +	struct virtio_pci_common_cfg __iomem *common_cfg;
> +	u8 __iomem *dev_cfg;
> +	u8 __iomem *isr;
> +	void __iomem *notify_base;
> +	phys_addr_t notify_base_pa;
> +	u32 notify_off_multiplier;
> +	u8 notify_bar;
> +	struct octep_vring_info *vqs;
> +	struct vdpa_callback config_cb;
> +	u64 features;
> +	u16 nr_vring;
> +	u32 config_size;
> +	int irq;
> +};
> +
> +u8 octep_hw_get_status(struct octep_hw *oct_hw); void
> +octep_hw_set_status(struct octep_hw *dev, uint8_t status); void
> +octep_hw_reset(struct octep_hw *oct_hw); void
> +octep_write_queue_select(struct octep_hw *oct_hw, u16 queue_id); void
> +octep_notify_queue(struct octep_hw *oct_hw, u16 qid); void
> +octep_read_dev_config(struct octep_hw *oct_hw, u64 offset, void *dst,
> +int length); int octep_set_vq_address(struct octep_hw *oct_hw, u16 qid, =
u64
> desc_area, u64 driver_area,
> +			 u64 device_area);
> +void octep_set_vq_num(struct octep_hw *oct_hw, u16 qid, u32 num); void
> +octep_set_vq_ready(struct octep_hw *oct_hw, u16 qid, bool ready); bool
> +octep_get_vq_ready(struct octep_hw *oct_hw, u16 qid); int
> +octep_set_vq_state(struct octep_hw *oct_hw, u16 qid, const struct
> +vdpa_vq_state *state); int octep_get_vq_state(struct octep_hw *oct_hw,
> +u16 qid, struct vdpa_vq_state *state);
> +u16 octep_get_vq_size(struct octep_hw *oct_hw); int
> +octep_hw_caps_read(struct octep_hw *oct_hw, struct pci_dev *pdev);
> +u64 octep_hw_get_dev_features(struct octep_hw *oct_hw); void
> +octep_hw_set_drv_features(struct octep_hw *oct_hw, u64 features);
> +u64 octep_hw_get_drv_features(struct octep_hw *oct_hw); int
> +octep_verify_features(u64 features);
> +
> +#endif /* __OCTEP_VDPA_H__ */
> diff --git a/drivers/vdpa/octeon_ep/octep_vdpa_hw.c
> b/drivers/vdpa/octeon_ep/octep_vdpa_hw.c
> new file mode 100644
> index 000000000000..7fa0491bb201
> --- /dev/null
> +++ b/drivers/vdpa/octeon_ep/octep_vdpa_hw.c
> @@ -0,0 +1,517 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (C) 2024 Marvell. */
> +
> +#include <linux/iopoll.h>
> +
> +#include "octep_vdpa.h"
> +
> +enum octep_mbox_ids {
> +	OCTEP_MBOX_MSG_SET_VQ_STATE =3D 1,
> +	OCTEP_MBOX_MSG_GET_VQ_STATE,
> +};
> +
> +#define OCTEP_HW_TIMEOUT       10000000
> +
> +#define MBOX_OFFSET            64
> +#define MBOX_RSP_MASK          0x00000001
> +#define MBOX_RC_MASK           0x0000FFFE
> +
> +#define MBOX_RSP_TO_ERR(val)   (-(((val) & MBOX_RC_MASK) >> 2))
> +#define MBOX_AVAIL(val)        (((val) & MBOX_RSP_MASK))
> +#define MBOX_RSP(val)          ((val) & (MBOX_RC_MASK |
> MBOX_RSP_MASK))
> +
> +#define DEV_RST_ACK_BIT        7
> +#define FEATURE_SEL_ACK_BIT    15
> +#define QUEUE_SEL_ACK_BIT      15
> +
> +struct octep_mbox_hdr {
> +	u8 ver;
> +	u8 rsvd1;
> +	u16 id;
> +	u16 rsvd2;
> +#define MBOX_REQ_SIG (0xdead)
> +#define MBOX_RSP_SIG (0xbeef)
> +	u16 sig;
> +};
> +
> +struct octep_mbox_sts {
> +	u16 rsp:1;
> +	u16 rc:15;
> +	u16 rsvd;
> +};
> +
> +struct octep_mbox {
> +	struct octep_mbox_hdr hdr;
> +	struct octep_mbox_sts sts;
> +	u64 rsvd;
> +	u32 data[];
> +};
> +
> +static inline struct octep_mbox __iomem *octep_get_mbox(struct octep_hw
> +*oct_hw) {
> +	return (struct octep_mbox __iomem *)(oct_hw->dev_cfg +
> MBOX_OFFSET); }
> +
> +static inline int octep_wait_for_mbox_avail(struct octep_mbox __iomem
> +*mbox) {
> +	u32 val;
> +
> +	return readx_poll_timeout(ioread32, &mbox->sts, val,
> MBOX_AVAIL(val), 10,
> +				  OCTEP_HW_TIMEOUT);
> +}
> +
> +static inline int octep_wait_for_mbox_rsp(struct octep_mbox __iomem
> +*mbox) {
> +	u32 val;
> +
> +	return readx_poll_timeout(ioread32, &mbox->sts, val,
> MBOX_RSP(val), 10,
> +				  OCTEP_HW_TIMEOUT);
> +}
> +
> +static inline void octep_write_hdr(struct octep_mbox __iomem *mbox, u16
> +id, u16 sig) {
> +	iowrite16(id, &mbox->hdr.id);
> +	iowrite16(sig, &mbox->hdr.sig);
> +}
> +
> +static inline u32 octep_read_sig(struct octep_mbox __iomem *mbox) {
> +	return ioread16(&mbox->hdr.sig);
> +}
> +
> +static inline void octep_write_sts(struct octep_mbox __iomem *mbox, u32
> +sts) {
> +	iowrite32(sts, &mbox->sts);
> +}
> +
> +static inline u32 octep_read_sts(struct octep_mbox __iomem *mbox) {
> +	return ioread32(&mbox->sts);
> +}
> +
> +static inline u32 octep_read32_word(struct octep_mbox __iomem *mbox,
> +u16 word_idx) {
> +	return ioread32(&mbox->data[word_idx]); }
> +
> +static inline void octep_write32_word(struct octep_mbox __iomem *mbox,
> +u16 word_idx, u32 word) {
> +	return iowrite32(word, &mbox->data[word_idx]); }
> +
> +static int octep_process_mbox(struct octep_hw *oct_hw, u16 id, u16 qid,
> void *buffer,
> +			      u32 buf_size, bool write)
> +{
> +	struct octep_mbox __iomem *mbox =3D octep_get_mbox(oct_hw);
> +	struct pci_dev *pdev =3D oct_hw->pdev;
> +	u32 *p =3D (u32 *)buffer;
> +	u16 data_wds;
> +	int ret, i;
> +	u32 val;
> +
> +	if (!IS_ALIGNED(buf_size, 4))
> +		return -EINVAL;
> +
> +	/* Make sure mbox space is available */
> +	ret =3D octep_wait_for_mbox_avail(mbox);
> +	if (ret) {
> +		dev_warn(&pdev->dev, "Timeout waiting for previous mbox
> data to be consumed\n");
> +		return ret;
> +	}
> +	data_wds =3D buf_size / 4;
> +
> +	if (write) {
> +		for (i =3D 1; i <=3D data_wds; i++) {
> +			octep_write32_word(mbox, i, *p);
> +			p++;
> +		}
> +	}
> +	octep_write32_word(mbox, 0, (u32)qid);
> +	octep_write_sts(mbox, 0);
> +
> +	octep_write_hdr(mbox, id, MBOX_REQ_SIG);
> +
> +	ret =3D octep_wait_for_mbox_rsp(mbox);
> +	if (ret) {
> +		dev_warn(&pdev->dev, "Timeout waiting for mbox : %d
> response\n", id);
> +		return ret;
> +	}
> +
> +	val =3D octep_read_sig(mbox);
> +	if ((val & 0xFFFF) !=3D MBOX_RSP_SIG) {
> +		dev_warn(&pdev->dev, "Invalid Signature from mbox : %d
> response\n", id);
> +		return ret;
> +	}
> +
> +	val =3D octep_read_sts(mbox);
> +	if (val & MBOX_RC_MASK) {
> +		ret =3D MBOX_RSP_TO_ERR(val);
> +		dev_warn(&pdev->dev, "Error while processing mbox : %d, err
> %d\n", id, ret);
> +		return ret;
> +	}
> +
> +	if (!write)
> +		for (i =3D 1; i <=3D data_wds; i++)
> +			*p++ =3D octep_read32_word(mbox, i);
> +
> +	return 0;
> +}
> +
> +static void octep_mbox_init(struct octep_mbox __iomem *mbox) {
> +	iowrite32(1, &mbox->sts);
> +}
> +
> +int octep_verify_features(u64 features) {
> +	/* Minimum features to expect */
> +	if (!(features & BIT_ULL(VIRTIO_F_VERSION_1)))
> +		return -EOPNOTSUPP;
> +
> +	if (!(features & BIT_ULL(VIRTIO_F_NOTIFICATION_DATA)))
> +		return -EOPNOTSUPP;
> +
> +	if (!(features & BIT_ULL(VIRTIO_F_RING_PACKED)))
> +		return -EOPNOTSUPP;
> +
> +	return 0;
> +}
> +
> +u8 octep_hw_get_status(struct octep_hw *oct_hw) {
> +	return ioread8(&oct_hw->common_cfg->device_status);
> +}
> +
> +void octep_hw_set_status(struct octep_hw *oct_hw, u8 status) {
> +	iowrite8(status, &oct_hw->common_cfg->device_status);
> +}
> +
> +void octep_hw_reset(struct octep_hw *oct_hw) {
> +	u8 val;
> +
> +	octep_hw_set_status(oct_hw, 0 | BIT(DEV_RST_ACK_BIT));
> +	if (readx_poll_timeout(ioread8, &oct_hw->common_cfg-
> >device_status, val, !val, 10,
> +			       OCTEP_HW_TIMEOUT)) {
> +		dev_warn(&oct_hw->pdev->dev, "Octeon device reset
> timeout\n");
> +		return;
> +	}
> +}
> +
> +static int feature_sel_write_with_timeout(struct octep_hw *oct_hw, u32
> +select, void __iomem *addr) {
> +	u32 val;
> +
> +	iowrite32(select | BIT(FEATURE_SEL_ACK_BIT), addr);
> +
> +	if (readx_poll_timeout(ioread32, addr, val, val =3D=3D select, 10,
> OCTEP_HW_TIMEOUT)) {
> +		dev_warn(&oct_hw->pdev->dev, "Feature select%d write
> timeout\n", select);
> +		return -1;
> +	}
> +	return 0;
> +}
> +
> +u64 octep_hw_get_dev_features(struct octep_hw *oct_hw) {
> +	u32 features_lo, features_hi;
> +
> +	if (feature_sel_write_with_timeout(oct_hw, 0, &oct_hw-
> >common_cfg->device_feature_select))
> +		return 0;
> +
> +	features_lo =3D ioread32(&oct_hw->common_cfg->device_feature);
> +
> +	if (feature_sel_write_with_timeout(oct_hw, 1, &oct_hw-
> >common_cfg->device_feature_select))
> +		return 0;
> +
> +	features_hi =3D ioread32(&oct_hw->common_cfg->device_feature);
> +
> +	return ((u64)features_hi << 32) | features_lo; }
> +
> +u64 octep_hw_get_drv_features(struct octep_hw *oct_hw) {
> +	u32 features_lo, features_hi;
> +
> +	if (feature_sel_write_with_timeout(oct_hw, 0, &oct_hw-
> >common_cfg->guest_feature_select))
> +		return 0;
> +
> +	features_lo =3D ioread32(&oct_hw->common_cfg->guest_feature);
> +
> +	if (feature_sel_write_with_timeout(oct_hw, 1, &oct_hw-
> >common_cfg->guest_feature_select))
> +		return 0;
> +
> +	features_hi =3D ioread32(&oct_hw->common_cfg->guest_feature);
> +
> +	return ((u64)features_hi << 32) | features_lo; }
> +
> +void octep_hw_set_drv_features(struct octep_hw *oct_hw, u64 features) {
> +	if (feature_sel_write_with_timeout(oct_hw, 0, &oct_hw-
> >common_cfg->guest_feature_select))
> +		return;
> +
> +	iowrite32(features & (BIT_ULL(32) - 1),
> +&oct_hw->common_cfg->guest_feature);
> +
> +	if (feature_sel_write_with_timeout(oct_hw, 1, &oct_hw-
> >common_cfg->guest_feature_select))
> +		return;
> +
> +	iowrite32(features >> 32, &oct_hw->common_cfg->guest_feature);
> +}
> +
> +void octep_write_queue_select(struct octep_hw *oct_hw, u16 queue_id) {
> +	u16 val;
> +
> +	iowrite16(queue_id | BIT(QUEUE_SEL_ACK_BIT),
> +&oct_hw->common_cfg->queue_select);
> +
> +	if (readx_poll_timeout(ioread16, &oct_hw->common_cfg-
> >queue_select, val, val =3D=3D queue_id,
> +			       10, OCTEP_HW_TIMEOUT)) {
> +		dev_warn(&oct_hw->pdev->dev, "Queue select write
> timeout\n");
> +		return;
> +	}
> +}
> +
> +void octep_notify_queue(struct octep_hw *oct_hw, u16 qid) {
> +	iowrite16(qid, oct_hw->vqs[qid].notify_addr); }
> +
> +void octep_read_dev_config(struct octep_hw *oct_hw, u64 offset, void
> +*dst, int length) {
> +	u8 old_gen, new_gen, *p;
> +	int i;
> +
> +	if (WARN_ON(offset + length > oct_hw->config_size))
> +		return;
> +
> +	do {
> +		old_gen =3D ioread8(&oct_hw->common_cfg-
> >config_generation);
> +		p =3D dst;
> +		for (i =3D 0; i < length; i++)
> +			*p++ =3D ioread8(oct_hw->dev_cfg + offset + i);
> +
> +		new_gen =3D ioread8(&oct_hw->common_cfg-
> >config_generation);
> +	} while (old_gen !=3D new_gen);
> +}
> +
> +int octep_set_vq_address(struct octep_hw *oct_hw, u16 qid, u64 desc_area=
,
> u64 driver_area,
> +			 u64 device_area)
> +{
> +	struct virtio_pci_common_cfg __iomem *cfg =3D oct_hw->common_cfg;
> +
> +	octep_write_queue_select(oct_hw, qid);
> +	vp_iowrite64_twopart(desc_area, &cfg->queue_desc_lo,
> +			     &cfg->queue_desc_hi);
> +	vp_iowrite64_twopart(driver_area, &cfg->queue_avail_lo,
> +			     &cfg->queue_avail_hi);
> +	vp_iowrite64_twopart(device_area, &cfg->queue_used_lo,
> +			     &cfg->queue_used_hi);
> +
> +	return 0;
> +}
> +
> +int octep_get_vq_state(struct octep_hw *oct_hw, u16 qid, struct
> +vdpa_vq_state *state) {
> +	return octep_process_mbox(oct_hw,
> OCTEP_MBOX_MSG_GET_VQ_STATE, qid, state,
> +				  sizeof(*state), 0);
> +}
> +
> +int octep_set_vq_state(struct octep_hw *oct_hw, u16 qid, const struct
> +vdpa_vq_state *state) {
> +	struct vdpa_vq_state q_state;
> +
> +	memcpy(&q_state, state, sizeof(struct vdpa_vq_state));
> +	return octep_process_mbox(oct_hw,
> OCTEP_MBOX_MSG_SET_VQ_STATE, qid, &q_state,
> +				  sizeof(*state), 1);
> +}
> +
> +void octep_set_vq_num(struct octep_hw *oct_hw, u16 qid, u32 num) {
> +	struct virtio_pci_common_cfg __iomem *cfg =3D oct_hw->common_cfg;
> +
> +	octep_write_queue_select(oct_hw, qid);
> +	iowrite16(num, &cfg->queue_size);
> +}
> +
> +void octep_set_vq_ready(struct octep_hw *oct_hw, u16 qid, bool ready) {
> +	struct virtio_pci_common_cfg __iomem *cfg =3D oct_hw->common_cfg;
> +
> +	octep_write_queue_select(oct_hw, qid);
> +	iowrite16(ready, &cfg->queue_enable);
> +}
> +
> +bool octep_get_vq_ready(struct octep_hw *oct_hw, u16 qid) {
> +	struct virtio_pci_common_cfg __iomem *cfg =3D oct_hw->common_cfg;
> +
> +	octep_write_queue_select(oct_hw, qid);
> +	return ioread16(&cfg->queue_enable);
> +}
> +
> +u16 octep_get_vq_size(struct octep_hw *oct_hw) {
> +	octep_write_queue_select(oct_hw, 0);
> +	return ioread16(&oct_hw->common_cfg->queue_size);
> +}
> +
> +static u32 octep_get_config_size(struct octep_hw *oct_hw) {
> +	return sizeof(struct virtio_net_config); }
> +
> +static void __iomem *octep_get_cap_addr(struct octep_hw *oct_hw, struct
> +virtio_pci_cap *cap) {
> +	struct device *dev =3D &oct_hw->pdev->dev;
> +	u32 length =3D le32_to_cpu(cap->length);
> +	u32 offset =3D le32_to_cpu(cap->offset);
> +	u8  bar    =3D cap->bar;
> +	u32 len;
> +
> +	if (bar !=3D OCTEP_HW_CAPS_BAR) {
> +		dev_err(dev, "Invalid bar: %u\n", bar);
> +		return NULL;
> +	}
> +	if (offset + length < offset) {
> +		dev_err(dev, "offset(%u) + length(%u) overflows\n",
> +			offset, length);
> +		return NULL;
> +	}
> +	len =3D pci_resource_len(oct_hw->pdev, bar);
> +	if (offset + length > len) {
> +		dev_err(dev, "invalid cap: overflows bar space: %u > %u\n",
> +			offset + length, len);
> +		return NULL;
> +	}
> +	return oct_hw->base[bar] + offset;
> +}
> +
> +/* In Octeon DPU device, the virtio config space is completely
> + * emulated by the device's firmware. So, the standard pci config
> + * read apis can't be used for reading the virtio capability.
> + */
> +static void octep_pci_caps_read(struct octep_hw *oct_hw, void *buf,
> +size_t len, off_t offset) {
> +	u8 __iomem *bar =3D oct_hw->base[OCTEP_HW_CAPS_BAR];
> +	u8 *p =3D buf;
> +	size_t i;
> +
> +	for (i =3D 0; i < len; i++)
> +		*p++ =3D ioread8(bar + offset + i);
> +}
> +
> +static int octep_pci_signature_verify(struct octep_hw *oct_hw) {
> +	u32 signature[2];
> +
> +	octep_pci_caps_read(oct_hw, &signature, sizeof(signature), 0);
> +
> +	if (signature[0] !=3D OCTEP_FW_READY_SIGNATURE0)
> +		return -1;
> +
> +	if (signature[1] !=3D OCTEP_FW_READY_SIGNATURE1)
> +		return -1;
> +
> +	return 0;
> +}
> +
> +int octep_hw_caps_read(struct octep_hw *oct_hw, struct pci_dev *pdev) {
> +	struct octep_mbox __iomem *mbox;
> +	struct device *dev =3D &pdev->dev;
> +	struct virtio_pci_cap cap;
> +	u16 notify_off;
> +	int i, ret;
> +	u8 pos;
> +
> +	oct_hw->pdev =3D pdev;
> +	ret =3D octep_pci_signature_verify(oct_hw);
> +	if (ret) {
> +		dev_err(dev, "Octeon Virtio FW is not initialized\n");
> +		return -EIO;
> +	}
> +
> +	octep_pci_caps_read(oct_hw, &pos, 1, PCI_CAPABILITY_LIST);
> +
> +	while (pos) {
> +		octep_pci_caps_read(oct_hw, &cap, 2, pos);
> +
> +		if (cap.cap_vndr !=3D PCI_CAP_ID_VNDR) {
> +			dev_err(dev, "Found invalid capability vndr id: %d\n",
> cap.cap_vndr);
> +			break;
> +		}
> +
> +		octep_pci_caps_read(oct_hw, &cap, sizeof(cap), pos);
> +
> +		dev_info(dev, "[%2x] cfg type: %u, bar: %u, offset: %04x, len:
> %u\n",
> +			 pos, cap.cfg_type, cap.bar, cap.offset, cap.length);
> +
> +		switch (cap.cfg_type) {
> +		case VIRTIO_PCI_CAP_COMMON_CFG:
> +			oct_hw->common_cfg =3D octep_get_cap_addr(oct_hw,
> &cap);
> +			break;
> +		case VIRTIO_PCI_CAP_NOTIFY_CFG:
> +			octep_pci_caps_read(oct_hw, &oct_hw-
> >notify_off_multiplier,
> +					    4, pos + sizeof(cap));
> +
> +			oct_hw->notify_base =3D octep_get_cap_addr(oct_hw,
> &cap);
> +			oct_hw->notify_bar =3D cap.bar;
> +			oct_hw->notify_base_pa =3D pci_resource_start(pdev,
> cap.bar) +
> +						 le32_to_cpu(cap.offset);
> +			break;
> +		case VIRTIO_PCI_CAP_DEVICE_CFG:
> +			oct_hw->dev_cfg =3D octep_get_cap_addr(oct_hw,
> &cap);
> +			break;
> +		case VIRTIO_PCI_CAP_ISR_CFG:
> +			oct_hw->isr =3D octep_get_cap_addr(oct_hw, &cap);
> +			break;
> +		}
> +
> +		pos =3D cap.cap_next;
> +	}
> +	if (!oct_hw->common_cfg || !oct_hw->notify_base ||
> +	    !oct_hw->dev_cfg    || !oct_hw->isr) {
> +		dev_err(dev, "Incomplete PCI capabilities");
> +		return -EIO;
> +	}
> +	dev_info(dev, "common cfg mapped at: 0x%016llx\n",
> (u64)(uintptr_t)oct_hw->common_cfg);
> +	dev_info(dev, "device cfg mapped at: 0x%016llx\n",
> (u64)(uintptr_t)oct_hw->dev_cfg);
> +	dev_info(dev, "isr cfg mapped at: 0x%016llx\n",
> (u64)(uintptr_t)oct_hw->isr);
> +	dev_info(dev, "notify base: 0x%016llx, notify off multiplier: %u\n",
> +		 (u64)(uintptr_t)oct_hw->notify_base, oct_hw-
> >notify_off_multiplier);
> +
> +	oct_hw->config_size =3D octep_get_config_size(oct_hw);
> +	oct_hw->features =3D octep_hw_get_dev_features(oct_hw);
> +
> +	ret =3D octep_verify_features(oct_hw->features);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Couldn't read features from the device
> FW\n");
> +		return ret;
> +	}
> +	oct_hw->nr_vring =3D vp_ioread16(&oct_hw->common_cfg-
> >num_queues);
> +
> +	oct_hw->vqs =3D devm_kcalloc(&pdev->dev, oct_hw->nr_vring,
> sizeof(*oct_hw->vqs), GFP_KERNEL);
> +	if (!oct_hw->vqs)
> +		return -ENOMEM;
> +
> +	oct_hw->irq =3D -1;
> +
> +	dev_info(&pdev->dev, "Device features : %llx\n", oct_hw->features);
> +	dev_info(&pdev->dev, "Maximum queues : %u\n", oct_hw-
> >nr_vring);
> +
> +	for (i =3D 0; i < oct_hw->nr_vring; i++) {
> +		octep_write_queue_select(oct_hw, i);
> +		notify_off =3D vp_ioread16(&oct_hw->common_cfg-
> >queue_notify_off);
> +		oct_hw->vqs[i].notify_addr =3D oct_hw->notify_base +
> +			notify_off * oct_hw->notify_off_multiplier;
> +		oct_hw->vqs[i].cb_notify_addr =3D (u32 __iomem *)oct_hw-
> >vqs[i].notify_addr + 1;
> +		oct_hw->vqs[i].notify_pa =3D oct_hw->notify_base_pa +
> +			notify_off * oct_hw->notify_off_multiplier;
> +	}
> +	mbox =3D octep_get_mbox(oct_hw);
> +	octep_mbox_init(mbox);
> +	dev_info(dev, "mbox mapped at: 0x%016llx\n",
> (u64)(uintptr_t)mbox);
> +
> +	return 0;
> +}
> diff --git a/drivers/vdpa/octeon_ep/octep_vdpa_main.c
> b/drivers/vdpa/octeon_ep/octep_vdpa_main.c
> new file mode 100644
> index 000000000000..cd55b1aac151
> --- /dev/null
> +++ b/drivers/vdpa/octeon_ep/octep_vdpa_main.c
> @@ -0,0 +1,857 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (C) 2024 Marvell. */
> +
> +#include <linux/interrupt.h>
> +#include <linux/io-64-nonatomic-lo-hi.h> #include <linux/module.h>
> +#include <linux/iommu.h> #include "octep_vdpa.h"
> +
> +#define OCTEP_VDPA_DRIVER_NAME "octep_vdpa"
> +
> +struct octep_pf {
> +	u8 __iomem *base[PCI_STD_NUM_BARS];
> +	struct pci_dev *pdev;
> +	struct resource res;
> +	u64 vf_base;
> +	int enabled_vfs;
> +	u32 vf_stride;
> +	u16 vf_devid;
> +};
> +
> +struct octep_vdpa {
> +	struct vdpa_device vdpa;
> +	struct octep_hw *oct_hw;
> +	struct pci_dev *pdev;
> +};
> +
> +struct octep_vdpa_mgmt_dev {
> +	struct vdpa_mgmt_dev mdev;
> +	struct octep_hw oct_hw;
> +	struct pci_dev *pdev;
> +	/* Work entry to handle device setup */
> +	struct work_struct setup_task;
> +	/* Device status */
> +	atomic_t status;
> +};
> +
> +static struct octep_hw *vdpa_to_octep_hw(struct vdpa_device *vdpa_dev)
> +{
> +	struct octep_vdpa *oct_vdpa;
> +
> +	oct_vdpa =3D container_of(vdpa_dev, struct octep_vdpa, vdpa);
> +
> +	return oct_vdpa->oct_hw;
> +}
> +
> +static irqreturn_t octep_vdpa_intr_handler(int irq, void *data) {
> +	struct octep_hw *oct_hw =3D data;
> +	int i;
> +
> +	for (i =3D 0; i < oct_hw->nr_vring; i++) {
> +		if (oct_hw->vqs[i].cb.callback && ioread32(oct_hw-
> >vqs[i].cb_notify_addr)) {
> +			/* Acknowledge the per queue notification to the
> device */
> +			iowrite32(0, oct_hw->vqs[i].cb_notify_addr);
> +			oct_hw->vqs[i].cb.callback(oct_hw-
> >vqs[i].cb.private);
> +		}
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static void octep_free_irqs(struct octep_hw *oct_hw) {
> +	struct pci_dev *pdev =3D oct_hw->pdev;
> +
> +	if (oct_hw->irq !=3D -1) {
> +		devm_free_irq(&pdev->dev, oct_hw->irq, oct_hw);
> +		oct_hw->irq =3D -1;
> +	}
> +	pci_free_irq_vectors(pdev);
> +}
> +
> +static int octep_request_irqs(struct octep_hw *oct_hw) {
> +	struct pci_dev *pdev =3D oct_hw->pdev;
> +	int ret, irq;
> +
> +	/* Currently HW device provisions one IRQ per VF, hence
> +	 * allocate one IRQ for all virtqueues call interface.
> +	 */
> +	ret =3D pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSIX);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "Failed to alloc msix vector");
> +		return ret;
> +	}
> +
> +	snprintf(oct_hw->vqs->msix_name, sizeof(oct_hw->vqs-
> >msix_name),
> +		 OCTEP_VDPA_DRIVER_NAME "-vf-%d", pci_iov_vf_id(pdev));
> +
> +	irq =3D pci_irq_vector(pdev, 0);
> +	ret =3D devm_request_irq(&pdev->dev, irq, octep_vdpa_intr_handler, 0,
> +			       oct_hw->vqs->msix_name, oct_hw);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to register interrupt handler\n");
> +		goto free_irq_vec;
> +	}
> +	oct_hw->irq =3D irq;
> +
> +	return 0;
> +
> +free_irq_vec:
> +	pci_free_irq_vectors(pdev);
> +	return ret;
> +}
> +
> +static u64 octep_vdpa_get_device_features(struct vdpa_device *vdpa_dev)
> +{
> +	struct octep_hw *oct_hw =3D vdpa_to_octep_hw(vdpa_dev);
> +
> +	return oct_hw->features;
> +}
> +
> +static int octep_vdpa_set_driver_features(struct vdpa_device *vdpa_dev,
> +u64 features) {
> +	struct octep_hw *oct_hw =3D vdpa_to_octep_hw(vdpa_dev);
> +	int ret;
> +
> +	pr_debug("Driver Features: %llx\n", features);
> +
> +	ret =3D octep_verify_features(features);
> +	if (ret) {
> +		dev_warn(&oct_hw->pdev->dev,
> +			 "Must negotiate minimum features 0x%llx for this
> device",
> +			 BIT_ULL(VIRTIO_F_VERSION_1) |
> BIT_ULL(VIRTIO_F_NOTIFICATION_DATA) |
> +			 BIT_ULL(VIRTIO_F_RING_PACKED));
> +		return ret;
> +	}
> +	octep_hw_set_drv_features(oct_hw, features);
> +
> +	return 0;
> +}
> +
> +static u64 octep_vdpa_get_driver_features(struct vdpa_device *vdpa_dev)
> +{
> +	struct octep_hw *oct_hw =3D vdpa_to_octep_hw(vdpa_dev);
> +
> +	return octep_hw_get_drv_features(oct_hw);
> +}
> +
> +static u8 octep_vdpa_get_status(struct vdpa_device *vdpa_dev) {
> +	struct octep_hw *oct_hw =3D vdpa_to_octep_hw(vdpa_dev);
> +
> +	return octep_hw_get_status(oct_hw);
> +}
> +
> +static void octep_vdpa_set_status(struct vdpa_device *vdpa_dev, u8
> +status) {
> +	struct octep_hw *oct_hw =3D vdpa_to_octep_hw(vdpa_dev);
> +	u8 status_old;
> +
> +	status_old =3D octep_hw_get_status(oct_hw);
> +
> +	if (status_old =3D=3D status)
> +		return;
> +
> +	if ((status & VIRTIO_CONFIG_S_DRIVER_OK) &&
> +	    !(status_old & VIRTIO_CONFIG_S_DRIVER_OK)) {
> +		if (octep_request_irqs(oct_hw))
> +			status =3D status_old | VIRTIO_CONFIG_S_FAILED;
> +	}
> +	octep_hw_set_status(oct_hw, status);
> +}
> +
> +static int octep_vdpa_reset(struct vdpa_device *vdpa_dev) {
> +	struct octep_hw *oct_hw =3D vdpa_to_octep_hw(vdpa_dev);
> +	u8 status =3D octep_hw_get_status(oct_hw);
> +	u16 qid;
> +
> +	if (status =3D=3D 0)
> +		return 0;
> +
> +	for (qid =3D 0; qid < oct_hw->nr_vring; qid++) {
> +		oct_hw->vqs[qid].cb.callback =3D NULL;
> +		oct_hw->vqs[qid].cb.private =3D NULL;
> +		oct_hw->config_cb.callback =3D NULL;
> +		oct_hw->config_cb.private =3D NULL;
> +	}
> +	octep_hw_reset(oct_hw);
> +
> +	if (status & VIRTIO_CONFIG_S_DRIVER_OK)
> +		octep_free_irqs(oct_hw);
> +
> +	return 0;
> +}
> +
> +static u16 octep_vdpa_get_vq_num_max(struct vdpa_device *vdpa_dev) {
> +	struct octep_hw *oct_hw =3D vdpa_to_octep_hw(vdpa_dev);
> +
> +	return octep_get_vq_size(oct_hw);
> +}
> +
> +static int octep_vdpa_get_vq_state(struct vdpa_device *vdpa_dev, u16 qid=
,
> +				   struct vdpa_vq_state *state)
> +{
> +	struct octep_hw *oct_hw =3D vdpa_to_octep_hw(vdpa_dev);
> +
> +	return octep_get_vq_state(oct_hw, qid, state); }
> +
> +static int octep_vdpa_set_vq_state(struct vdpa_device *vdpa_dev, u16 qid=
,
> +				   const struct vdpa_vq_state *state) {
> +	struct octep_hw *oct_hw =3D vdpa_to_octep_hw(vdpa_dev);
> +
> +	return octep_set_vq_state(oct_hw, qid, state); }
> +
> +static void octep_vdpa_set_vq_cb(struct vdpa_device *vdpa_dev, u16 qid,
> +struct vdpa_callback *cb) {
> +	struct octep_hw *oct_hw =3D vdpa_to_octep_hw(vdpa_dev);
> +
> +	oct_hw->vqs[qid].cb =3D *cb;
> +}
> +
> +static void octep_vdpa_set_vq_ready(struct vdpa_device *vdpa_dev, u16
> +qid, bool ready) {
> +	struct octep_hw *oct_hw =3D vdpa_to_octep_hw(vdpa_dev);
> +
> +	octep_set_vq_ready(oct_hw, qid, ready); }
> +
> +static bool octep_vdpa_get_vq_ready(struct vdpa_device *vdpa_dev, u16
> +qid) {
> +	struct octep_hw *oct_hw =3D vdpa_to_octep_hw(vdpa_dev);
> +
> +	return octep_get_vq_ready(oct_hw, qid); }
> +
> +static void octep_vdpa_set_vq_num(struct vdpa_device *vdpa_dev, u16
> +qid, u32 num) {
> +	struct octep_hw *oct_hw =3D vdpa_to_octep_hw(vdpa_dev);
> +
> +	octep_set_vq_num(oct_hw, qid, num);
> +}
> +
> +static int octep_vdpa_set_vq_address(struct vdpa_device *vdpa_dev, u16
> qid, u64 desc_area,
> +				     u64 driver_area, u64 device_area) {
> +	struct octep_hw *oct_hw =3D vdpa_to_octep_hw(vdpa_dev);
> +
> +	pr_debug("qid[%d]: desc_area: %llx\n", qid, desc_area);
> +	pr_debug("qid[%d]: driver_area: %llx\n", qid, driver_area);
> +	pr_debug("qid[%d]: device_area: %llx\n\n", qid, device_area);
> +
> +	return octep_set_vq_address(oct_hw, qid, desc_area, driver_area,
> +device_area); }
> +
> +static void octep_vdpa_kick_vq(struct vdpa_device *vdpa_dev, u16 qid) {
> +	/* Not supported */
> +}
> +
> +static void octep_vdpa_kick_vq_with_data(struct vdpa_device *vdpa_dev,
> +u32 data) {
> +	struct octep_hw *oct_hw =3D vdpa_to_octep_hw(vdpa_dev);
> +	u16 idx =3D data & 0xFFFF;
> +
> +	vp_iowrite32(data, oct_hw->vqs[idx].notify_addr); }
> +
> +static u32 octep_vdpa_get_generation(struct vdpa_device *vdpa_dev) {
> +	struct octep_hw *oct_hw =3D vdpa_to_octep_hw(vdpa_dev);
> +
> +	return vp_ioread8(&oct_hw->common_cfg->config_generation);
> +}
> +
> +static u32 octep_vdpa_get_device_id(struct vdpa_device *vdpa_dev) {
> +	return VIRTIO_ID_NET;
> +}
> +
> +static u32 octep_vdpa_get_vendor_id(struct vdpa_device *vdpa_dev) {
> +	return PCI_VENDOR_ID_CAVIUM;
> +}
> +
> +static u32 octep_vdpa_get_vq_align(struct vdpa_device *vdpa_dev) {
> +	return PAGE_SIZE;
> +}
> +
> +static size_t octep_vdpa_get_config_size(struct vdpa_device *vdpa_dev)
> +{
> +	struct octep_hw *oct_hw =3D vdpa_to_octep_hw(vdpa_dev);
> +
> +	return oct_hw->config_size;
> +}
> +
> +static void octep_vdpa_get_config(struct vdpa_device *vdpa_dev, unsigned
> int offset, void *buf,
> +				  unsigned int len)
> +{
> +	struct octep_hw *oct_hw =3D vdpa_to_octep_hw(vdpa_dev);
> +
> +	octep_read_dev_config(oct_hw, offset, buf, len); }
> +
> +static void octep_vdpa_set_config(struct vdpa_device *vdpa_dev, unsigned
> int offset,
> +				  const void *buf, unsigned int len) {
> +	/* Not supported */
> +}
> +
> +static void octep_vdpa_set_config_cb(struct vdpa_device *vdpa_dev,
> +struct vdpa_callback *cb) {
> +	struct octep_hw *oct_hw =3D vdpa_to_octep_hw(vdpa_dev);
> +
> +	oct_hw->config_cb.callback =3D cb->callback;
> +	oct_hw->config_cb.private =3D cb->private; }
> +
> +static struct vdpa_notification_area octep_get_vq_notification(struct
> vdpa_device *vdpa_dev,
> +							       u16 idx)
> +{
> +	struct octep_hw *oct_hw =3D vdpa_to_octep_hw(vdpa_dev);
> +	struct vdpa_notification_area area;
> +
> +	area.addr =3D oct_hw->vqs[idx].notify_pa;
> +	area.size =3D PAGE_SIZE;
> +
> +	return area;
> +}
> +
> +static struct vdpa_config_ops octep_vdpa_ops =3D {
> +	.get_device_features =3D octep_vdpa_get_device_features,
> +	.set_driver_features =3D octep_vdpa_set_driver_features,
> +	.get_driver_features =3D octep_vdpa_get_driver_features,
> +	.get_status	=3D octep_vdpa_get_status,
> +	.set_status	=3D octep_vdpa_set_status,
> +	.reset		=3D octep_vdpa_reset,
> +	.get_vq_num_max	=3D octep_vdpa_get_vq_num_max,
> +	.get_vq_state	=3D octep_vdpa_get_vq_state,
> +	.set_vq_state	=3D octep_vdpa_set_vq_state,
> +	.set_vq_cb	=3D octep_vdpa_set_vq_cb,
> +	.set_vq_ready	=3D octep_vdpa_set_vq_ready,
> +	.get_vq_ready	=3D octep_vdpa_get_vq_ready,
> +	.set_vq_num	=3D octep_vdpa_set_vq_num,
> +	.set_vq_address	=3D octep_vdpa_set_vq_address,
> +	.get_vq_irq	=3D NULL,
> +	.kick_vq	=3D octep_vdpa_kick_vq,
> +	.kick_vq_with_data	=3D octep_vdpa_kick_vq_with_data,
> +	.get_generation	=3D octep_vdpa_get_generation,
> +	.get_device_id	=3D octep_vdpa_get_device_id,
> +	.get_vendor_id	=3D octep_vdpa_get_vendor_id,
> +	.get_vq_align	=3D octep_vdpa_get_vq_align,
> +	.get_config_size	=3D octep_vdpa_get_config_size,
> +	.get_config	=3D octep_vdpa_get_config,
> +	.set_config	=3D octep_vdpa_set_config,
> +	.set_config_cb  =3D octep_vdpa_set_config_cb,
> +	.get_vq_notification =3D octep_get_vq_notification, };
> +
> +static int octep_iomap_region(struct pci_dev *pdev, u8 __iomem **tbl,
> +u8 bar) {
> +	int ret;
> +
> +	ret =3D pci_request_region(pdev, bar, OCTEP_VDPA_DRIVER_NAME);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to request BAR:%u region\n",
> bar);
> +		return ret;
> +	}
> +
> +	tbl[bar] =3D pci_iomap(pdev, bar, pci_resource_len(pdev, bar));
> +	if (!tbl[bar]) {
> +		dev_err(&pdev->dev, "Failed to iomap BAR:%u\n", bar);
> +		pci_release_region(pdev, bar);
> +		ret =3D -ENOMEM;
> +	}
> +
> +	return ret;
> +}
> +
> +static void octep_iounmap_region(struct pci_dev *pdev, u8 __iomem
> +**tbl, u8 bar) {
> +	pci_iounmap(pdev, tbl[bar]);
> +	pci_release_region(pdev, bar);
> +}
> +
> +static void octep_vdpa_pf_bar_shrink(struct octep_pf *octpf) {
> +	struct pci_dev *pf_dev =3D octpf->pdev;
> +	struct resource *res =3D pf_dev->resource + PCI_STD_RESOURCES + 4;
> +	struct pci_bus_region bus_region;
> +
> +	octpf->res.start =3D res->start;
> +	octpf->res.end =3D res->end;
> +	octpf->vf_base =3D res->start;
> +
> +	bus_region.start =3D res->start;
> +	bus_region.end =3D res->start - 1;
> +
> +	pcibios_bus_to_resource(pf_dev->bus, res, &bus_region); }
> +
> +static void octep_vdpa_pf_bar_expand(struct octep_pf *octpf) {
> +	struct pci_dev *pf_dev =3D octpf->pdev;
> +	struct resource *res =3D pf_dev->resource + PCI_STD_RESOURCES + 4;
> +	struct pci_bus_region bus_region;
> +
> +	bus_region.start =3D octpf->res.start;
> +	bus_region.end =3D octpf->res.end;
> +
> +	pcibios_bus_to_resource(pf_dev->bus, res, &bus_region); }
> +
> +static void octep_vdpa_remove_pf(struct pci_dev *pdev) {
> +	struct octep_pf *octpf =3D pci_get_drvdata(pdev);
> +
> +	pci_disable_sriov(pdev);
> +
> +	if (octpf->base[OCTEP_HW_CAPS_BAR])
> +		octep_iounmap_region(pdev, octpf->base,
> OCTEP_HW_CAPS_BAR);
> +
> +	if (octpf->base[OCTEP_HW_MBOX_BAR])
> +		octep_iounmap_region(pdev, octpf->base,
> OCTEP_HW_MBOX_BAR);
> +
> +	octep_vdpa_pf_bar_expand(octpf);
> +}
> +
> +static void octep_vdpa_vf_bar_shrink(struct pci_dev *pdev) {
> +	struct resource *vf_res =3D pdev->resource + PCI_STD_RESOURCES + 4;
> +
> +	memset(vf_res, 0, sizeof(*vf_res));
> +}
> +
> +static void octep_vdpa_remove_vf(struct pci_dev *pdev) {
> +	struct octep_vdpa_mgmt_dev *mgmt_dev =3D pci_get_drvdata(pdev);
> +	struct octep_hw *oct_hw;
> +	int status;
> +
> +	oct_hw =3D &mgmt_dev->oct_hw;
> +	status =3D atomic_read(&mgmt_dev->status);
> +	atomic_set(&mgmt_dev->status,
> OCTEP_VDPA_DEV_STATUS_UNINIT);
> +
> +	cancel_work_sync(&mgmt_dev->setup_task);
> +	if (status =3D=3D OCTEP_VDPA_DEV_STATUS_READY)
> +		vdpa_mgmtdev_unregister(&mgmt_dev->mdev);
> +
> +	if (oct_hw->base[OCTEP_HW_CAPS_BAR])
> +		octep_iounmap_region(pdev, oct_hw->base,
> OCTEP_HW_CAPS_BAR);
> +
> +	if (oct_hw->base[OCTEP_HW_MBOX_BAR])
> +		octep_iounmap_region(pdev, oct_hw->base,
> OCTEP_HW_MBOX_BAR);
> +
> +	octep_vdpa_vf_bar_shrink(pdev);
> +}
> +
> +static void octep_vdpa_remove(struct pci_dev *pdev) {
> +	if (pdev->is_virtfn)
> +		octep_vdpa_remove_vf(pdev);
> +	else
> +		octep_vdpa_remove_pf(pdev);
> +}
> +
> +static int octep_vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char
> *name,
> +			      const struct vdpa_dev_set_config *config) {
> +	struct octep_vdpa_mgmt_dev *mgmt_dev =3D container_of(mdev,
> struct octep_vdpa_mgmt_dev, mdev);
> +	struct octep_hw *oct_hw =3D &mgmt_dev->oct_hw;
> +	struct pci_dev *pdev =3D oct_hw->pdev;
> +	struct vdpa_device *vdpa_dev;
> +	struct octep_vdpa *oct_vdpa;
> +	u64 device_features;
> +	int ret;
> +
> +	oct_vdpa =3D vdpa_alloc_device(struct octep_vdpa, vdpa, &pdev->dev,
> &octep_vdpa_ops, 1, 1,
> +				     NULL, false);
> +	if (IS_ERR(oct_vdpa)) {
> +		dev_err(&pdev->dev, "Failed to allocate vDPA structure for
> octep vdpa device");
> +		return PTR_ERR(oct_vdpa);
> +	}
> +
> +	oct_vdpa->pdev =3D pdev;
> +	oct_vdpa->vdpa.dma_dev =3D &pdev->dev;
> +	oct_vdpa->vdpa.mdev =3D mdev;
> +	oct_vdpa->oct_hw =3D oct_hw;
> +	vdpa_dev =3D &oct_vdpa->vdpa;
> +
> +	device_features =3D oct_hw->features;
> +	if (config->mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES)) {
> +		if (config->device_features & ~device_features) {
> +			dev_err(&pdev->dev, "The provisioned features 0x%llx
> are not supported by this device with features 0x%llx\n",
> +				config->device_features, device_features);
> +			ret =3D -EINVAL;
> +			goto vdpa_dev_put;
> +		}
> +		device_features &=3D config->device_features;
> +	}
> +
> +	oct_hw->features =3D device_features;
> +	dev_info(&pdev->dev, "Vdpa management device features : %llx\n",
> +device_features);
> +
> +	ret =3D octep_verify_features(device_features);
> +	if (ret) {
> +		dev_warn(mdev->device,
> +			 "Must provision minimum features 0x%llx for this
> device",
> +			 BIT_ULL(VIRTIO_F_VERSION_1) |
> BIT_ULL(VIRTIO_F_ACCESS_PLATFORM) |
> +			 BIT_ULL(VIRTIO_F_NOTIFICATION_DATA) |
> BIT_ULL(VIRTIO_F_RING_PACKED));
> +		goto vdpa_dev_put;
> +	}
> +	if (name)
> +		ret =3D dev_set_name(&vdpa_dev->dev, "%s", name);
> +	else
> +		ret =3D dev_set_name(&vdpa_dev->dev, "vdpa%u", vdpa_dev-
> >index);
> +
> +	ret =3D _vdpa_register_device(&oct_vdpa->vdpa, oct_hw->nr_vring);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to register to vDPA bus");
> +		goto vdpa_dev_put;
> +	}
> +	return 0;
> +
> +vdpa_dev_put:
> +	put_device(&oct_vdpa->vdpa.dev);
> +	return ret;
> +}
> +
> +static void octep_vdpa_dev_del(struct vdpa_mgmt_dev *mdev, struct
> +vdpa_device *vdpa_dev) {
> +	_vdpa_unregister_device(vdpa_dev);
> +}
> +
> +static const struct vdpa_mgmtdev_ops octep_vdpa_mgmt_dev_ops =3D {
> +	.dev_add =3D octep_vdpa_dev_add,
> +	.dev_del =3D octep_vdpa_dev_del
> +};
> +
> +static bool get_device_ready_status(u8 __iomem *addr) {
> +	u64 signature =3D readq(addr + OCTEP_VF_MBOX_DATA(0));
> +
> +	if (signature =3D=3D OCTEP_DEV_READY_SIGNATURE) {
> +		writeq(0, addr + OCTEP_VF_MBOX_DATA(0));
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
> +static struct virtio_device_id id_table[] =3D {
> +	{ VIRTIO_ID_NET, VIRTIO_DEV_ANY_ID },
> +	{ 0 },
> +};
> +
> +static void octep_vdpa_setup_task(struct work_struct *work) {
> +	struct octep_vdpa_mgmt_dev *mgmt_dev =3D container_of(work,
> struct octep_vdpa_mgmt_dev,
> +							    setup_task);
> +	struct pci_dev *pdev =3D mgmt_dev->pdev;
> +	struct device *dev =3D &pdev->dev;
> +	struct octep_hw *oct_hw;
> +	unsigned long timeout;
> +	int ret;
> +
> +	oct_hw =3D &mgmt_dev->oct_hw;
> +
> +	atomic_set(&mgmt_dev->status,
> +OCTEP_VDPA_DEV_STATUS_WAIT_FOR_BAR_INIT);
> +
> +	/* Wait for a maximum of 5 sec */
> +	timeout =3D jiffies + msecs_to_jiffies(5000);
> +	while (!time_after(jiffies, timeout)) {
> +		if (get_device_ready_status(oct_hw-
> >base[OCTEP_HW_MBOX_BAR])) {
> +			atomic_set(&mgmt_dev->status,
> OCTEP_VDPA_DEV_STATUS_INIT);
> +			break;
> +		}
> +
> +		if (atomic_read(&mgmt_dev->status) >=3D
> OCTEP_VDPA_DEV_STATUS_READY) {
> +			dev_info(dev, "Stopping vDPA setup task.\n");
> +			return;
> +		}
> +
> +		usleep_range(1000, 1500);
> +	}
> +
> +	if (atomic_read(&mgmt_dev->status) !=3D
> OCTEP_VDPA_DEV_STATUS_INIT) {
> +		dev_err(dev, "BAR initialization is timed out\n");
> +		return;
> +	}
> +
> +	ret =3D octep_iomap_region(pdev, oct_hw->base,
> OCTEP_HW_CAPS_BAR);
> +	if (ret)
> +		return;
> +
> +	ret =3D octep_hw_caps_read(oct_hw, pdev);
> +	if (ret < 0)
> +		goto unmap_region;
> +
> +	mgmt_dev->mdev.ops =3D &octep_vdpa_mgmt_dev_ops;
> +	mgmt_dev->mdev.id_table =3D id_table;
> +	mgmt_dev->mdev.max_supported_vqs =3D oct_hw->nr_vring;
> +	mgmt_dev->mdev.supported_features =3D oct_hw->features;
> +	mgmt_dev->mdev.config_attr_mask =3D (1 <<
> VDPA_ATTR_DEV_FEATURES);
> +	mgmt_dev->mdev.device =3D dev;
> +
> +	ret =3D vdpa_mgmtdev_register(&mgmt_dev->mdev);
> +	if (ret) {
> +		dev_err(dev, "Failed to register vdpa management
> interface\n");
> +		goto unmap_region;
> +	}
> +
> +	atomic_set(&mgmt_dev->status,
> OCTEP_VDPA_DEV_STATUS_READY);
> +
> +	return;
> +
> +unmap_region:
> +	octep_iounmap_region(pdev, oct_hw->base, OCTEP_HW_CAPS_BAR);
> +	oct_hw->base[OCTEP_HW_CAPS_BAR] =3D NULL; }
> +
> +static int octep_vdpa_probe_vf(struct pci_dev *pdev) {
> +	struct octep_vdpa_mgmt_dev *mgmt_dev;
> +	struct device *dev =3D &pdev->dev;
> +	int ret;
> +
> +	ret =3D pcim_enable_device(pdev);
> +	if (ret) {
> +		dev_err(dev, "Failed to enable device\n");
> +		return ret;
> +	}
> +
> +	ret =3D dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
> +	if (ret) {
> +		dev_err(dev, "No usable DMA configuration\n");
> +		return ret;
> +	}
> +	pci_set_master(pdev);
> +
> +	mgmt_dev =3D devm_kzalloc(dev, sizeof(struct octep_vdpa_mgmt_dev),
> GFP_KERNEL);
> +	if (!mgmt_dev)
> +		return -ENOMEM;
> +
> +	ret =3D octep_iomap_region(pdev, mgmt_dev->oct_hw.base,
> OCTEP_HW_MBOX_BAR);
> +	if (ret)
> +		return ret;
> +
> +	mgmt_dev->pdev =3D pdev;
> +	pci_set_drvdata(pdev, mgmt_dev);
> +
> +	atomic_set(&mgmt_dev->status, OCTEP_VDPA_DEV_STATUS_ALLOC);
> +	INIT_WORK(&mgmt_dev->setup_task, octep_vdpa_setup_task);
> +	schedule_work(&mgmt_dev->setup_task);
> +	dev_info(&pdev->dev, "octep vdpa mgmt device setup task is
> queued\n");
> +
> +	return 0;
> +}
> +
> +static void octep_vdpa_assign_barspace(struct pci_dev *vf_dev, struct
> +pci_dev *pf_dev, u8 idx) {
> +	struct resource *vf_res =3D vf_dev->resource + PCI_STD_RESOURCES + 4;
> +	struct resource *pf_res =3D pf_dev->resource + PCI_STD_RESOURCES +
> 4;
> +	struct octep_pf *pf =3D pci_get_drvdata(pf_dev);
> +	struct pci_bus_region bus_region;
> +
> +	vf_res->name =3D pci_name(vf_dev);
> +	vf_res->flags =3D pf_res->flags;
> +	vf_res->parent =3D (pf_dev->resource + PCI_STD_RESOURCES)->parent;
> +
> +	bus_region.start =3D pf->vf_base + idx * pf->vf_stride;
> +	bus_region.end =3D bus_region.start + pf->vf_stride - 1;
> +	pcibios_bus_to_resource(vf_dev->bus, vf_res, &bus_region); }
> +
> +static int octep_sriov_enable(struct pci_dev *pdev, int num_vfs) {
> +	struct octep_pf *pf =3D pci_get_drvdata(pdev);
> +	u8 __iomem *addr =3D pf->base[OCTEP_HW_MBOX_BAR];
> +	struct pci_dev *vf_pdev =3D NULL;
> +	bool done =3D false;
> +	int index =3D 0;
> +	int ret, i;
> +
> +	ret =3D pci_enable_sriov(pdev, num_vfs);
> +	if (ret)
> +		return ret;
> +
> +	pf->enabled_vfs =3D num_vfs;
> +
> +	while ((vf_pdev =3D pci_get_device(PCI_VENDOR_ID_CAVIUM,
> PCI_ANY_ID, vf_pdev))) {
> +		if (vf_pdev->device !=3D pf->vf_devid)
> +			continue;
> +
> +		octep_vdpa_assign_barspace(vf_pdev, pdev, index);
> +		if (++index =3D=3D num_vfs) {
> +			done =3D true;
> +			break;
> +		}
> +	}
> +
> +	if (done) {
> +		for (i =3D 0; i < pf->enabled_vfs; i++)
> +			writeq(OCTEP_DEV_READY_SIGNATURE, addr +
> OCTEP_PF_MBOX_DATA(i));
> +	}
> +
> +	return num_vfs;
> +}
> +
> +static int octep_sriov_disable(struct pci_dev *pdev) {
> +	struct octep_pf *pf =3D pci_get_drvdata(pdev);
> +
> +	if (!pci_num_vf(pdev))
> +		return 0;
> +
> +	pci_disable_sriov(pdev);
> +	pf->enabled_vfs =3D 0;
> +
> +	return 0;
> +}
> +
> +static int octep_vdpa_sriov_configure(struct pci_dev *pdev, int
> +num_vfs) {
> +	if (num_vfs > 0)
> +		return octep_sriov_enable(pdev, num_vfs);
> +	else
> +		return octep_sriov_disable(pdev);
> +}
> +
> +static u16 octep_get_vf_devid(struct pci_dev *pdev) {
> +	u16 did;
> +
> +	switch (pdev->device) {
> +	case OCTEP_VDPA_DEVID_CN106K_PF:
> +		did =3D OCTEP_VDPA_DEVID_CN106K_VF;
> +		break;
> +	case OCTEP_VDPA_DEVID_CN105K_PF:
> +		did =3D OCTEP_VDPA_DEVID_CN105K_VF;
> +		break;
> +	case OCTEP_VDPA_DEVID_CN103K_PF:
> +		did =3D OCTEP_VDPA_DEVID_CN103K_VF;
> +		break;
> +	default:
> +		did =3D 0xFFFF;
> +		break;
> +	}
> +
> +	return did;
> +}
> +
> +static int octep_vdpa_pf_setup(struct octep_pf *octpf) {
> +	u8 __iomem *addr =3D octpf->base[OCTEP_HW_MBOX_BAR];
> +	struct pci_dev *pdev =3D octpf->pdev;
> +	int totalvfs;
> +	size_t len;
> +	u64 val;
> +
> +	totalvfs =3D pci_sriov_get_totalvfs(pdev);
> +	if (unlikely(!totalvfs)) {
> +		dev_info(&pdev->dev, "Total VFs are %d in PF sriov
> configuration\n", totalvfs);
> +		return 0;
> +	}
> +
> +	addr =3D octpf->base[OCTEP_HW_MBOX_BAR];
> +	val =3D readq(addr + OCTEP_EPF_RINFO(0));
> +	if (val =3D=3D 0) {
> +		dev_err(&pdev->dev, "Invalid device configuration\n");
> +		return -EINVAL;
> +	}
> +
> +	if (OCTEP_EPF_RINFO_RPVF(val) !=3D BIT_ULL(0)) {
> +		val &=3D ~GENMASK_ULL(35, 32);
> +		val |=3D BIT_ULL(32);
> +		writeq(val, addr + OCTEP_EPF_RINFO(0));
> +	}
> +
> +	len =3D pci_resource_len(pdev, OCTEP_HW_CAPS_BAR);
> +
> +	octpf->vf_stride =3D len / totalvfs;
> +	octpf->vf_devid =3D octep_get_vf_devid(pdev);
> +
> +	octep_vdpa_pf_bar_shrink(octpf);
> +
> +	return 0;
> +}
> +
> +static int octep_vdpa_probe_pf(struct pci_dev *pdev) {
> +	struct device *dev =3D &pdev->dev;
> +	struct octep_pf *octpf;
> +	int ret;
> +
> +	ret =3D pcim_enable_device(pdev);
> +	if (ret) {
> +		dev_err(dev, "Failed to enable device\n");
> +		return ret;
> +	}
> +
> +	ret =3D dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
> +	if (ret) {
> +		dev_err(dev, "No usable DMA configuration\n");
> +		return ret;
> +	}
> +	octpf =3D devm_kzalloc(dev, sizeof(*octpf), GFP_KERNEL);
> +	if (!octpf)
> +		return -ENOMEM;
> +
> +	ret =3D octep_iomap_region(pdev, octpf->base,
> OCTEP_HW_MBOX_BAR);
> +	if (ret)
> +		return ret;
> +
> +	pci_set_master(pdev);
> +	pci_set_drvdata(pdev, octpf);
> +	octpf->pdev =3D pdev;
> +
> +	ret =3D octep_vdpa_pf_setup(octpf);
> +	if (ret)
> +		goto unmap_region;
> +
> +	return 0;
> +
> +unmap_region:
> +	octep_iounmap_region(pdev, octpf->base, OCTEP_HW_MBOX_BAR);
> +	return ret;
> +}
> +
> +static int octep_vdpa_probe(struct pci_dev *pdev, const struct
> +pci_device_id *id) {
> +	if (pdev->is_virtfn)
> +		return octep_vdpa_probe_vf(pdev);
> +	else
> +		return octep_vdpa_probe_pf(pdev);
> +}
> +
> +static struct pci_device_id octep_pci_vdpa_map[] =3D {
> +	{ PCI_DEVICE(PCI_VENDOR_ID_CAVIUM,
> OCTEP_VDPA_DEVID_CN106K_PF) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_CAVIUM,
> OCTEP_VDPA_DEVID_CN106K_VF) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_CAVIUM,
> OCTEP_VDPA_DEVID_CN105K_PF) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_CAVIUM,
> OCTEP_VDPA_DEVID_CN105K_VF) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_CAVIUM,
> OCTEP_VDPA_DEVID_CN103K_PF) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_CAVIUM,
> OCTEP_VDPA_DEVID_CN103K_VF) },
> +	{ 0 },
> +};
> +
> +static struct pci_driver octep_pci_vdpa =3D {
> +	.name     =3D OCTEP_VDPA_DRIVER_NAME,
> +	.id_table =3D octep_pci_vdpa_map,
> +	.probe    =3D octep_vdpa_probe,
> +	.remove   =3D octep_vdpa_remove,
> +	.sriov_configure =3D octep_vdpa_sriov_configure };
> +
> +module_pci_driver(octep_pci_vdpa);
> +
> +MODULE_AUTHOR("Marvell");
> +MODULE_DESCRIPTION("Marvell Octeon PCIe endpoint vDPA driver");
> +MODULE_LICENSE("GPL");
> --
> 2.25.1

