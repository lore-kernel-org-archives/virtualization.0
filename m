Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BFF8BE8
	for <virtualization@lists.linux.dev>; Wed, 10 Apr 2024 12:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712752839; cv=fail; b=XNmIv4Isl9Lf+iqlNwylK5UV0+waNjmMEvcf0h1jqy41qPk0m1GomIEWXkILhs0I1HHl2nDCVd/4e8aqrLfx5Ikqe5SL4G7T2GtZB9uMDUM7lbtXxei02nHXoAelb1pFhV56swx7KxtTi7tEISSKL/GSAUM7EBLC/VzwF8wvdFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712752839; c=relaxed/simple;
	bh=fegAahdxDvwPpNARigjC1OZeVlICw9PT8rJW/Jreaws=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AhreTozfHVVBIvnhYjyLe+8P+31pPZ9b01WUdslJVaHK+HJAZFjuSOyG8h8EkBkItAmRehe6stZ0JHUxDiorG7McM5CUG2zjCjf3ovv3vXbrN+hzdBtwKVy9lNfIySFa1pEVTPYZburOx75lDvBu5Xo+v9NgXeGHrh9skCLHjzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=QcJ1MOOW; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="QcJ1MOOW"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43A9gjtV014095;
	Wed, 10 Apr 2024 05:40:31 -0700
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3xdrc6hv8x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 05:40:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FXxDHbLZH3McZOrsjHARcy5k5ebk0E+k7hKDEsPN3RRjKDIVNTB5PlVZqsXKZubX/8ns2SbfqTQJGu5fLZZb3qDjbFza9y3SHGcJE8ybs0AMfE8AmnPAZmF4kcUi+lROVkQIiw/Vf6ufllGjUZhFrCVTKcWirvKR5ThJxtsXnvABYmLSb8PXqvrAQW8Y9qQdQVGvfu9z1pYD5ZTXCGn21Tj0YoJn7CEB7WfENUcAZ/v6E5vIML6QY/AKC4qoR+MhSp9mDPSBMZ5mvGeI/BnMzXr5LywcNvD9FZO0vY3/fj+8Ybz/hCA689faaRTjWRbKwklQ+s+MKLWJJ0TMcHGWOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8sSsbTcR4kfT9oMrLULzuv2zUevJltZ8cpmuwYaJESM=;
 b=Ekz9hCDprTrbxA41bbBbXz8rMnK/ArUh3MD/SXgj1neJu5dEI4+ACJ9C5B8/A1OiQKcTh3Ly1LKE3dKofhMlOc4IN/IzAHvcCjwOGc8kmIkml4wNMoJDKd+D03HLmkHjtF/IKedKFY/ktVsX09PCMsKtAtGfYBH1cMKDhlWmdNtI0z909Vq1pd8FCXzTwJXKAoK/Fe3AMXX8FVcYx1DA6/WsuNw1NluI+U/DycERFOHW8b4YfpqyGo8BKhE3jRW25GtV05eQV6jvTkOiHHQE2RfAcspcF4rtrEc4gokFBXOwsTUv6V+Hd0SmGhSIHpXxv/jJT/Aw4YsZBBQrfWCM4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8sSsbTcR4kfT9oMrLULzuv2zUevJltZ8cpmuwYaJESM=;
 b=QcJ1MOOWAP9tHl3jMripvSlRt5lFPvOYTS5qnSkgCVcbZvmj2lKzpE0tG6Oy3SBmdTICMQu20uT7+5uM/DhTLnOcwzP43CuLt8t2uimlq6wxUt0rI8Poto/eHuAAd+DNuT331ZmOONYC6DtZGNQ0A43kCQXxL8Hmy9Ea5XyTau4=
Received: from DS0PR18MB5368.namprd18.prod.outlook.com (2603:10b6:8:12f::17)
 by SN7PR18MB5261.namprd18.prod.outlook.com (2603:10b6:806:2eb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.53; Wed, 10 Apr
 2024 12:40:29 +0000
Received: from DS0PR18MB5368.namprd18.prod.outlook.com
 ([fe80::9728:b607:b464:a2dc]) by DS0PR18MB5368.namprd18.prod.outlook.com
 ([fe80::9728:b607:b464:a2dc%7]) with mapi id 15.20.7409.053; Wed, 10 Apr 2024
 12:40:29 +0000
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
Thread-Index: AQHagDj2SsvzR050EUWY0iVJi2EC1bFOmnOAgAARb5CAAAsuAIASz7Lw
Date: Wed, 10 Apr 2024 12:40:29 +0000
Message-ID: 
 <DS0PR18MB53689105898A0ACAEDD60322A0062@DS0PR18MB5368.namprd18.prod.outlook.com>
References: <20240327112136.2897479-1-schalla@marvell.com>
 <zuo2dwyz3rzwotgjnml2n5scjjwc563hh6cj5mtz6qieh6sgy7@kxluctu2tayv>
 <DS0PR18MB5368EA931E6FE873DD94A50BA03A2@DS0PR18MB5368.namprd18.prod.outlook.com>
 <zngyydrkdaeufu3d4r4mfjijxua4ivtxy6aalctvyge2xhv623@kzcgysxs2lbg>
In-Reply-To: <zngyydrkdaeufu3d4r4mfjijxua4ivtxy6aalctvyge2xhv623@kzcgysxs2lbg>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR18MB5368:EE_|SN7PR18MB5261:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 fsQ3YQqk6ftHiX4UgeTOC2cs05JXQcjsohiemLSMgCGJS+L8f2zOyt4IV+qVd8sMijA7Xll3AtUjwy6wzrQts6hkge3eTQLfN2ZS4JavmUFbjujbV1JXTNGX8SRWldvOtzh027O1Ktx+8WZ6cLiJi4K5OqBczTvGQb8xEwDsP7I+bBiM9AOva3EDf7baS/6rDfLQ3r5mFzQEjoAanzqMWYWXHVUooCo4QVBtRXRdXAMXwsFadrZkAXFLr5y5zjhrUxO8A7BKR3WYsfIOqEfmS6QRjT/hINpD1IxjVBl5Z7Jm7B//mqjBi1s5uzXSXUderkmTrlaeiN5R5ZXg84+A7JFqXPIiiMlWPU3UhhMhiq87VHpH+JAsC+G9Bqe3zhikdZz7KmSQhIGxaiBzY36ppIA6ZE3+VBoVK5BUM/c132KwKdtA7mOQV/OsJMlGLNsnYgT9Og7mdvMR2ZfMZBNlGczeAE70rX7cR43nbXcVQPlBixd/FQbgwC8GxcMUSU91OdN73XbVVrEDMTKDxNpcWtLPPlbjUrAa4UWZ7XZ1UH6fJZnpheABRKiYVYSPtsB4SBDEccs9rluAhdUQRggYFUKcO5DvvzWmWDblc7mxi0FFBtaGtrObOiL+/LNoJf0ETLRIxSHd/HD/HHrKcnlPIeS8N239WYXpBpRWcf8KwP8=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR18MB5368.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?+8qf/0Prl08hk6Zq5BrvycLj46mppwuecWbdMMzv3OMe/GFl4jgHroBTS4wL?=
 =?us-ascii?Q?v4yB9yy4MDvDbJrcmznhtxyxMGYJMERo6VyIDF+4sRr7UsJEAlDJs9n4Dxla?=
 =?us-ascii?Q?rxiM+y41ZAhwE/Yx/lUTo2JOaGOoh4WXHjP0C2d4vVlaQMj492Bru5TeIXMN?=
 =?us-ascii?Q?EAdxaDZjxyZFVvOdZo/G8MqX7DtlopMrp15xP0MjRCEWV451no6se3PpWdSY?=
 =?us-ascii?Q?1ClAkjp1Lgixj00jerithHVt03WshcQpT9TULjyb6BBYORkxW3uQKTZyVckA?=
 =?us-ascii?Q?eGkZdkD1bqVWoYwRb2UNz/PBxWPGNGgidmvm8HxBp9NCtBRy7xCZyLzxtSJE?=
 =?us-ascii?Q?if7RBXE/73XsVbNpQKkKI405Y+9Wx5Jx9FOH2bInWt1u2DIMAwxI2mHK6rAZ?=
 =?us-ascii?Q?ti6ps8qUb5HNljACuBdKknjUWi8E3q7XE2dZ11DE5dOtzEssap/pd/VK/h+2?=
 =?us-ascii?Q?cq7ELBvTknqQdSumQNYExdlGP/fT8nBvgLn5XJ2JM5Gs6W5ozH/MLd2/uEI2?=
 =?us-ascii?Q?EULaDRU2rxEo3VHs07fE975Q1a1afXB8De9SsiqdRKNMu6rCZAFDC9qx6tgj?=
 =?us-ascii?Q?JA77HbJVGO2vV/6LvhCosRsPUWBAedqrOTmcUO1+lwGsfcoG+FPtO0pwEMfj?=
 =?us-ascii?Q?iBnaLqvR4cBgHhb8T/Pehk/psg74CZFUPIVCGMeQgTCr/IdtRweNZE1W+X60?=
 =?us-ascii?Q?Zuk/f+D6RoL3LHY5KGYmrqiUMwjHdRUsaktKeVE9paINBcRZqmnZSidqd5cB?=
 =?us-ascii?Q?Nt4EdHDkrhFHh9eZQZ9GKRwDyqfaZORjNMnsP+fdczl/xSiItnxlncxsqNA/?=
 =?us-ascii?Q?n/IttcGbAb2hEcd8RmhEgcTwzKV9oSvx19lZ9icqUlLgeUEGj+hJwKHBetVL?=
 =?us-ascii?Q?wvWy8Qc7sqyP8OaSKryDRrZ4/bv0HN2uoFhFcHx7i9Vx0ZJhYN5jQtbVQeOR?=
 =?us-ascii?Q?RlHN4wMkFNBUSp/PzXRM9Yh0nb+W5Dfs9wrtOl+C/QMhN5LnmWzq2tkGsg+h?=
 =?us-ascii?Q?NTBbXUUo0otxq3L4OlbuWPOMzaCrNnEPXc3YQHoFhdU+PwjvbN+Mn2n8k3Mq?=
 =?us-ascii?Q?8H8nRiHp3bMARwMeOvRxxeqTcSppjwTMJXmABz5QCRD8zfdHV2Kr31ASnLLj?=
 =?us-ascii?Q?6i3ZYuUU4Msx5+O2tBgAZ9l+GSwWI3d44bRMDRev6++Y6FV/i0Dk4StwB5w6?=
 =?us-ascii?Q?CElvo6aHOYIx1KayvntC2lc9sBhI6DEGq0B/wVS4A1p2jaM3yur6Iidbp9O/?=
 =?us-ascii?Q?DTBR6Vw/0lVpazFG/kyumO5wFDBDPEfbk9miYoxvdSsdNIR+zEBOkuzjwN2G?=
 =?us-ascii?Q?Dd4RIoqeFKfbma2WuOT+KZWDfyr3xu6c7KtY2/zXYob+rM5ST2l4br6mqkcA?=
 =?us-ascii?Q?buVH5uNJpPPIsQdVifxghOUvhyk1pJwOrGSwx3/4qPB8Nj/ypjwg6iN8dC0T?=
 =?us-ascii?Q?Xb1VAHUbUgWrHxBlMQAGDqAmoZsM0SNhGEXz1pzFir1OfZhPX3uHhJV4uliD?=
 =?us-ascii?Q?Wn9rWpVYT/LrrChb6HlbDEkQtnsVNlmRnfM6VDZ49zrhpdTlKrLjzkaZuqkS?=
 =?us-ascii?Q?nwVhLkRC4O5762Tv3hKZWuJM2RbobMKr+r/TFFHu?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2da5b80b-9be5-4115-4353-08dc595b6789
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2024 12:40:29.3510
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RQp5jJdrCS+6eqkMWVTobXUEdZxEBl5eJDV837DI4nnu0i+/rUqavwN8o7TqjVjWZxO//67SDay86uj3jNt0dA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR18MB5261
X-Proofpoint-GUID: WxP5DWTqLE2bZrcOAolUlvu_lOT8asqG
X-Proofpoint-ORIG-GUID: WxP5DWTqLE2bZrcOAolUlvu_lOT8asqG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-10_04,2024-04-09_01,2023-05-22_02

> Subject: Re: [EXTERNAL] Re: [PATCH] virtio: vdpa: vDPA driver for Marvell
> OCTEON DPU devices
>=20
> On Fri, Mar 29, 2024 at 01:02:28PM +0000, Srujana Challa wrote:
> >> Subject: [EXTERNAL] Re: [PATCH] virtio: vdpa: vDPA driver for Marvell
> >> OCTEON DPU devices
> >>
> >> Prioritize security for external emails: Confirm sender and content
> >> safety before clicking links or opening attachments
> >>
> >> ---------------------------------------------------------------------
> >> - On Wed, Mar 27, 2024 at 04:51:36PM +0530, Srujana Challa wrote:
> >> >This commit introduces a new vDPA driver specifically designed for
> >> >managing the virtio control plane over the vDPA bus for OCTEON DPU
> >> >devices. The driver consists of two layers:
> >> >
> >> >1. Octep HW Layer (Octeon Endpoint): Responsible for handling
> >> >hardware operations and configurations related to the DPU device.
> >> >
> >> >2. Octep Main Layer: Compliant with the vDPA bus framework, this
> >> >layer implements device operations for the vDPA bus. It handles
> >> >device probing, bus attachment, vring operations, and other relevant
> tasks.
> >> >
> >> >Signed-off-by: Srujana Challa <schalla@marvell.com>
> >> >Signed-off-by: Vamsi Attunuru <vattunuru@marvell.com>
> >> >Signed-off-by: Shijith Thotton <sthotton@marvell.com>
> >> >Signed-off-by: Nithin Dabilpuram <ndabilpuram@marvell.com>
> >> >---
> >> > MAINTAINERS                              |   5 +
> >> > drivers/vdpa/Kconfig                     |   9 +
> >> > drivers/vdpa/Makefile                    |   1 +
> >> > drivers/vdpa/octeon_ep/Makefile          |   4 +
> >> > drivers/vdpa/octeon_ep/octep_vdpa.h      |  93 +++
> >> > drivers/vdpa/octeon_ep/octep_vdpa_hw.c   | 457 ++++++++++++
> >> > drivers/vdpa/octeon_ep/octep_vdpa_main.c | 903
> >> +++++++++++++++++++++++
> >> > 7 files changed, 1472 insertions(+) create mode 100644
> >> > drivers/vdpa/octeon_ep/Makefile  create mode
> >> 100644
> >> >drivers/vdpa/octeon_ep/octep_vdpa.h
> >> > create mode 100644 drivers/vdpa/octeon_ep/octep_vdpa_hw.c
> >> > create mode 100644 drivers/vdpa/octeon_ep/octep_vdpa_main.c
>=20
> [...]
>=20
> >> >diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig index
> >> >656c1cb541de..775149fad476 100644
> >> >--- a/drivers/vdpa/Kconfig
> >> >+++ b/drivers/vdpa/Kconfig
> >> >@@ -126,4 +126,13 @@ config PDS_VDPA
> >> > 	  With this driver, the VirtIO dataplane can be
> >> > 	  offloaded to an AMD/Pensando DSC device.
> >> >
> >> >+config OCTEONEP_VDPA
> >> >+	tristate "vDPA driver for Octeon DPU devices"
> >> >+	depends on m
> >>
> >> Just for curiosity, why restrict it to module-only?
> >
> >There is an etherent driver for the same class of devices. So, we made
> >this vDPA driver as module.
>=20
> Sorry, I didn`t get it.
>=20
> What would be the problem if we don`t put `depends on m` here?
Our device's firmware needs to boot up on the card before loading
the vdpa driver.
>=20
> >
> >>
> >> >+	depends on PCI_MSI
> >> >+	help
> >> >+	  vDPA driver for Marvell's Octeon DPU devices.
> >> >+	  With this driver, the VirtIO dataplane can be
> >> >+	  offloaded to a Octeon DPU device.
> >> >+
> >> > endif # VDPA
>=20
> [...]
>=20
> >> >+
> >> >+void octep_notify_queue(struct octep_hw *oct_hw, u16 qid) {
> >> >+	iowrite16(qid, oct_hw->vqs[qid].notify_addr); }
> >> >+
> >> >+void octep_read_dev_config(struct octep_hw *oct_hw, u64 offset,
> >> >+void *dst, int length) {
> >> >+	u8 old_gen, new_gen, *p;
> >> >+	int i;
> >> >+
> >> >+	WARN_ON(offset + length > oct_hw->config_size);
> >>                 ^
> >> Should we return early in this case?
> >Yes, I will move this to caller of this function.
>=20
> Otherwise you can do this here:
>=20
> 	if (WARN_ON(offset + length > oct_hw->config_size))
> 		return;
>=20
> Thanks,
> Stefano

