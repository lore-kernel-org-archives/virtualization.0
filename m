Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010052.outbound.protection.outlook.com [40.93.198.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA66415F0F
	for <virtualization@lists.linux.dev>; Mon,  3 Aug 2026 14:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785766053; cv=fail; b=VBTx7xTXiSUqRFaCpLF9wSxTh/LHnrWrwY2C8g5O50p0u/4QMNnGd2+JPKsn6r0eikx3bfAVIzJ1z8TxlaeUL8flt2fy/VLRw8KZmYxPowKwhJOlEI0UaJVxjNuJb5E29wiEvza5ZYTMlDBg4ev8eSYCOgRyV3b/73YxHQ8/u0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785766053; c=relaxed/simple;
	bh=JAiJx505x/VoWszGK9WwSmukAcGVoyGNdUUr/8IJeUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VgOSXbnlE5biAlM+Nmk1fro2zjN3nQ9kDdpugOlIeZcxagXlmmPGGdx3BLBUDEgDdIKSvO8U2bKAyVON6PsW33fn9p+4jV6O+iXpK0Nue68PAGkrEYQS/xgab3uWu0EwlTNBPemVPkeEeVW+Ya8c0+7SNcJxGhokyGMo6yXwRtg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=h7LJZb2h; arc=fail smtp.client-ip=40.93.198.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="h7LJZb2h"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tCYwE2dc6J0F7befHeZ6agHvJPiyEOlxxYQFsuEUdzeJtgf8I15t5UR3lE0FvcuqZT+SfDBQ8O50rgYCXxZsaGf/Wt2K58haCK+jfzluzzcRiLTIPeJpGpTkC/2YIs7q3O1YvDCYDLwhKftWlqdxU4KhpQcaT165yAUxyiQH8mQUMKvgLs0feITpqYZaO+amqk08ck59l9hzJeo2URlu2fS/a7g+TAJsq4/29KWSYmLnrhAmd59k2qQenBs4gPETJNGyCGJbQcenE7shZzuMx6RRxGUETWAIoYxm8EoxPK0YFhtZ+UaZkYMejLuSjoX7Uvaa6xg9jV7T67thFGQTuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IrSaQE7N/lXXIj1A43W5rMMCPUggxYz+U2/hcCiezSE=;
 b=O+vfK2vNlOKibrxxE52JKGV2BJ1IV8WuKa4Fq+p+fb3IiyZB/IFEAojkogCOjXbPQUEgucUn3cGPlIp09l5BhMf/HMaIL/LJI6t0KLAI7nPwqoUuXrsIspR3dxwxF6tei4sLTlPat0EL/M/YBrEJDL3Mf2ZC9Gv1MCJL2pmRGolB5NdHZ1sLstzKa97dX3U/P8EBmCre5p7QJ37D4MXJYie5bx/jdko5g7M1hzoNcEamSmmnW4dTbyqZy9lLDWdUbT4oRlePiv4ttDhQ95kiEFUDMdDsYPDNkp15qBOVSJUMOTJ2Tb+xaecYPL11Gg1oBP0P6uSxMokfOQqhTM8FmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IrSaQE7N/lXXIj1A43W5rMMCPUggxYz+U2/hcCiezSE=;
 b=h7LJZb2hOOPmSPygDxjwLfUtLBNtYRIKdDZaGhWh3xb6KAml4U/3H5o8fdLuT9uAoxiZsg+xlG9k2f3/nQvGaZDoUouLLax0qOgcq/aMzx7KXZeODRiA71eVVe0x3zpJuUyzHGk7zNLURdgCkk+dubiZ374Y7dGPnGA8b+2awiR96F6xgB+SpR2M6NRy/u6D3BTOgxGTY42aGfuWLP4YKuD+Sw2HSuKmNwrkxhlPm3LUwngg02CkWch2GX1Njm/5uLmlF0F3TuV22AyQ1q3nGaWXYw2wOltgkIoUCej+2Bou/xybP6CbuNgOA9uN0I33ponhEUISjJgMOiBaCGLOIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5505.namprd12.prod.outlook.com (2603:10b6:208:1ce::7)
 by MW9PR12MB999208.namprd12.prod.outlook.com (2603:10b6:303:301::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Mon, 3 Aug
 2026 14:07:26 +0000
Received: from BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21]) by BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21%3]) with mapi id 15.21.0270.017; Mon, 3 Aug 2026
 14:07:26 +0000
From: Shahar Shitrit <shshitrit@nvidia.com>
To: netdev@vger.kernel.org,
	mst@redhat.com,
	jasowang@redhat.com,
	pabeni@redhat.com
Cc: virtualization@lists.linux.dev,
	parav@nvidia.com,
	shshitrit@nvidia.com,
	yohadt@nvidia.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	jgg@ziepe.ca,
	kevin.tian@intel.com,
	kuba@kernel.org,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	danielj@nvidia.com
Subject: [PATCH net-next v21 01/13] virtio_pci: Remove supported_cap size build assert
Date: Mon,  3 Aug 2026 17:07:09 +0300
Message-ID: <20260803140721.1871678-2-shshitrit@nvidia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260803140721.1871678-1-shshitrit@nvidia.com>
References: <20260803140721.1871678-1-shshitrit@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TLZP290CA0001.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::14) To BL0PR12MB5505.namprd12.prod.outlook.com
 (2603:10b6:208:1ce::7)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB5505:EE_|MW9PR12MB999208:EE_
X-MS-Office365-Filtering-Correlation-Id: 6505b22a-f1cd-4fa1-3834-08def1688c3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	cYCOQ0OrSpOKCb3GNCk1DXWWTBFFEg9J0G+4RNFFyNVcK7gGvp1EYJchSsniYealnKM9o4yrTdDOIUrKzSGJniNaYOQEx2vGRAbmUfw6re9RYxf067hImgMa78Y6KsnHDGX/fuZuz/WpNwB4GldCUhQYjUbqaux+QGKilWjVzQf+Vg5/PRgAYBtLk5co/xoBCeJBl9GBx6mC5rsM26R5+ERW9CtsawQOHvfWCWXz014Iyt45lYrmCbvC2/i44Cvozpu8ia4poH8/am/MtTdoYBJKYRJqbvRAnlBGtOUHB/vOLYds6jFmupMPPwSx1P4Xsm0YJfi88Cwfju+/v+z0QmudJYqhFFAyYknf36OMbatp7D6QRRid0Vhq0OP0DK8cjzAay+fJuCJrZBi9Oe4x49nksBV/u1XuSsRM/eCLn0ZpNfVgj6kgvHxkcPtC5TIMstja6M5DIXkhCkijfAvOXCqNylhRc//XFhcbCsWYEKNhWGMVZm/e01DSFwa7M5ujVIYVzKF97Vhm76lmNm0jG95HWYrAqR21bBOEGnoDwKVv1A7pO/R50WCrxnC5aFBDv5MQuvtTzlb46xBb+2cxXZXGPBc7ANwH6FN30upQgmIxRdGn7eJWgSlyseoStj/HgZveR1mDVC16Dx17v/bHzaanEp2SVzL7j58L6Ma4cgM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Va9Hf1RHrdTe9Xs6L29EjC3QyeSWPsRIM9v/fgRTBnOLAU8uOQOVdyVBKsqh?=
 =?us-ascii?Q?+VfQIv/8JFFQJa2mLiwWdV1D5C8vlNcYyTDHqYHJcNhar0z1y5CQVVxD3HGE?=
 =?us-ascii?Q?Y+SpLQxKj9APOexBkzomGh1gYNQ8uB6hmX3CZrwZmt3yfzg5E/Yz2/cSCOyo?=
 =?us-ascii?Q?g89Of1Pwe0wfkKcgFE6Zt0+bLh38Dh39Q6UCFfo324bb5HXIG30Uj9xtPv+s?=
 =?us-ascii?Q?5smcZRK6GpFHmWO60gwaC6J8QC9q+Kkn4C6rZ+JPDWfrm/4/Jx6qMOKA7hvt?=
 =?us-ascii?Q?I4yRzNNJj707XYpZdB9eHDGuCi6+r12kIpEuRV9hBLOOs8Wu1b+9W2ZySRba?=
 =?us-ascii?Q?S7LOjvOOVasquSHxIwKj+YWGexzm1GG7KbIepOzxMUfMQM/yurlC6d6IBlLl?=
 =?us-ascii?Q?puONaXGqYdWBacrGzcqDuQrv4vvX+QVM+xFIPx4uNAdRNA08V+fPdhs9sefF?=
 =?us-ascii?Q?1BOv1v3QCxYB8s4jE1veciFRClQUD4et7ieb6/BF+02EkBy+c3+HZNI85yP5?=
 =?us-ascii?Q?FdKM7mgmZwltXepQLytBXtBs2tmcJBuke3KAXOuIchV5GOMp1ArdAIGoPQTN?=
 =?us-ascii?Q?o21ZPPh+g/XlEz7aXUeiPbfTao9CWY3nDpOYlfL/rZgo+5z81isFHUc0MtWQ?=
 =?us-ascii?Q?4N0MbOizyCdB22ZcRyY91LmGJMw0l9hLHX6JzZxjD/GC2AKG9ACBeSB1Zilh?=
 =?us-ascii?Q?GaE/6nCDLX9fcNzJY5sSmhXiavsnnlFFmjdU0byVmat9hJpWIu+pvwUrTOk6?=
 =?us-ascii?Q?8ClRRMzmAdjx1ZJHllLCUHtYRGi2KwsT1NQGDzsSjrdo8rwGeQg7gTALGYGR?=
 =?us-ascii?Q?CdnKkpwRT8NA8VJ5mo35lPo+BJFWQv6cuVZUd9rcUguu77AcfDHNkTNFYDi9?=
 =?us-ascii?Q?GZsBO06b4mBGqixGBhUBe6odK+YODrU26lEGncx6KdghPTCR06/NC++MUjAC?=
 =?us-ascii?Q?lYelULAvT3Q6nIP/FHjVvQv8+RcsnaJbPdiMkl83SUP8N1x6Mi+evSJm3OcH?=
 =?us-ascii?Q?EOn+gTQseiaHNT0d4p5xpp80U0wLKF7gcgIn2s61cZlos0R+sV5CWunE16WD?=
 =?us-ascii?Q?3nx4mMTQqe9WX1gpLDtFgrbgkyh6Mkn6dTtAKXy7+0cGdJlHF/LIOviYUnyc?=
 =?us-ascii?Q?H5hH4jF27x609m4DWHkdjsItzZkw2PV3qELSzmMj88H3Qc/KaC+1ExDDYW5o?=
 =?us-ascii?Q?CUC0hssVzzjvb2nlu4P4nu94H1h/aMTRzWHSmQZzNKY0oz7e+COSgoB3nrli?=
 =?us-ascii?Q?0MzljnZiF1XAOML2O083cT+KawCz9sVhwgKcnkPbu+V9PoYXoBevMkvlki7j?=
 =?us-ascii?Q?4D8stIrZtIESJ8hyDCaNoAeJb3VmxkzFNQcvC2Ci8zUx+6ZS932/CQlkvet8?=
 =?us-ascii?Q?WBvrQD/FG7sXIqWpGmTbfo4vAjGGJnPk2I1baZUiUxTkyxulWw4i3LUBC71k?=
 =?us-ascii?Q?pX0+0F7ZUF320hXFRfA9SWvwpxTiHILIesn7SkVctfV1Uh4ChP9JrC3Gdrjo?=
 =?us-ascii?Q?BlzhqWWV4q49A9ZM36i+82EnHcSbbwW5IfKE8o2rErbCFu1UFdm9UV0NJVcT?=
 =?us-ascii?Q?/mEExYEI0KzWhjb+2Y2qdBCzs1khzoh1hr8YOgpztQ9yH5OqZQ4qenRm3mX/?=
 =?us-ascii?Q?wFmeMbWKd5zdGUby+diHcu5rXyCN1Xjvq/vioeXydN3nM3rFAX97LwyFomMo?=
 =?us-ascii?Q?zmOVpVfF2TdYXSgX1lDwqaRP+V+xCaaTm80a2tcBxJX7RljgJ7XzczkUaT/o?=
 =?us-ascii?Q?G6UxB8MitQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6505b22a-f1cd-4fa1-3834-08def1688c3b
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 14:07:26.7833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r8EocDjkT+L1SbpgWBiuaryeLOhxUYrmSzFeNazBWS89RJFxmOYUFi71ACBBhPZhpHsgZGCQtJx9L5cOgM/QnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW9PR12MB999208

From: Daniel Jurgens <danielj@nvidia.com>

The cap ID list can be more than 64 bits. Remove the build assert. Also
remove caching of the supported caps, it wasn't used.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
---
 drivers/virtio/virtio_pci_common.h |  1 -
 drivers/virtio/virtio_pci_modern.c | 10 +++-------
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
index 8cd01de27baf..fc26e035e7a6 100644
--- a/drivers/virtio/virtio_pci_common.h
+++ b/drivers/virtio/virtio_pci_common.h
@@ -48,7 +48,6 @@ struct virtio_pci_admin_vq {
 	/* Protects virtqueue access. */
 	spinlock_t lock;
 	u64 supported_cmds;
-	u64 supported_caps;
 	u8 max_dev_parts_objects;
 	struct ida dev_parts_ida;
 	/* Name of the admin queue: avq.$vq_index. */
diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index 6d8ae2a6a8ca..ef4a64eb9982 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -304,10 +304,10 @@ virtio_pci_admin_cmd_dev_parts_objects_enable(struct virtio_device *virtio_dev)
 
 static void virtio_pci_admin_cmd_cap_init(struct virtio_device *virtio_dev)
 {
-	struct virtio_pci_device *vp_dev = to_vp_device(virtio_dev);
 	struct virtio_admin_cmd_query_cap_id_result *data;
 	struct virtio_admin_cmd cmd = {};
 	struct scatterlist result_sg;
+	u64 caps;
 	int ret;
 
 	data = kzalloc_obj(*data);
@@ -323,12 +323,8 @@ static void virtio_pci_admin_cmd_cap_init(struct virtio_device *virtio_dev)
 	if (ret)
 		goto end;
 
-	/* Max number of caps fits into a single u64 */
-	BUILD_BUG_ON(sizeof(data->supported_caps) > sizeof(u64));
-
-	vp_dev->admin_vq.supported_caps = le64_to_cpu(data->supported_caps[0]);
-
-	if (!(vp_dev->admin_vq.supported_caps & (1 << VIRTIO_DEV_PARTS_CAP)))
+	caps = le64_to_cpu(data->supported_caps[0]);
+	if (!(caps & BIT_ULL(VIRTIO_DEV_PARTS_CAP)))
 		goto end;
 
 	virtio_pci_admin_cmd_dev_parts_objects_enable(virtio_dev);
-- 
2.49.0

