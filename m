Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2075.outbound.protection.outlook.com [40.107.102.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE331C2312
	for <virtualization@lists.linux.dev>; Fri,  2 Aug 2024 07:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722583498; cv=fail; b=cfR9c0jNukgUtdzSfEHvsWh6NPS3QOiYZ5WjZTrYMzqOUgWinosu1j2gPVpDT3yQPM1RhKy+62GNfECQCAssOGY9HozSZBvTd1uFH2gs3nqTKl8vh0mDHfH68ye+mPqOcqzPUHJholl1DOT3JhBf0J5AFnn3cwJhskts9wgZMGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722583498; c=relaxed/simple;
	bh=ZiUTAvRdB/T5M0v/iYfar5K8MOlYIYYVGI4lX1Yh4sY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LJAeujP5unHR+dSq7ox6a8Zl0u/pbvwXL9KoCjsXaJf7Zjfl6iY8ijhiyXHEy5asPXUSrmk3qIAhIPMNqchJozFLxsLmLu0KCy2WywuQaBi+KTw371YubWZ0Qz1t5uS5sSQTJ6W61AIlWOWDcYtVFImKnp1srxh+0nAT7qA5bKY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cz+BV79G; arc=fail smtp.client-ip=40.107.102.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cz+BV79G"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R3/ZqctKHuXr2D2m6ni3vnS71e6L8d1vrm5QFgx2vTslaWdt0bzrEOnYM2u6OVo0vfF+yQMF08iJx7vI+vAbgPtvpYm8lxty+T4vYxnKVnAM0OsL2xFKr9/qXRE2WGNDf/7UHMoTleqa6yflBlkJiHHhAfIdL+QL0gxMasokC58dDI1T+V7DKWUnQyl2xAIMB5kcWFMzBjoc3KHtmTh8m9HIUaa6ojhPfOkmHAa3eFn5zzKqhe5oq9d9N9NkwtQchvwpvQwdcZWPc2Yv2sSEWHi+CQxxJFvQQnpwjvP/qyeD+00cje5uBF0szSjdJsOIzhkUyfJf1+nX9fX7ueu2gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9dSnGiN3Qnf8DRC0KPA4mo7fyyvJQWFbY4XjuoOc9Us=;
 b=sQEgIDCHp6FWvJ2M5eBLWJwll90ff6oYtFFUut7mLvWBl3fW6FYkk6ylAzzv9jjfmnVBeQjqdmcyi1NE6WiLr47z0Uu250CwlfJM7vmhzLdryv6cwKDa57ysBfbE0C44NwMqsXm+Dhni4Ahrp+xYE3wt/QrKQhIe3D6rBhYnkbOAMzijKlWGiaRD7gE18DJ9LgyrrLgyr3Ds2hsGqLdSFO15Y7hpZjs4ELYvdU9lxyt5pdyaOvq4Lryozlu2kUAXoxmGpDv8vlBB36EPbT74nZTKlN75h2bBRpZ6oT9byxGx255XZt5zRqbvvx1pj7l1il7pV9KcMdPdTsFSrI2TrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9dSnGiN3Qnf8DRC0KPA4mo7fyyvJQWFbY4XjuoOc9Us=;
 b=cz+BV79GFsW2nV8/u9iMXrhhtarguXg4sbm3BM/yyrIgZhMBwIbTrA9PM+ODHIuqPU1cTJEx9wK0yG02yUdrGFljlY9PpsfDSEayM2mpIrd4QRGj8xZfGER4Qj2MWA35aHg+nDNpWSkCkh2adjGCWaIlrbsp7kZk/x6NEkjQGoBvnCeqnmZEpSobStIMRgMSY/8AppvjNMEMZgw1Us6GJ68u/ha5/T8peUx6PdECNpkhpRj/6qaJB26cnHQkK+bzr3A/n5g17k6FSqZD1vAFkLZGFxyxGmQOyjDuuoXdZb2LzA6Ge8B5gWek7kEZWxbn3J7RrbWAYFUnGcAol5J1Rg==
Received: from CH0PR04CA0050.namprd04.prod.outlook.com (2603:10b6:610:77::25)
 by DS0PR12MB7746.namprd12.prod.outlook.com (2603:10b6:8:135::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Fri, 2 Aug
 2024 07:24:53 +0000
Received: from CH2PEPF00000144.namprd02.prod.outlook.com
 (2603:10b6:610:77:cafe::e5) by CH0PR04CA0050.outlook.office365.com
 (2603:10b6:610:77::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23 via Frontend
 Transport; Fri, 2 Aug 2024 07:24:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF00000144.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Fri, 2 Aug 2024 07:24:52 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 2 Aug 2024
 00:24:40 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 2 Aug 2024
 00:24:39 -0700
Received: from dev-l-177.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 2 Aug 2024 00:24:37 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Dragos Tatulea <dtatulea@nvidia.com>, "Michael S. Tsirkin"
	<mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>, =?UTF-8?q?Eugenio=20P=C3=A9rez?=
	<eperezma@redhat.com>
CC: Si-Wei Liu <si-wei.liu@oracle.com>, Tariq Toukan <tariqt@nvidia.com>,
	<virtualization@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH vhost 5/7] vdpa/mlx5: Parallelize device suspend
Date: Fri, 2 Aug 2024 10:20:22 +0300
Message-ID: <20240802072039.267446-6-dtatulea@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000144:EE_|DS0PR12MB7746:EE_
X-MS-Office365-Filtering-Correlation-Id: 96b8e434-b318-49cd-d211-08dcb2c433ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?plJb4wVe6a40rpt+rqU92vQ1QU/T5UPKHkW3m9bJkzq/vZMnV2MX2dI02YI8?=
 =?us-ascii?Q?/XZd+pZ64uNQFiCFGHHbh0HpKTQvF6PzJrJ6N8EPy78ojoWGSCoDCM2i1nx7?=
 =?us-ascii?Q?VQ5YfqxZV6F8LCupK6E0dxJ0HqImp85+RN6jCEqep0WW/seqWkZ9Ic7w/3dA?=
 =?us-ascii?Q?Gd7Nm2vHVlNrmkd5Znw8A56QyHbZD4UEQXK9ASpAr+KJauXhXoB0rLOVEgEG?=
 =?us-ascii?Q?ljbMEhrl5e8fka+3AeoU+Ls6W1jpINzfw5Kf0gDGYNP0DnEkh6urdYPlPlDx?=
 =?us-ascii?Q?bSIadM7SlD+UUb4bw9O45OLEP81ruJPHM6lBXitembKWaZHIvRgg4zkz2TFl?=
 =?us-ascii?Q?itGLsBFZ4hCOAblTxAnx8LFjdYsAA49rhk7J9S6HSOuo9T3uDMNAaTxrEamz?=
 =?us-ascii?Q?H0KWv1570b9eQeD4kHbPAb7LvEPsl+12f55Ej4es+uFaC+NhS1wKPEujFsIV?=
 =?us-ascii?Q?mrjKzrYQmPApBr4nLNszLYHD3jW6TlpERgOK8W4YYJFDTVNrLIjqKSXdoRNL?=
 =?us-ascii?Q?mK7ia77OUs3+nWhIDKa3H9TwmxEwynto33/N+gBe4l41tbe73aJxi1iRsSeO?=
 =?us-ascii?Q?g+fn3XDMf22SW5FmWILm33dWc/lGV/NCj/LzyEMlHcU8O2RklEd5ZtnyT5Sd?=
 =?us-ascii?Q?RKYd/mn7oeO24a0z7K4oJXX+ZXRXGAh2rlZvJF70A45QsgArphP9AakHITGh?=
 =?us-ascii?Q?K28crwkzL7mpgjKlTxL2w6vvYcBBksfUPz33KnykLRlWcmWNPjGSKubXdA1N?=
 =?us-ascii?Q?yw8PTULcx4kCB0if+6uk78PW2Fklg7xduCZ14tglh5+kpysVTaKM8NKh0Zr1?=
 =?us-ascii?Q?S3GOwoWG1AoNVtEw8OELw0smknnb2mwIVWeKbA4DrFbUvSiDuTx8cZuYbeKx?=
 =?us-ascii?Q?3f7X2mD5ZrOR3Wp5TYgaCmL0Wbdu6DwaLi8Mw9jMONDYWaSX4vAA8bkiP+TJ?=
 =?us-ascii?Q?UW5YSjzHim5BGTrgYP9LR6IhNHLkUzcPDKCmltOc2Qriyot+eFHxTWfgFg65?=
 =?us-ascii?Q?RfNlo1WybtZPv9R0LszD+TQ3VtCU7sFMOp6/iFwcYx1pWzbTIicH4yYU1Uqr?=
 =?us-ascii?Q?q+fB9LYb3ChrUKXN6CUEnem3eSZO1xWMdW3BZLXCHFyrOrSu3Q3NN+LTQ8pu?=
 =?us-ascii?Q?qVLqcUo0k4Q0LO/jZ3C8u9BNq3jUBTCIr1kOulpQGWgWqZRXv1f8SSyycRYF?=
 =?us-ascii?Q?9xpTuAPP5ANAnizxtn5/8cN1V3C8qS4vR91WjCQ8JiU7ZXfGt7uUWNZ7ScLm?=
 =?us-ascii?Q?Fr8W3Kpc76YMNvEpJerbSV2YVFtX0erh5pFQNLRE5opIxA3xrTmAwVoUdhiI?=
 =?us-ascii?Q?lpCOSXwtfvWHrS/ET6KmhbFttSn/718TbmwnRD1m3OGLqFJJpfL62IjnPJ70?=
 =?us-ascii?Q?a/G8QvcFso54DGyUixYu5Im2r8LTYDKN5LFKuU2J5OsuWFt7++/nxYMKgQ0P?=
 =?us-ascii?Q?Vp9LCuK6Q31265payabM/F5SFiCrmpwv?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2024 07:24:52.8437
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96b8e434-b318-49cd-d211-08dcb2c433ab
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000144.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7746

Currently device suspend works on vqs serially. Building up on previous
changes that converted vq operations to the async api, this patch
parallelizes the device suspend:
1) Suspend all active vqs parallel.
2) Query suspended vqs in parallel.

For 1 vDPA device x 32 VQs (16 VQPs) attached to a large VM (256 GB RAM,
32 CPUs x 2 threads per core), the device suspend time is reduced from
~37 ms to ~13 ms.

A later patch will remove the link unregister operation which will make
it even faster.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 56 ++++++++++++++++---------------
 1 file changed, 29 insertions(+), 27 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index e56a0ee1b725..1887939c5673 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -1714,49 +1714,51 @@ static int modify_virtqueues(struct mlx5_vdpa_net *ndev, int start_vq, int num_v
 	return err;
 }
 
-static int suspend_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq)
+static int suspend_vqs(struct mlx5_vdpa_net *ndev, int start_vq, int num_vqs)
 {
-	struct mlx5_virtq_attr attr;
+	struct mlx5_vdpa_virtqueue *mvq;
+	struct mlx5_virtq_attr *attrs;
+	int vq_idx, i;
 	int err;
 
+	if (start_vq >= ndev->cur_num_vqs)
+		return -EINVAL;
+
+	mvq = &ndev->vqs[start_vq];
 	if (!mvq->initialized)
 		return 0;
 
 	if (mvq->fw_state != MLX5_VIRTIO_NET_Q_OBJECT_STATE_RDY)
 		return 0;
 
-	err = modify_virtqueues(ndev, mvq->index, 1, MLX5_VIRTIO_NET_Q_OBJECT_STATE_SUSPEND);
-	if (err) {
-		mlx5_vdpa_err(&ndev->mvdev, "modify to suspend failed, err: %d\n", err);
-		return err;
-	}
-
-	err = query_virtqueues(ndev, mvq->index, 1, &attr);
-	if (err) {
-		mlx5_vdpa_err(&ndev->mvdev, "failed to query virtqueue, err: %d\n", err);
+	err = modify_virtqueues(ndev, start_vq, num_vqs, MLX5_VIRTIO_NET_Q_OBJECT_STATE_SUSPEND);
+	if (err)
 		return err;
-	}
-
-	mvq->avail_idx = attr.available_index;
-	mvq->used_idx = attr.used_index;
-
-	return 0;
-}
 
-static int suspend_vqs(struct mlx5_vdpa_net *ndev)
-{
-	int err = 0;
-	int i;
+	attrs = kcalloc(num_vqs, sizeof(struct mlx5_virtq_attr), GFP_KERNEL);
+	if (!attrs)
+		return -ENOMEM;
 
-	for (i = 0; i < ndev->cur_num_vqs; i++) {
-		int local_err = suspend_vq(ndev, &ndev->vqs[i]);
+	err = query_virtqueues(ndev, start_vq, num_vqs, attrs);
+	if (err)
+		goto done;
 
-		err = local_err ? local_err : err;
+	for (i = 0, vq_idx = start_vq; i < num_vqs; i++, vq_idx++) {
+		mvq = &ndev->vqs[vq_idx];
+		mvq->avail_idx = attrs[i].available_index;
+		mvq->used_idx = attrs[i].used_index;
 	}
 
+done:
+	kfree(attrs);
 	return err;
 }
 
+static int suspend_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq)
+{
+	return suspend_vqs(ndev, mvq->index, 1);
+}
+
 static int resume_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq)
 {
 	int err;
@@ -3137,7 +3139,7 @@ static int mlx5_vdpa_change_map(struct mlx5_vdpa_dev *mvdev,
 	bool teardown = !is_resumable(ndev);
 	int err;
 
-	suspend_vqs(ndev);
+	suspend_vqs(ndev, 0, ndev->cur_num_vqs);
 	if (teardown) {
 		err = save_channels_info(ndev);
 		if (err)
@@ -3690,7 +3692,7 @@ static int mlx5_vdpa_suspend(struct vdpa_device *vdev)
 
 	down_write(&ndev->reslock);
 	unregister_link_notifier(ndev);
-	err = suspend_vqs(ndev);
+	err = suspend_vqs(ndev, 0, ndev->cur_num_vqs);
 	mlx5_vdpa_cvq_suspend(mvdev);
 	mvdev->suspended = true;
 	up_write(&ndev->reslock);
-- 
2.45.2

