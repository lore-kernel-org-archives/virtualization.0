Received: from mail-pj2-f38.google.com (mail-pj2-f38.google.com [74.125.227.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45CA37EFE9
	for <virtualization@lists.linux.dev>; Sun,  4 Oct 2026 23:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791157875; cv=none; b=mBsGEEkybZFWWRZBJuztho4+7NHf9mBRKMA1GLCzzETLSHqKmh+xXEKWXRAF6AqT3cUQzrrZBDD2xan+ldmwHsT471yAaVIlDav6Wk9QAk4tyNX01tYM/o8NxlH1mtP98Tx8OIF+RPgYU6Fimr8oICr6q7/574cKRJU1LrmNUBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791157875; c=relaxed/simple;
	bh=r9JeIpNoZHCyy/ygKsUJh/s5EDs4VehT8XxBw1zqi5M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qz/bKLkEbE0ueCkupoQHeMpxq9d2rpEJO7hkvh+28Xu3Ny/sCfuv6+fwMte9EWdEJnGF5KKinSyY0KBWz8eYSboKOTX+7SwnA2ZnVhwnzjqoq/lTMvjJMhcbeakvVrCv5kjFa4I60Vg9K7xaggtmYMzMxyJ9EuRKdBzEej5aYW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GPnYdJ1+; arc=none smtp.client-ip=74.125.227.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GPnYdJ1+"
Received: by mail-pj2-f38.google.com with SMTP id 98e67ed59e1d1-3a8195ed6fdso25248a91.1
        for <virtualization@lists.linux.dev>; Sun, 04 Oct 2026 16:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791157873; x=1791762673; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tAh1IpDRk+myJWBu/bO09Zer/mYlX7SwJvX5QUX3ZFc=;
        b=GPnYdJ1+//PX41MSwQTWfx2Jb2eY9zAO7NY6o1X4szRl8iORt3VoVb43Sk3abRv43l
         Q3E3PAlCWjXtlAHEJ/we66fJM6HZoSZLwY5q/Bk4m+K0xLu3Hw0y4p5QD3bMfhT9KVg3
         wCv0layQGlihoMyf1m0n0Rov8xnqlbwpUJnrj4aVD6pZBJjHCC3m8MDiMIBQXbs3llgm
         C3cQalPnt5BZb1f7OfDd/+uBA9XjIWuFxvguNoJPx82JYfWnTqEtRP00tBeGyiMx9tG2
         nmAdXziyLvuTqdoh3T4qjM0ttUlSCo60AUNCJfF4ynv/0RLseE75HxHCT67wkaR7mJY8
         yyaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791157873; x=1791762673;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tAh1IpDRk+myJWBu/bO09Zer/mYlX7SwJvX5QUX3ZFc=;
        b=XYbXuPVEtbaO2W3qO4Nkm9HPTlDcYWur/h2VzBdJc0DRbZoEYLBpyeGOuQZgJY+sQb
         epZs/o16I6hTF21nwW+iNkC2jJNBvPuJ3QIaw+KLCIigmGFD6BojYQRWDYkdbM0n0I6K
         Dc47iPLfuulqjOgOS8DYFKUvc3K7tFl4oLZ3LtUKR77Z8tLV1SsUptXbs3JD3id8gYr9
         ajDX/OT68o+55rnBIY91SdBAGGnKEE3LUd2TDzmKmgbkaXVVhn+YE5ZRvVN2A798VQ8v
         37HT/TzmrsXqZdxk346s+EgsF6wJOz9q9KcPPLXo3MyJ6xgGAW1tA51GErIvn2c4gDir
         K6bQ==
X-Forwarded-Encrypted: i=1; AKwUvByBHCTK3rQvaxeU+a/9Rm/gO2RVDTxTYSGo8Om5DuNhANe5nyRM443Nl+0u/nuMPrdOAM/ukJUHv/H7HB4UBA==@lists.linux.dev
X-Gm-Message-State: AFq9FYK6WNlCI/Raaf8YU8PV0z39+U9rhVTwZKCqfow81/vkqmWtxsLx
	MVdZHxHpq43wKXh69145Jg7jM0ztLPa4G59VgvjVzIStpOEBAPklCSX0
X-Gm-Gg: AYBFou2QNqOOlkDz3vcvVE8ueAgsmBg+ZNFFMnK0M0rJfLLZ5pT7lsHeWTRc7kDocj/
	9atDDbyHzaXCX+TXkt9vPxnfAYzn7Gbimf/vHjXtYqMbzMsrobyp3aFizcYTUaV/KfX43y9e/Yz
	YlifcadgLIINuEtsUqpffcki7R+TLeZQSB9Yqh4cP77JHPM0i4pvB1LnhlKIMByfUnPQI9Ct7Mq
	LN/DXeD1d3IQaOZo3jblDd6Axv7UbS7RXoy4Lsb9tN/34xXKpNxQXp5bsyGhXzTQClXQ5qocb45
	wcYNQduWq0Q9Dydvjo3CPXxBgkiiQq3CFg8eM36Z1MqUN0sL8Ym1wWE5iSm0gTmhnlEGUQikXTv
	DIYu4ZUfbbXOasrV9MMzSbtQaH6p6PG4hKrc8y2Bw5XobXf5QIiNHHjXG6Z6KvJ38HvalBPLW3b
	AwnZGpF0Qg2bC6ssv5EtKkdQ2fgqu46oPEpLxHRnIe1tuflJZbSDRBPa8kwa25uuRnfUAmxZ+56
	KBKwmhVzLM=
X-Received: by 2002:a17:90b:58c5:b0:3a4:f8da:2478 with SMTP id 98e67ed59e1d1-3a6cec6044emr6950610a91.29.1791157873044;
        Sun, 04 Oct 2026 16:51:13 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a7bfc344bbsm5532242a91.12.2026.10.04.16.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 16:51:12 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Cc: Daehyeon Ko <4ncienth@gmail.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Bobby Eshleman <bobby.eshleman@bytedance.com>,
	"David S . Miller" <davem@davemloft.net>,
	Will Deacon <will@kernel.org>,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v3] vhost/vsock: size receive SKBs from declared payload
Date: Mon,  5 Oct 2026 08:51:01 +0900
Message-ID: <20261004235101.1464007-1-4ncienth@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vhost_vsock_alloc_skb() sizes the skb from iov_length(), the total guest
descriptor length.  virtio_transport_inc_rx_pkt() instead adds hdr->len to
rx_bytes and buf_used, and budgets each queued skb as SKB_TRUESIZE(0).  The
guest controls the descriptor length and hdr->len independently.

A guest can therefore provide a 64 KiB descriptor while declaring a zero
payload.  The descriptor-sized skb remains queued, rx_bytes and buf_used
remain unchanged, and only the fixed queue-entry budget limits retention.
This is not a lifetime leak: the skb is freed when dequeued or at socket
teardown.  Repeating this across connections can nevertheless exhaust host
memory.  On Linux v7.2, 455 such descriptors retained 30,255,680 bytes for
a 262,144-byte receive buffer; a full-payload control retained 265,984
bytes.

Vhost previously read hdr->len and allocated pkt->buf from that value.  The
conversion from virtio_vsock_pkt to sk_buff instead allocated receive skbs
from the descriptor length, introducing the allocation-accounting mismatch.

Copy the header into a stack object and validate hdr->len before allocating
the skb.  Size the allocation as sizeof(hdr) + payload_len so descriptor
capacity no longer determines queued memory.  Check payload_len against
len - sizeof(hdr) to avoid addition overflow on 32-bit hosts.

Fixes: 71dc9ec9ac7d ("virtio/vsock: replace virtio_vsock_pkt with sk_buff")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
---
Changes in v3:
- clarify that queued skb memory is under-accounted rather than leaked, and
  explain why a zero payload is the strongest case;
- remove v1-to-v2 implementation rationale from the permanent changelog;
- correct the Fixes tag from ab9aa2f3afc2 to 71dc9ec9ac7d; and
- make no code changes.

v2: https://lore.kernel.org/netdev/20261004073419.4039011-1-4ncienth@gmail.com/

The issue was identified during an LLM-assisted source audit and confirmed
with a focused in-kernel probe on Linux v7.2.  The code diff is
byte-identical to v2, so its existing build and runtime results remain
applicable.

 drivers/vhost/vsock.c | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index abed1fbcf66cc5..35f75e23c7497e 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -364,7 +364,7 @@ static struct sk_buff *
 vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
 		      unsigned int out, unsigned int in)
 {
-	struct virtio_vsock_hdr *hdr;
+	struct virtio_vsock_hdr hdr;
 	struct iov_iter iov_iter;
 	struct sk_buff *skb;
 	size_t payload_len;
@@ -382,34 +382,32 @@ vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
 	    len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE + VIRTIO_VSOCK_SKB_HEADROOM)
 		return NULL;
 
-	/* len contains both payload and hdr */
-	skb = virtio_vsock_alloc_skb(len, GFP_KERNEL);
-	if (!skb)
-		return NULL;
-
 	iov_iter_init(&iov_iter, ITER_SOURCE, vq->iov, out, len);
 
-	hdr = virtio_vsock_hdr(skb);
-	nbytes = copy_from_iter(hdr, sizeof(*hdr), &iov_iter);
-	if (nbytes != sizeof(*hdr)) {
+	nbytes = copy_from_iter(&hdr, sizeof(hdr), &iov_iter);
+	if (nbytes != sizeof(hdr)) {
 		vq_err(vq, "Expected %zu bytes for pkt->hdr, got %zu bytes\n",
-		       sizeof(*hdr), nbytes);
-		kfree_skb(skb);
+		       sizeof(hdr), nbytes);
 		return NULL;
 	}
 
-	payload_len = le32_to_cpu(hdr->len);
+	payload_len = le32_to_cpu(hdr.len);
+
+	/* The pkt is too big or the length in the header is invalid */
+	if (payload_len > len - sizeof(hdr))
+		return NULL;
+
+	/* Allocate only for the payload declared in the header. */
+	skb = virtio_vsock_alloc_skb(payload_len + sizeof(hdr), GFP_KERNEL);
+	if (!skb)
+		return NULL;
+
+	memcpy(virtio_vsock_hdr(skb), &hdr, sizeof(hdr));
 
 	/* No payload */
 	if (!payload_len)
 		return skb;
 
-	/* The pkt is too big or the length in the header is invalid */
-	if (payload_len + sizeof(*hdr) > len) {
-		kfree_skb(skb);
-		return NULL;
-	}
-
 	virtio_vsock_skb_put(skb, payload_len);
 
 	if (skb_copy_datagram_from_iter(skb, 0, &iov_iter, payload_len)) {

base-commit: 6dc989ea46b96ce170840174b4a38c4a387fb005
-- 
2.55.0
