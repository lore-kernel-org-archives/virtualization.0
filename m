Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E1525C6E2
	for <virtualization@lists.linux.dev>; Tue, 28 Oct 2025 03:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761620642; cv=none; b=jEJYOIdl7P5f+4YaSHj01QCpEjKNesHeotPAyWpbHlaxg092sNqxrKDBA++oUptEErdoHFrZ98xclVHjZFXf8Tdf9RyZopXxKJwkmPmc9CPlQmeXQ5OXAGBSz0HYbZUH2JgIGdvX22NkfDeHyNu2aYvanJEdMTe+3n6JKYpB27U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761620642; c=relaxed/simple;
	bh=MAMBTDB5J81podhs/Vxvh8Om3RfCRucDoiCNDGV+6Gc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lVUVVuv2JCHyQtHGrs3AevNUpeEzNJT3CazA/WI8PFvc6txNJtQKtODCZ+R3KPIHv/gcFgaxAMTb1vV7HKpg+AoFiEoOuGIjJmFQ9ak5zdiyUs7rzbhFYVrId81UPqBBLkWiWCyhpCntZ5jSah9rEyv3sinb+oQML3BEBwPxF8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BSp2w5cP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BSp2w5cP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761620638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vfNTkoX5o8M7lD+gAK07FYlqQWjsG6C+tpRjNjLD85s=;
	b=BSp2w5cPG1EdyFxoMlxx1K25J0KLTphWGYcKP44ElDZ9O3GLs728pJ7E6Z+8KEt6HILjmo
	H7knc4oTuCw9t8O3pXc0VxvRLwy8brgn9TdR4j912LHpTuodTeQKe9f37u+MEApw2PvZiu
	DF4CtUaLJy2wGec/E8gDYcfoz6fSDx0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-548-MOErp7MUNkyaHL7YM-fbQQ-1; Mon,
 27 Oct 2025 23:03:54 -0400
X-MC-Unique: MOErp7MUNkyaHL7YM-fbQQ-1
X-Mimecast-MFC-AGG-ID: MOErp7MUNkyaHL7YM-fbQQ_1761620632
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3FF84180A220;
	Tue, 28 Oct 2025 03:03:52 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.238])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 129E219560AD;
	Tue, 28 Oct 2025 03:03:44 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] virtio-net: calculate header alignment mask based on features
Date: Tue, 28 Oct 2025 11:03:41 +0800
Message-ID: <20251028030341.46023-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Commit 56a06bd40fab ("virtio_net: enable gso over UDP tunnel support.")
switches to check the alignment of the virtio_net_hdr_v1_hash_tunnel
even when doing the transmission even if the feature is not
negotiated. This will cause a series performance degradation of pktgen
as the skb->data can't satisfy the alignment requirement due to the
increase of the header size then virtio-net must prepare at least 2
sgs with indirect descriptors which will introduce overheads in the
device.

Fixing this by calculate the header alignment during probe so when
tunnel gso is not negotiated, we can less strict.

Pktgen in guest + XDP_DROP on TAP + vhost_net shows the TX PPS is
recovered from 2.4Mpps to 4.45Mpps.

Note that we still need a way to recover the performance when tunnel
gso is enabled, probably a new vnet header format.

Fixes: 56a06bd40fab ("virtio_net: enable gso over UDP tunnel support.")
Cc: stable@vger.kernel.org
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 31bd32bdecaf..5b851df749c0 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -441,6 +441,9 @@ struct virtnet_info {
 	/* Packet virtio header size */
 	u8 hdr_len;
 
+	/* header alignment */
+	size_t hdr_align;
+
 	/* Work struct for delayed refilling if we run low on memory. */
 	struct delayed_work refill;
 
@@ -3308,8 +3311,9 @@ static int xmit_skb(struct send_queue *sq, struct sk_buff *skb, bool orphan)
 	pr_debug("%s: xmit %p %pM\n", vi->dev->name, skb, dest);
 
 	can_push = vi->any_header_sg &&
-		!((unsigned long)skb->data & (__alignof__(*hdr) - 1)) &&
+		!((unsigned long)skb->data & (vi->hdr_align - 1)) &&
 		!skb_header_cloned(skb) && skb_headroom(skb) >= hdr_len;
+
 	/* Even if we can, don't push here yet as this would skew
 	 * csum_start offset below. */
 	if (can_push)
@@ -6926,15 +6930,20 @@ static int virtnet_probe(struct virtio_device *vdev)
 	}
 
 	if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO) ||
-	    virtio_has_feature(vdev, VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO))
+	    virtio_has_feature(vdev, VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO)) {
 		vi->hdr_len = sizeof(struct virtio_net_hdr_v1_hash_tunnel);
-	else if (vi->has_rss_hash_report)
+		vi->hdr_align = __alignof__(struct virtio_net_hdr_v1_hash_tunnel);
+	} else if (vi->has_rss_hash_report) {
 		vi->hdr_len = sizeof(struct virtio_net_hdr_v1_hash);
-	else if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF) ||
-		 virtio_has_feature(vdev, VIRTIO_F_VERSION_1))
+		vi->hdr_align = __alignof__(struct virtio_net_hdr_v1_hash);
+	} else if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF) ||
+		virtio_has_feature(vdev, VIRTIO_F_VERSION_1)) {
 		vi->hdr_len = sizeof(struct virtio_net_hdr_mrg_rxbuf);
-	else
+		vi->hdr_align = __alignof__(struct virtio_net_hdr_mrg_rxbuf);
+	} else {
 		vi->hdr_len = sizeof(struct virtio_net_hdr);
+		vi->hdr_align = __alignof__(struct virtio_net_hdr);
+	}
 
 	if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM))
 		vi->rx_tnl_csum = true;
-- 
2.31.1

