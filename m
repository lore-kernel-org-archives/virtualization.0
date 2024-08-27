Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5161C6F4F
	for <virtualization@lists.linux.dev>; Tue, 27 Aug 2024 16:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724774614; cv=fail; b=fe9X/4CiC/V/5YjhgCJrTeWYRxcvKGB7w7yDZVGSGkMQqZIJFU2E199ewgsoh57VvP3VwtX93m0HLyZbKYUPqKKxSMCWKLAV287BNShTLYaI+O8/FNTEPLKzgTyrDx0E/I9iLDucTQjkYHONv0XX4YFs0SM4+fk9EIrQBl79LmY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724774614; c=relaxed/simple;
	bh=E5beNy1a78Otr5fgeW10Hg8t0FTBRQX9bKySDnikgg0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Xp7EnZ8oa9OcfpH/WR8KdgTyfnKs7wx9fr/J0Rw50JQ6QBL2SY0DkVJs+J/I0glRiFLQ8YBkJA/waOxICzjn8HmrD6Xv19Hgx0NVTE/N5bPLM5AVQXwVObMeoKnpodAphv99ERaTmKMlC9Y/D5TjrVInWnKNToHuR82pKJKBLS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RoDhZHF0; arc=fail smtp.client-ip=40.107.94.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RoDhZHF0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t9DaZY+WRBM3Iiyf6LUYC3LVdKWd2L2GCgHvkp85KmIx9CLz5qlMcOzIa4NEk9RmeCUw0WZd0FMLuuho6hnXMd1XQtyenoHoIr/3RLhztF7Zr5pDzrEVWihXpez354Z5PqJXzfkXD0sP494ENtUeA5a+c9GA6lMKTh1HjH8AuOgvIwu2nFT10vD1wOK8OG+OuihW4hk2sTM2yuMfqUIBhv/un8gQR9gGevh57g1Oo4OI3T25oV0Ybf+cfgAs0trqhJah+O5ncPDMZiGuTrhLLNtvhZD2LslOsvnj/fAha38GToRz2qTmUwoGer+JpD0QwSXg7zXrx44l7gW4BCy4Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0RMVkzAxQtIXrR8ltI04gQpyfMQ0WSvrIFsx5/WNJ4o=;
 b=nonaeCoRCGvlVaQhDb+F08btXwPBGx+prG4RXjfWGotZ8AQyk6jsDlhrMadOv5g67dwiTuZzx1Z+ly+bBmr7I54aBjJt9xeiUqb96RLcqM1usmr7RIsgnekMI11jY4vqceuMrDGMobOln91SPcg8by2fnb6NSTawFmMuXNUhf0jfbsd9MQoZ8f5oUc5JWEZO2+zsx1IxYOLMJvbPNuxgAKIkOhc5pDkxMGcFlPmdeTKDF+d6bwN2EgJdRRokLi7ormShg0oKoZQLqhCPjJaapfOsPzlBPl/VcIi4GOkosA8lurmUNoy2bccHYicN2XbzJ/lqE/aRhdeYh8FLskHYRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0RMVkzAxQtIXrR8ltI04gQpyfMQ0WSvrIFsx5/WNJ4o=;
 b=RoDhZHF0Vi1kqTULlEmiA9vjtLHVpXdPPCqVikCpWKGhoqaM5QjbHlGv6njoD53vV2SCK/k12HZYFV2RztaWyMRpco/L0+NNHLFSM2cXrpsXRqyQGgJw9wqDAAHxXkk7f6Bjz9nD8yLMLutFr35dRgcQDC4fgnCN8JqZlUCeFgTKTzmTePQdzOgrIJLrT38IyiNgztjswMwH5Pg76xaDbzPFqPYGay1gkp2sjoWdH2vNV5mkmAlK1G2uaay/+lCjWxmtM5k0/p0/2LYhWu6gt32cKjX0TAp6hOULNG5aflHE/1qimL2kXLsJSsk4VGeGNCzQcG5+/XF+c/q+BRbhkQ==
Received: from SN7PR04CA0072.namprd04.prod.outlook.com (2603:10b6:806:121::17)
 by DM4PR12MB6303.namprd12.prod.outlook.com (2603:10b6:8:a3::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.26; Tue, 27 Aug 2024 16:03:29 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:806:121:cafe::49) by SN7PR04CA0072.outlook.office365.com
 (2603:10b6:806:121::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24 via Frontend
 Transport; Tue, 27 Aug 2024 16:03:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Tue, 27 Aug 2024 16:03:28 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 27 Aug
 2024 09:03:13 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 27 Aug
 2024 09:03:13 -0700
Received: from c-237-113-220-225.mtl.labs.mlnx (10.127.8.12) by
 mail.nvidia.com (10.129.68.9) with Microsoft SMTP Server id 15.2.1544.4 via
 Frontend Transport; Tue, 27 Aug 2024 09:03:11 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Dragos Tatulea <dtatulea@nvidia.com>, "Michael S. Tsirkin"
	<mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>, =?UTF-8?q?Eugenio=20P=C3=A9rez?=
	<eperezma@redhat.com>
CC: <si-wei.liu@oracle.com>, Jiri Pirko <jiri@nvidia.com>,
	<virtualization@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] vdpa/mlx5: Use random MAC address when no nic vport MAC set
Date: Tue, 27 Aug 2024 19:02:56 +0300
Message-ID: <20240827160256.2446626-2-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.45.1
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|DM4PR12MB6303:EE_
X-MS-Office365-Filtering-Correlation-Id: 20de135a-8781-4c1d-3785-08dcc6b1ca8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?swbgInxHvbbKGJ9RE2WEqTYD07H5ol87YsXqw7LaSrUlmEPga53hC8vrSA4y?=
 =?us-ascii?Q?guUuNAfIJzYU4LdPCxEmUYmH1wwdXSZx0S6Mf6QDFiSAaagrRygCEgqeOKIb?=
 =?us-ascii?Q?AwlfW2/0M3k4Jw57euZgc9RraXC/rFWa5tN4pO8XwdB4M4T2HDSOHcWGP8k4?=
 =?us-ascii?Q?UOK5JTnkAP5JvRkviWJYT6crjO+8pG5IsYNLAjXuWCcoc1X5WssGJ7kRiSM/?=
 =?us-ascii?Q?3T5yQCP1poIqhbUumQf0eQ4fuA8oX/ocXewL54oCFhAUvE2tM/CtRsHNNZ0/?=
 =?us-ascii?Q?963Ki+IaNJtcxfg2/7NO7YFMJapj9F44es06Z31FdzZWufxd3SJyB/xoulzI?=
 =?us-ascii?Q?gwOlwQXaj3R4zs4zHXkJHKTvcCxnnDNd9oD9on6ZjtORxZjaLv6tFoPv9iZs?=
 =?us-ascii?Q?QBv6RSFyC6K9mcYIkfuUFLgh0bF16BhXBub5Lu/6xJgy2K1VqBFHl4eSGoBq?=
 =?us-ascii?Q?kaQbk7FQOQtZOk9IoeagRg+PcIRvJU1rcLGxCQuzY0iLYUr6CIYM3EcaX6Cd?=
 =?us-ascii?Q?zQgqNZYz06lJrt1ySctJ0bFrH9mN5QiMVztmOztI+kTYiC8iN6zQXDV2OALy?=
 =?us-ascii?Q?wpvB4sNUQbqmlxgVFDxXVTrKt5LCkfXgF6SQMCKvP7So/dWK76GOs+auKx86?=
 =?us-ascii?Q?eufnQZul3BL0ns15wC5j9DTSNisCNQvpk9/pvxJUm4xUUWFL0FxLYBd7mRkU?=
 =?us-ascii?Q?p6BIq4J9rAnYy4z5zHjAPC7rKM74QD3HeozZs1qdt87UIsysPFFNhZmU9DKP?=
 =?us-ascii?Q?6wHhwDDlLVFcQ0KT3E4HPsjDRgJcUZV8C1/ehcBbxEFb6S0e0ma1MjyvpXe/?=
 =?us-ascii?Q?FrSE1T/Hjt2tgQhbBlKhcOk21aHZZfaqE1rF+iZSXKuGeJOlIaijZM8OTWqc?=
 =?us-ascii?Q?t+1yiRu7qejQjp+7/nvatHEpDHraTu7YUvVhcTCgrwRDtMaFvZUKYtfAL2Ts?=
 =?us-ascii?Q?FIhXH+bGVgyZcBEm1scXf7JvOUyL/oa6ry9UygwX5M2x5CK53xRzeLkK4qtd?=
 =?us-ascii?Q?unOdJ6B2/257W//cN3Yb+sZZ2rnleKBMF6s3CDw2OtChUBDdrjkH7TJbqU+0?=
 =?us-ascii?Q?+CT0TETUojxchGE8T9ClVma8o4vFzWOGn59yQWTZqsNnbhPCA+XtfUp3oG2N?=
 =?us-ascii?Q?WZdgM4Bwe426FPrTILgGYqjC9XO4d4FA3PzRRPN1rBb3c3zTcZYtnZXRHbbG?=
 =?us-ascii?Q?qqKU+88gtTZG321Kc8HO59nrE7ZCvB144Q+MCTWT6E0dPvolwCo175xjQvQN?=
 =?us-ascii?Q?F+CGe/X0ne9q8Z0CAN5J/7L+CLxoXT7ia+8ldP8lLpaeRBfOS8RTIoOA4G2M?=
 =?us-ascii?Q?a40iLYT5BqV9zni6jUY44veLuM5ou7/eM8Bz72xHxHKEL66pk/9jWy3jYKIW?=
 =?us-ascii?Q?ZH8iRqo2Qjwnwtb8BgMrhSb8+Pi9uSWoR9kkutIZDx4Ki7QkJM7QWcWkxaAi?=
 =?us-ascii?Q?K5EsN2sqIkUHteneeu7E5ifrUHXTDthr?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 16:03:28.8397
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20de135a-8781-4c1d-3785-08dcc6b1ca8a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6303

When the vdpa device is configured without a specific MAC
address, the vport MAC address is used. However, this
address can be 0 which prevents the driver from properly
configuring the MPFS and breaks steering.

The solution is to simply generate a random MAC address
when no MAC is set on the nic vport.

Now it's possible to create a vdpa device without a
MAC address and run qemu with this device without needing
to configure an explicit MAC address.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index fa78e8288ebb..1c26139d02fe 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -3824,6 +3824,9 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
 		err = mlx5_query_nic_vport_mac_address(mdev, 0, 0, config->mac);
 		if (err)
 			goto err_alloc;
+
+		if (is_zero_ether_addr(config->mac))
+			eth_random_addr(config->mac);
 	}
 
 	if (!is_zero_ether_addr(config->mac)) {
-- 
2.45.1

