Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CF0FC6FA99
	for <virtualization@archiver.kernel.org>; Fri, 10 Mar 2023 05:34:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E96C381EF3;
	Fri, 10 Mar 2023 05:34:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E96C381EF3
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=OhpNevsa
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PpzOJ00jf7Fr; Fri, 10 Mar 2023 05:34:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 72BCA81EC0;
	Fri, 10 Mar 2023 05:34:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 72BCA81EC0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 40CE9C0071;
	Fri, 10 Mar 2023 05:34:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0B78EC0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 05:34:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A5B58401A1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 05:34:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A5B58401A1
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=OhpNevsa
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2pA3Br7oN6hG
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 05:34:48 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A79C1400EA
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::61d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A79C1400EA
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 05:34:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gRgzwS7A5jCjovx3o5rzKkEem7XLSgo03EUJ0BxEJyFYqmv8KTdyV+CYQbLaw3oqd8rLZ+3GcWzSbHkIaPl/6Np4wgvEAszi4Phocc70obVHexf9pHjuW2gv3y+sNaiSmF/lb/iGnzY6o8qCV/tYIvLChczdAsMeQ4OBo6blPr+Yvnp04xnBMYZIOttNYEqO5WRZYM1Ibb9msPLDHz6FcatPuZMnoRLiWRygMK6B52a0rqPBkgFWNDVp7A783G96VcXDdiIAzZOxI68Vu6qUIWf/AagrQ3Q9YcklgxZGcffKTPbhqthn497pAHTaOXASHoxWChJ22aHbDaF4TAj7xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BzvLGma5AUAVAkrctZiCZdGtiR4sSW9IiOSXuob3pSQ=;
 b=JIKoIkZYxaSWx7iucpFbRf4kpE5kZ1JPUZwcaUSh8kEafaRju06E64ghltkIgHqgH9osTPEpgHEl1hCdO79kSwD+ZCrLUFSoC91S4vsqfrAKHxXSiI6QJCpqtfCmVQJj+sUKygRWs4R/hAVWcZnuhsU/ra30B7ehV5XOL0K5Eg8z5ruwRIb+F/qTt2ByhyHD54jpzQ8n3K+fj6Wd/YOdjkgdgWJAWOs/lQ4xImYBU3FEKOO1FFySqb4X7YbBFEXqAjuU/po3ofcvawzaOCk4r1JxNwZyUZgH7sy8MO8BRYUAOdK/30su1Kla5sSYWJiA7p01XomE1jk79hBwO/6xmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BzvLGma5AUAVAkrctZiCZdGtiR4sSW9IiOSXuob3pSQ=;
 b=OhpNevsaJGJPR5r+I3NYdcXRxYyNr8fXi/+vvy6DNTlgc9DdKk2jr7DQq9v+xOTWp+b1tk6mHtzOgWdEZfoTjhoi+wmcTbYZbTK64KYnh6+RErfGHtvuZAi8xqmwNxqT/CEJbtURWWr5Ev73Kycvv+yL9UuwjyEQ+0TpIJJx9aK/q/RyZt397fGdm4Eb7Ch+Dd/VWgwy84wBzDwwh9N0PjYvWUuIr4qKrGZS4ErJrgrQLUPd2aPVS4oRXEmFvCdfNnrIvzwIiLHVe5rSJKhO03I4ajlBZ3q3HwWmafIdf8Knz2+YQziLy+9PaH2X0NiuxteIZmkJkK+ZKBLXxuQblw==
Received: from DM6PR11CA0068.namprd11.prod.outlook.com (2603:10b6:5:14c::45)
 by PH7PR12MB6906.namprd12.prod.outlook.com (2603:10b6:510:1b8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 05:34:44 +0000
Received: from DM6NAM11FT109.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:14c:cafe::63) by DM6PR11CA0068.outlook.office365.com
 (2603:10b6:5:14c::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29 via Frontend
 Transport; Fri, 10 Mar 2023 05:34:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DM6NAM11FT109.mail.protection.outlook.com (10.13.173.178) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.19 via Frontend Transport; Fri, 10 Mar 2023 05:34:44 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 9 Mar 2023
 21:34:41 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Thu, 9 Mar 2023 21:34:40 -0800
Received: from mtl123.mtl.labs.mlnx (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5 via Frontend
 Transport; Thu, 9 Mar 2023 21:34:40 -0800
Received: from sw-mtx-012-001.mtx.labs.mlnx (sw-mtx-012-001.mtx.labs.mlnx
 [10.9.150.40])
 by mtl123.mtl.labs.mlnx (8.14.4/8.14.4) with ESMTP id 32A5YVo5007739;
 Fri, 10 Mar 2023 07:34:37 +0200
To: <virtualization@lists.linux-foundation.org>
Subject: [PATCH v2 3/3] virtio_ring: Use const to annotate read-only pointer
 params
Date: Fri, 10 Mar 2023 07:34:28 +0200
Message-ID: <20230310053428.3376-4-feliu@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230310053428.3376-1-feliu@nvidia.com>
References: <20230310053428.3376-1-feliu@nvidia.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT109:EE_|PH7PR12MB6906:EE_
X-MS-Office365-Filtering-Correlation-Id: 94878cf3-8634-4d8f-e57c-08db2129277e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mYxPmyZKVWfuqJPlrgXslyyLwfodjKmK9C5jUxKrTJQA6nS/yc3bqdekTemyj6u2BMyOoGph5PPq1uyEvZ68qqB9PwkexfgEfUgmD8+iEn9JFrS7DBCuZgha53NOdtgskkZ+8wlDjHLSD07MYM2+zz9xMmbAi5Rgn3bqRUeZ1tb38MK4xkOmMf86DVi/TcV+AEbdR9kInfTYSMxjtEfBi8AOdmsv0KHb7Jm7WEsb1nAHsinOMPMqXrlw4o1oDz7kG7wJl6tH+Rmp5QN4DQyDWMTrLDWIIejbHjwap8BfrTEZ7bIj1RYQSbZBIDPHZYmWMmvJcLP0B+MCttpi8jtiHRNf8MXXybX8FL05d2TATmSjZt2hcU5hrLad4Z9HmZgS18KEHOzOeDurfoK4tQZ5J2mzOlYyJZwvCtC68/KbzIECJtBDfTKKfkMaha9yQtiOIW5265Fifl1eBsPkBQTGCqQh6vy5BF3t3EldTHhujYtCdZd1hMBNDGPPWtuhWOWbdNTy0gwWYW+6D6p8MYUg5Qb4eQwUzVJsoxv0tzCC2d8uQ7foylEODTBfkVIhP5APNbaWAafM1VC6ytqliFhrFJ3NW0TeMykHqOhGvqzqGYPxf+zrxEVyxNH/tdxTe1Jtig97mnt0d11YN0mulk51/C8owrZNIqz8Qy3af11ceaQXGng3VNhuqTrzBrlCkM3vS+ehkX4BQiDxTljo6vDnoX/It9rHkI2fWRKPY0oMMthLzO1l1L0HKgtrJVLy3q32
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(346002)(136003)(396003)(39860400002)(451199018)(40470700004)(46966006)(36840700001)(47076005)(336012)(356005)(54906003)(36756003)(40460700003)(40480700001)(86362001)(7636003)(36860700001)(1076003)(82740400003)(26005)(82310400005)(83380400001)(6666004)(186003)(2616005)(316002)(6916009)(107886003)(478600001)(5660300002)(41300700001)(4326008)(70586007)(2906002)(8936002)(70206006)(8676002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 05:34:44.1810 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94878cf3-8634-4d8f-e57c-08db2129277e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT109.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6906
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

To implement this change, the commit also introduces the use of
`container_of_const` to implement `to_vvq`, which ensures the const-ness
of read-only parameters and avoids accidental modification of their
members.

Signed-off-by: Feng Liu <feliu@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Gavin Li <gavinl@nvidia.com>
Reviewed-by: Bodong Wang <bodong@nvidia.com>

---
v1 -> v2
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
