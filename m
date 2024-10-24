Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7AC1714B0
	for <virtualization@lists.linux-foundation.org>; Thu, 24 Oct 2024 13:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729778077; cv=fail; b=WlTpC6qqV9jti2AXpFh6rg4jV+LanqumbPcbUCkNFUPPC8/c6lC86HWDO2ZZcVDk2yanblxA5OPFYeJahz0+ZPJagaHjiGNj7kmb3SSW15zSCvmemsOI8ZCQyVKlNh9ArTYbLS/N3G1HvZBh3r32UV+NtQ34fEwvPKd/hYYvHG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729778077; c=relaxed/simple;
	bh=jyO7eAHGHOjNTYFtsyn0foaCSOwr8KyXEzEiLOkQ5VM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qtXC0HUbEp0Ppty4xEa2qof0jlKkG+7c28vZlqNfVDz3DacpZtXnS6l4XC85u08n9bx1BZ/REx5QErEgRhVdIlD2qkXG0RdRdoqcfclOn6AjOPs3vp/ylTadGBqhmdj4JQvzen9I4H2IdG7uXiBdGzll45Y9VaShy2ggTFtDa+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Fh5YJV/b; arc=fail smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Fh5YJV/b"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 947764077B
	for <virtualization@lists.linux-foundation.org>; Thu, 24 Oct 2024 13:54:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.103
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nj_pt9b1dg9U for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Oct 2024 13:54:34 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:111:f403:200a::613; helo=nam12-mw2-obe.outbound.protection.outlook.com; envelope-from=feliu@nvidia.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 4C9C84077A
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4C9C84077A
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Fh5YJV/b
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on20613.outbound.protection.outlook.com [IPv6:2a01:111:f403:200a::613])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4C9C84077A
	for <virtualization@lists.linux-foundation.org>; Thu, 24 Oct 2024 13:54:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y4iZxBQYQ5QIoaQoArgQFPqCQUKEkks/FuL99HDVTPaZ6Ug0VpvgKegLHRBWG4U+ybcsuPCVeAO6QT/nb6SmsLPoDi7XE88bETk724GBhHNwmqwjPn2j7dczRjDXdbjB7VTvx/hNirQ7jtzebyftNGUFZlFKkGZq7wFMDSnJkSB1ndHGhfhB/PjwizHO6oLzr5m21VJFQYW7wFkbHI1vPWoCLD8M4TDUAU7qav4j3mMLi7yQSXZ1qT64GwbsmQG+RB+pQ3HcAIEkE/PWVkAD/1WVyF2jShzXDcqN5P781dMyhK8b9UNgxYpX9ECrStVIQiYsXm2gsHHwb2TxcE+eQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=to6O/nzs9d8xtskAWdaRAtLf/bK8iUs59lgShcJZx7Y=;
 b=o5XJ73rMPbMCfsQJN7LKnIOsV3DBsGdOD0LlhWj/JyEdzA5gWiUTFaBs1aEFfqDIP3gtHCAMScjBfg5il5M7/1+SBAsmXLovDmXd/sD8yVzCe+rMRoBeuxubdkZmOEZVRS9XfU6VuhtRIuiHGIr5ymibgIRqagHQIByJNVMcuhzqmpoFvU1i7Jb2mIBd/g8chO8IvdrBbI6dWposfRYlWJZ7tu/cgiwdgPftDeuadfKCUMFoR92nCY2K8oUMh+zuZS++Ve5FlNNHx92lIMSQwpYRaZUDXKKHZiHmhGhriO7UbBzsbtlAdC8KPENH6ZvBTJfDnMniLlXOgpqLnQtYLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=to6O/nzs9d8xtskAWdaRAtLf/bK8iUs59lgShcJZx7Y=;
 b=Fh5YJV/b+g6W/9lJkP+6BgPA8wybI512HfQ/VsJu45Ug459oCVZe6qu9eoNaNZ6KT/7mdZbTZqhbOScBUkyqsCoxsS+o1JvzxEl67OSyEkQ+iNkRfWMlQJvQM7G/Vq+37lHceEKrExYFkBhrlxcYb3Z29bD9Fhmht9UDkCkUOAAU3Lw08SSsleHPNLVGoKqzwLkDjrhK4IswW6Jpy6uxgR1lQ5NN5/jFpDnVR2hioBGsyBS9mD6EWSw+jPReYeWNqOKu4yJPdteTYvMsK+1MqeXpEDq936Q+6e0fpZY5CHZ202y7nqaQJbFrrGHdVJXWWfs0saGDdGOLuRx9+xoJwQ==
Received: from MW4P220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::8)
 by PH8PR12MB7229.namprd12.prod.outlook.com (2603:10b6:510:227::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.32; Thu, 24 Oct
 2024 13:54:28 +0000
Received: from CO1PEPF000075F3.namprd03.prod.outlook.com
 (2603:10b6:303:115:cafe::34) by MW4P220CA0003.outlook.office365.com
 (2603:10b6:303:115::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28 via Frontend
 Transport; Thu, 24 Oct 2024 13:54:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000075F3.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Thu, 24 Oct 2024 13:54:27 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 24 Oct
 2024 06:54:10 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 24 Oct
 2024 06:54:10 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 24 Oct
 2024 06:54:09 -0700
From: Feng Liu <feliu@nvidia.com>
To: <virtualization@lists.linux-foundation.org>
CC: Jason Wang <jasowang@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
	Bodong Wang <bodong@nvidia.com>, Feng Liu <feliu@nvidia.com>, Jiri Pirko
	<jiri@nvidia.com>, Parav Pandit <parav@nvidia.com>
Subject: [PATCH] virtio_pci: Fix admin vq cleanup by using correct info pointer
Date: Thu, 24 Oct 2024 09:54:06 -0400
Message-ID: <20241024135406.81388-1-feliu@nvidia.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F3:EE_|PH8PR12MB7229:EE_
X-MS-Office365-Filtering-Correlation-Id: 55fcf485-f85e-4f4d-1f67-08dcf4336025
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?d3KhqB2yKbACBSVYfhCw544Ue3HF7sYcETkr64dK2eRSRt3wPfktsyxZqSqM?=
 =?us-ascii?Q?+4scknmr9pTbwqycCKCTiQox8XMgGU1CYbmSSFKgTO5K92V39f6QFhVj1B9d?=
 =?us-ascii?Q?Z2xeaIAyhaiEsFQxllBaydqyZJOsNZjHuOAIkYglo2gptfPz0sGVLZnl8XrL?=
 =?us-ascii?Q?gRuSPV+eF7TfOal3sogA7EtEfi6Jaw40LC3qOlSW9guuOD042/4cKILyFKm1?=
 =?us-ascii?Q?YQPdh1ZQlZGLUaSler0hxbFIUay5aYDPhbyBc3+ZtPjkkt389BoVy+l6Z3WA?=
 =?us-ascii?Q?q3vPyixnK/ZC6/EYXSi/QghU44EmMUms8eb3pShwFQa/doZ4rG3M1x+IAQAo?=
 =?us-ascii?Q?Jq4xFGE6o/E/BkqyLK+fVRbQXcOlU8RDiDI4DMUnlvbwVQCIPkhfxDioBSpZ?=
 =?us-ascii?Q?97GeBor5h03iDSlm5xrMYzMwTkh/nE6GonFIM+A046M0F+80jBKhsH6Vurte?=
 =?us-ascii?Q?ymveG+teNOuOnQycjaXJCeGMelbRcch6HocbGmZaTUiNKiBnTgZ63wwczJ4/?=
 =?us-ascii?Q?7ndcfyg21FHQSh9XnGtdWp6JOdF3tJStfcpnd5S5x2l4Jmzefz5wjipFO1zz?=
 =?us-ascii?Q?TjSdwx9QweV14RezNngmdkxZN/hmcwFf68biVLI7MG570YOC2w3NM82+t85W?=
 =?us-ascii?Q?Z9gnbPQCtY6HXqHGtIJCZY8XGCFH/NRm7QFINQDyAusXrMRULFd1XR3BsAsV?=
 =?us-ascii?Q?YQG1om4VQfiwHABg+R4oqHmWU/vguxgi1HfKsoQfoBRFFe7/ERtxPo8Qzgpz?=
 =?us-ascii?Q?ELu/eYikuBR+YdfY8RwQ03agSBdeRz4cE0CeaDMMxjPIBfaQp//iJbEKt9xo?=
 =?us-ascii?Q?U2AW1uh8EKSQU4RY5Wu7UTBfu1O324OlNgqejZB+FBUnycWoL0CaQ2HlqmxS?=
 =?us-ascii?Q?SB6mAaV6R9tl3YlXr2UMlXVgEnQ3cNJKqXUa5OD11zRXCTwqbxkmjiFI1+Kz?=
 =?us-ascii?Q?Z0eK3nKYiwAaM56FRViKthjj8vGcoJiuj427fPvfQOqYVTImTr7mcjA+T6mV?=
 =?us-ascii?Q?pCXjXyAKRMlpqyx0yQGwnvsu3epi1eWGiasbY7x0jua21r20Ct1RWDoTobUI?=
 =?us-ascii?Q?JuR6w6sdcAj6BIH52ieoyl4O69a/i48uwTQIsjBbcVqANidIfDfKRz8Y7oIg?=
 =?us-ascii?Q?l/JPaSBiGYwQUm3JlCnn2PKyG1DAvq/rHzAkynoIMkY7WH6QGVErw8W09Tc0?=
 =?us-ascii?Q?iRbOX1roFLucF6nP0STg4Yhf6xvEq7eLoLQkjWN6QGMh409SFd2utJQdizM8?=
 =?us-ascii?Q?hXQkG/bf7m5Ec4TxApfosELSdUrqeHHKR108En5noxIR8ifr/U702sf9S0CQ?=
 =?us-ascii?Q?ygpFASIeULoaxdgb8wdpnPtl2BaRCf6PCXHuxPeth7mQT1RQhz0dBgx43MlK?=
 =?us-ascii?Q?O735A7ERKWSX2LadeFbqyX6HfRTFtUeCkPHbHHHlVsQ2llWD7Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 13:54:27.2385
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55fcf485-f85e-4f4d-1f67-08dcf4336025
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075F3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7229

vp_modern_avq_cleanup() and vp_del_vqs() clean up admin vq
resources by virtio_pci_vq_info pointer. The info pointer of admin
vq is stored in vp_dev->admin_vq.info instead of vp_dev->vqs[].
Using the info pointer from vp_dev->vqs[] for admin vq causes a
kernel NULL pointer dereference bug.
In vp_modern_avq_cleanup() and vp_del_vqs(), get the info pointer
from vp_dev->admin_vq.info for admin vq to clean up the resources.
Also make info ptr as argument of vp_del_vq() to be symmetric with
vp_setup_vq().

vp_reset calls vp_modern_avq_cleanup, and causes the Call Trace:
==================================================================
BUG: kernel NULL pointer dereference, address:0000000000000000
...
CPU: 49 UID: 0 PID: 4439 Comm: modprobe Not tainted 6.11.0-rc5 #1
RIP: 0010:vp_reset+0x57/0x90 [virtio_pci]
Call Trace:
 <TASK>
...
 ? vp_reset+0x57/0x90 [virtio_pci]
 ? vp_reset+0x38/0x90 [virtio_pci]
 virtio_reset_device+0x1d/0x30
 remove_vq_common+0x1c/0x1a0 [virtio_net]
 virtnet_remove+0xa1/0xc0 [virtio_net]
 virtio_dev_remove+0x46/0xa0
...
 virtio_pci_driver_exit+0x14/0x810 [virtio_pci]
==================================================================

Fixes: 4c3b54af907e ("virtio_pci_modern: use completion instead of busy loop to wait on admin cmd result")
Signed-off-by: Feng Liu <feliu@nvidia.com>
Signed-off-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
---
 drivers/virtio/virtio_pci_common.c | 24 ++++++++++++++++++------
 drivers/virtio/virtio_pci_common.h |  1 +
 drivers/virtio/virtio_pci_modern.c | 12 +-----------
 3 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index c44d8ba00c02..88074451dd61 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -24,6 +24,16 @@ MODULE_PARM_DESC(force_legacy,
 		 "Force legacy mode for transitional virtio 1 devices");
 #endif
 
+bool vp_is_avq(struct virtio_device *vdev, unsigned int index)
+{
+	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
+
+	if (!virtio_has_feature(vdev, VIRTIO_F_ADMIN_VQ))
+		return false;
+
+	return index == vp_dev->admin_vq.vq_index;
+}
+
 /* wait for pending irq handlers */
 void vp_synchronize_vectors(struct virtio_device *vdev)
 {
@@ -234,10 +244,9 @@ static struct virtqueue *vp_setup_vq(struct virtio_device *vdev, unsigned int in
 	return vq;
 }
 
-static void vp_del_vq(struct virtqueue *vq)
+static void vp_del_vq(struct virtqueue *vq, struct virtio_pci_vq_info *info)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vq->vdev);
-	struct virtio_pci_vq_info *info = vp_dev->vqs[vq->index];
 	unsigned long flags;
 
 	/*
@@ -258,13 +267,16 @@ static void vp_del_vq(struct virtqueue *vq)
 void vp_del_vqs(struct virtio_device *vdev)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
+	struct virtio_pci_vq_info *info;
 	struct virtqueue *vq, *n;
 	int i;
 
 	list_for_each_entry_safe(vq, n, &vdev->vqs, list) {
-		if (vp_dev->per_vq_vectors) {
-			int v = vp_dev->vqs[vq->index]->msix_vector;
+		info = vp_is_avq(vdev, vq->index) ? vp_dev->admin_vq.info :
+						    vp_dev->vqs[vq->index];
 
+		if (vp_dev->per_vq_vectors) {
+			int v = info->msix_vector;
 			if (v != VIRTIO_MSI_NO_VECTOR &&
 			    !vp_is_slow_path_vector(v)) {
 				int irq = pci_irq_vector(vp_dev->pci_dev, v);
@@ -273,7 +285,7 @@ void vp_del_vqs(struct virtio_device *vdev)
 				free_irq(irq, vq);
 			}
 		}
-		vp_del_vq(vq);
+		vp_del_vq(vq, info);
 	}
 	vp_dev->per_vq_vectors = false;
 
@@ -354,7 +366,7 @@ vp_find_one_vq_msix(struct virtio_device *vdev, int queue_idx,
 			  vring_interrupt, 0,
 			  vp_dev->msix_names[msix_vec], vq);
 	if (err) {
-		vp_del_vq(vq);
+		vp_del_vq(vq, *p_info);
 		return ERR_PTR(err);
 	}
 
diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
index 1d9c49947f52..8beecf23ec85 100644
--- a/drivers/virtio/virtio_pci_common.h
+++ b/drivers/virtio/virtio_pci_common.h
@@ -178,6 +178,7 @@ struct virtio_device *virtio_pci_vf_get_pf_dev(struct pci_dev *pdev);
 #define VIRTIO_ADMIN_CMD_BITMAP 0
 #endif
 
+bool vp_is_avq(struct virtio_device *vdev, unsigned int index);
 void vp_modern_avq_done(struct virtqueue *vq);
 int vp_modern_admin_cmd_exec(struct virtio_device *vdev,
 			     struct virtio_admin_cmd *cmd);
diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index 9193c30d640a..4fbcbc7a9ae1 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -43,16 +43,6 @@ static int vp_avq_index(struct virtio_device *vdev, u16 *index, u16 *num)
 	return 0;
 }
 
-static bool vp_is_avq(struct virtio_device *vdev, unsigned int index)
-{
-	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
-
-	if (!virtio_has_feature(vdev, VIRTIO_F_ADMIN_VQ))
-		return false;
-
-	return index == vp_dev->admin_vq.vq_index;
-}
-
 void vp_modern_avq_done(struct virtqueue *vq)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vq->vdev);
@@ -245,7 +235,7 @@ static void vp_modern_avq_cleanup(struct virtio_device *vdev)
 	if (!virtio_has_feature(vdev, VIRTIO_F_ADMIN_VQ))
 		return;
 
-	vq = vp_dev->vqs[vp_dev->admin_vq.vq_index]->vq;
+	vq = vp_dev->admin_vq.info->vq;
 	if (!vq)
 		return;
 
-- 
2.37.1 (Apple Git-137.1)

