Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E2B7C74A5B
	for <virtualization@archiver.kernel.org>; Wed, 15 Mar 2023 18:55:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 864E1418DB;
	Wed, 15 Mar 2023 18:55:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 864E1418DB
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=rsMBNvpD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5IfmHWyE8Gmz; Wed, 15 Mar 2023 18:55:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8CF5141876;
	Wed, 15 Mar 2023 18:55:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8CF5141876
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5D6DCC0035;
	Wed, 15 Mar 2023 18:55:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B5836C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Mar 2023 18:55:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 90E7540BCA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Mar 2023 18:55:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 90E7540BCA
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=rsMBNvpD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KrfF6zwHMjDv
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Mar 2023 18:55:19 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 162DB40BD3
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::61b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 162DB40BD3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Mar 2023 18:55:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JQ9l3fN0NTpsNGSLjbUKqDjLJ3CI/qSPF9RQlrIjqoBVpc3topirCLGf4ZBO81LFuwoYwJrAcJSHOwpLsOZUJeUdDa6qpq728xo5ZNxEm0ZIA7N/z2eVZ/fbfkRGIqe1MYOSyFE8MbKMqK3Rlp9nm7X+UJkoc4q0Zx5rg5IeaYSFsKsx/45nHEHzIknwNHD8m6ku+jOYOIuja3YQf33s1FM1mFxyw366fh3ZtTBrqVS5fuoNNBXGAiJW70gv6GhtCz0Kg1IkTrY7Yckom5vOriTfUDzoHqzz5fkfCBdckIt2DrLmb50frcjqZx7Gnui/1hXz2s+f8GbBYFsqaYIXDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tha9eY/m17EAjfeQQtYiOGjw5Hp5dsoIg5MaIox28vQ=;
 b=namhldfzM2GZnfju5ABcogsOueuyQtJjGobpEXgm9bYwZW1Rxy1kZ3e82QG0EsdfehRGdIe8V3JIfW9UoR6VgzK9mVU3GYaMvlCiiy6qocIp1stk29SS8+s+BRblV5oe03KcV1E3jCtM6brpQDSscpifkPx1k50CReQqfjez67VWh4EA3giQcykvqmzGai/cLUF/jODKrI3hpd0hfdDw1VUbJgPQwto5ivOuw20i2HEx1wOrGnTmP4nyKsh3EX4VxWb1G4hriYHjNIv9oHmSHRCFxEn9llL9zvnJ34QfV9+c69M3aUYJAjj5/bCior5y2Omj/G+hYHZXC3lYZsb+Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tha9eY/m17EAjfeQQtYiOGjw5Hp5dsoIg5MaIox28vQ=;
 b=rsMBNvpD+w+lY4maOjFEYe2EyB2V/7bf4Tx9sggIZm6Qy0i4LaVZY+2RnggBm65w0k8VjcyqN/Bz7z0q/KxfMuL4+/TL3ljhU5bM/tXAdPwWjgDMWQBEtUJR5APeEsHqH+QyVl9DtsMUXhCe6gVn24vJ/JUzA9LMBshsmel7U++Vxsc+Ld7NnB5dixUtUvwWn0EcLfIe6Qd8DDvr/4upIj7fiFtJY+MK/kEcNjWZx1L4hoJAXGb3PbwFRx7O0i4Hf2UprcNeEwqZ/N3vDF0hfHsZ3wL8ReeO3PuA5V/DR2b+KGkXWTU3CXetVYk0p3SQvN66GIAjjpgHauFBK0FupA==
Received: from DM6PR06CA0026.namprd06.prod.outlook.com (2603:10b6:5:120::39)
 by MW3PR12MB4395.namprd12.prod.outlook.com (2603:10b6:303:5c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.29; Wed, 15 Mar
 2023 18:55:14 +0000
Received: from DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::59) by DM6PR06CA0026.outlook.office365.com
 (2603:10b6:5:120::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.29 via Frontend
 Transport; Wed, 15 Mar 2023 18:55:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT061.mail.protection.outlook.com (10.13.173.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6199.11 via Frontend Transport; Wed, 15 Mar 2023 18:55:13 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 15 Mar 2023
 11:55:04 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 15 Mar
 2023 11:55:04 -0700
Received: from vdi.nvidia.com (10.127.8.11) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.5 via Frontend Transport; Wed, 15 Mar
 2023 11:55:03 -0700
To: <virtualization@lists.linux-foundation.org>
Subject: [PATCH v2 3/3] virtio_ring: Use const to annotate read-only pointer
 params
Date: Wed, 15 Mar 2023 20:54:58 +0200
Message-ID: <20230315185458.11638-4-feliu@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230315185458.11638-1-feliu@nvidia.com>
References: <20230315185458.11638-1-feliu@nvidia.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT061:EE_|MW3PR12MB4395:EE_
X-MS-Office365-Filtering-Correlation-Id: e637d745-5f2d-495e-a190-08db2586cf83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R+6vkdzSClwUGVJoBawZtgQxb5WwoCdBKUd0Tki+MGJcDTHHE31LvvY3uDuhMe9DbJUfsyOKk5V9ddeHsIk9Ucd3DK+nQZkG2FFFhcyc3JVvIaxK4oNZtbn3wXxYdSa6aoMSzv28xOdQ+eDTIW8hYpcf85iAHe2Z+qToOSFfhzCAzh2TMl986LS0eJW12ZkogGZZ5/ts8wThr3sH7O+gmMtq9VZeluFlkSs4GyYPAArbGZtpbujl8Xt5vtsSC8gGmK7D2FSqYtrVT4jw50jf4ZXQTqDhau2XrVsUqtH0De49+KTqmLn4CkW05nv09m5n79syrxcQoAscqELZxlROmbkndOuSSIGcClQuw5c8sLgOF7Fg2CMkt2eo5vZ/mwgkCo3NCprZ0xbe1AsLR50SsJhTj6B3wO+NLVDlHALz8ksoqNbPWx5AVDFBeGXMdrNrDHmjokau1NwfE1CUqfeFFsI60iZ2BxaiN+Z2qp8ynVGdilLCS9ldRXoHUnjnLHqwfhV7x8+JVjUqPWCgcu9vd77ij405cbPmxTaGFsQJORNu4DI/ndrAxRmUYai21aoPJwkd+wh0nvfIg9lH65S9wPSL6golvGpkiv0+QYFjxAHWPvETZmWO+6LxR7UlGTsUM6pC/cKIsngt0XFFoLriREV9fDagqFBAbjjB61I/1cinsGz418hU7JLVHRoPgjympYydMztdQh3OjuLlObBJeurenwm9AGlT0ud5on7YHmDBhmlwEj/XH8UnhNghJbet
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(376002)(136003)(346002)(396003)(451199018)(46966006)(36840700001)(40470700004)(356005)(36756003)(36860700001)(86362001)(7636003)(82740400003)(41300700001)(8936002)(2906002)(5660300002)(26005)(82310400005)(40460700003)(4326008)(2616005)(40480700001)(1076003)(47076005)(186003)(83380400001)(336012)(316002)(54906003)(426003)(70206006)(70586007)(8676002)(107886003)(6666004)(6916009)(7696005)(478600001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2023 18:55:13.8850 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e637d745-5f2d-495e-a190-08db2586cf83
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4395
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

Use `container_of_const` to implement `to_vvq`, which ensures the
const-ness of read-only parameters and avoids accidental modification
of their members.

Signed-off-by: Feng Liu <feliu@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>

---
v0 -> v1
feedbacks from Michael S. Tsirkin
- use `container_of_const` to implement `to_vvq`
---
 drivers/virtio/virtio_ring.c | 36 ++++++++++++++++++------------------
 include/linux/virtio.h       | 14 +++++++-------
 2 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index a26fab91c59f..4c3bb0ddeb9b 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -231,9 +231,9 @@ static void vring_free(struct virtqueue *_vq);
  * Helpers.
  */
 
-#define to_vvq(_vq) container_of(_vq, struct vring_virtqueue, vq)
+#define to_vvq(_vq) container_of_const(_vq, struct vring_virtqueue, vq)
 
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
 
@@ -2786,10 +2786,10 @@ EXPORT_SYMBOL_GPL(vring_transport_features);
  * Returns the size of the vring.  This is mainly used for boasting to
  * userspace.  Unlike other operations, this need not be serialized.
  */
-unsigned int virtqueue_get_vring_size(struct virtqueue *_vq)
+unsigned int virtqueue_get_vring_size(const struct virtqueue *_vq)
 {
 
-	struct vring_virtqueue *vq = to_vvq(_vq);
+	const struct vring_virtqueue *vq = to_vvq(_vq);
 
 	return vq->packed_ring ? vq->packed.vring.num : vq->split.vring.num;
 }
@@ -2819,9 +2819,9 @@ void __virtqueue_unbreak(struct virtqueue *_vq)
 }
 EXPORT_SYMBOL_GPL(__virtqueue_unbreak);
 
-bool virtqueue_is_broken(struct virtqueue *_vq)
+bool virtqueue_is_broken(const struct virtqueue *_vq)
 {
-	struct vring_virtqueue *vq = to_vvq(_vq);
+	const struct vring_virtqueue *vq = to_vvq(_vq);
 
 	return READ_ONCE(vq->broken);
 }
@@ -2868,9 +2868,9 @@ void __virtio_unbreak_device(struct virtio_device *dev)
 }
 EXPORT_SYMBOL_GPL(__virtio_unbreak_device);
 
-dma_addr_t virtqueue_get_desc_addr(struct virtqueue *_vq)
+dma_addr_t virtqueue_get_desc_addr(const struct virtqueue *_vq)
 {
-	struct vring_virtqueue *vq = to_vvq(_vq);
+	const struct vring_virtqueue *vq = to_vvq(_vq);
 
 	BUG_ON(!vq->we_own_ring);
 
@@ -2881,9 +2881,9 @@ dma_addr_t virtqueue_get_desc_addr(struct virtqueue *_vq)
 }
 EXPORT_SYMBOL_GPL(virtqueue_get_desc_addr);
 
-dma_addr_t virtqueue_get_avail_addr(struct virtqueue *_vq)
+dma_addr_t virtqueue_get_avail_addr(const struct virtqueue *_vq)
 {
-	struct vring_virtqueue *vq = to_vvq(_vq);
+	const struct vring_virtqueue *vq = to_vvq(_vq);
 
 	BUG_ON(!vq->we_own_ring);
 
@@ -2895,9 +2895,9 @@ dma_addr_t virtqueue_get_avail_addr(struct virtqueue *_vq)
 }
 EXPORT_SYMBOL_GPL(virtqueue_get_avail_addr);
 
-dma_addr_t virtqueue_get_used_addr(struct virtqueue *_vq)
+dma_addr_t virtqueue_get_used_addr(const struct virtqueue *_vq)
 {
-	struct vring_virtqueue *vq = to_vvq(_vq);
+	const struct vring_virtqueue *vq = to_vvq(_vq);
 
 	BUG_ON(!vq->we_own_ring);
 
@@ -2910,7 +2910,7 @@ dma_addr_t virtqueue_get_used_addr(struct virtqueue *_vq)
 EXPORT_SYMBOL_GPL(virtqueue_get_used_addr);
 
 /* Only available for split ring */
-const struct vring *virtqueue_get_vring(struct virtqueue *vq)
+const struct vring *virtqueue_get_vring(const struct virtqueue *vq)
 {
 	return &to_vvq(vq)->split.vring;
 }
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 2b472514c49b..c4225653f949 100644
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
@@ -147,7 +147,7 @@ int virtio_device_restore(struct virtio_device *dev);
 #endif
 void virtio_reset_device(struct virtio_device *dev);
 
-size_t virtio_max_dma_size(struct virtio_device *vdev);
+size_t virtio_max_dma_size(const struct virtio_device *vdev);
 
 #define virtio_device_for_each_vq(vdev, vq) \
 	list_for_each_entry(vq, &vdev->vqs, list)
-- 
2.34.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
