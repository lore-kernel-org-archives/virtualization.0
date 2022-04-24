Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FF75C4332F
	for <virtualization@archiver.kernel.org>; Sun, 24 Apr 2022 02:41:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C56F741702;
	Sun, 24 Apr 2022 02:41:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4Z6DV8BxVw4z; Sun, 24 Apr 2022 02:41:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id EECC04092F;
	Sun, 24 Apr 2022 02:40:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E524CC0086;
	Sun, 24 Apr 2022 02:40:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E0117C002D
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Apr 2022 02:40:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B9E49403BE
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Apr 2022 02:40:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tp05Hwlum00y
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Apr 2022 02:40:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-133.freemail.mail.aliyun.com
 (out30-133.freemail.mail.aliyun.com [115.124.30.133])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E651E4016D
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Apr 2022 02:40:54 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R191e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04357; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=4; SR=0; TI=SMTPD_---0VAzcuZa_1650768051; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VAzcuZa_1650768051) by smtp.aliyun-inc.com(127.0.0.1);
 Sun, 24 Apr 2022 10:40:52 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: linux-kernel@vger.kernel.org
Subject: [RFC PATCH 08/16] virtio_ring: packed: extract next_idx()
Date: Sun, 24 Apr 2022 10:40:36 +0800
Message-Id: <20220424024044.94749-9-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220424024044.94749-1-xuanzhuo@linux.alibaba.com>
References: <20220424024044.94749-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: c42022d07dde
Cc: virtualization@lists.linux-foundation.org,
 "Michael S. Tsirkin" <mst@redhat.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Separate the logic of idx growth of packed into a function. It is
convenient to share in multiple locations. Subsequent patches will also
use this logic.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index fa4270e8c009..e3525d92f646 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1330,6 +1330,18 @@ static int virtqueue_resize_split(struct virtqueue *_vq, u32 num,
  * Packed ring specific functions - *_packed().
  */
 
+static u32 next_idx(struct vring_virtqueue *vq, u32 idx)
+{
+	if ((unlikely(++idx >= vq->packed.vring.num))) {
+		idx = 0;
+		vq->packed.avail_used_flags ^=
+			1 << VRING_PACKED_DESC_F_AVAIL |
+			1 << VRING_PACKED_DESC_F_USED;
+	}
+
+	return idx;
+}
+
 static void vring_unmap_extra_packed(const struct vring_virtqueue *vq,
 				     struct vring_desc_extra *extra)
 {
@@ -1465,14 +1477,11 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 	vq->vq.num_free -= 1;
 
 	/* Update free pointer */
-	n = head + 1;
-	if (n >= vq->packed.vring.num) {
-		n = 0;
+	n = next_idx(vq, head);
+
+	if (n < head)
 		vq->packed.avail_wrap_counter ^= 1;
-		vq->packed.avail_used_flags ^=
-				1 << VRING_PACKED_DESC_F_AVAIL |
-				1 << VRING_PACKED_DESC_F_USED;
-	}
+
 	vq->packed.next_avail_idx = n;
 	vq->free_head = vq->packed.desc_extra[id].next;
 
@@ -1592,12 +1601,7 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 			prev = curr;
 			curr = vq->packed.desc_extra[curr].next;
 
-			if ((unlikely(++i >= vq->packed.vring.num))) {
-				i = 0;
-				vq->packed.avail_used_flags ^=
-					1 << VRING_PACKED_DESC_F_AVAIL |
-					1 << VRING_PACKED_DESC_F_USED;
-			}
+			i = next_idx(vq, i);
 		}
 	}
 
-- 
2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
