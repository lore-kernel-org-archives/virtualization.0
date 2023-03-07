Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E528AC678DB
	for <virtualization@archiver.kernel.org>; Tue,  7 Mar 2023 03:57:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5058E60758;
	Tue,  7 Mar 2023 03:57:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5058E60758
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=GgpPPWFH
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HXkW4kmBKIgU; Tue,  7 Mar 2023 03:57:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9377F60F98;
	Tue,  7 Mar 2023 03:57:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9377F60F98
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 711C4C0035;
	Tue,  7 Mar 2023 03:57:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C1039C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Mar 2023 03:57:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 96D294097E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Mar 2023 03:57:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 96D294097E
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=GgpPPWFH
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id B3j4tiPvRmkR
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Mar 2023 03:57:33 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 00A6140929
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::612])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 00A6140929
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Mar 2023 03:57:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YxqGYwN65mnPZjUfrO4vV2ux3wNd508Vry6a0Pp9mmp2F9Uf1dQOi/pMOZAYpTZSQ2uqK4ktSVAZHX1by9FJGD0JKNjfT8vLWl1YVaZt+9t+CZmekN5KzehLZ858o3lo3N+mrbMEBvrbaUv3hZVooIgQJ7Vj26YAOvISJdn1/gwkV0B/GekOy96T/27XrSfOOPEG8LXQX+VOwYmy0JJsJgSewSk1e2jCMPoFudFogEkCinOLu3X3sZmoCp1MXdavToRQO5nfz9UcHqbHXYaAad1u2PoEoe9q6vORqwdWUqtpsYxYi91+SB1/b/DPx73N+ijyx+8DEIZlcyvEakNV4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ocef81fr7HBwHNkZF0dhRzDMMgqBqk062HTYXkpNa0Y=;
 b=ZJGvmYn7K40aqPmlXKWHZDTGI/Kw8U1v2r4jh8rdqrGKujMCmA9jKRF8/5j5xMe928rd7MDqcawzD+hpEFZ1jLh/nx8lackfv4cYM2m5HyIDvOoslBXP0xO8OY4UKDp2WcgeR0SbnONSb/ezE/N7PUkKz4DeFN+OK0JBbEOkdrB+zxyaH2uHa4q/3q5z6mNOYUnDVaL5m4TgzZM/VPXEpTyUs0LTSe1tkrf60WFQuFUMxc8JqsNJP0jBMy9uliiBdU8GMWcIi9sgqqL5xeW3XOZFhz8f6VlcJ/VJ3l4rhYFFhS3zzWww8JqcpH5aMnI8cuETMnWHgPy70eWycaVVwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ocef81fr7HBwHNkZF0dhRzDMMgqBqk062HTYXkpNa0Y=;
 b=GgpPPWFH7kkTgCnavsY4PqOZtf1oQ3Bd0HGIRqRwsyRvLgMWc/saIbim9wxThtU2FxzBWzbPmObqSqwm31tFFFUZXbk5XHLNbD+l7r8Ebcc1B+VLtXjgTg1fTn4fF0P+J630jIiKs1fS0hE8et5HUGQcQwcpHriRhpPZ0cgNmKnK9uaWtDv6QOq3J84su5Ha+xeabYdnXs5uur0qccIgUQuVD1x8OhPP/MVo/RBVPSx1MIVY/gGYyBmFy/ji2cXaaCny5+mCaYj67+SKscXgvSC2dut1ax+7Vr4qcG25o3fKHogp0cuxKmCxC60azhZu8gUUgiHywaGcrL9ZSFp7Ig==
Received: from BN9PR03CA0746.namprd03.prod.outlook.com (2603:10b6:408:110::31)
 by DM4PR12MB6541.namprd12.prod.outlook.com (2603:10b6:8:88::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Tue, 7 Mar
 2023 03:57:29 +0000
Received: from BN8NAM11FT108.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:110:cafe::94) by BN9PR03CA0746.outlook.office365.com
 (2603:10b6:408:110::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28 via Frontend
 Transport; Tue, 7 Mar 2023 03:57:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT108.mail.protection.outlook.com (10.13.176.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.16 via Frontend Transport; Tue, 7 Mar 2023 03:57:29 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 6 Mar 2023
 19:57:17 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 6 Mar 2023
 19:57:16 -0800
Received: from mtl123.mtl.labs.mlnx (10.127.8.10) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5 via Frontend
 Transport; Mon, 6 Mar 2023 19:57:16 -0800
Received: from sw-mtx-012-001.mtx.labs.mlnx (sw-mtx-012-001.mtx.labs.mlnx
 [10.9.150.40])
 by mtl123.mtl.labs.mlnx (8.14.4/8.14.4) with ESMTP id 3273v7Pq019487;
 Tue, 7 Mar 2023 05:57:13 +0200
To: <virtualization@lists.linux-foundation.org>
Subject: [PATCH 3/3] virtio_ring: Use const to annotate read-only pointer
 params
Date: Tue, 7 Mar 2023 05:57:05 +0200
Message-ID: <20230307035705.4479-4-feliu@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230307035705.4479-1-feliu@nvidia.com>
References: <20230307035705.4479-1-feliu@nvidia.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT108:EE_|DM4PR12MB6541:EE_
X-MS-Office365-Filtering-Correlation-Id: 8eb1d691-8f0e-487b-d6c0-08db1ec0126e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FANlUG3tD+c+30qyNfSShz7WFNLiguIkrOzPX4cLQ5H5H42E3BbHegiG/v0sFp/ekpo+ZKvQKbr6ntU4o2rM8wB3TrU3UmP9C19luO481gdwgGEjeTWkUUZiBoJnfM+iNsISmucf3yZc8NJdNh3fsXLFnZtw65qK4va32q2oS6GVzN2AXhUi4E8Il+AUtEgD1dZet8LKZ9veBoXeqfowByKiVIP9g8hl2LlKcw6PHWxmbc/QkFsS/7nAwPBKq3rjRC7IpEmWIF8ERhuQalDODDeGByPm76BNvFjEzLRcZZvj7Q0g0qET5ZPiV0i3sHxbLepGanvj8oQFDHvYlAYpm+notFNww4i58UpGnq3i/MbERy7xGSDIB9woTW8nLgPC8jn/UwliiqQIwb92RdjLaJmf7kyx5l6srzTrqqQxRR1wGAnKmORnsYSSvsegfOEuLCw4RMhDv7aq0U32X0suw4tCV8pYzcQRiLTNqYPnp5ZC7/RVXCm1TioumTiPc7Ku1Na18TUgOHoAgeSRWxVa06ncn0Ft2Iyb92F7AFd+2cAKZPQOBz8sEF9wG9ObDIMggLRht8dDm4j7licraZUtZOV0ruG/B3rFX1iDzJIyyq2Bs51ROTQdmHLHf7CdcIR6r8vQMGDT5naHXLlPphsVsaE2qX+3CGeF2lO7WPHhXnsox3fG5mFd86KmOXF0L9+ysW5QX9v4lhQdIOIJRBPfdQ==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(346002)(136003)(39860400002)(376002)(451199018)(36840700001)(46966006)(40470700004)(1076003)(26005)(336012)(107886003)(40480700001)(6666004)(2616005)(41300700001)(47076005)(186003)(86362001)(54906003)(82310400005)(478600001)(316002)(83380400001)(6916009)(4326008)(82740400003)(7636003)(2906002)(36756003)(40460700003)(70206006)(70586007)(5660300002)(356005)(8676002)(36860700001)(8936002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 03:57:29.2833 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eb1d691-8f0e-487b-d6c0-08db1ec0126e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT108.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6541
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jiri Pirko <jiri@nvidia.com>,
 Bodong Wang <bodong@nvidia.com>, Gavin Li <gavinl@nvidia.com>
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
From: Feng Liu via Virtualization <virtualization@lists.linux-foundation.org>
Reply-To: Feng Liu <feliu@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Add const to make the read-only pointer parameters clear, similar to
many existing functions.

Signed-off-by: Feng Liu <feliu@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Gavin Li <gavinl@nvidia.com>
Reviewed-by: Bodong Wang <bodong@nvidia.com>
---
 drivers/virtio/virtio_ring.c | 25 ++++++++++++-------------
 include/linux/virtio.h       | 12 ++++++------
 2 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 806cc44eae64..8010fd1d2047 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -233,7 +233,7 @@ static void vring_free(struct virtqueue *_vq);
 
 #define to_vvq(_vq) container_of(_vq, struct vring_virtqueue, vq)
 
-static bool virtqueue_use_indirect(struct vring_virtqueue *vq,
+static bool virtqueue_use_indirect(const struct vring_virtqueue *vq,
 					  unsigned int total_sg)
 {
 	/*
@@ -269,7 +269,7 @@ static bool virtqueue_use_indirect(struct vring_virtqueue *vq,
  * unconditionally on data path.
  */
 
-static bool vring_use_dma_api(struct virtio_device *vdev)
+static bool vring_use_dma_api(const struct virtio_device *vdev)
 {
 	if (!virtio_has_dma_quirk(vdev))
 		return true;
@@ -289,7 +289,7 @@ static bool vring_use_dma_api(struct virtio_device *vdev)
 	return false;
 }
 
-size_t virtio_max_dma_size(struct virtio_device *vdev)
+size_t virtio_max_dma_size(const struct virtio_device *vdev)
 {
 	size_t max_segment_size = SIZE_MAX;
 
@@ -423,7 +423,7 @@ static void virtqueue_init(struct vring_virtqueue *vq, u32 num)
  */
 
 static void vring_unmap_one_split_indirect(const struct vring_virtqueue *vq,
-					   struct vring_desc *desc)
+					   const struct vring_desc *desc)
 {
 	u16 flags;
 
@@ -1183,7 +1183,7 @@ static u16 packed_last_used(u16 last_used_idx)
 }
 
 static void vring_unmap_extra_packed(const struct vring_virtqueue *vq,
-				     struct vring_desc_extra *extra)
+				     const struct vring_desc_extra *extra)
 {
 	u16 flags;
 
@@ -1206,7 +1206,7 @@ static void vring_unmap_extra_packed(const struct vring_virtqueue *vq,
 }
 
 static void vring_unmap_desc_packed(const struct vring_virtqueue *vq,
-				   struct vring_packed_desc *desc)
+				    const struct vring_packed_desc *desc)
 {
 	u16 flags;
 
@@ -2786,7 +2786,7 @@ EXPORT_SYMBOL_GPL(vring_transport_features);
  * Returns the size of the vring.  This is mainly used for boasting to
  * userspace.  Unlike other operations, this need not be serialized.
  */
-unsigned int virtqueue_get_vring_size(struct virtqueue *_vq)
+unsigned int virtqueue_get_vring_size(const struct virtqueue *_vq)
 {
 
 	struct vring_virtqueue *vq = to_vvq(_vq);
@@ -2819,7 +2819,7 @@ void __virtqueue_unbreak(struct virtqueue *_vq)
 }
 EXPORT_SYMBOL_GPL(__virtqueue_unbreak);
 
-bool virtqueue_is_broken(struct virtqueue *_vq)
+bool virtqueue_is_broken(const struct virtqueue *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
@@ -2827,8 +2827,7 @@ bool virtqueue_is_broken(struct virtqueue *_vq)
 }
 EXPORT_SYMBOL_GPL(virtqueue_is_broken);
 
-/*
- * This should prevent the device from being used, allowing drivers to
+/ This should prevent the device from being used, allowing drivers to
  * recover.  You may need to grab appropriate locks to flush.
  */
 void virtio_break_device(struct virtio_device *dev)
@@ -2881,7 +2880,7 @@ dma_addr_t virtqueue_get_desc_addr(struct virtqueue *_vq)
 }
 EXPORT_SYMBOL_GPL(virtqueue_get_desc_addr);
 
-dma_addr_t virtqueue_get_avail_addr(struct virtqueue *_vq)
+dma_addr_t virtqueue_get_avail_addr(const struct virtqueue *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
@@ -2895,7 +2894,7 @@ dma_addr_t virtqueue_get_avail_addr(struct virtqueue *_vq)
 }
 EXPORT_SYMBOL_GPL(virtqueue_get_avail_addr);
 
-dma_addr_t virtqueue_get_used_addr(struct virtqueue *_vq)
+dma_addr_t virtqueue_get_used_addr(const struct virtqueue *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
@@ -2910,7 +2909,7 @@ dma_addr_t virtqueue_get_used_addr(struct virtqueue *_vq)
 EXPORT_SYMBOL_GPL(virtqueue_get_used_addr);
 
 /* Only available for split ring */
-const struct vring *virtqueue_get_vring(struct virtqueue *vq)
+const struct vring *virtqueue_get_vring(const struct virtqueue *vq)
 {
 	return &to_vvq(vq)->split.vring;
 }
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 2b472514c49b..36a79374e735 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -84,14 +84,14 @@ bool virtqueue_enable_cb_delayed(struct virtqueue *vq);
 
 void *virtqueue_detach_unused_buf(struct virtqueue *vq);
 
-unsigned int virtqueue_get_vring_size(struct virtqueue *vq);
+unsigned int virtqueue_get_vring_size(const struct virtqueue *vq);
 
-bool virtqueue_is_broken(struct virtqueue *vq);
+bool virtqueue_is_broken(const struct virtqueue *vq);
 
-const struct vring *virtqueue_get_vring(struct virtqueue *vq);
-dma_addr_t virtqueue_get_desc_addr(struct virtqueue *vq);
-dma_addr_t virtqueue_get_avail_addr(struct virtqueue *vq);
-dma_addr_t virtqueue_get_used_addr(struct virtqueue *vq);
+const struct vring *virtqueue_get_vring(const struct virtqueue *vq);
+dma_addr_t virtqueue_get_desc_addr(const struct virtqueue *vq);
+dma_addr_t virtqueue_get_avail_addr(const struct virtqueue *vq);
+dma_addr_t virtqueue_get_used_addr(const struct virtqueue *vq);
 
 int virtqueue_resize(struct virtqueue *vq, u32 num,
 		     void (*recycle)(struct virtqueue *vq, void *buf));
-- 
2.34.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
