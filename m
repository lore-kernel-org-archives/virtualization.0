Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305201C0DFE
	for <virtualization@lists.linux.dev>; Fri,  2 Aug 2024 07:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722583504; cv=fail; b=ZYwWzAPlNxTLhHs6klE5wuFA2VqrVCQLB4XFdMuy/eqoTgz/BffQNxbunlp/S6SyyFnX/wHBOWzjD+PgxCw/i3V/CMW8AiqlqiUblnmB/nFQZ2CsTQ1Og/aBjWaSzZRqdXAv7OjWYw+4uZ05QDy/ExkC4n17SIVK9RdaGUpHln4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722583504; c=relaxed/simple;
	bh=zOqykgshV8PWrA4TDWUt1QJId7VdK3lgaYQZrudRB14=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pkOshSjgrk1igEWqceP/HLJAHx/bp4EJVN1LfYHXHJMYjl0jqT8K4c2H2y40FpPv/s7Aw/7p5toCDO7WDQm8M7wHYtuYrbMNLQzSXxy3+dFbPsCJ4jmrUnIG16isgUiJ/LX3EY+m17tyhVq+uq/NtXEHwaTRxw4gsfXYivEd3g4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Tq7XZHsX; arc=fail smtp.client-ip=40.107.223.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Tq7XZHsX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eKlLuB5IakCqa+m2rXf5Cz8XFWjlbEqVa8YoeWnMxpsnyaOleIzZfoehmAnEWonsubTXYJpqzAtwpzf7aTGDVn1fV5nctXrZBDhJsv+zKR/U6TC4N3JqFT1L7lYG8XonvsizGrV1m4xaIzhShlcV7Ht7v/XBCutDf6AVE0Z+MLbcotg7oMxuS9t9quCI6tUeD1bWqcYdbKkr3P2SXjtKAA+IRdccC28fdA8/4VdBExY7uN6NyBvfRoGyfX2B+w5HE4cq19oFCPI+v7dF6BWg9u6Tniib3jG+MutCRwKogVW8qFHM1RpK8ts9f5lSbGwzLq6ssP5A7Wf6a1dPY/ad/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QXmPlIwj6VycoUapHOhFBDEW7WszrIdTIdXKwTgODw4=;
 b=hUsJiDd2HDpICNxn1m1SOscloF3MCZN58fcsOl4U95zqUl7QcpW70pNOqVUSWYHoSzu+K48D/cMsG5NZ+9FFpP53fUUZssZ8erLDfZyK7scYCEPvZ7jt9bITM3r2jPa1lRqTFWn+NtyJQlcwnngI2njUbk5zDOv5GugOx75RbKx0i42UMdRrx6Ml0heqMzFOYEGnHIYFRocVf3ACFKpftSKea94E/C9peXJgeliJpzge6TIaRuPwKOj86jFp8RTcXCW0tFxbbopCwE4YavkjpvtdqCSVYW2o30/ytq3bhYUrG4WJ+i4RgeaILZ326PtQ7A3sgTLxSfO7BEs4Lcu2dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QXmPlIwj6VycoUapHOhFBDEW7WszrIdTIdXKwTgODw4=;
 b=Tq7XZHsXYyGNuXqTPtApp6jVZpIn9PbiNK7NUU20KwLiM3zh1fk4htBpQXEQrVJPaZHEyJ7Fa8mi3OS+vIFZUr8snHyROCTONDsJvMsgdhSQ7z3BChE/mYhQneXnlyp0CUWlxQBHP0auTPuS44aqmrn0YwJgYDdN3xJU5KNvHprgFyBLZwc5sxFbxcsSI5zpVYWO5miQYyiq1hCnFp0xfCGAU8Oy2kZ8p4sgs9TtGzIgyWvl2s1wpEcO1hW0bKforuOM0fp0U8LEypHeMGZNOZOQg3Yph6TqU7GN+cdd3S/RBAUXa8siWowL65OcrU/0RJh72EwnHxNKR145O0ODGg==
Received: from BL1PR13CA0122.namprd13.prod.outlook.com (2603:10b6:208:2bb::7)
 by CH3PR12MB8971.namprd12.prod.outlook.com (2603:10b6:610:177::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Fri, 2 Aug
 2024 07:24:58 +0000
Received: from BL6PEPF0001AB4F.namprd04.prod.outlook.com
 (2603:10b6:208:2bb:cafe::53) by BL1PR13CA0122.outlook.office365.com
 (2603:10b6:208:2bb::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.7 via Frontend
 Transport; Fri, 2 Aug 2024 07:24:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB4F.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Fri, 2 Aug 2024 07:24:58 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 2 Aug 2024
 00:24:44 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 2 Aug 2024
 00:24:43 -0700
Received: from dev-l-177.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 2 Aug 2024 00:24:41 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Dragos Tatulea <dtatulea@nvidia.com>, "Michael S. Tsirkin"
	<mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>, =?UTF-8?q?Eugenio=20P=C3=A9rez?=
	<eperezma@redhat.com>
CC: Si-Wei Liu <si-wei.liu@oracle.com>, Tariq Toukan <tariqt@nvidia.com>,
	<virtualization@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH vhost 6/7] vdpa/mlx5: Parallelize device resume
Date: Fri, 2 Aug 2024 10:20:23 +0300
Message-ID: <20240802072039.267446-7-dtatulea@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4F:EE_|CH3PR12MB8971:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b3243fa-af5d-4d16-7b83-08dcb2c436f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AeRqO4wqZ3A41Fx7dISb8yPRIu42unPezNfMDl48ey+iWsK1S5vygdobiLM2?=
 =?us-ascii?Q?rIzZwCiz2RReQadmCuW+jv9iT8EiSsOlhH2C5v07lgfuXTi3IrJHRpLUmTcZ?=
 =?us-ascii?Q?g3Gz3bwv6X+MnR4EILhQ0cA6a9OXgEhiGXMu6lYJURP0Oeqa78dvpZKV6rZ6?=
 =?us-ascii?Q?SXnTc/QyYTGBxRoEZ2wR+hTxKMKvUf29yW1kGsmUrKr2QOJnZspy4Bs9Yr4U?=
 =?us-ascii?Q?CysRkR2LlTLE7Fi4m+4bdjE4/f8p/yqrmKthwTbgh3QqGn5lGNhuV6Zz4C7I?=
 =?us-ascii?Q?TFv3Ui6IsBXSazs30sesauIH4o9GKtjDFw/NsheKmx4P3UFrMWolhbvfV49V?=
 =?us-ascii?Q?JMU4zlLWfnTvYciMTDV22cUSW6cbxEH8qFj4qLYpMGRhaDsMAYMuzFcJeN5E?=
 =?us-ascii?Q?RuCiltH4X/uy9u01tdrYIwJuORatuoEYYiV2FWysZMUX6Xpvq5q420xiPF+W?=
 =?us-ascii?Q?UXlPXJRFjYWxJizFmgPaKIUyxmCleK5UY9qmpPhhlvnBB6mHlwOYUmnmBJ56?=
 =?us-ascii?Q?dKAsIrNiYVlW2DvxvrznbK3mOlR0XKI6NmvA5tZn57717xhPI9UZSX7Rk999?=
 =?us-ascii?Q?NUYo2jxfoGa6mLNWg831dqjuKcC7im6sJdBg4ZgK1RzvyPxlsxqXCS34Jm99?=
 =?us-ascii?Q?eiI50EBX3sHTejE75vritVx8fX9xA9PIDVI/F3MVilT6xxXo1egfZlNhzLah?=
 =?us-ascii?Q?v1xlbcLwIuPvxQibxvCDgDzPyj+soN43UhM1ZolamVZZ6QiTB6yjnzKqgPFN?=
 =?us-ascii?Q?Sjkw7RxdKRH3WLbPjQpLQG6JIWF+tYfl2bZb2KR/dkiOYOmGvwvumF3/5V9N?=
 =?us-ascii?Q?uNTiHhxj24MEyvzhnGUHmatbrLDgIybhVsWuD1a8C2N3PwVocKtzfH9m/z9E?=
 =?us-ascii?Q?W79G3s7O1afVfRv3r+LplYtiszwotvy4yb2orEiHeymWr3x7RGFeClIJ4N8W?=
 =?us-ascii?Q?EM6ECSZ311sbeP+xIn1MablhpugxHVbNZHp9hkEnI2DVgtlwr8ipF53a3E5k?=
 =?us-ascii?Q?zm1Rkwzyba3ym21Xy/h1iVq1PDWsbfPs7nVKC52WU9P4+6DOdaUwM8/AZ+cJ?=
 =?us-ascii?Q?03tWOvzert2LBjxZ8DnVB1krZqRrp/dP/kVlqwBMHGXjg5RzqPdtge20lQqW?=
 =?us-ascii?Q?QMBjFpwNsNtSxtuixSkGP9U5XhZ/GCG9JBUD+Q+qx5hmgG8SL6H+SREJTBrn?=
 =?us-ascii?Q?l1dfjJcAy0kTedzU01Wo6bAsuiw7NL80E3elJHD2YwOPjjpA0uCscmC7guj1?=
 =?us-ascii?Q?WSxYhVATWpfYPBuHgxpLOEG/1z+mH+0XhDl/bnwyo5uu87sJRwFOpgjss0ka?=
 =?us-ascii?Q?z7gQQzxqjU9Ni7G95rLI+Nl/FQ9Ra9vK/ubtoo3NmpuWGQ6GycWgvbVynALo?=
 =?us-ascii?Q?jyJV0tAdl2pRkNVwNcsaqy97BJqqT6SKcTt3VR8clgv8Mo2qpyayYPS48jjx?=
 =?us-ascii?Q?Q2XHkakzMmXUodNuZXFh4onShiw1aDF1?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2024 07:24:58.3193
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b3243fa-af5d-4d16-7b83-08dcb2c436f6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8971

Currently device resume works on vqs serially. Building up on previous
changes that converted vq operations to the async api, this patch
parallelizes the device resume.

For 1 vDPA device x 32 VQs (16 VQPs) attached to a large VM (256 GB RAM,
32 CPUs x 2 threads per core), the device resume time is reduced from
~16 ms to ~4.5 ms.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 40 +++++++++++--------------------
 1 file changed, 14 insertions(+), 26 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 1887939c5673..87d355aba380 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -1759,10 +1759,15 @@ static int suspend_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mv
 	return suspend_vqs(ndev, mvq->index, 1);
 }
 
-static int resume_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq)
+static int resume_vqs(struct mlx5_vdpa_net *ndev, int start_vq, int num_vqs)
 {
+	struct mlx5_vdpa_virtqueue *mvq;
 	int err;
 
+	if (start_vq >= ndev->mvdev.max_vqs)
+		return -EINVAL;
+
+	mvq = &ndev->vqs[start_vq];
 	if (!mvq->initialized)
 		return 0;
 
@@ -1774,13 +1779,9 @@ static int resume_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq
 		/* Due to a FW quirk we need to modify the VQ fields first then change state.
 		 * This should be fixed soon. After that, a single command can be used.
 		 */
-		err = modify_virtqueues(ndev, mvq->index, 1, mvq->fw_state);
-		if (err) {
-			mlx5_vdpa_err(&ndev->mvdev,
-				"modify vq properties failed for vq %u, err: %d\n",
-				mvq->index, err);
+		err = modify_virtqueues(ndev, start_vq, num_vqs, mvq->fw_state);
+		if (err)
 			return err;
-		}
 		break;
 	case MLX5_VIRTIO_NET_Q_OBJECT_STATE_SUSPEND:
 		if (!is_resumable(ndev)) {
@@ -1796,25 +1797,12 @@ static int resume_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq
 		return -EINVAL;
 	}
 
-	err = modify_virtqueues(ndev, mvq->index, 1, MLX5_VIRTIO_NET_Q_OBJECT_STATE_RDY);
-	if (err)
-		mlx5_vdpa_err(&ndev->mvdev, "modify to resume failed for vq %u, err: %d\n",
-			      mvq->index, err);
-
-	return err;
+	return modify_virtqueues(ndev, start_vq, num_vqs, MLX5_VIRTIO_NET_Q_OBJECT_STATE_RDY);
 }
 
-static int resume_vqs(struct mlx5_vdpa_net *ndev)
+static int resume_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq)
 {
-	int err = 0;
-
-	for (int i = 0; i < ndev->cur_num_vqs; i++) {
-		int local_err = resume_vq(ndev, &ndev->vqs[i]);
-
-		err = local_err ? local_err : err;
-	}
-
-	return err;
+	return resume_vqs(ndev, mvq->index, 1);
 }
 
 static void teardown_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq)
@@ -3164,7 +3152,7 @@ static int mlx5_vdpa_change_map(struct mlx5_vdpa_dev *mvdev,
 			return err;
 	}
 
-	resume_vqs(ndev);
+	resume_vqs(ndev, 0, ndev->cur_num_vqs);
 
 	return 0;
 }
@@ -3288,7 +3276,7 @@ static void mlx5_vdpa_set_status(struct vdpa_device *vdev, u8 status)
 				teardown_vq_resources(ndev);
 
 			if (ndev->setup) {
-				err = resume_vqs(ndev);
+				err = resume_vqs(ndev, 0, ndev->cur_num_vqs);
 				if (err) {
 					mlx5_vdpa_warn(mvdev, "failed to resume VQs\n");
 					goto err_driver;
@@ -3712,7 +3700,7 @@ static int mlx5_vdpa_resume(struct vdpa_device *vdev)
 
 	down_write(&ndev->reslock);
 	mvdev->suspended = false;
-	err = resume_vqs(ndev);
+	err = resume_vqs(ndev, 0, ndev->cur_num_vqs);
 	register_link_notifier(ndev);
 	up_write(&ndev->reslock);
 
-- 
2.45.2

