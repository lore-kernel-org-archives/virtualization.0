Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F211C0DD3
	for <virtualization@lists.linux.dev>; Fri,  2 Aug 2024 07:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722583485; cv=fail; b=Ocg7itu7+zLf10WJAmzW9I8bRdIyD5ca+fPdMi+Z7J7v0HqJ+TmfzjK3vTynIaBb4gTa90JDa/C4ZGvc3sn2fhtpYLBKNAVu+YRSiVdCNpK938f4U3c1xugGdVzNsgekFf3l5BdvISWQlemqXtZqN2tSSA+fLXpCjQmJ90TKgVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722583485; c=relaxed/simple;
	bh=9uGCBqHkq8Qmn0HHjK+cIpTyE7TwIl8u7dAftV9IP8g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=err6DJPdK7gCtPSbCxqtRSOllt5X78T8QgXKiHWMIxSBLdDI+rw0jBLjIA0lJz1GiEGJzddPJlRhrvq3bN7SfLium1ejj1lf02NimHlEL6Ed7/6mDbl22V//G9VS6XMvUzdMYhs6g9QJ40haWz3jSSMeqbuDjMhG0WUjNJ1MrFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=r0Rba11m; arc=fail smtp.client-ip=40.107.93.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="r0Rba11m"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FJ603CHaW7gtUjeOkF/73i0RlhSkLdzHdl1EkpR1C5BS60eMF0Ez5/Un9/y/noPYTy/rbVZa12HkqyP924Gcn1rZmWe8JrZp1ccdmiudjW26i1gAcv9eeHT6HyFm1ZJlKqQJ1sJfLgi1HHaxFmjY3NDS2bvb2vbzuVLLKcjMh5VQ9ppXaq06auL6Haj5rMeqbIlK57b83w7C3IWxhgAdcrmdhv6sEK4DouuBSJRruVX/rYpGmbF34rVvKTyYvNdfwNosHsoYflzIsC8GQxGZBuiIfDQyaBJjDDJoAfkHQtATlxA+lomoxoaNdA0N3GbzBtU7KsMMlEnfAqAL8DQiNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fmkn+/ZzPeR3gOgUm4vohEtfonYNDyg7w8DZJlwvIsQ=;
 b=RQpf5Pl/W9n9uN9y3MhDRSgf17Ju7MMz/FWSBbXDVljb1iXUsP/Pw+XLb55IrCgJijvrgSc5S/TK4DpiUQDnqbU5EFyY0goJdG0hZMiHv9cwsFvYvzVyy5Umm5fiSiI26ecK4VfEUIaATnYjjuEirakQQ5fLkA9kKAK+KABrTPmfdLqqtBLtUFJuLjunN8sBOJa5FJlFCx0Jn7LYA+ilxGMGzKul4k/1Jsc4LrI+SLORIf3s3blb+G33lTLFHt3CeZU0Y/DrtDufQV/7ByzrNRlzknJp6hr1wnU0woA7H3c9P3lwc9eyJWu27HyoQQohYJsugdIuBLgq9829LzkZXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fmkn+/ZzPeR3gOgUm4vohEtfonYNDyg7w8DZJlwvIsQ=;
 b=r0Rba11mVOVKfZmSuo7pk3KSH6NepSXaMqDMJSPDbK85NY3X4uieSMannI46BO45Q/ygSrlUmUrX2i19R9OR/wZDO92Id3GJfnWhpaI+PHHpEmrf3V71Qb5xQBnyFMTELFvRDGT2Q4MJl0i7+TXv5WlcqqW6+dDNeoD9gPpq23aD+xh2IsRuSJI97EbJXpNgDcTSAgl+XmhMO+9b/1okhhKFMA/fOnXhaJpHZ32o1GqWRt68zJTSmewaZczxfFy/OAx25ynw2vgCUm0va20c9HYu9bOQKdZzGP0OXesXVNdX2RtIXse90glFB0p4AICYSAOAJ7I+gSA7B4Puc4t/iA==
Received: from CH5PR02CA0005.namprd02.prod.outlook.com (2603:10b6:610:1ed::7)
 by CY8PR12MB7315.namprd12.prod.outlook.com (2603:10b6:930:51::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Fri, 2 Aug
 2024 07:24:40 +0000
Received: from CH2PEPF00000146.namprd02.prod.outlook.com
 (2603:10b6:610:1ed:cafe::79) by CH5PR02CA0005.outlook.office365.com
 (2603:10b6:610:1ed::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23 via Frontend
 Transport; Fri, 2 Aug 2024 07:24:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF00000146.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Fri, 2 Aug 2024 07:24:40 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 2 Aug 2024
 00:24:28 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 2 Aug 2024
 00:24:27 -0700
Received: from dev-l-177.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 2 Aug 2024 00:24:25 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Dragos Tatulea <dtatulea@nvidia.com>, "Michael S. Tsirkin"
	<mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>, =?UTF-8?q?Eugenio=20P=C3=A9rez?=
	<eperezma@redhat.com>
CC: Si-Wei Liu <si-wei.liu@oracle.com>, Tariq Toukan <tariqt@nvidia.com>,
	<virtualization@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH vhost 2/7] vdpa/mlx5: Introduce error logging function
Date: Fri, 2 Aug 2024 10:20:19 +0300
Message-ID: <20240802072039.267446-3-dtatulea@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000146:EE_|CY8PR12MB7315:EE_
X-MS-Office365-Filtering-Correlation-Id: cccdda9e-c96d-4db1-8772-08dcb2c42c10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?B+5AIGtWW0UnUbPNJbAvgsDZ4oP1J+hVThNebX9uLxifko5ezQi70YWgdECo?=
 =?us-ascii?Q?SUsI1Yq3Vw2eFFjrtiFp5xExU674Mo/VA08zQ9d/hK2G34E65wUAl7lZ8C/8?=
 =?us-ascii?Q?bgleqk6REbfaIKauoZQqLswPfJNcC65BTB7fjtLnC8aPY05t2Ye9M9Zsq3Tb?=
 =?us-ascii?Q?YJw7IZRuzvlHBVtRGhi49jtddtk7p7gYLgleYh7F9QZ0QPdqdZZUTwYEzBxe?=
 =?us-ascii?Q?R6svABCw9dMPtRYacQ24VsjKSzJCHEvbqSihBnHzHIPvrOpb+Qksg8Aw91zF?=
 =?us-ascii?Q?vNJSq+FLWHTrsyMs04yYGZUdAXiUQ07a8vyrGcDfIOZDqv2jTMeww448k6NX?=
 =?us-ascii?Q?QkgFhVi2bcuOX2bGtx4VFgmKtpzIfa8ddVQno/aB1QrfZhiAJJBU4y2BD+p6?=
 =?us-ascii?Q?p9Cud0UyKdF8XsJ9997HANg6sQ9AKKOOf6qiAyynzQEstQ5ji7dSz2QPCofL?=
 =?us-ascii?Q?m7bPc+rG8P6Bw1J2YQtQBQuXjBZCBy91bTeRMrh9xW3B77WvvGmymVs6uMH3?=
 =?us-ascii?Q?tqt8LcA5xHq6GumqrCdImYd4CdATT9URyWC2poXtGZGGLsFxskFbfsJpWcWG?=
 =?us-ascii?Q?yRAsJhZpuwX9wpLXIdIIwM54e7BYRRcdL6tuVCSGjGExVIDRntaCcpYYd06F?=
 =?us-ascii?Q?a9b3f8fLPaX97/PhHSFcrN+AsJK+H75iBgs3dtzl1gda4WR1fKy+NGzVBs4F?=
 =?us-ascii?Q?Yz/n8hhO+RO9Ck5JsBSk0ThJkmD4TWMpHOEEBkRspZP7QZDfdbSSlKA1M7SO?=
 =?us-ascii?Q?HXETdcwGyQdRCD44ZLYTYjy0eQ5GF1EPqor5pJLG5UnvkNG5rgF8/UHHeXVA?=
 =?us-ascii?Q?Jvm19cSA9wr1g5Vf6pMbclBRtA1EcPMpyRnSsZkH039+ZOAiluz+HZ43WCtH?=
 =?us-ascii?Q?WYp6jg4MYUvX5Ld8J/GpfxGdsfkmNvvZ9g/MLnYdUVDfnOd3D/daSVPYy1x3?=
 =?us-ascii?Q?B7EnWQQ7h9XV//TpH49l98mw3Vw+6Y8TcK6Cfvvfes9ZbhHQNz5cArrV9eYZ?=
 =?us-ascii?Q?XPkXq/cPxnTeMYx4vzZu1ZkhKQCZqTp9RIP8TygFHd3w7a0PcxfNL+m6ovs8?=
 =?us-ascii?Q?P9DQLjA0HmsyckC9kuaKhVdR872EOkdwlevYLC0504tM+kUxsdd/ZcnyR5Op?=
 =?us-ascii?Q?x6AUqYqj+AUA329c20qQY6aMVGuJIPKKWsBCxex59n2EinlKHvVzdGTBqliK?=
 =?us-ascii?Q?vH17bOt2b/umOBeT+mAf7h88gTSka/LYReM6D4diJHWlhb2DQVylj/Twrue4?=
 =?us-ascii?Q?oqYTmhMVE7wBJClfnUIrhT5N/QYHtJJddN/PmBiEvE2fDy5bKhioGBiGe5Pz?=
 =?us-ascii?Q?zEtBOOTWyZuaAmR7Scc06fc+rmWxzI+8ItL8u2j2mloWM22leP/Rn1y0q9Gq?=
 =?us-ascii?Q?HFcs2imqkHyIlGjbTTjFLxoilhwXA52QRH7dxuyGGFzAA9VJxMeJsxz7NoJp?=
 =?us-ascii?Q?8SMVazkRGCnuMvR+TTw7Ic6OeNM8CbOk?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2024 07:24:40.1445
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cccdda9e-c96d-4db1-8772-08dcb2c42c10
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000146.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7315

mlx5_vdpa_err() was missing. This patch adds it and uses it in the
necessary places.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/vdpa/mlx5/core/mlx5_vdpa.h |  5 +++++
 drivers/vdpa/mlx5/net/mlx5_vnet.c  | 24 ++++++++++++------------
 2 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/vdpa/mlx5/core/mlx5_vdpa.h b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
index 50aac8fe57ef..424d445ebee4 100644
--- a/drivers/vdpa/mlx5/core/mlx5_vdpa.h
+++ b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
@@ -135,6 +135,11 @@ int mlx5_vdpa_update_cvq_iotlb(struct mlx5_vdpa_dev *mvdev,
 int mlx5_vdpa_create_dma_mr(struct mlx5_vdpa_dev *mvdev);
 int mlx5_vdpa_reset_mr(struct mlx5_vdpa_dev *mvdev, unsigned int asid);
 
+#define mlx5_vdpa_err(__dev, format, ...)                                                          \
+	dev_err((__dev)->mdev->device, "%s:%d:(pid %d) error: " format, __func__, __LINE__,        \
+		 current->pid, ##__VA_ARGS__)
+
+
 #define mlx5_vdpa_warn(__dev, format, ...)                                                         \
 	dev_warn((__dev)->mdev->device, "%s:%d:(pid %d) warning: " format, __func__, __LINE__,     \
 		 current->pid, ##__VA_ARGS__)
diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index fa78e8288ebb..12133e5d1285 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -1538,13 +1538,13 @@ static int suspend_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mv
 
 	err = modify_virtqueue_state(ndev, mvq, MLX5_VIRTIO_NET_Q_OBJECT_STATE_SUSPEND);
 	if (err) {
-		mlx5_vdpa_warn(&ndev->mvdev, "modify to suspend failed, err: %d\n", err);
+		mlx5_vdpa_err(&ndev->mvdev, "modify to suspend failed, err: %d\n", err);
 		return err;
 	}
 
 	err = query_virtqueue(ndev, mvq, &attr);
 	if (err) {
-		mlx5_vdpa_warn(&ndev->mvdev, "failed to query virtqueue, err: %d\n", err);
+		mlx5_vdpa_err(&ndev->mvdev, "failed to query virtqueue, err: %d\n", err);
 		return err;
 	}
 
@@ -1585,7 +1585,7 @@ static int resume_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq
 		 */
 		err = modify_virtqueue(ndev, mvq, 0);
 		if (err) {
-			mlx5_vdpa_warn(&ndev->mvdev,
+			mlx5_vdpa_err(&ndev->mvdev,
 				"modify vq properties failed for vq %u, err: %d\n",
 				mvq->index, err);
 			return err;
@@ -1600,15 +1600,15 @@ static int resume_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq
 	case MLX5_VIRTIO_NET_Q_OBJECT_STATE_RDY:
 		return 0;
 	default:
-		mlx5_vdpa_warn(&ndev->mvdev, "resume vq %u called from bad state %d\n",
+		mlx5_vdpa_err(&ndev->mvdev, "resume vq %u called from bad state %d\n",
 			       mvq->index, mvq->fw_state);
 		return -EINVAL;
 	}
 
 	err = modify_virtqueue_state(ndev, mvq, MLX5_VIRTIO_NET_Q_OBJECT_STATE_RDY);
 	if (err)
-		mlx5_vdpa_warn(&ndev->mvdev, "modify to resume failed for vq %u, err: %d\n",
-			       mvq->index, err);
+		mlx5_vdpa_err(&ndev->mvdev, "modify to resume failed for vq %u, err: %d\n",
+			      mvq->index, err);
 
 	return err;
 }
@@ -2002,13 +2002,13 @@ static int setup_steering(struct mlx5_vdpa_net *ndev)
 
 	ns = mlx5_get_flow_namespace(ndev->mvdev.mdev, MLX5_FLOW_NAMESPACE_BYPASS);
 	if (!ns) {
-		mlx5_vdpa_warn(&ndev->mvdev, "failed to get flow namespace\n");
+		mlx5_vdpa_err(&ndev->mvdev, "failed to get flow namespace\n");
 		return -EOPNOTSUPP;
 	}
 
 	ndev->rxft = mlx5_create_auto_grouped_flow_table(ns, &ft_attr);
 	if (IS_ERR(ndev->rxft)) {
-		mlx5_vdpa_warn(&ndev->mvdev, "failed to create flow table\n");
+		mlx5_vdpa_err(&ndev->mvdev, "failed to create flow table\n");
 		return PTR_ERR(ndev->rxft);
 	}
 	mlx5_vdpa_add_rx_flow_table(ndev);
@@ -2530,7 +2530,7 @@ static int mlx5_vdpa_get_vq_state(struct vdpa_device *vdev, u16 idx, struct vdpa
 
 	err = query_virtqueue(ndev, mvq, &attr);
 	if (err) {
-		mlx5_vdpa_warn(mvdev, "failed to query virtqueue\n");
+		mlx5_vdpa_err(mvdev, "failed to query virtqueue\n");
 		return err;
 	}
 	state->split.avail_index = attr.used_index;
@@ -3189,7 +3189,7 @@ static int mlx5_vdpa_compat_reset(struct vdpa_device *vdev, u32 flags)
 	if ((flags & VDPA_RESET_F_CLEAN_MAP) &&
 	    MLX5_CAP_GEN(mvdev->mdev, umem_uid_0)) {
 		if (mlx5_vdpa_create_dma_mr(mvdev))
-			mlx5_vdpa_warn(mvdev, "create MR failed\n");
+			mlx5_vdpa_err(mvdev, "create MR failed\n");
 	}
 	if (vq_reset)
 		setup_vq_resources(ndev, false);
@@ -3244,7 +3244,7 @@ static int set_map_data(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb *iotlb,
 		new_mr = mlx5_vdpa_create_mr(mvdev, iotlb);
 		if (IS_ERR(new_mr)) {
 			err = PTR_ERR(new_mr);
-			mlx5_vdpa_warn(mvdev, "create map failed(%d)\n", err);
+			mlx5_vdpa_err(mvdev, "create map failed(%d)\n", err);
 			return err;
 		}
 	} else {
@@ -3257,7 +3257,7 @@ static int set_map_data(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb *iotlb,
 	} else {
 		err = mlx5_vdpa_change_map(mvdev, new_mr, asid);
 		if (err) {
-			mlx5_vdpa_warn(mvdev, "change map failed(%d)\n", err);
+			mlx5_vdpa_err(mvdev, "change map failed(%d)\n", err);
 			goto out_err;
 		}
 	}
-- 
2.45.2

