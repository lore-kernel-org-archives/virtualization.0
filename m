Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD30E1C233C
	for <virtualization@lists.linux.dev>; Fri,  2 Aug 2024 07:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722583505; cv=fail; b=YJsPF8BX3Iq7z70PHAkjqUOXXugMpop1T0E2bYOL6XJbQskZgbo/bmaTtPkj5zr55KhCojg42Dt91Bwf2UEIJUBnM17R6KH2p3wW6k+d1cTRRms1zcd76p7Po6Rk/vhF4w5+HsNfDU83zix2tS481PLUeuYf3P5hJRztHxTm9oU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722583505; c=relaxed/simple;
	bh=JbJ3XIngQVydHEHuuDDFKSmBkibrYiVYeEg45FNsgsQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lBuPC45epfZ7j9locEpYSOOU46AW+S1Y3tz37nFJfLpx0GeqrLIlOuAFNYImKovtL0PA0FgDf+XEmfEzAQF2srgj0gdAHErnrA10gyyqqVKF9RwKtPRC1oXdPcF2br0dfQDAkhNIH6FQqZ+OIdurT8spcfzcOJfPrhTd926ocJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jbEwPkwz; arc=fail smtp.client-ip=40.107.220.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jbEwPkwz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w1fh9l6u7YTirKsxEiUJXeo6ge0d11VDZ016MbxY3QQB89ZAeWARRgxrfqtxaVT1nXxDEuyweCIkjLYGk4W+qbdIP1VInFut0H+i6Vv3jrhvxJFqoFkjcLhvYy6iYPvNooHU2lZ0T/ITQyt6vzX99dXOvXC+YpuKrpmyt+Dp8tCdRPSfASyFzkOB9WLmHeZdv0nS5u6n1SnUn833FkEKgHPIXhc0lfEJlG4gf8hgWVG5C1EP4CFbTDJ79cXh/I23gzFTf3n/3OQkkn5C6KDwYbypiFz3l/AICQocx21sgXraJQ7L77Ns7YHEe9TtMlHXyrRUNbkuyI8Iz48HJ3wBIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zK0dXhJnuESlzxascJCuO5HR2ybkRf8OrqjydhvK4qU=;
 b=iVo5jdNlbUtAYrLORcrDPtrlK4qYeFJ0avwjY2Iv/LGgASDNa0RdCEovreo/EncJqO2tcrO4DF88kwOJvonktWlgwH5aB/xJ2NA+oM9kBaPAfaAddYOElwVFqhjQj9pNQb0ZVKGn2qImV6Tzu5+r6fSiAV21A26Qze0GCh3EbEn0yjqZpNmRtNn3YNue8r7y+Mg3ERAmgAQKlTuyxbBl/LCWodGYd0OFlIeizGN4jV5u4123/10rDhnC7jOPYHUaH5lH+btI4ktRZb2S65na7QaLpb+ForWyIPLn0JKuGQ4Gbc6L4CoumgJScVAIhl3ynqOiyyutxXptkWN9jYThZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zK0dXhJnuESlzxascJCuO5HR2ybkRf8OrqjydhvK4qU=;
 b=jbEwPkwzYq/TjX4MFn6Ez/VNm5oMgC2c8DETcktNB+McW/WGYlrL2/XkiopEurnPIoZP9nY4UiMzkbk6pYQzxMJ5tXuBdtC/M29bbJ/PJ0X+4YUE5RysHIFGaZEyl2YQlLJ2S2kDx8NJlTZ9GIuGRT/bvjNPcw2nY0hhi7Crcqz0KFJv4k4Qkmv1syEdGtaAGqgsJbef+xoIt7VrUv22Zn1HXePrAZsqiW0fcY4dnVjJ4mzAWgw3e51F0VesjajDM1fFuckbVwyJoXeFoOZuUJxi9hNBpOZYOUc9jNuY9o7S6kCG71ZLoHbR66G6ofNPrCiBUz1KUbSBcXngGmaI3g==
Received: from MN2PR01CA0062.prod.exchangelabs.com (2603:10b6:208:23f::31) by
 CH3PR12MB9193.namprd12.prod.outlook.com (2603:10b6:610:195::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Fri, 2 Aug
 2024 07:25:00 +0000
Received: from BL6PEPF0001AB4E.namprd04.prod.outlook.com
 (2603:10b6:208:23f:cafe::c2) by MN2PR01CA0062.outlook.office365.com
 (2603:10b6:208:23f::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22 via Frontend
 Transport; Fri, 2 Aug 2024 07:25:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB4E.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Fri, 2 Aug 2024 07:25:00 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 2 Aug 2024
 00:24:47 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 2 Aug 2024
 00:24:47 -0700
Received: from dev-l-177.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 2 Aug 2024 00:24:44 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Dragos Tatulea <dtatulea@nvidia.com>, "Michael S. Tsirkin"
	<mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>, =?UTF-8?q?Eugenio=20P=C3=A9rez?=
	<eperezma@redhat.com>
CC: Si-Wei Liu <si-wei.liu@oracle.com>, Tariq Toukan <tariqt@nvidia.com>,
	<virtualization@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH vhost 7/7] vdpa/mlx5: Keep notifiers during suspend but ignore
Date: Fri, 2 Aug 2024 10:20:24 +0300
Message-ID: <20240802072039.267446-8-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240802072039.267446-1-dtatulea@nvidia.com>
References: <20240802072039.267446-1-dtatulea@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4E:EE_|CH3PR12MB9193:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f6198dd-0c99-46b0-d4a0-08dcb2c43838
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gCwBu7d3/+X+SchSh5ARRGl5aYGYIpjq5etDLoo3R5X5vOz8ojOl49lMSOHV?=
 =?us-ascii?Q?Kw3Lx440E02qGSoHaUm74Mt0Jj/6R6gEi5s5bOzyTekFwkKb1haSddbqdtmh?=
 =?us-ascii?Q?dBIXQSBDtlBSgnEwneQIeIbEmkYnLxUCy3FrP404BxC4NxWLOQglt5BGgbUV?=
 =?us-ascii?Q?zo8sJX6iXG6YcD2Bqer/fDimREfUMGnokg17HZkAUGL6mZiXQJ2Ix62Fi+an?=
 =?us-ascii?Q?o0LvCZbDqoPvY9JPD6Er8wl0BoKUkkeYhD5d8dASs0sfnvYS4VfEFrBbrG4W?=
 =?us-ascii?Q?y+Spc9/PhZ+dyREdX5GNuAnLlER/4svhi1aDXvK1nPgm4r921aSGn/QcMaxH?=
 =?us-ascii?Q?Y1D9uoey0j4fOllqQVydh0ee6Dh6eTGAiCtdkOxxjmpq5TdgMUcpQ9tpsHfm?=
 =?us-ascii?Q?iSl2We3XgaN8dXKHgT5opIjPcEJLOnz9nPkuffKmpk/ENX/3N/dXSxgFBk3Z?=
 =?us-ascii?Q?ocn585iTqZw/MX9fZf4NcCKAiKWb3K2VvqEuY4w98rhTEfQr80LlWBcBcugF?=
 =?us-ascii?Q?VnEddlqUvRVMrKOIp+MDOaz8lTB5yw9WKDrSG0VEy67MbFv5hkfk7i0n1YiG?=
 =?us-ascii?Q?Pl1Td1DLagjCnoes+hAF3bjehXw2igCxrKCc0p7MSGQ5O6xKDscCkelQQP0k?=
 =?us-ascii?Q?BatJh5w3GdNFWQEywxufDqAw6pcqarIbnUb6dQFVtqdOkTE9nFFIZwj0afnk?=
 =?us-ascii?Q?gl/Vv1ZBVKlH/mNTp0Bh/78k4dWxgN4l3gfhsLFtNjkXU0ooTRM55H7kLVua?=
 =?us-ascii?Q?EHgx92xDj4Ut6c2P8VMzPywGAsBq0bfB0fGLgYMU663f1lU8GD2Ad/PhNvW1?=
 =?us-ascii?Q?N4aoOqYdgCjDp8oLqUw+WnGm6W+vyJtrbv+Sy7H2EaoUFQj0l7CRYiMlxlGz?=
 =?us-ascii?Q?XtFhri4TaQ3SpinN0PpludXKPQqGs9ILS6YJzvUwvEq7PrmfOkioZHnm1Aj0?=
 =?us-ascii?Q?5LHi1wetuR0jJkB65Nhiuhwq2Tz/yEF5e/Cd6HEMLZM3UZB1t8G1hc91CIrg?=
 =?us-ascii?Q?NVoaBec88sP1htt0j3LTNNQ8VHRRDKT7ofXdsfmvgej7vbQfe2Y1FyT9FLJV?=
 =?us-ascii?Q?+aYmzg2ADVREV7gpvdMZwZmDloQf+zpI70hmrK1FyI6Si34YXAyczUoTtbaJ?=
 =?us-ascii?Q?gXKbnO8HIENIXBQPLtjRP/FNI4PH2OxWIpfiPjOhyfpmzzlZTN4jm+HHrFlt?=
 =?us-ascii?Q?i8fOYsC2cSdJSkk04dja5i1yVsG8ZrY2LSu/stfkQf9ouKyXljHB908p9JsB?=
 =?us-ascii?Q?229XPKkVJ2HSrmWjDHn3s/pKw5gj8iOXaZfRZ1lQhmGH3I1pOAUJrKcFbQdj?=
 =?us-ascii?Q?lli71HyYlHSWw5TNKHis1sPwGVFbnAT9xpem5MOBI/e6kHXk/nzFiGmV7bPM?=
 =?us-ascii?Q?9ouMcPhxM9BBET1aDZAw/kgojgfShgeGVgtnYQMw1cImgjTVL3sinKMOFtVV?=
 =?us-ascii?Q?vI8XjJeEGJDdxi25KCBGfZK00gSWiJkd?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2024 07:25:00.4319
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f6198dd-0c99-46b0-d4a0-08dcb2c43838
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9193

Unregistering notifiers is a costly operation. Instead of removing
the notifiers during device suspend and adding them back at resume,
simply ignore the call when the device is suspended.

At resume time call queue_link_work() to make sure that the device state
is propagated in case there were changes.

For 1 vDPA device x 32 VQs (16 VQPs) attached to a large VM (256 GB RAM,
32 CPUs x 2 threads per core), the device suspend time is reduced from
~13 ms to ~2.5 ms.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 87d355aba380..af96e49697d0 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -2934,6 +2934,9 @@ static int event_handler(struct notifier_block *nb, unsigned long event, void *p
 	struct mlx5_eqe *eqe = param;
 	int ret = NOTIFY_DONE;
 
+	if (ndev->mvdev.suspended)
+		return NOTIFY_DONE;
+
 	if (event == MLX5_EVENT_TYPE_PORT_CHANGE) {
 		switch (eqe->sub_type) {
 		case MLX5_PORT_CHANGE_SUBTYPE_DOWN:
@@ -3679,7 +3682,6 @@ static int mlx5_vdpa_suspend(struct vdpa_device *vdev)
 	mlx5_vdpa_info(mvdev, "suspending device\n");
 
 	down_write(&ndev->reslock);
-	unregister_link_notifier(ndev);
 	err = suspend_vqs(ndev, 0, ndev->cur_num_vqs);
 	mlx5_vdpa_cvq_suspend(mvdev);
 	mvdev->suspended = true;
@@ -3701,7 +3703,7 @@ static int mlx5_vdpa_resume(struct vdpa_device *vdev)
 	down_write(&ndev->reslock);
 	mvdev->suspended = false;
 	err = resume_vqs(ndev, 0, ndev->cur_num_vqs);
-	register_link_notifier(ndev);
+	queue_link_work(ndev);
 	up_write(&ndev->reslock);
 
 	return err;
-- 
2.45.2

