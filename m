Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3D65C61DA4
	for <virtualization@archiver.kernel.org>; Wed, 15 Mar 2023 18:55:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 464F781E70;
	Wed, 15 Mar 2023 18:55:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 464F781E70
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=SgYASqHJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kLZQw0T74pLs; Wed, 15 Mar 2023 18:55:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B005B81D4D;
	Wed, 15 Mar 2023 18:55:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B005B81D4D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 976B6C0035;
	Wed, 15 Mar 2023 18:55:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 75B00C008C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Mar 2023 18:55:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 324B781B17
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Mar 2023 18:55:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 324B781B17
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NBes8Vt9T7uW
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Mar 2023 18:55:20 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4969A81971
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20603.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::603])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4969A81971
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Mar 2023 18:55:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W8sVv2NZx7xQZ4SHu5a09t+tq1Y1Z4uK46KOZgHLp+pQkeKf2/zOvj4Iuff3RlB3nAy2CaogNrE27zivv2A6bWotXT+d/CAAySvrYk08va5Ylfrmd1DzXd3rU8bVVJQC7Sk/OEeOahZshKqzzLIaAJJ6NGMF16q/ycf85N6/shoK/vPNgweRP21g6S6dt0twAPqV+dAPRWwrVZAsRK4sN4moVWMvxZ6cXWfTIkGyVO6ok8KHDS1FF5uJI3kJKLXSG3Ljvg132JZfF0MNW0kMt1mAUS+Uws+bPJ/EE9tZbEOcE3eGF5cf62Gr4aTk1ru0sWfA9yLnA4LPEfyXz3FUKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cqnsjt+NIMrBJ4f0NjRLw/C4x0lMTDcczBD54YGNw54=;
 b=UqA8VX2m4B5sIgBaQrlLnnjqH8FrVOq4WNCacvPm/8PeEriMynRSpXPyHJ+D3iGbk/csgmV1NFC0316BFyU2mSJ3VwTQ73juPt/SSj8e5j9cSv52Qk/xzR1ebfq7W+oNzNW5THfuC0jpa6xZE1oiS4k7bdDtAqcBFeS0DiWlE7Y77V+TYnDviyqXr/2YWatOeamm8yoizitFBigVHKUUjpqV+PeAYCnKHY6wTtPKkG8e5LvVDaFqi+H4ey9GBDlRSSeUEVY22qhdB4eUf/TCjUkQbMASfkaCCJPQQrhUZjzXaBJRbWSmmVxtYktucQhCDv9s3Pe8NAOHlPBoVx605A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cqnsjt+NIMrBJ4f0NjRLw/C4x0lMTDcczBD54YGNw54=;
 b=SgYASqHJJljsiV0WwsDrdQvZVz2SYpWjzVEeL5z/BXAJABkOH8yGaxVrxfUfooNQQKdSPYlR2rU1hdYjt3MmM1fBRCV17obg4R/M6l2Wdvr1EyGBaDZNF3njxMjsv0C1YulAQO970GIFiLfo44yz74a1bJfwHEJzISueK2m44l2w1ERSm9HuaP4EJafcLDRPO8O1jnIxFOgoBDfkFcKNxfmPWOtIHgJu8oy4KR6pqgogumqe3VP50aMtTUnCzhqCtcid8xeizOtae/IfUm5xgGXJ4WOB72aSeT6BlKpFPvxuLENEMHCyGy7ZSktK9RtQGPsqC4+1EF0vMOxzC8Tuqw==
Received: from DM6PR03CA0011.namprd03.prod.outlook.com (2603:10b6:5:40::24) by
 CH0PR12MB5123.namprd12.prod.outlook.com (2603:10b6:610:be::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.26; Wed, 15 Mar 2023 18:55:14 +0000
Received: from DM6NAM11FT109.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:40:cafe::9f) by DM6PR03CA0011.outlook.office365.com
 (2603:10b6:5:40::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.29 via Frontend
 Transport; Wed, 15 Mar 2023 18:55:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT109.mail.protection.outlook.com (10.13.173.178) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6199.16 via Frontend Transport; Wed, 15 Mar 2023 18:55:14 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 15 Mar 2023
 11:55:03 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 15 Mar
 2023 11:55:03 -0700
Received: from vdi.nvidia.com (10.127.8.11) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.5 via Frontend Transport; Wed, 15 Mar
 2023 11:55:02 -0700
To: <virtualization@lists.linux-foundation.org>
Subject: [PATCH v2 2/3] virtio_ring: Avoid using inline for small functions
Date: Wed, 15 Mar 2023 20:54:57 +0200
Message-ID: <20230315185458.11638-3-feliu@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230315185458.11638-1-feliu@nvidia.com>
References: <20230315185458.11638-1-feliu@nvidia.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT109:EE_|CH0PR12MB5123:EE_
X-MS-Office365-Filtering-Correlation-Id: b8f07cd6-ecd5-4ad5-7225-08db2586cfb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HclvrT6ymZgfwFqLfnqnuBNddqq4mlU5X1+Q/rpmY87h+v2PFvb7jlPuC1HBl/eXKdl0Nb7JvkWU9jjYAZ0EgH7uKGUIwcJjixWBKPSBYvPy3johoyLC1amlvq+tZ+PVmUvo1yGMQNI4lbAQyeT51H2X0DnpcqwyaWt5ZXyOfO9OChIb2tC9Q+SJ5Am0aJn6gYl3Ep/+8WE267JAYbAO4Jy8MGyBAZnqeUE46cmpgecPubl5K15dkkvii7ZHlc4zz4khPUQw8Ig3RoARPWPiMbzG35tVOxcrbDC6v4OU1wyPr6kcj8Gp2P/r/iYESewo0BhUApZhb8hJiPcGpEms02x8We5meEZN/+0zzamysgEU08Kq/kniWNuu9g0YuKL1WZrCRPnxQM5ZNQoUFG297c0hlLkSkSTOf42QS54EO2X2OB/HGQAh/+5O1Y2/PAemZxnClGHxW29G8aao7/t1pJ9FQaHdNQCcCPU3+MBzsicHNFczAtDlrYEn9CkVgFC8pGBjqOpUomdtMEUT08LaSlzxk2ibHdC1AAyapGVfUlW71OmR03gG778tPampzpTxCRlf6gqvt6shke4aiE+iwYxKbGJsySG/ge5jyuAmaKCpoRkK/mYAESzTqZvEEH/IQUKSfhMffXEdoBorWb25cMs3b3oKY889VEj5XKIMeXVmPWUsOjpDb7dR1JdlZjCubwPlx4q/R4WSJQX6JtnxnclFmUxbB0+uzOAUFmvaiZWvWYhr0U64M8nXS9sO43Ka6frEDVlQAJoWhxd8ITLwHfQ1VSEZ3czBvh00XAcIjS8=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(396003)(39860400002)(376002)(136003)(451199018)(36840700001)(40470700004)(46966006)(41300700001)(5660300002)(8936002)(2906002)(36756003)(36860700001)(86362001)(356005)(82740400003)(7636003)(7696005)(478600001)(70586007)(6666004)(70206006)(6916009)(966005)(107886003)(8676002)(4326008)(40480700001)(40460700003)(82310400005)(47076005)(54906003)(83380400001)(426003)(316002)(2616005)(26005)(336012)(186003)(1076003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2023 18:55:14.2377 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8f07cd6-ecd5-4ad5-7225-08db2586cfb9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT109.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5123
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

Remove the inline keyword, according to kernel coding style [1], defining
inline functions is not necessary for samll functions.

It is verified with GCC 12.2.0, the generated code with/without inline
is the same. Additionally tested with kernel pktgen and iperf, and
verified the result, pps of the results are the same in the cases of
with/without inline.

[1]
https://www.kernel.org/doc/html/v6.2-rc3/process/coding-style.html#the-inline-disease

Signed-off-by: Feng Liu <feliu@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/virtio/virtio_ring.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 41144b5246a8..a26fab91c59f 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -233,8 +233,8 @@ static void vring_free(struct virtqueue *_vq);
 
 #define to_vvq(_vq) container_of(_vq, struct vring_virtqueue, vq)
 
-static inline bool virtqueue_use_indirect(struct vring_virtqueue *vq,
-					  unsigned int total_sg)
+static bool virtqueue_use_indirect(struct vring_virtqueue *vq,
+				   unsigned int total_sg)
 {
 	/*
 	 * If the host supports indirect descriptor tables, and we have multiple
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
+static bool more_used_split(const struct vring_virtqueue *vq)
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
