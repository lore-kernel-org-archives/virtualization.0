Received: from pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.83.148.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0D73EDACB
	for <virtualization@lists.linux.dev>; Mon, 17 Aug 2026 22:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.83.148.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787005973; cv=none; b=V3KRLwQngz7B9deakRbDg4gdw6ytQb5eHrVVY5tKxir9CEp/FIdc7EkeWN8HBTVuXmOXpr9tFuH1eXANg3Xcr9DFdL0ddSjuMlCz4M+kdotcShDDb5knXHRuYFozQb+PzBpYHN7qydqRuusO0FM901x64yfL6PGthwGYczukA3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787005973; c=relaxed/simple;
	bh=9zWXEnu2fl5xhqQPlwMgUiFrh4EIvGoxBY6eWzq5R+E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BSWgZQWK87Pn3zxx0snGDQKt1YIP/8c5cfcwerTAE9wTH4kmyj6NignhfTn70Ipd+3Kh+0cf/+CBy7viLK44+Yim0E66X/OnTk5BCXqTflS9G7XaBl7rfDBZPlQ4TNHQHX5dh24cRw/8Jm6cTakoiCmGacLwruuurtnQWJtSDnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=bOFRh97N; arc=none smtp.client-ip=35.83.148.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="bOFRh97N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1787005971; x=1818541971;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jWaY6e9LlKSjCAqiHPjq1jfr1HpG/1qkbd94J/fVYJA=;
  b=bOFRh97NeV7e4r+V2SGuRw7cJkO9sacyVCtlugPhD/JhviQCbW31u91W
   khNRijU5kTCf4ru2a4wg1SwFwi7wGiwQZwqKt6bpWo8QBQquvX/jPzgct
   D0cMckAngcaFKTUYIGuJfOVFlhFTZN2+sHpSgXB3NDBbmrMunIoqOXokr
   7GuWc0L2Ei4vOFxuyJ9AIlF7972ZSFTsniG8tRVg+OGVteco4u4PvIxQy
   zl2RRNQ0tGx55azOvWWnd/OLP2wpQuPtS5b04FNJy96dmIynNZgshlg4X
   SUlvSh5Blx93+qPQfrkJcuHRoh9ibJQeSPRatOV+FSXSKDVo/mzxtSTJA
   Q==;
X-CSE-ConnectionGUID: 84wRdPapQ/G4IzfmPWT3pQ==
X-CSE-MsgGUID: oQt3M2i8RiaulO2JU3C8jQ==
X-IronPort-AV: E=Sophos;i="6.25,229,1779148800"; 
   d="scan'208";a="26015023"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 22:32:33 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.51:27922]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.63.84:2525] with esmtp (Farcaster)
 id 119677b6-900a-4a1e-8076-bffe8e965faa; Mon, 17 Aug 2026 22:32:33 +0000 (UTC)
X-Farcaster-Flow-ID: 119677b6-900a-4a1e-8076-bffe8e965faa
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Mon, 17 Aug 2026 22:32:33 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Mon, 17 Aug 2026 22:32:31 +0000
From: Alexander Graf <graf@amazon.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>
CC: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?q?Eugenio=20P=C3=A9rez?=
	<eperezma@redhat.com>, Tiwei Bie <tiwei.bie@intel.com>, Stefan Hajnoczi
	<stefanha@redhat.com>, <virtualization@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <nh-open-source@amazon.com>
Subject: [PATCH] virtio_ring: fix stale descriptor flags after a failed packed add
Date: Mon, 17 Aug 2026 22:32:29 +0000
Message-ID: <20260817223229.28954-1-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWA001.ant.amazon.com (10.13.139.101) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

In a packed ring the AVAIL and USED bits sit in the descriptor itself,
so writing them makes that descriptor available. Those bit combinations
flip meaning on every round of the ring, tracked by a wrap counter, so
invalidating or validating a descriptor means inverting both bits.

Commit 1ce9e6055fa0 ("virtio_ring: introduce packed ring support") has
virtqueue_add_packed() make every descriptor of a chain available as it
maps the chain, and write the head last. The device consumes the ring in
order and stops at a head that is not available yet, so it never reaches
the rest.

When vring_map_one_sg() fails partway, unmap_release unmaps the segments
and restores avail_used_flags, but the descriptors it wrote to in the
ring stay marked with AVAIL and USED bits. The head is now the only
entry that keeps the device from consuming these stale entries.

For example, the ring would look like this now.

  Z - pre-previous command
  A - previous command
  B - aborted command
  C - current command

  [A1 DONE] [A2 DONE] <C1 EMPTY> [B2] [B3] [Z1 DONE]

When the driver now attempts to issue the C command, the next add starts
at the same head as B. If C spans less descriptors than B, there is no
end marker because AVAIL and USED bits were still in place. And that
means the device will start interpreting these stale entries (B2/B3) as
another command entry, which then blocks the queue.

This effect typically happens in swiotlb configurations under memory
pressure, because vring_map_one_sg() can then fail with larger I/O
requests which then leads to command abortions.

There are broadly 2 ways to avoid leaving those flags behind:

  1) Defer those flags too until the chain is complete.
  2) Rewrite those flags for the previous wrap counter.

Implement the second option in both packed add paths. The first option
traverses the chain a second time on every successful add. The second
option invalidates all added descriptors when any add fails.

With this patch applied, a packed virtqueue keeps completing requests
after a failed add.

Fixes: 1ce9e6055fa0 ("virtio_ring: introduce packed ring support")
Fixes: f6a15d854986 ("virtio_ring: add in order support")
Assisted-by: Kiro:claude-opus-5 checkpatch sparse
Signed-off-by: Alexander Graf <graf@amazon.com>

---
 drivers/virtio/virtio_ring.c | 38 ++++++++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index b438dc2ce1b8..a9e1ee9536b5 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1670,7 +1670,7 @@ static inline int virtqueue_add_packed(struct vring_virtqueue *vq,
 	struct scatterlist *sg;
 	unsigned int i, n, c, descs_used, err_idx, len;
 	__le16 head_flags, flags;
-	u16 head, id, prev, curr, avail_used_flags;
+	u16 head, id, prev, curr, avail_used_flags, unpub_flags;
 	int err;
 
 	START_USE(vq);
@@ -1798,15 +1798,30 @@ static inline int virtqueue_add_packed(struct vring_virtqueue *vq,
 	curr = vq->free_head;
 
 	vq->packed.avail_used_flags = avail_used_flags;
+	unpub_flags = avail_used_flags ^ (1 << VRING_PACKED_DESC_F_AVAIL |
+					  1 << VRING_PACKED_DESC_F_USED);
 
 	for (n = 0; n < total_sg; n++) {
 		if (i == err_idx)
 			break;
+		/*
+		 * The mapping loop made every descriptor but the head
+		 * available. Stamp the previous wrap counter's AVAIL and USED
+		 * bits on those, so that a later and shorter chain at this head
+		 * does not leave one of them available beyond its own last
+		 * descriptor. Marking them used instead would hand
+		 * is_used_desc_packed() a completion we never made.
+		 */
+		if (i != head)
+			desc[i].flags = cpu_to_le16(unpub_flags);
 		vring_unmap_extra_packed(vq, &vq->packed.desc_extra[curr]);
 		curr = vq->packed.desc_extra[curr].next;
 		i++;
-		if (i >= vq->packed.vring.num)
+		if (i >= vq->packed.vring.num) {
 			i = 0;
+			unpub_flags ^= 1 << VRING_PACKED_DESC_F_AVAIL |
+				       1 << VRING_PACKED_DESC_F_USED;
+		}
 	}
 
 	END_USE(vq);
@@ -1828,7 +1843,7 @@ static inline int virtqueue_add_packed_in_order(struct vring_virtqueue *vq,
 	struct scatterlist *sg;
 	unsigned int i, n, sg_count, err_idx, total_in_len = 0;
 	__le16 head_flags, flags;
-	u16 head, avail_used_flags;
+	u16 head, avail_used_flags, unpub_flags;
 	bool avail_wrap_counter;
 	int err;
 
@@ -1955,14 +1970,29 @@ static inline int virtqueue_add_packed_in_order(struct vring_virtqueue *vq,
 	i = head;
 	vq->packed.avail_used_flags = avail_used_flags;
 	vq->packed.avail_wrap_counter = avail_wrap_counter;
+	unpub_flags = avail_used_flags ^ (1 << VRING_PACKED_DESC_F_AVAIL |
+					  1 << VRING_PACKED_DESC_F_USED);
 
 	for (n = 0; n < total_sg; n++) {
 		if (i == err_idx)
 			break;
+		/*
+		 * The mapping loop made every descriptor but the head
+		 * available. Stamp the previous wrap counter's AVAIL and USED
+		 * bits on those, so that a later and shorter chain at this head
+		 * does not leave one of them available beyond its own last
+		 * descriptor. Marking them used instead would hand
+		 * is_used_desc_packed() a completion we never made.
+		 */
+		if (i != head)
+			desc[i].flags = cpu_to_le16(unpub_flags);
 		vring_unmap_extra_packed(vq, &vq->packed.desc_extra[i]);
 		i++;
-		if (i >= vq->packed.vring.num)
+		if (i >= vq->packed.vring.num) {
 			i = 0;
+			unpub_flags ^= 1 << VRING_PACKED_DESC_F_AVAIL |
+				       1 << VRING_PACKED_DESC_F_USED;
+		}
 	}
 
 	END_USE(vq);

base-commit: fc02acf6ac0ccde0c805c2daa9148683cdd01ba8
-- 
2.47.1

