Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010019.outbound.protection.outlook.com [52.101.201.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54075415F22
	for <virtualization@lists.linux.dev>; Mon,  3 Aug 2026 14:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785766057; cv=fail; b=pUIIuKxk6EzNe9V+sWcQYYKHXAcUdErN58k0RJ6F1xU4GLPRdtUGiqrOaOk4mhuVrueRVZvF2QC4JRv1R23sK1hIqSJ4HG0LLkoPWZCJRCpfZeo1MzYlubsw0aumaZHYqEfofYJ6xSA2guUuV7mqDN8PArEs02kU5KguvMMwJoQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785766057; c=relaxed/simple;
	bh=onFnbMdyd9lKko0Nexw8cTb24Sr+QiGD7cpDPM7uY1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Pg2b5duiDquYMkl8d9eGYDRVOPydEIu+xz11bEBzTbZGk5Qf2nx3a4zQMGTW3g8i4SVaU5rXHcSSobdUi8f6tTHlmvUmr5gCyN8giJnSPu3sPBa1P3HtN6nwkncNOCsPfnMZTLNihsvQZpETyVZnW/n+fr0gDqamrOoUn88P9mo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YhF7E2SO; arc=fail smtp.client-ip=52.101.201.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YhF7E2SO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JMtzo8EYuGy/4PUgVK+TTOdHCmuZtzyZ8sBtfmRGXqKMzCdGsorJGGnzNrnCnzXswJna7FlViUWZt8dOMYEd5eFTjPUecNuYGjlroBeJOFyMTT2+ZuEkBLe6QMTYzKBQUpdp/c22lnuCIoafO2NfWdyBUCQGdLfuxyDBTUQ/69GlpM5nGIqV+KYLOLMuEA1n/WzRV41DkPlm1h7SqhfQoZ9KeAdwqGXwHlJRPksbk/SiUILVrbv7W/EvjIetAygNLMR2NzEv+8sO5KlJX7qStMHlAZNZdB3CCvJXFzVhgVxPJNb0zceB/UXxtd9D9wGb56qc+NsenTCADgNezAHobQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TyHuTvEpPfspxIPL1yNasuNG22X73Q9K3lyNQdp6N8Y=;
 b=WR+vOaHeYadyCh/B3Ul3PSoq2MaGl/LSvS/8+E7FLaNUIr6wRFPzAq9XrlSWH9UGGpOcak0nRB5uhWEX4hy48n+y9eJuXJ04mDArfxLW0yPk2M9ji04rG4HnyHKFHoXwaQggeDM2wfqw4tnt2GlcVR+MSJBVpb6M4J3sqMed7cAS2lzUVebQ9QSlLY/Cluxehq+Hknojc4i7/Xq2YSQIXRKxZOoDjVUHPeifeKyQDVFo8p0Dw0wJtfZE1AmXnnArxS+/H8dcia9uXZbkrznrH74c0bVwYy19hMCHlsrQf4LJVNeyk+4T/+mHV6/S5cYWpY26pWP+mYlC5XT+VhzFEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TyHuTvEpPfspxIPL1yNasuNG22X73Q9K3lyNQdp6N8Y=;
 b=YhF7E2SOZPDM+zJWLjSJ57fzslcRCy7W+LgbxnbSASN+oW7ml5Z6CdOTGRNain5WcZ6YfIySq9YDlkIxNVU6raALM4GRNrZlSdkUDoKIDsLjjEJ6om5ebDLJ89TCRJk3KD2ilqbKzEXOPwOz4lfbOmm/STpx2zF+iuywyOhz4dfpYpMSW9g2jhvehk5gXPdAJpMYTiNlpodtYLaPcZNuS42Idb3kLvS6uaegRysk68Q/hIehgZ4eJgOGFYMffgXrFgx/jMMXdfofOvfxWmyQCl10Rd+yb8zVT5CVDMMtf5s+lUs46m40zkki0tNvDMx/X6wV23CX7mYy6n0rQPPfTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5505.namprd12.prod.outlook.com (2603:10b6:208:1ce::7)
 by SJ0PR12MB7459.namprd12.prod.outlook.com (2603:10b6:a03:48d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 14:07:30 +0000
Received: from BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21]) by BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21%3]) with mapi id 15.21.0270.017; Mon, 3 Aug 2026
 14:07:30 +0000
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
Subject: [PATCH net-next v21 02/13] virtio: Add config_op for admin commands
Date: Mon,  3 Aug 2026 17:07:10 +0300
Message-ID: <20260803140721.1871678-3-shshitrit@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL0PR12MB5505:EE_|SJ0PR12MB7459:EE_
X-MS-Office365-Filtering-Correlation-Id: 0545ddc1-4bea-4cd8-6a59-08def1688e59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|366016|6133799003|11063799006|56012099006|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	cPtQwjN21JXmML5Wh1ssAzLe9rK3evAZ64vQ1wZbfzyI66nGKy7T2iORhPBtoFIGS41lAuJkJIjaS6Ibvq0gAfPYmx5RJ7rlnQ1zVLHbOH9k7GjcFgdWIMaFJ7T8ce2SFjWFgoZD0mBo26+wrwOkOYuiWLX0uZ5bxP3/jzp/Hav8nk9vn7HD4XV042CqQ/0Qgxg749LusPXvmygqT/aiOBQtmtcp5pDySMoexMfOx5zUEaVDTySuPTUa8poOhQ+I/cE8m7XHC9Ji91gssEeBx0S2w62I7zd1r4JPDjpQf4/voIRXn5lbv4yJCbwNKadmzWGKHuaEFkalKR9Jd88Wm+6PQbqC+0yRa9fpoJpeO3JEi76rGm3d0Y8FZkRyYoG/2soQOO1Nxzp3bWKdesxClhLbr6dXEvhnRfnUFcUG+8axMeKb0XAVCWT+kvuNE3iLFczHr0fnriUvtLgEf0Q2Yw5ZFSY8Rsy8FHGDno2Ig6wENBWqQS8OJKZBoLR8rh/PxEClC8Uox4Z0Cf6zLiLc9TxePl5IqbZU5vBQloXSEvMyx5SnJ7oZQfKedFBm1+qUfc/cJbMz3j5OdR4UOCC2DGaJbwro+4ocwrVEYxhKjTpyDr7wxzXkyG0Q6sHnEZbC6/tsvBGHL+XiC8HhucCtktwzNMeQ5cCCHLB4WqNjkdE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(6133799003)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/PlmkmGyrDAiAUT49wJqSyhvAF03gjjdDUGXsW4lcM2d1G9NTwjLFh/aNsaM?=
 =?us-ascii?Q?QAj7nr+5DSlcQ6+3zN3Jui2jmdnmYf7AFZCcGTC88g3lk37iB5BqZtJWK4jr?=
 =?us-ascii?Q?lCDr3FJg3NgQpV94CsoFrRYj6nHoI7puUk8oPsivM0oqfbkYshMRNupgnxAW?=
 =?us-ascii?Q?YZyF2xPsRFKKFCq6cM619dQXY40jexLdETL8esXUcu+mzZ104MzdHSVCa+bh?=
 =?us-ascii?Q?0dzmqTIR8cisqzPo8zXNBhUpwv368FKnFb9f8NZPj2Wk898UWpVrLh0mNsPW?=
 =?us-ascii?Q?k3ITfc962h3KaVzQlxb50f73WFWDfEKj43mM1rCqLcBwRWJitxf5lbjVDMw7?=
 =?us-ascii?Q?nIC+rbioQWPBZlbtBT1Xxr5Zh75LPJWZDeMhdZ0Gk8JUPG94S+1+7ZO3vlFj?=
 =?us-ascii?Q?+hAqxPCJDgNmhgA+wEZnVH7sw8u9XYqEMqbyZ+Oc3PTh600xbor0Mq0yp8nI?=
 =?us-ascii?Q?u7c2nRZnVeBBQBvYuKMXRpJm+LZ/MW3MhVSCpuddCf03d8vH4R0Sr8rP8M/u?=
 =?us-ascii?Q?u52KO10a4iXuUM4Ym81Bkh+37YS9FUb1YAsU3MCwcqT0qH0RvGWB/YQ/hp14?=
 =?us-ascii?Q?Wl4wP03HvmtH0JD89CBI9fUS9/SQ4RxeMfeXtvmci+WGRa769QSppPfRGpUs?=
 =?us-ascii?Q?VfeqUU3f9WMAKJhmXHi4AF0rWqB+NGzLXqlB3orIp2zMfV60P+lvJFaQsorl?=
 =?us-ascii?Q?tmcfvulKRdg7YFhKs51OcfzllAg+wsZe8/H4SLIUYOQDtyuMHmx7Jshb2DQg?=
 =?us-ascii?Q?gwWTNaCjdMvMYruvT+/Zj+/HIVRvCvPQ5/77sKfEKeGq67qmIhwXh6in2fTm?=
 =?us-ascii?Q?TsnINU7oLszmEDYPy30oFu62oBG4cO1hEUaGRUq0+Nv95U6W6Osrd60sGJBc?=
 =?us-ascii?Q?iYQI2eRsCSvRAq5jfsKgOJHEJH4xqV3l2QH3TZdl6A/K2QzHTIfx4yeLKTbA?=
 =?us-ascii?Q?54A/FR3YWb/e1rc3c8IOucQ67V2OI8T4jBGiEU4n/5juEf0zPPxDRmCXvG+6?=
 =?us-ascii?Q?6DFa+M6are7Ozt1CTE5TuNQYspRlOg3Uz8SJpx8yB25EqYxn67IkRanFuUw7?=
 =?us-ascii?Q?kQTxIr9+IFkHq0eQ4EvQgjpCGMsIlkbxh5piJEneUg6VHwW21oQNw8LLNWxZ?=
 =?us-ascii?Q?4yryUIzsPHO/JWfQ9wHKtn7YGaJo3QmsN4gW3gBYG9N/4GRmCW/KPIGBaj9J?=
 =?us-ascii?Q?Cxh5l1WXQtUeTgmkaVGO/NJ6v584O/+F1H0ae5MChtheL+ciMZ1ZPh3huhK4?=
 =?us-ascii?Q?kgF2FJ6rD4tKZpR+qqeNSXle09uCeYK5O1mSrgYsP3J9GyT/cSk1BGqdfDVs?=
 =?us-ascii?Q?LixaFvBRKyFy07gp32FdPuQbAI+xI0mlBpsXGVIANJC4Q6g3DuZywIHw9LLG?=
 =?us-ascii?Q?346e8zMm59r0/uzCSLZUyBm54BqME2ARUFZWpob6o9MximRjavTvKfEDoD2I?=
 =?us-ascii?Q?REcIsbBlr6cV8cMmxkZzwkRywC0/Bp+c4UsuGpSEIfJ4uj5daI6ij4O8RZcd?=
 =?us-ascii?Q?rnbfpdWSUHJFmcJWuMXL0VZUr5+A8WH3Hd8Ie3U2ZLvXnnvfOb2QVHKa97Vd?=
 =?us-ascii?Q?uDlE0U6vxHCyLE6JYgdLKtoyUYjA4LD2nlw7dr2sYccOCvFm+8ypLzcg09S4?=
 =?us-ascii?Q?0pDOFzI6Fx0cLxXPJNFZd/I08WwOyMZHBdgBNTOueUkrPzsC2pepWe6e3/Xh?=
 =?us-ascii?Q?BxHT+OJEs6J5Cv44gcSE9F/OI74j4nv2brDaDrWZNEABxPMqnDk/LlSMItgb?=
 =?us-ascii?Q?Gi9+HrYTHQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0545ddc1-4bea-4cd8-6a59-08def1688e59
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 14:07:30.3124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cDYgihcNqUhXFCulpDHA5XmBhgOjrzloX7Hkx9egOrkG0V6xoCAU94Pcm7RTpGKJB3HX7Ic052OwiicY3JHaDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7459

From: Daniel Jurgens <danielj@nvidia.com>

This will allow device drivers to issue administration commands.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
---
 drivers/virtio/virtio_pci_modern.c | 2 ++
 include/linux/virtio_config.h      | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index ef4a64eb9982..a18683761aa5 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -1238,6 +1238,7 @@ static const struct virtio_config_ops virtio_pci_config_nodev_ops = {
 	.get_shm_region  = vp_get_shm_region,
 	.disable_vq_and_reset = vp_modern_disable_vq_and_reset,
 	.enable_vq_after_reset = vp_modern_enable_vq_after_reset,
+	.admin_cmd_exec = vp_modern_admin_cmd_exec,
 };
 
 static const struct virtio_config_ops virtio_pci_config_ops = {
@@ -1258,6 +1259,7 @@ static const struct virtio_config_ops virtio_pci_config_ops = {
 	.get_shm_region  = vp_get_shm_region,
 	.disable_vq_and_reset = vp_modern_disable_vq_and_reset,
 	.enable_vq_after_reset = vp_modern_enable_vq_after_reset,
+	.admin_cmd_exec = vp_modern_admin_cmd_exec,
 };
 
 /* the PCI probing function */
diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 69f84ea85d71..e36a32e0a20c 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -108,6 +108,10 @@ struct virtqueue_info {
  *	Returns 0 on success or error status
  *	If disable_vq_and_reset is set, then enable_vq_after_reset must also be
  *	set.
+ * @admin_cmd_exec: Execute an admin VQ command (optional).
+ *	vdev: the virtio_device
+ *	cmd: the command to execute
+ *	Returns 0 on success or error status
  */
 struct virtio_config_ops {
 	void (*get)(struct virtio_device *vdev, unsigned offset,
@@ -137,6 +141,8 @@ struct virtio_config_ops {
 			       struct virtio_shm_region *region, u8 id);
 	int (*disable_vq_and_reset)(struct virtqueue *vq);
 	int (*enable_vq_after_reset)(struct virtqueue *vq);
+	int (*admin_cmd_exec)(struct virtio_device *vdev,
+			      struct virtio_admin_cmd *cmd);
 };
 
 /**
-- 
2.49.0

