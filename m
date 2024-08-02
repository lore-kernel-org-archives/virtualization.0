Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C12F1C0DF4
	for <virtualization@lists.linux.dev>; Fri,  2 Aug 2024 07:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722583494; cv=fail; b=A9zryrw80+Qq16CHYDi0GvFnqNPSXeQrnXJ8om29ZOyVsFpwMNdOnzjW/t/YLEG9vxKRMACJxSNttll+ErLi0zzbNCeyFlNxcRHcEnIwdCat0Yeab+nM6oBA79oBj2Kz0MIi8/5JTtANkmYSPm0GflaxA8UR49SCDN97S2dkp3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722583494; c=relaxed/simple;
	bh=AQC6nrmSXuQue3Ae81zOXQbcl5D7ZHr/xGNZcvgcDL8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eE2BN19BJd/dNCLbwcqIf+lDNoNHjDgKByDbjay/HI+ChIqLnOAtnocUhXOxaAhDs6DA+BiRejERRrHR3FSgDGcCEw+YIfl60KPRFa25y5ENTYZiAtcfIsqq1INGke3AbaN2l/BihjsM3Aq3QUBwKt5PWu08G2B/dJ0mhjuS8Hc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rOcE1IYD; arc=fail smtp.client-ip=40.107.220.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rOcE1IYD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bzq7fV0mofnLYDMb99bEDGFm/eQ46t6H/n/4cCFcSPvY1tGA8HH9z8chR9LBqg836FY9n/HsuT67oZnDqSZdzNqdOUhZe/jLGlYcnzbiZUnzWnHsF2m7zRSqVELpStQpLwOJcPM+jaJw/4b9MjdxKwAbzsEj1nfSRew3QOJR5K6VECXMf+zXwCl1JGq6v/x23MLmQEauZWlhQUV386DqjcVMZDWJD9BS+wk0DGatqsBJqa89w3zdtn7hKq95Im4p4RAmQFt99z8+co0TreUSfrV3MPlog6BS5BsXJ1yTMlm4KQEfAybaQUM7F8OrXjpMahuSvXHlhlVZF28EuJZyDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GmD8ZNeHPCAb5iNDNcSObGVC0wf0GlR1gfYLa+WmHGw=;
 b=GhE+8RDs5H9NjYlB1JjktkLB140ae++VaEp4+KgTkQBuqS/o3Ovqm+uYecqHPWBTF8Zkr+XGwAX3HkBzdX5Lx30dhEizC1YBz/iDV37NYTa/7m+FsAJhzkfxcpIKNWVkqa3Y+fcyrECp8RjeUR7DBoGgcJqsHOdgOhyaff0k1SWaMRHqUa/Te8OHHrQXmJcu1Xn2tjUUdtZTiArZpztlfoHN6HRSByv1klil3nH4/tE5tTsTvL3fZvTGkIhnlX7ANs8hvUnQcyW8TLO+9VCoZE7aYcwhZqVNE0bw6HNC4J8XUO2YktZfi3j1dM3clkaNKPwc/O+TmyX+mXTBznsGpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GmD8ZNeHPCAb5iNDNcSObGVC0wf0GlR1gfYLa+WmHGw=;
 b=rOcE1IYDi4gIY1ZoVXIQTZkRCJB6Frad741dvmx12qKAlunmQ+KpChhBFk342Im1o8yMJfBTVfhWCKWEEOLXdv3rMabYESJ3sQnGeXKJr6WqTV9w+0O54fP0fEbECSY5QIQZY3TsNEKAAOrgx8mSZ9LBZvepSlAsEL3ptvlNRd0ttup/XwVixxW2xsycu0ZN3iNJmLjvjFT9OMiXFzxdBA7mI2iFhyXk7gF+Cy0kfxLGC9mS2LCjVQ7aJzqiScu+4Bmcr8wk40WO15hVW8RzyLE8i8GIt9dEMkYJTs+ALO82CGsDsFAlxX+QPuNyjjowqNM237IUBjVax9BWy7lFqw==
Received: from CH5PR03CA0008.namprd03.prod.outlook.com (2603:10b6:610:1f1::26)
 by DM4PR12MB6541.namprd12.prod.outlook.com (2603:10b6:8:88::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Fri, 2 Aug
 2024 07:24:49 +0000
Received: from CH2PEPF00000143.namprd02.prod.outlook.com
 (2603:10b6:610:1f1:cafe::79) by CH5PR03CA0008.outlook.office365.com
 (2603:10b6:610:1f1::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23 via Frontend
 Transport; Fri, 2 Aug 2024 07:24:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF00000143.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Fri, 2 Aug 2024 07:24:49 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 2 Aug 2024
 00:24:36 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 2 Aug 2024
 00:24:35 -0700
Received: from dev-l-177.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 2 Aug 2024 00:24:33 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Dragos Tatulea <dtatulea@nvidia.com>, "Michael S. Tsirkin"
	<mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>, =?UTF-8?q?Eugenio=20P=C3=A9rez?=
	<eperezma@redhat.com>
CC: Si-Wei Liu <si-wei.liu@oracle.com>, Tariq Toukan <tariqt@nvidia.com>,
	<virtualization@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH vhost 4/7] vdpa/mlx5: Use async API for vq modify commands
Date: Fri, 2 Aug 2024 10:20:21 +0300
Message-ID: <20240802072039.267446-5-dtatulea@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000143:EE_|DM4PR12MB6541:EE_
X-MS-Office365-Filtering-Correlation-Id: d9813031-532d-48d6-4d97-08dcb2c43188
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OJc9a7/6HyeP1j1cCr11SSK7OU/ry9HU1SdLkCrbX/m6GtD55cjWY3UQKOXg?=
 =?us-ascii?Q?So4MJkHXCbnXJRDvYiCGXoPZJvuuttRCZIHqzpKp0ShDAu/ILeJsbVX20pNQ?=
 =?us-ascii?Q?RisVjUsaEU9nzeSFqLv4M2WkXln95JU42YmqVbACCKPQa4o/KiExX8I8Y00M?=
 =?us-ascii?Q?hXxLtApB+nyi1zBDXBC7gadr2ToSYUxihfmQWJjwzWSVXxCFs+kKy86i65Hv?=
 =?us-ascii?Q?EHP7k3ZN8vDc99dyrrxRWwJnuXOidW3yciRtlFHgW0KFaF+IITBP7IzKT5ye?=
 =?us-ascii?Q?RxBFiDx1JxBGWdgEXfjSyWiUiOejdjZynqN3oSsKSFRjS4AcEkGXB2UXevYc?=
 =?us-ascii?Q?MeG8iFO6x2BHyEenoCceWeLQ5sAyiMhwKnT4XrIP0pIKP4p8U5SRAdew+LmS?=
 =?us-ascii?Q?dLw1FmWGPaKZuGevWVN634hLxEEpPk5htZGO0z6GgXqv9hbbNHAHm9ZI6yoe?=
 =?us-ascii?Q?kiDKS45ZdNzMQ06YpVbx0Dltds+LrQziOU4hrhCullc+ImCnA7CtCAnn0/fF?=
 =?us-ascii?Q?7mrSHf0XpwuHw9SSLdDiAqNF6b1hZwn9wIt2vUHYxnI5qaq/Z3poBoc1ov4J?=
 =?us-ascii?Q?+kqH32uhnfoVuTYw6SYOVhv21DiVv0A8HXrXWF/IF1LQe34kAZdirl7PVkGu?=
 =?us-ascii?Q?xg60ENMi4Kd+2h/Kerv5yqUX/i39Jobuq8ssiHRTe90pOcrD4eadDbhvU2eI?=
 =?us-ascii?Q?O0E5KC634wGguXCR0DywHvo5O9QD1+7Wlf5qT+fsypdHAYjx1oYM+KxmlgmC?=
 =?us-ascii?Q?BR7suBaxH1de0+NBZT4u423NgTdKzQdmJs0MHPf6yiW9qf/+oyLmg+AXVSv7?=
 =?us-ascii?Q?00TZSf64rKg9uLiDHobYs6sf5O6Yv4MakIlAn99Vnfk/ahsYkfNp0lJga/9s?=
 =?us-ascii?Q?zL9OczGp/ROSwYTtNS664MhLcp9x7Cv3qDu9xN4IFoTwEict/RgEhfLTlxkX?=
 =?us-ascii?Q?KIEacRAsX7mosqKbD+JTusOZBiyYmAa/4CaIO1Uf0EApqJYN34v/OSXcJGqA?=
 =?us-ascii?Q?DpIHwJz1mxKBfNsBbqcbT5EDASXj6w4Tm7dXBvcdiUB8sExuS8t+KZXMjKT5?=
 =?us-ascii?Q?fK4k2AU2LEBxOgHyiWjSlqe+/7n8ayWmFRaUBbKUs2b7TvaJ0sHjV/YewLuP?=
 =?us-ascii?Q?+5RT39a1YV+RwgMrvGckn/MiBZvS1dGXNiFElQn0vQe23sEMSCiGTv9BfbO4?=
 =?us-ascii?Q?GK8zHrRiuujqv0BMF9fymlVaDAaFGcSK+dodqwKqhOm30fzb1zKh4r0Db5GR?=
 =?us-ascii?Q?3GBRvA5sD0KmHjlH4G49qlQUqpxxwy3LxMsnRSsdweMlwQtJPGEwkiOoBmZ1?=
 =?us-ascii?Q?SwvKrw2gHJH3RP77L4FH5Tk+euRAUYzY39v1+urZctiFMvxqb3AJUUtazFds?=
 =?us-ascii?Q?gHjbD7EozEtb6VeqNta+tSVdkO8pDkijObJz/+9ra2yqqfpEPtZyTGHW1GXQ?=
 =?us-ascii?Q?cklpM0lIZAM4LTHD6mqL+eBoV4e/PXMF?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2024 07:24:49.2555
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9813031-532d-48d6-4d97-08dcb2c43188
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000143.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6541

Switch firmware vq modify command to be issued via the async API to
allow future parallelization. The new refactored function applies the
modify on a range of vqs and waits for their execution to complete.

For now the command is still used in a serial fashion. A later patch
will switch to modifying multiple vqs in parallel.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 150 ++++++++++++++++++++----------
 1 file changed, 103 insertions(+), 47 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index be8df9d9f4df..e56a0ee1b725 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -1189,6 +1189,12 @@ struct mlx5_virtqueue_query_mem {
 	u8 out[MLX5_ST_SZ_BYTES(query_virtio_net_q_out)];
 };
 
+struct mlx5_virtqueue_modify_mem {
+	u8 in[MLX5_ST_SZ_BYTES(modify_virtio_net_q_in)];
+	u8 out[MLX5_ST_SZ_BYTES(modify_virtio_net_q_out)];
+};
+
+
 struct mlx5_vdpa_async_virtqueue_cmd {
 	int err;
 	struct mlx5_async_work cb_work;
@@ -1202,6 +1208,7 @@ struct mlx5_vdpa_async_virtqueue_cmd {
 
 	union {
 		struct mlx5_virtqueue_query_mem query;
+		struct mlx5_virtqueue_modify_mem modify;
 	};
 };
 
@@ -1384,51 +1391,35 @@ static bool modifiable_virtqueue_fields(struct mlx5_vdpa_virtqueue *mvq)
 	return true;
 }
 
-static int modify_virtqueue(struct mlx5_vdpa_net *ndev,
-			    struct mlx5_vdpa_virtqueue *mvq,
-			    int state)
+static void fill_modify_virtqueue_cmd(struct mlx5_vdpa_net *ndev,
+				      struct mlx5_vdpa_virtqueue *mvq,
+				      int state,
+				      struct mlx5_vdpa_async_virtqueue_cmd *cmd)
 {
-	int inlen = MLX5_ST_SZ_BYTES(modify_virtio_net_q_in);
-	u32 out[MLX5_ST_SZ_DW(modify_virtio_net_q_out)] = {};
 	struct mlx5_vdpa_dev *mvdev = &ndev->mvdev;
 	struct mlx5_vdpa_mr *desc_mr = NULL;
 	struct mlx5_vdpa_mr *vq_mr = NULL;
-	bool state_change = false;
 	void *obj_context;
 	void *cmd_hdr;
 	void *vq_ctx;
-	void *in;
-	int err;
 
-	if (mvq->fw_state == MLX5_VIRTIO_NET_Q_OBJECT_NONE)
-		return 0;
-
-	if (!modifiable_virtqueue_fields(mvq))
-		return -EINVAL;
-
-	in = kzalloc(inlen, GFP_KERNEL);
-	if (!in)
-		return -ENOMEM;
+	cmd->in = &cmd->modify.in;
+	cmd->inlen = sizeof(cmd->modify.in);
+	cmd->out = &cmd->modify.out;
+	cmd->outlen = sizeof(cmd->modify.out);
 
-	cmd_hdr = MLX5_ADDR_OF(modify_virtio_net_q_in, in, general_obj_in_cmd_hdr);
+	cmd_hdr = MLX5_ADDR_OF(modify_virtio_net_q_in, cmd->in, general_obj_in_cmd_hdr);
 
 	MLX5_SET(general_obj_in_cmd_hdr, cmd_hdr, opcode, MLX5_CMD_OP_MODIFY_GENERAL_OBJECT);
 	MLX5_SET(general_obj_in_cmd_hdr, cmd_hdr, obj_type, MLX5_OBJ_TYPE_VIRTIO_NET_Q);
 	MLX5_SET(general_obj_in_cmd_hdr, cmd_hdr, obj_id, mvq->virtq_id);
 	MLX5_SET(general_obj_in_cmd_hdr, cmd_hdr, uid, ndev->mvdev.res.uid);
 
-	obj_context = MLX5_ADDR_OF(modify_virtio_net_q_in, in, obj_context);
+	obj_context = MLX5_ADDR_OF(modify_virtio_net_q_in, cmd->in, obj_context);
 	vq_ctx = MLX5_ADDR_OF(virtio_net_q_object, obj_context, virtio_q_context);
 
-	if (mvq->modified_fields & MLX5_VIRTQ_MODIFY_MASK_STATE) {
-		if (!is_valid_state_change(mvq->fw_state, state, is_resumable(ndev))) {
-			err = -EINVAL;
-			goto done;
-		}
-
+	if (mvq->modified_fields & MLX5_VIRTQ_MODIFY_MASK_STATE)
 		MLX5_SET(virtio_net_q_object, obj_context, state, state);
-		state_change = true;
-	}
 
 	if (mvq->modified_fields & MLX5_VIRTQ_MODIFY_MASK_VIRTIO_Q_ADDRS) {
 		MLX5_SET64(virtio_q, vq_ctx, desc_addr, mvq->desc_addr);
@@ -1474,38 +1465,36 @@ static int modify_virtqueue(struct mlx5_vdpa_net *ndev,
 	}
 
 	MLX5_SET64(virtio_net_q_object, obj_context, modify_field_select, mvq->modified_fields);
-	err = mlx5_cmd_exec(ndev->mvdev.mdev, in, inlen, out, sizeof(out));
-	if (err)
-		goto done;
+}
 
-	if (state_change)
-		mvq->fw_state = state;
+static void modify_virtqueue_end(struct mlx5_vdpa_net *ndev,
+				 struct mlx5_vdpa_virtqueue *mvq,
+				 int state)
+{
+	struct mlx5_vdpa_dev *mvdev = &ndev->mvdev;
 
 	if (mvq->modified_fields & MLX5_VIRTQ_MODIFY_MASK_VIRTIO_Q_MKEY) {
+		unsigned int asid = mvdev->group2asid[MLX5_VDPA_DATAVQ_GROUP];
+		struct mlx5_vdpa_mr *vq_mr = mvdev->mr[asid];
+
 		mlx5_vdpa_put_mr(mvdev, mvq->vq_mr);
 		mlx5_vdpa_get_mr(mvdev, vq_mr);
 		mvq->vq_mr = vq_mr;
 	}
 
 	if (mvq->modified_fields & MLX5_VIRTQ_MODIFY_MASK_DESC_GROUP_MKEY) {
+		unsigned int asid = mvdev->group2asid[MLX5_VDPA_DATAVQ_DESC_GROUP];
+		struct mlx5_vdpa_mr *desc_mr = mvdev->mr[asid];
+
 		mlx5_vdpa_put_mr(mvdev, mvq->desc_mr);
 		mlx5_vdpa_get_mr(mvdev, desc_mr);
 		mvq->desc_mr = desc_mr;
 	}
 
-	mvq->modified_fields = 0;
-
-done:
-	kfree(in);
-	return err;
-}
+	if (mvq->modified_fields & MLX5_VIRTQ_MODIFY_MASK_STATE)
+		mvq->fw_state = state;
 
-static int modify_virtqueue_state(struct mlx5_vdpa_net *ndev,
-				  struct mlx5_vdpa_virtqueue *mvq,
-				  unsigned int state)
-{
-	mvq->modified_fields |= MLX5_VIRTQ_MODIFY_MASK_STATE;
-	return modify_virtqueue(ndev, mvq, state);
+	mvq->modified_fields = 0;
 }
 
 static int counter_set_alloc(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq)
@@ -1658,6 +1647,73 @@ static int setup_vq(struct mlx5_vdpa_net *ndev,
 	return err;
 }
 
+static int modify_virtqueues(struct mlx5_vdpa_net *ndev, int start_vq, int num_vqs, int state)
+{
+	struct mlx5_vdpa_async_virtqueue_cmd *cmds;
+	struct mlx5_vdpa_dev *mvdev = &ndev->mvdev;
+	int err = 0;
+
+	WARN(start_vq + num_vqs > mvdev->max_vqs, "modify vq range invalid [%d, %d), max_vqs: %u\n",
+	     start_vq, start_vq + num_vqs, mvdev->max_vqs);
+
+	cmds = kvcalloc(num_vqs, sizeof(*cmds), GFP_KERNEL);
+	if (!cmds)
+		return -ENOMEM;
+
+	for (int i = 0; i < num_vqs; i++) {
+		struct mlx5_vdpa_async_virtqueue_cmd *cmd = &cmds[i];
+		struct mlx5_vdpa_virtqueue *mvq;
+		int vq_idx = start_vq + i;
+
+		mvq = &ndev->vqs[vq_idx];
+
+		if (!modifiable_virtqueue_fields(mvq)) {
+			err = -EINVAL;
+			goto done;
+		}
+
+		if (mvq->fw_state != state) {
+			if (!is_valid_state_change(mvq->fw_state, state, is_resumable(ndev))) {
+				err = -EINVAL;
+				goto done;
+			}
+
+			mvq->modified_fields |= MLX5_VIRTQ_MODIFY_MASK_STATE;
+		}
+
+		fill_modify_virtqueue_cmd(ndev, mvq, state, cmd);
+	}
+
+	err = exec_virtqueue_async_cmds(ndev, cmds, num_vqs);
+	if (err) {
+		mlx5_vdpa_err(mvdev, "error issuing modify cmd for vq range [%d, %d)\n",
+			      start_vq, start_vq + num_vqs);
+		goto done;
+	}
+
+	for (int i = 0; i < num_vqs; i++) {
+		struct mlx5_vdpa_async_virtqueue_cmd *cmd = &cmds[i];
+		struct mlx5_vdpa_virtqueue *mvq;
+		int vq_idx = start_vq + i;
+
+		mvq = &ndev->vqs[vq_idx];
+
+		if (cmd->err) {
+			mlx5_vdpa_err(mvdev, "modify vq %d failed, state: %d -> %d, err: %d\n",
+				      vq_idx, mvq->fw_state, state, err);
+			if (!err)
+				err = cmd->err;
+			continue;
+		}
+
+		modify_virtqueue_end(ndev, mvq, state);
+	}
+
+done:
+	kfree(cmds);
+	return err;
+}
+
 static int suspend_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq)
 {
 	struct mlx5_virtq_attr attr;
@@ -1669,7 +1725,7 @@ static int suspend_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mv
 	if (mvq->fw_state != MLX5_VIRTIO_NET_Q_OBJECT_STATE_RDY)
 		return 0;
 
-	err = modify_virtqueue_state(ndev, mvq, MLX5_VIRTIO_NET_Q_OBJECT_STATE_SUSPEND);
+	err = modify_virtqueues(ndev, mvq->index, 1, MLX5_VIRTIO_NET_Q_OBJECT_STATE_SUSPEND);
 	if (err) {
 		mlx5_vdpa_err(&ndev->mvdev, "modify to suspend failed, err: %d\n", err);
 		return err;
@@ -1716,7 +1772,7 @@ static int resume_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq
 		/* Due to a FW quirk we need to modify the VQ fields first then change state.
 		 * This should be fixed soon. After that, a single command can be used.
 		 */
-		err = modify_virtqueue(ndev, mvq, 0);
+		err = modify_virtqueues(ndev, mvq->index, 1, mvq->fw_state);
 		if (err) {
 			mlx5_vdpa_err(&ndev->mvdev,
 				"modify vq properties failed for vq %u, err: %d\n",
@@ -1738,7 +1794,7 @@ static int resume_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq
 		return -EINVAL;
 	}
 
-	err = modify_virtqueue_state(ndev, mvq, MLX5_VIRTIO_NET_Q_OBJECT_STATE_RDY);
+	err = modify_virtqueues(ndev, mvq->index, 1, MLX5_VIRTIO_NET_Q_OBJECT_STATE_RDY);
 	if (err)
 		mlx5_vdpa_err(&ndev->mvdev, "modify to resume failed for vq %u, err: %d\n",
 			      mvq->index, err);
-- 
2.45.2

