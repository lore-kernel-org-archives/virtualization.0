Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B409C83F01
	for <virtualization@archiver.kernel.org>; Thu, 31 Aug 2023 15:58:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 19877835E9;
	Thu, 31 Aug 2023 15:58:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 19877835E9
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=MXJPPWoF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VPB_8C7D8ac1; Thu, 31 Aug 2023 15:58:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6BE8E83336;
	Thu, 31 Aug 2023 15:58:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6BE8E83336
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 337E7C0039;
	Thu, 31 Aug 2023 15:58:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BED54C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 31 Aug 2023 15:58:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8E8C083336
 for <virtualization@lists.linux-foundation.org>;
 Thu, 31 Aug 2023 15:58:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8E8C083336
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LtK0vwSc5r9K
 for <virtualization@lists.linux-foundation.org>;
 Thu, 31 Aug 2023 15:58:05 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on20616.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::616])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 744B4835CA
 for <virtualization@lists.linux-foundation.org>;
 Thu, 31 Aug 2023 15:58:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 744B4835CA
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ekADxuFSGoYgF9GtD4AM4K2pFLn/YVjOIYUjLzJWzxBk/PDeKl1lVt54zPFkzY3M3tQWU1irfQRSeW4No7Hl4rfwq0SMUn/huEzMDFNpDJMOcrYY2JJkz6n58W6r+p4S/Ar5a4K3EpyAU8/8fVJPOq7VLUwAOdP3ozvNtW7b5QazvVTlkl7cGSGjXHctbpn0mhzWzBRxB54hA+6c1iE7jj1r7oe/z4nbYIjmGDei7ngp2a+fxT4nI3PIm0w2q9FKe/jgNMvdskVfOx0hpGJrP1PUiWPQ1nFvgl4Edkotuokp21eolaimIMEvIx/+LaVNAp6GXNxk8XdBBwzuPQguFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IFhij5ZgMlMpjtlEP68IlERRVlXU16q2+aRiDhUBH1A=;
 b=a7G7ElaEu50tjFo+ja8AgZBOw5LmUV+Pop++4bgSD6T2ub2vQwg3G5xWRSQU9E1V6UBOg9JsDfe5pKBF6SX6R/ebKoaPYbAvyAXmJsuzMj4eQt9tE7XWoGASZO1XnzNnNkQ6Gv2KTEEk4T6ukPnvKKM5YeYUbV/xWjR4zbSl3M5guhs5We8v3fviR/NJNGi8c74wkfKEjUjhc51RKFBk3MgtnpinmvP1YBe5sN83KBqG48CI87ZSQTeW6oH+UhMseAdOlmZ27Fjbtop6gJdb/wwUCATTlabGCj+uY/Y5RB/U+mHxsND8oZDEIm43HJS62Ji8hJSGw6PJyp44fZyzfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IFhij5ZgMlMpjtlEP68IlERRVlXU16q2+aRiDhUBH1A=;
 b=MXJPPWoFScuYJsDUB8hrCPAyyRs4lFuFc+PmLlPmff5CZBVSeWXnrrJFUWsEs6U3QfX6bgsa/QhOHOoPU30Ed2t4ZEinFHg7qwsx9vDsFsW/CnJH0wXRF5NtInMSMOwJM1CcombkYYr6qh5QKVql2wSGqOtap5Q8JBo3z05NSjmQayP72ilBw32zGw4GTb92p050klT8bxL7+/husWWo/HtE7sKeUM7d0OF4iVstlLJRSp8muruHQeY5jOlLJW6EBS0DUwUq/y4kWG1u4UtarjAW8kXE9ztdHvnRX9NSisjp9Op4i2Ue9hGx0OBHnQISpEOVkLe6/+XgVwdObhrakQ==
Received: from MW4P222CA0018.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::23)
 by DS7PR12MB5982.namprd12.prod.outlook.com (2603:10b6:8:7d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Thu, 31 Aug
 2023 15:58:02 +0000
Received: from MWH0EPF000971E5.namprd02.prod.outlook.com
 (2603:10b6:303:114:cafe::fe) by MW4P222CA0018.outlook.office365.com
 (2603:10b6:303:114::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.22 via Frontend
 Transport; Thu, 31 Aug 2023 15:58:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000971E5.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.16 via Frontend Transport; Thu, 31 Aug 2023 15:58:01 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 31 Aug 2023
 08:57:47 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 31 Aug
 2023 08:57:46 -0700
Received: from c-237-113-220-225.mtl.labs.mlnx (10.127.8.12) by
 mail.nvidia.com (10.129.68.10) with Microsoft SMTP Server id 15.2.986.37 via
 Frontend Transport; Thu, 31 Aug 2023 08:57:44 -0700
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Parav Pandit <parav@mellanox.com>
Subject: [PATCH v2] vdpa/mlx5: Fix firmware error on creation of 1k VQs
Date: Thu, 31 Aug 2023 18:50:56 +0300
Message-ID: <20230831155702.1080754-1-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E5:EE_|DS7PR12MB5982:EE_
X-MS-Office365-Filtering-Correlation-Id: d3857c07-9813-49b7-2c4e-08dbaa3b0e39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WkdfPJSKncyfN/2clQlQ77Ie60OP+AeQhdH3QT2rI0qILsO605YNIKQL10qKIbnzzf2Ac7tPdHa+3g/TJBXXfaBCtg/nlysMDlxaoV9NQ/s1n5Bpvt/hNPk+qPqMVw0a6dqIXWE0FgIrMsJFdsogaO8ZpSPer8u5L+3bjRuFV4caKAXG629eJ7bAuQ4z9idq+lxXiTWcAbaReRC605NqUCnqjRLh9pQ5A5kp3LQ6S+1pAHIZ4NVHswfMp9ISFJ6ZHnKhkggdAUxO9jV13iYNMddHbryp8smQifRSt8iMmYDnAw0S53/HC1iY6iKNnyDBnZ408iECmFsHUMWy1mgncT4P52RkkiYod0fsdcVD2gf61NuQQ/GkE5KeX3FTMSAXOnzh1hX0WhIJUiucv34aaJNdOlUpq4TQrijX0CKiToo7pREen5I63F7cAYzLuQuN7oM1kIz7FMCbz5KkCIvUa/cuGzwaYKTeSD/xn1WkVpqjQhfKnzkw9jGARHxhAPe7H/7bHft95nwfCpQVMMY1D2l7iV8Aw2e7aH4+4SjRvSMI0P/u0EROneOSNEkg5G1Pkw7n7mLK+zGSPO2qYm2+5bPkRf21d9Ab4cTFgrDWG045PV28vjv5AOIAob72NSu8PMS4wiZHbN73W5aHnHnnfl8Vgs+HjZ/9imEch7tArxyrDk50J35a5Xhu6dhhVVh51nTESaPvnHqKg42Z6DSp2W0rs9wq7A3kExFh4FDEq592fNGdL78yk9dcgLkZtSDD
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(39860400002)(396003)(376002)(451199024)(82310400011)(1800799009)(186009)(36840700001)(46966006)(40470700004)(6666004)(40480700001)(26005)(2616005)(86362001)(1076003)(40460700003)(4326008)(2906002)(8676002)(5660300002)(8936002)(110136005)(70586007)(36756003)(41300700001)(70206006)(316002)(54906003)(36860700001)(478600001)(356005)(7636003)(83380400001)(82740400003)(47076005)(336012)(426003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 15:58:01.9914 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3857c07-9813-49b7-2c4e-08dbaa3b0e39
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5982
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
From: Dragos Tatulea via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Dragos Tatulea <dtatulea@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

A firmware error is triggered when configuring a 9k MTU on the PF after
switching to switchdev mode and then using a vdpa device with larger
(1k) rings:
mlx5_cmd_out_err: CREATE_GENERAL_OBJECT(0xa00) op_mod(0xd) failed, status bad resource(0x5), syndrome (0xf6db90), err(-22)

This is due to the fact that the hw VQ size parameters are computed
based on the umem_1/2/3_buffer_param_a/b capabilities and all
device capabilities are read only when the driver is moved to switchdev mode.

The problematic configuration flow looks like this:
1) Create VF
2) Unbind VF
3) Switch PF to switchdev mode.
4) Bind VF
5) Set PF MTU to 9k
6) create vDPA device
7) Start VM with vDPA device and 1K queue size

Note that setting the MTU before step 3) doesn't trigger this issue.

This patch reads the forementioned umem parameters at the latest point
possible before the VQs of the device are created.

v2:
- Allocate output with kmalloc to reduce stack frame size.
- Removed stable from cc.

Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 63 ++++++++++++++++++++++++++-----
 drivers/vdpa/mlx5/net/mlx5_vnet.h |  9 +++++
 2 files changed, 63 insertions(+), 9 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 40a03b08d7cf..ef5907b1d513 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -625,30 +625,70 @@ static void cq_destroy(struct mlx5_vdpa_net *ndev, u16 idx)
 	mlx5_db_free(ndev->mvdev.mdev, &vcq->db);
 }
 
+static int read_umem_params(struct mlx5_vdpa_net *ndev)
+{
+	u32 in[MLX5_ST_SZ_DW(query_hca_cap_in)] = {};
+	u16 opmod = (MLX5_CAP_VDPA_EMULATION << 1) | (HCA_CAP_OPMOD_GET_CUR & 0x01);
+	struct mlx5_core_dev *mdev = ndev->mvdev.mdev;
+	int out_size;
+	void *caps;
+	void *out;
+	int err;
+
+	out_size = MLX5_ST_SZ_BYTES(query_hca_cap_out);
+	out = kzalloc(out_size, GFP_KERNEL);
+	if (!out)
+		return -ENOMEM;
+
+	MLX5_SET(query_hca_cap_in, in, opcode, MLX5_CMD_OP_QUERY_HCA_CAP);
+	MLX5_SET(query_hca_cap_in, in, op_mod, opmod);
+	err = mlx5_cmd_exec_inout(mdev, query_hca_cap, in, out);
+	if (err) {
+		mlx5_vdpa_warn(&ndev->mvdev,
+			"Failed reading vdpa umem capabilities with err %d\n", err);
+		goto out;
+	}
+
+	caps =  MLX5_ADDR_OF(query_hca_cap_out, out, capability);
+
+	ndev->umem_1_buffer_param_a = MLX5_GET(virtio_emulation_cap, caps, umem_1_buffer_param_a);
+	ndev->umem_1_buffer_param_b = MLX5_GET(virtio_emulation_cap, caps, umem_1_buffer_param_b);
+
+	ndev->umem_2_buffer_param_a = MLX5_GET(virtio_emulation_cap, caps, umem_2_buffer_param_a);
+	ndev->umem_2_buffer_param_b = MLX5_GET(virtio_emulation_cap, caps, umem_2_buffer_param_b);
+
+	ndev->umem_3_buffer_param_a = MLX5_GET(virtio_emulation_cap, caps, umem_3_buffer_param_a);
+	ndev->umem_3_buffer_param_b = MLX5_GET(virtio_emulation_cap, caps, umem_3_buffer_param_b);
+
+out:
+	kfree(out);
+	return 0;
+}
+
 static void set_umem_size(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq, int num,
 			  struct mlx5_vdpa_umem **umemp)
 {
-	struct mlx5_core_dev *mdev = ndev->mvdev.mdev;
-	int p_a;
-	int p_b;
+	u32 p_a;
+	u32 p_b;
 
 	switch (num) {
 	case 1:
-		p_a = MLX5_CAP_DEV_VDPA_EMULATION(mdev, umem_1_buffer_param_a);
-		p_b = MLX5_CAP_DEV_VDPA_EMULATION(mdev, umem_1_buffer_param_b);
+		p_a = ndev->umem_1_buffer_param_a;
+		p_b = ndev->umem_1_buffer_param_b;
 		*umemp = &mvq->umem1;
 		break;
 	case 2:
-		p_a = MLX5_CAP_DEV_VDPA_EMULATION(mdev, umem_2_buffer_param_a);
-		p_b = MLX5_CAP_DEV_VDPA_EMULATION(mdev, umem_2_buffer_param_b);
+		p_a = ndev->umem_2_buffer_param_a;
+		p_b = ndev->umem_2_buffer_param_b;
 		*umemp = &mvq->umem2;
 		break;
 	case 3:
-		p_a = MLX5_CAP_DEV_VDPA_EMULATION(mdev, umem_3_buffer_param_a);
-		p_b = MLX5_CAP_DEV_VDPA_EMULATION(mdev, umem_3_buffer_param_b);
+		p_a = ndev->umem_3_buffer_param_a;
+		p_b = ndev->umem_3_buffer_param_b;
 		*umemp = &mvq->umem3;
 		break;
 	}
+
 	(*umemp)->size = p_a * mvq->num_ent + p_b;
 }
 
@@ -2679,6 +2719,11 @@ static int setup_driver(struct mlx5_vdpa_dev *mvdev)
 		goto out;
 	}
 	mlx5_vdpa_add_debugfs(ndev);
+
+	err = read_umem_params(ndev);
+	if (err)
+		goto err_setup;
+
 	err = setup_virtqueues(mvdev);
 	if (err) {
 		mlx5_vdpa_warn(mvdev, "setup_virtqueues\n");
diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.h b/drivers/vdpa/mlx5/net/mlx5_vnet.h
index 36c44d9fdd16..65ebbba20662 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.h
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.h
@@ -65,6 +65,15 @@ struct mlx5_vdpa_net {
 	struct hlist_head macvlan_hash[MLX5V_MACVLAN_SIZE];
 	struct mlx5_vdpa_irq_pool irqp;
 	struct dentry *debugfs;
+
+	u32 umem_1_buffer_param_a;
+	u32 umem_1_buffer_param_b;
+
+	u32 umem_2_buffer_param_a;
+	u32 umem_2_buffer_param_b;
+
+	u32 umem_3_buffer_param_a;
+	u32 umem_3_buffer_param_b;
 };
 
 struct mlx5_vdpa_counter {
-- 
2.41.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
