Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011012.outbound.protection.outlook.com [40.107.208.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D2B3C76BC
	for <virtualization@lists.linux.dev>; Mon, 31 Aug 2026 07:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788163096; cv=fail; b=ISDiV5fvepAwBQlpa3mLH/4eMSHIJUaLf76t6BPSIQGwigl5r3m32xVjRnBr6ARRH5Py5aItg+eR5C9+QkhuiT0wbTzWu07vASgKphaJhj01Wktx+QmdSOZz1V6L/QKDxnvb9pDvPnsIk5+bvp56uCHjgqx3rp79N7nloNlyPuc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788163096; c=relaxed/simple;
	bh=jayR55tE50PzgiZZacQjgEEUuTAyLLaRpclfWJkSFYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eOtjGdUdaUt6/X0JVSBUlVl9EFV8QNvemjIYqk3egKSqXnyk2b0qM0DsBXLIRzE7YgtTFwu0I7fFHNGIc19PIsSGlr9CEi0IJOzkN/ATG2RbD9ZloKLo4NSPWDGLIFAJpalgE3/9eTuTbVNtISOQ4UtaZPDq1nDDAjHqzti1/Cw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YHynKNEk; arc=fail smtp.client-ip=40.107.208.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YHynKNEk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TNCDU/PpE6QUNfI59RGxEZAOjNU0r3JXt9Vn8sddTxQ7JeSKLDHypcZwinHRGISjo7Na55aFghfQdzpaXlGcJB+Uv0MLMdc2NINuocv0LvbjyHXZH2aMVZj01RDwQ3lh9/BK0la0teDDec2jHRdNfPo6Hx65WDgqq7wfFjim7TtfpD8Nh1LMpwJYZNRHaGWXntC50hoXjQppG3uHXtRLU+1dzR+iE1eO5SIdsBMVbnF2qU+xTQJoWzyNWymCWBI+CO5uuUXGhuM29C4jhLodrFvB+EdqvWRLru16iZGbg10iJFZQKJgbhhbCwMTelvDqpvFLtUenEHZAhqGR2e0PXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HLlYyJ/D+hsAZgXCKxOykXEhynWchWO8ysVpbEBwxPE=;
 b=IWy3YyN2F0N972YPYDSpnXXAk9tiXSAnVTYk9Vns+07DoDFIGC5G2ExujLi4k40XYGepBj1Am/PLxGRrZ8hw83sAQvMrP23yTM2yW3mEoRS65aHwWZhvzWaYSoKKUWTh82o4nJbb1PwB/BMDzhGXfo051hC2BuFvZK9Alh0xgVWAtqrgsh5dQGp3PdoA2n3l+XNlKl1NxJx6/Weo+MfD9yJceGmjCs5zr4YU7I/eqq/JSfGng4Z59jLcUbPMnmN0VG/I9dCoK3eRebHK59MHQV5St8uPP+vKYBpIrVevMxQ4ceh4hAZZrYQFhHCjCfq+3lzVDMT9X5Qg90l2tDAlPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HLlYyJ/D+hsAZgXCKxOykXEhynWchWO8ysVpbEBwxPE=;
 b=YHynKNEkxjo78QNyJK1PWIC/r+KvfinLYC+OvFGQv8IPvWd5B/g5ETJ8UMsQIpmDBOLc7WAL9oXyhX6G5lphclrGuoQ3foQyoZDnMeNsZAMSjc2dSs7ecgQArami63q9lzRDwfhZTnL06bpC+zXryqF9cMJgd3Y0FThLezokXPhJFngrxFuXYBCOpBXu0lUasGcCclBjiXd9Yh3lk72cKTbLvasn8M7PtibpMWsCWHi6SownpdFWTuS0T8EaIcdDnN73pSZF3aUft6LCApPS/6mHA5X9StvXD2UODO1rFCbNPnMRcCeqLn44WxOqjiEzMvHe4UTLiCVpW0q/SSChog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5505.namprd12.prod.outlook.com (2603:10b6:208:1ce::7)
 by SA0PR12MB4430.namprd12.prod.outlook.com (2603:10b6:806:70::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 07:58:11 +0000
Received: from BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21]) by BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21%3]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 07:58:11 +0000
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
Subject: [PATCH net-next v22 01/14] virtio_pci: Remove supported_caps cache and build assert
Date: Mon, 31 Aug 2026 10:57:54 +0300
Message-ID: <20260831075807.2891426-2-shshitrit@nvidia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260831075807.2891426-1-shshitrit@nvidia.com>
References: <20260831075807.2891426-1-shshitrit@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0129.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::12) To BL0PR12MB5505.namprd12.prod.outlook.com
 (2603:10b6:208:1ce::7)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB5505:EE_|SA0PR12MB4430:EE_
X-MS-Office365-Filtering-Correlation-Id: f0452752-f53b-467c-2ab5-08df07359a1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|23010399003|376014|22082099003|18002099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	n/bly2/O2Uk0wG7gjB9oEtfmCPfFL9k3U8BHZVoLJWykxU39/uBR0kyKVXKUsK3GTPaPylcFxOM4O5YGKQIjRVbLjXKDfTVxcjE8FSBu7B/YiT9LIoUVPMRvPG8NhvMs+IaS63k3XYyLmOTWK07HnsnA+JQVzUzKQAXkJ4ZtdfUDGQzCMf0z9/XX4I5nNl+MPaVV0bhFjmbRP1AYEKILS+HW2i9Q82Fpu9D1CHN/tbtBF1vVlAqoGjrufIWwO3HFKiShNPDu+A5KL4K56w1XD3xE1IbejmsnHVaWvm0kuKP12JoDCgaAcihV/dWl8DuAIi58Cz6YZCY8V6k1B8lZ2tO5pfbdhtYZCaWJVoG3zXVXZ5QEVOet3QDbptgfM1E9ElfE6KOi+t7eXh3AKjsyk24Yd31iznTHYDgrYZraC7Gz3woIP8/LM4Dmi64bcMZOZKOPxYp7vVXVnJH5AbNRAi4HxgGg9xiKE6vhRn8Q2npQK/ENeYJiZA+9VsHFI3uSss50qUx56+N/lNdgtyw+X8UWxqQqZs73CImYCrPlm/z2KkcQKu5TUERktq1OnvMH1tTGDx7G1o/J88SuWHhpv35NH1T8OeW213awhHXaHrewTq7lERFjc4kDIwtQ81uO+1eDjxGEzkWNp95PIEjpnN394+Mrn1WPywUt5l0HQZs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(23010399003)(376014)(22082099003)(18002099003)(56012099006)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?llVBs4hEpMf2CsFQ80ABrsDNQ25nMjJPR2ltCXe2aixteD1q5ZgETb3Yw4N5?=
 =?us-ascii?Q?iXHpFCkaG+boEfQTy7Xr5QCGQl3pYbNBIbN3ycMIWdhETu658WP/b4aLIomJ?=
 =?us-ascii?Q?4H2POzi1cB6dnA0mzvinY9k+iVXeJV6Pd7v6E0YSG8WHtYZJ/vC7vYjHLeR/?=
 =?us-ascii?Q?/rbvzUS5UwJnaMVklQA5IcZV8RG///j1ULFtOhMOReNd7X9aBZCUiP3krKLe?=
 =?us-ascii?Q?2vEob6PBT28wvcSpPUDtZX0Ioekg6QHwp9WlmXxy68IYsAGw9PydO71jnoxk?=
 =?us-ascii?Q?qVOQ/2ATORS4RWDG1iQ+GWEdUTpRL3rMHl71yBO1saskE9IokrL+E4UvnTiS?=
 =?us-ascii?Q?gyg4A3B/ax1kQWb1nWdumFD8TwOIakX5NNirO/P8pOgdHwXLDa70w4n/4kW4?=
 =?us-ascii?Q?kysVqo10yeteCgqh/7KEuAHnW75eZlx2tT6lbtR/JrlZg0PndIUZlcpujOVg?=
 =?us-ascii?Q?FSMYuMKrEDOD9Eiyd2IPVdu/U81DzWRaCHNUrUf42Sc3fQYcsgXvez8P9hdo?=
 =?us-ascii?Q?ydziGymdT3Rjt8ivvX+37SEd3fcU7M5P5RtEJiw+1F5Yon/J4aMwgbj6stxz?=
 =?us-ascii?Q?e1enFcaqBx9D3rDHqWn7O6XNzHckAbBp1GtSr/Y6Pq67Txn2lEqlYfXjWem3?=
 =?us-ascii?Q?mMlPSsgtSrVK0duv6gyHprOhuUDuRGpGz4+y+ttE9KcEiB58nBQDN1RsocF6?=
 =?us-ascii?Q?Cp/XiwGWMJZpFGd3obvkyo0KADwXlNo3z6G5m/76cAHqF/Ob5xV9iGBctSL+?=
 =?us-ascii?Q?+rHC7Q4gN/wVo9LI3+hVRTfFJXV2XlKPCP1Z2/iveKdFD7jZprr+wAbnxb3I?=
 =?us-ascii?Q?LeLGOAdFmEkms45m3rRZu5GF/Kc1f4er7JI93gby5HabhEL7pcKiUgSZB/cb?=
 =?us-ascii?Q?2ApxUzAwa03zpvXXaP/PNe68FqaYEVT+JDy2+Xccm40x0wDTR0o793E1ZKAh?=
 =?us-ascii?Q?O+QCMzSAb/va9vpETBA1Ly66OTyQ2WT+y6ZXA5yOpVVFn/hnfXafWoscOLDM?=
 =?us-ascii?Q?SJH7xbliQ5JMX8Mkx9mdbeN0D71aBc44cVezRHqaZ6QRF2TrlcpxJfVHsvd1?=
 =?us-ascii?Q?6+qNHvREa2gpkwkNdE47/hgsExIWRKuAgsDRUlbHG2vxy0ylF3UKTMHIrFsf?=
 =?us-ascii?Q?RoBhg/lhiX4SHjYTAb8OS5yFDdWKDrTr5sGIOXS89iKywYsXRMIZNWZOr3sV?=
 =?us-ascii?Q?LZ9cx0KrIuqmcIuAv1YJn7zCw4KpHiY75rTcggUh5HYiwB7oybYGI8XJvGDX?=
 =?us-ascii?Q?ielMRx/knZYqsuW+OU0eKI+JBzi6gZwOGaLRXRu1Et92OcuhapQx3pDNOXPW?=
 =?us-ascii?Q?EQUSSSOdnMN9MhHbtDgFTDWMt663vpL/ZV2n23MeYGUNcGOY9cQ8hP6BrPWg?=
 =?us-ascii?Q?cIdwLHn/5qse+AW1Oav8Tj+hCV/nBvAiebBMeX9LfAkGC9lbYqMyoLq19nXY?=
 =?us-ascii?Q?8grlR0Udw7oq/o4seQh/qI3d31DqD3V3kS/4XYzu703AWEG9qqfDKYf+/hNS?=
 =?us-ascii?Q?VGQ+f6GF+zyIxYz/YVhGI/e0JEjKHTbXUEgdXj4OqIaETT0PkSEP7CAwKmpH?=
 =?us-ascii?Q?YZehL6mRunOWVtPjWlghqYn2l1aTuBSSkmfxJ6hHPNBFQ7aUoB0EQvn3EwAO?=
 =?us-ascii?Q?B3JaXa920G0lGpVktWwXkd/b+vOwI7BmU91T1dIYR8cYZFJEYlMnqop+YrvP?=
 =?us-ascii?Q?qIetZP/6BPbWbhDOZeV6o7mnS1DLq9hnnZV9edF01W4/V8M2WxVyapYgZhmx?=
 =?us-ascii?Q?jHLwljD4tw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0452752-f53b-467c-2ab5-08df07359a1d
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 07:58:11.2048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eg3Io88maHYig8tfrmRRyOnYRGxuYqDCTbt1hNFXDWdCUL81TkLVq7KFawi/u674blH/P1spsHJXT14YHawpog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4430

From: Daniel Jurgens <danielj@nvidia.com>

Following patches introduce capability IDs above 63 (e.g. 0x800),
making the capability ID list larger than a single u64. Remove the
cached supported_caps field so the code uses data->supported_caps
directly, transparently handling a bitmap of any size. Remove the
build assert that enforced the list fit in 64 bits.

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

