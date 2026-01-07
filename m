Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013007.outbound.protection.outlook.com [40.93.196.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4C0357A3F
	for <virtualization@lists.linux.dev>; Wed,  7 Jan 2026 17:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767805501; cv=fail; b=DulMcqYO2W0/oymOfcbW3UYYFW9TlbjjizaQyq9CDCghD+h3eEz4P6oIsSiQg+8hoAv/XvCtEpazz+WzsDpQsmaXQLdJwW22yuFiQtGrHJEHBtaeZwA1S55RTFZrfgoKbaoUX3GjB1kdlWHzjnWKVUZ7Ixwa0tyNtO5CirrIHyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767805501; c=relaxed/simple;
	bh=rV+BYBScHZrwQo5VCoLAB9GLWd98W0R5QYE8DpXG300=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xhdz2Q1f449y3Tk4zkjA8K9OcZVtm91uprc+PCrpfKnzuOjCprTbZJaSqIVxlWwLaSK1wQU29ImXzrL5unSAmkqp/yi+HxmPiwsrvdixsGs9QDOJahlffV1IKOGmYy+Z4S0P4p8jBGgtEqdfuxm4EZQJYzG3kDRkXmHepMHXS5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fEGzxN/i; arc=fail smtp.client-ip=40.93.196.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fEGzxN/i"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PrtVcWGDpMxCl1TIO+9Nd8qOYxXdeybax0KImgNkJ20sG8fLtANjVrvWf/W41LYIahI9FMzDOKZ3jYhmOl+1AORLeJUr+toO5TxImeYDkxJUiLPm3wF1VkuU3e1CTj8wm3FRS9zXM+w6Nrn1c/3etNf4yrLFp1411LO0/mk4rv1EkOFKfhHj6Zk7I1YY9IUZlBAAp78w5HPGL7hHNSRlVACGzPN6ECLxep7+7EadrZTLphBd4HsfM0nf6MXxHwQneoI/UCZ7aGguDstVu9t074T+0Wpk43c3qUyCGhMgyc81RnHXq49KY1m3oe1EPb7402W1G0x3YDQOLxK6OTMlJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R38e6nZvYGCaJHSLMq/L6GLkbMDDeQI+wiK3nJXoLUI=;
 b=xacJvKbyxBTZRrBzOU6IXPY/FnhNV/ntIPs8H5iHEGARcyowQNH43c1ecGsJQ9lMp80nIXZUYjPsBzfyTtlO0s8RZLTarDGJ3g4YrIZZ6M43JFe42YXJAWuFGFONSecOQAlWBhr4ygIBrTZAp8tQl8GC5TOKA/yN8AW61uDNsNM9Oyfy+eHckeirmydYfUi+jD8b+tTb2W2vRxOwhspkHPjn5TOJ4rEkx9WwR/GfLM1yjbz8/dzxDjMsTkxMsGiX2BdCH0m18gGEKdp5wlvj+EiMjvkJah05Mo5Vbrg8mLwJN9+PVL4d6XlOKsSeYOcNTsYkUY1NsFxzhjCD6McIjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R38e6nZvYGCaJHSLMq/L6GLkbMDDeQI+wiK3nJXoLUI=;
 b=fEGzxN/ig5x3ogx8vfMq35ZThL20Jp/+tlL4wMNfXYdjEwDoc1nheWlCyTQ5ottyFDlYSc09fBJZ5tEcO1sv3lguQonUh/yf8iF2LfTCvPZm9OmGyQvzIIB3vJziKzMnWQfKkSOankVyCt4rKCCwl7fQoP9A46dmmnVtfSA48ah/1qxpdOB43bGKfTPHKZuh3sagq8Ax+qqsic9CAcT7eZkO9ElBuDZF5oG3s8aDk433BKq44gPAMW6xrdAI1EsntaZQaK8len1gcLppamSR5JSyfh/F7PGk8OYrjIH0OgjZ1ZnthGRInnbdFNw6TAxVBbwwrS5Z15Y1IUUgUCdobQ==
Received: from PH7P222CA0016.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:33a::7)
 by PH7PR12MB8037.namprd12.prod.outlook.com (2603:10b6:510:27d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 17:04:50 +0000
Received: from CO1PEPF000044F8.namprd21.prod.outlook.com
 (2603:10b6:510:33a:cafe::5a) by PH7P222CA0016.outlook.office365.com
 (2603:10b6:510:33a::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.2 via Frontend Transport; Wed, 7
 Jan 2026 17:04:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000044F8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.0 via Frontend Transport; Wed, 7 Jan 2026 17:04:50 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 7 Jan
 2026 09:04:31 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 7 Jan 2026 09:04:30 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 7 Jan 2026 09:04:29 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v15 02/12] virtio: Add config_op for admin commands
Date: Wed, 7 Jan 2026 11:04:12 -0600
Message-ID: <20260107170422.407591-3-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260107170422.407591-1-danielj@nvidia.com>
References: <20260107170422.407591-1-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F8:EE_|PH7PR12MB8037:EE_
X-MS-Office365-Filtering-Correlation-Id: f1bb8c83-f5be-461a-fe9e-08de4e0ede9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TQ+IVEHj0BV/BRiif6BHtgl5ZitvlJ9KgJoJv4ME8C+0r+/uIIXB5TrqxYkT?=
 =?us-ascii?Q?QzBKGU9TreatI208JhocFssE3C2HskP7ccW4jhT1lhkD9qZQyzP7kqx0jkM3?=
 =?us-ascii?Q?ncg/EdSjNDUublY0pEkgwMUsStZWNrm1juXbhLyk4Ug1nEkRVwSdkDgzlfHT?=
 =?us-ascii?Q?fL5Gj2FhifuVnkbDpU4LLb90o/SVpfGMO3qudD7HYfiKsndE4DJegPcxfUKs?=
 =?us-ascii?Q?tXNhDdzY5/h8noPWaeJCNUys2j9E385EyXnZ5kSZblLPZjrJX2gA0jzN92dM?=
 =?us-ascii?Q?JJayPFCYgombsUJ8fnWBo3N2DfTbiPrD2hk7PbqG8YO/KAuWOY6Qy/1/Akit?=
 =?us-ascii?Q?TMygScdxfB1mG8jCcV1P0004TXTfKyJFyiv1XyvrBSkMLRx8GkLrl67ClLNy?=
 =?us-ascii?Q?deF3DycxoOggnDo+oXOu1rmkjmhXC92N5HLU9srLebyCgSOecopLgdm4VFdW?=
 =?us-ascii?Q?3PjxRii7GU/PVlbj3zlrpbdkSFN8xFqkS1DrE5yoM8Xi6trrmB8ZaZfgCfhL?=
 =?us-ascii?Q?AW37pxdaJ6cy9rT5gQsLzc6/6X9J6LGesZH8e6lw7LGGTNJiUwoPWafD9hCQ?=
 =?us-ascii?Q?OBLm5P2jeHzJ0dkyT0RXtVpqjluJVVUHTXTSkCJTxn5AyYQC95X6/83R2oiU?=
 =?us-ascii?Q?2VMwpd41jdwnTZfdtWJatJLwBv6jM1jQEmNUfzqhEDn7CQC3JVnVsvSRi+g0?=
 =?us-ascii?Q?cK84LZEWX+Ec3/i4pxkyUTTQKMUneml2RmyKryai2HsW9M2CEJucLatRaw3t?=
 =?us-ascii?Q?qyUectK2Mm66Zxrjz0EU4perhyXQQHAsf/clpsOQdvGWNZnCUvIGn0ZZ73PN?=
 =?us-ascii?Q?ju+IWbmmiDeJRt4TdYbWslIOncneuIAnvvPOTQmKpgEgputSaGyuElTEsUgA?=
 =?us-ascii?Q?84QrhhDQBg/BTp56iWik7olN4lJmUrI0koo6OOks/cUmLBLamTaHBH2mcP8G?=
 =?us-ascii?Q?hku2hbUiqAE19clPfnJp42P9JBQWsjsfKGUIU61V9jfeZp4T13+bkjfXYoot?=
 =?us-ascii?Q?liUaNdCygn079Fr0sEHqaUdK7qSwP+y8iq/TAM8zcKAQ0QnKTL5DN27Dekpc?=
 =?us-ascii?Q?bkh6JPXcWXsYhP77mKQrWtCfIHfvKsAbQCh/O8tVDrI4pjK1Cw2QLW3dsXlj?=
 =?us-ascii?Q?E8v4E0rjMraWXd+OEbdkjQRuY6SeMTPTEX+3+7kYsnHsulkRSu7Cl0c8muSJ?=
 =?us-ascii?Q?s9q77UIZsG9KNuD6r6o8ZDGS5CfOTYOsILh628GxRGAQ01bVMGr9xmU08qEi?=
 =?us-ascii?Q?F0UhCMrxZYcD8FQCzQnQTdEFl0BS85lgKaBi/S/fEojswGFAA4GIqeGnv7J+?=
 =?us-ascii?Q?bYstpl/P+snXUEI2Uv2QmkAs3O+7ZbV4YHwa9ZZfcZ+zytVtgs/m2kgEy+6W?=
 =?us-ascii?Q?VxGwXUHdlN8eOm+EyVRLq1TjObjVKB1u3ggEI1C0rJqQARqG2ffnB+ERQZJL?=
 =?us-ascii?Q?jXqteWS/Nsgsh3edOkI41LxFL09AkitDbv09CIlloCu5kDuNjyFEt+/1G/j+?=
 =?us-ascii?Q?7Al2fnfB5WJM8UzYtYjNafjle08tgq9NJy766If8mmCfLb/TgMSf0esIWm32?=
 =?us-ascii?Q?/OP3JaWskFrvbzCT0mY=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 17:04:50.3526
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1bb8c83-f5be-461a-fe9e-08de4e0ede9a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8037

This will allow device drivers to issue administration commands.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

---
v4: New patch for v4

v12: Add (optional) to admin_cmd_exec field. MST
---
 drivers/virtio/virtio_pci_modern.c | 2 ++
 include/linux/virtio_config.h      | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index 1675d6cda416..e2a813b3b3fd 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -1236,6 +1236,7 @@ static const struct virtio_config_ops virtio_pci_config_nodev_ops = {
 	.get_shm_region  = vp_get_shm_region,
 	.disable_vq_and_reset = vp_modern_disable_vq_and_reset,
 	.enable_vq_after_reset = vp_modern_enable_vq_after_reset,
+	.admin_cmd_exec = vp_modern_admin_cmd_exec,
 };
 
 static const struct virtio_config_ops virtio_pci_config_ops = {
@@ -1256,6 +1257,7 @@ static const struct virtio_config_ops virtio_pci_config_ops = {
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
2.50.1

