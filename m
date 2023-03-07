Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08AF6C678DB
	for <virtualization@archiver.kernel.org>; Tue,  7 Mar 2023 03:57:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 10BEC4098F;
	Tue,  7 Mar 2023 03:57:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 10BEC4098F
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=mkKjbtXQ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qTkP-aQjzMkr; Tue,  7 Mar 2023 03:57:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E4F7440936;
	Tue,  7 Mar 2023 03:57:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E4F7440936
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E0742C008D;
	Tue,  7 Mar 2023 03:57:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E71A3C0035
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Mar 2023 03:57:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B4165813E4
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Mar 2023 03:57:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B4165813E4
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=mkKjbtXQ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id W6KMsVTjyyZh
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Mar 2023 03:57:26 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 44DB1813E1
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::630])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 44DB1813E1
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Mar 2023 03:57:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JROa1K5kHI+Ybk0kjxtO5eMY2MPBpkA849LN8ar7ETclOyArIhDqGDjtvxRZzaNX2SYNOoy2jkzPPgrbwuAorUgH2DDgu/COobhuifs2Ra5AZSzCl+oDmJOdVKflJvaqpyGy478m5Bl7DU8AnFs4QJvzvjLSMS4bdh5B6lqHjx++u5jsRlL8u/FfLrRjo2DJil+5h0QG3N+0kBVb7B7c/IBUIPyPvFHOM9CxaV6IOetcNNO/w4wlfjuFgn+kNvkDSgoEsozfzwM11iniMa9+WY4nYQIU5bnzNyKfs6bsBiHm4BMUocVQ/8IbwCLEVXNkY8TnQAk8K3+VA6TkA6xb9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n7AM73+Z5vPWqPsGLdJDJ/AecwwbaniBnYZto4BfaCk=;
 b=g0kvJ4bvZDzxSeyJhHxccs4dt1DrhtIY0IG+k/1Mnh7PenKd4EaVX9oe4NIO9qw2OyRbGUMuZh+wFWeNQ9b1PqS7JfnDmHCl5jaGSPYmFEhKpYrwxD5xoPmuFxjuLYBFOofWTFdMKw0ePSjzSqv+PFgPgCgZQM9j/l31Jocqxi79WzLPzO6chL15NpfsqSrPKdGu5V30enGSHt/TvraxEiTdSvWM1VVv4ZbOukFQsnX3tpuFdA3uvRpaZAg7pgb56yvauf34SMwH7b2gEVyFcuoyoiCfHxms1a+J4+ynD9i6+5nMySJonGZeiWwCoRGAt4r4Abk/Ir+C6J+gdIFioQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n7AM73+Z5vPWqPsGLdJDJ/AecwwbaniBnYZto4BfaCk=;
 b=mkKjbtXQeY+y7+AT3iEC+LHIKyGJypKLoARlEkhrGy7dT2EPWvh7xSqPoP8OC6jZJxcYrR3uuVs3eKjjMbQoldSHgT/3eMhDUG1bw1rFTKV5inrH9R8dny7cs71R+nKMLBsmA/bgn6VZj1T8Jvs3VF9lEwfAMIf+eXGMfuWSrKoltVyvCN9WHrGCZdKzfgZgV0Nz2D6BHR5PxL7gifrBQuMudT/07MvJINL13SkBTcgG2LhhVprYttbFHT22uO5H1UMAI0lecrDGULxlLrG4M7fmfKwVEXzw1SFiSE/kJbCX8Ye8q0K5khwbjcCts7rJT0x9AtBRxdDyIkx+iOdbIA==
Received: from MW4PR04CA0106.namprd04.prod.outlook.com (2603:10b6:303:83::21)
 by DM6PR12MB5519.namprd12.prod.outlook.com (2603:10b6:5:1b5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Tue, 7 Mar
 2023 03:57:23 +0000
Received: from CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::d4) by MW4PR04CA0106.outlook.office365.com
 (2603:10b6:303:83::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28 via Frontend
 Transport; Tue, 7 Mar 2023 03:57:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1NAM11FT016.mail.protection.outlook.com (10.13.175.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.16 via Frontend Transport; Tue, 7 Mar 2023 03:57:23 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 6 Mar 2023
 19:57:15 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Mon, 6 Mar 2023 19:57:14 -0800
Received: from mtl123.mtl.labs.mlnx (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5 via Frontend
 Transport; Mon, 6 Mar 2023 19:57:14 -0800
Received: from sw-mtx-012-001.mtx.labs.mlnx (sw-mtx-012-001.mtx.labs.mlnx
 [10.9.150.40])
 by mtl123.mtl.labs.mlnx (8.14.4/8.14.4) with ESMTP id 3273v7Pp019487;
 Tue, 7 Mar 2023 05:57:11 +0200
To: <virtualization@lists.linux-foundation.org>
Subject: [PATCH 2/3] virtio_ring: Avoid using inline for small functions
Date: Tue, 7 Mar 2023 05:57:04 +0200
Message-ID: <20230307035705.4479-3-feliu@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230307035705.4479-1-feliu@nvidia.com>
References: <20230307035705.4479-1-feliu@nvidia.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT016:EE_|DM6PR12MB5519:EE_
X-MS-Office365-Filtering-Correlation-Id: 18a65c0d-2592-48d9-80bf-08db1ec00eca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NqKW7oc1s10us1YpARxCHxG1sbzxUXe1QuoXpWN1eL6F+mza8aNOJqsQoCFNzYJVp4AmFnna7I2zl6inizA7fcVeN6iQMJCugAawELpeVI4Qu3fWEXRNDgYd52Xyjn/M/+oLZ4Qcw8ejs+gX8XCV6ToUbf+Ou0dj0FQGHU8b0/FcvsncUuO0uHZ1NakZkAVeDJdAxI6sl/MbkGqKdSeQJ0qkS5FyTIEk9RDLIu5WqVcOGXdkciRKUogbXYmO6XQvLDhRTLhfYgLtPFIGGxN/QoclSTyQbY+F2Ed44FLA5w2Ppq8kNDLlfsjFd6LHT9yysQuO5y4AHKzNC3Jx5Y9VISSt1NJyKkZfwvj03vFf+8BL1scMuujQqaztXY5bcvggBVGFz/8RxAPWGgOGvetA+Xw2n+B3ZqTOSFZcxkHv2wqF0RHQaTW+ZC8iE87rhxL6idGkX1WTCyDG1z5TzDOLKuIxrlFQeJfLEVHNXV3oXfJXEXv1tWCTv7D4AgP/ou9Q6HQNYCHG2qQMZI2r9btRPldaxBIMbQaXoFao+/MfuWqxVAdIC7PT3OAPBVHPDoRdU5Veh+V5adD5ppUiYwS4dJuHmgfPYu+rDux7kf2Wa2D6tMADC6yBF18CXiOVpt6nYPJ5CfN8WiaUWaTGddCZgc4u5Rtyhcb7TYPtK5dwRdsxw3Dy5JfiI5FzX4kV4A0FojM4C2GhK22GeMZ0y3d2yL6glJsCSRW6zaXbo0vty+VsQBPuhtzDaR7802pc5ydI
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(376002)(136003)(396003)(39860400002)(451199018)(46966006)(36840700001)(40470700004)(1076003)(966005)(36860700001)(6666004)(107886003)(47076005)(36756003)(82310400005)(83380400001)(356005)(40460700003)(82740400003)(86362001)(7636003)(40480700001)(336012)(186003)(2616005)(26005)(41300700001)(70206006)(70586007)(8676002)(4326008)(6916009)(2906002)(8936002)(5660300002)(478600001)(316002)(54906003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 03:57:23.2826 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18a65c0d-2592-48d9-80bf-08db1ec00eca
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5519
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

According to kernel coding style [1], defining inline functions is not
necessary and beneficial for simple functions. Hence clean up the code
by removing the inline keyword.

It is verified with GCC 12.2.0, the generated code with/without inline
is same. Additionally tested with pktgen and iperf, and verified the
result, the pps test results are the same in the cases of with/without
inline.

Iperf and pps of pktgen for virtio-net didn't change before and after
the change.

[1]
https://www.kernel.org/doc/html/v6.2-rc3/process/coding-style.html#the-inline-disease

Signed-off-by: Feng Liu <feliu@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Gavin Li <gavinl@nvidia.com>
Reviewed-by: Bodong Wang <bodong@nvidia.com>
---
 drivers/virtio/virtio_ring.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 41144b5246a8..806cc44eae64 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -233,7 +233,7 @@ static void vring_free(struct virtqueue *_vq);
 
 #define to_vvq(_vq) container_of(_vq, struct vring_virtqueue, vq)
 
-static inline bool virtqueue_use_indirect(struct vring_virtqueue *vq,
+static bool virtqueue_use_indirect(struct vring_virtqueue *vq,
 					  unsigned int total_sg)
 {
 	/*
@@ -349,7 +349,7 @@ static void vring_free_queue(struct virtio_device *vdev, size_t size,
  * making all of the arch DMA ops work on the vring device itself
  * is a mess.
  */
-static inline struct device *vring_dma_dev(const struct vring_virtqueue *vq)
+static struct device *vring_dma_dev(const struct vring_virtqueue *vq)
 {
 	return vq->dma_dev;
 }
@@ -784,7 +784,7 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
 	}
 }
 
-static inline bool more_used_split(const struct vring_virtqueue *vq)
+static inline more_used_split(const struct vring_virtqueue *vq)
 {
 	return vq->last_used_idx != virtio16_to_cpu(vq->vq.vdev,
 			vq->split.vring.used->idx);
@@ -1172,12 +1172,12 @@ static int virtqueue_resize_split(struct virtqueue *_vq, u32 num)
 /*
  * Packed ring specific functions - *_packed().
  */
-static inline bool packed_used_wrap_counter(u16 last_used_idx)
+static bool packed_used_wrap_counter(u16 last_used_idx)
 {
 	return !!(last_used_idx & (1 << VRING_PACKED_EVENT_F_WRAP_CTR));
 }
 
-static inline u16 packed_last_used(u16 last_used_idx)
+static u16 packed_last_used(u16 last_used_idx)
 {
 	return last_used_idx & ~(-(1 << VRING_PACKED_EVENT_F_WRAP_CTR));
 }
@@ -1612,7 +1612,7 @@ static inline bool is_used_desc_packed(const struct vring_virtqueue *vq,
 	return avail == used && used == used_wrap_counter;
 }
 
-static inline bool more_used_packed(const struct vring_virtqueue *vq)
+static bool more_used_packed(const struct vring_virtqueue *vq)
 {
 	u16 last_used;
 	u16 last_used_idx;
-- 
2.34.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
