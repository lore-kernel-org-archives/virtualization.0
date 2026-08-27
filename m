Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB87318BA6
	for <virtualization@lists.linux.dev>; Thu, 27 Aug 2026 05:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787810378; cv=none; b=r0EgyZ+mQA7VFFTIzZtv9yT7kFjKWBHzBQf22sQ1BNV394N2xQZHWNlSMofYSNJgzE9aLMbgDuOqj7r4nW+vfeVHu7pX/7uaS4ArmxYwAlWo/n1DySMN8dTADHSEXWNoPUj0IYVxKJp9O6c2HMuytyB/90eftVzhFPrZ9oj8LhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787810378; c=relaxed/simple;
	bh=6xGaRyHabjqQHSPfBdLVdAauPJVqvcRRuz9CkwkMyeE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lQY2uR7g6ebHLWs5xm7fDyKcHV4DrdFMPrJdwixKHmzIbdCMJCiuCD8w+wl8dMqV743EOY9Kju2pJLOLqspz1vWOPeVJA/knMUlWK+yLsk0qf8WLDyFrmDDYh3a+j6QwXUUlMwoVLGS8axskZfs2UXNCAVs1FD+DPCUy71qYHmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=otn8JNqH; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="otn8JNqH"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2d6fe26ef1cso20459445ad.2
        for <virtualization@lists.linux.dev>; Wed, 26 Aug 2026 22:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787810376; x=1788415176; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=O+Chh90ybpjMvhqrL9ZavLsHC4dx+fqvxodSXo5kx7g=;
        b=otn8JNqHchZuI5xwqY5MaXdTIbZdCn8KU0RPw9NvbBktco89JsSO66HVWMG5mjgYVI
         P28RmdfbVCzvBK1Hk+s4oXtxEM46YHOarZpCZ0C/lVElU8agKLkr6+d1aKF7a74iQ/rD
         K3GFBag9H+tWjTzG1JQaJoDWKdSMtHkYYtvm9WaGVM+j2vISKqRSJWanGWwkx7pH0ERS
         QPxjqU9Kp5lI0+PAgwAdXEKd/NHt97uibE93/p9Id8WG2Y4/vAo7DK/zkN0uoIRnvFis
         wgWerb0xgCUm9jEWZ/0wVZHY7KsCMVkBluLPGFqGiu2RmfLvSVrnqDtSswR7J0t8zxG8
         krDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787810376; x=1788415176;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O+Chh90ybpjMvhqrL9ZavLsHC4dx+fqvxodSXo5kx7g=;
        b=h9ZZhDsLWygMAQ6LlChimlEwBXAzEQJnSocNw7NGktwZSn2myApyv78/GgmYF6gpa9
         Fl8W0i/Iu/ntRfqTZsXbSpNqAvpxdw8jmReRG2UtbuCg9o7UczoZePMnAJfy5CbcB/u7
         YvRu+c3MwEl7vGfeZQHtCdTgrABQhK5nXXxiNg/DEQuK37jFdsE44JrRj9hZWnDWn/Wl
         k4Oi4DIzbyg9BDXWc7rfExXg5KcSjNZWuDk3khM6tyW1KxABMD4mxu4Wx/J2rmlgWRhR
         ObOYVBo25oF8U2iPISPr5JQPWOPdCi7MNuiu+q0oaw11HgueV2jfDAuohO1ZZNjdTSkI
         Vqhg==
X-Forwarded-Encrypted: i=1; AHgh+RoT7t028TbLwgf1KOSPb7hU4Mcmnk/isM1n9G6PPSpQovzQLNUxaayBFsENjx5H0/kKg/mm/zcmvtnh7gwvqg==@lists.linux.dev
X-Gm-Message-State: AFuF++kUZIBIV6cXc6WBNo3yfYYJ1SA4xn2OSzImRxsio97Wqpc06bz0
	i53l9ZEJFvyKH7Ki4ktjq+ENBcBwWQRYzWdF+XAIg3VREvtm/EFB98wf87r5Lg==
X-Gm-Gg: AR+sD10FqCyJAjX1Hp+xc/iroD7H7y3DgVH1WSwM+FRf09ZY+X8AhBmU+OZWvDHKxY4
	Td4CZ+BYi/LyW7JejhUg1+HTVuJnYvpHWMOZ+lroK20qUoqwyLoey+FXzveYvNBrU1xIt1dr7DO
	u1hSyGizJfq3Ixw+YQ9yuozlNIkMBxa72ApYrEjMDjXxxtsTfRw4wyQbt0pJaR4PqkroxyGLnI/
	aFzQOl2gyYIy2SNbTOlFYyxJga5fATL50MuZTy4uM7JHOoY9ynrYauB+1h6eUxuz306tyxbvhK7
	jeimJmZXtK85PQ/P3sjBSWD9z0HpTuKhZnTeARwNpfkUi5D+rAx1pD3HqooTt7HFkRc6E4i2lCy
	UHcaoMWuzCin3hTGZORm9s3uSvg9Uq+y6K1t9xtQ3Zj6n5mLGNyMoJIe3Eo8GggeLf5VH9J0szQ
	63kVW9D6ApWw03k1IDW0J6LtgA2yZQqsCB8KsgXskdwKdjaVhf/vrMZz4LdzjiqJtMduLXELA=
X-Received: by 2002:a17:903:26c5:b0:2d1:1a18:4d0a with SMTP id d9443c01a7336-2d707b3c6a6mr237304505ad.9.1787810375877;
        Wed, 26 Aug 2026 22:59:35 -0700 (PDT)
Received: from gmail.com ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d70493f3f5sm13971145ad.1.2026.08.26.22.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 22:59:35 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>
Cc: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] vhost/vsock: batch RX used-ring updates
Date: Thu, 27 Aug 2026 13:58:50 +0800
Message-Id: <20260827055850.26951-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vhost_transport_do_send_pkt() calls vhost_add_used() for every Guest RX
buffer even though it delays the Guest signal until the worker finishes.
Each call publishes one used entry and updates the used index separately.

Collect the completed buffer heads in the arrays already allocated for the
virtqueue and publish them with vhost_add_used_n().  Bound the batch by the
ring size, array capacity, and worker packet budget.  Flush before
re-enabling notifications or leaving the worker.

Each used entry describes one completed RX buffer and keeps its actual used
length, so set nheads to 1 for every entry.  This patch does not change
negotiated features or compress multiple buffers into one used entry.

This patch is limited to the current skb-based vhost-vsock RX path.

Performance:

Tested with a QEMU/KVM guest on a host with 4 online CPUs, using 2 vCPUs
pinned to host CPUs 2 and 3, QEMU 10.2.1, q35, 1536 MiB, and Linux
7.2.0-rc3-next-20260713-next-debug-kasan.  The vhost-vsock source is based
on linux-next master at 49362394dad7df66c274c867a271394c10ca2bb8.

Current vhost-vsock does not implement VIRTIO_F_IN_ORDER or
VIRTIO_F_RING_PACKED, so both configurations used packed=off and
in_order=off:

  baseline:                 RX batching=off
  vhost-vsock RX batching:  RX batching=on

The test used vsock_perf.  The Guest receiver was started with:

  vsock_perf --port PORT --buf-size 64M --vsk-size 64M --rcvlowat 1

The Host sender was started with:

  vsock_perf --sender 3 --port PORT --bytes BYTES \
      --buf-size SEND_BUF --vsk-size 64M

Each workload transferred BYTES=1 GiB.  The SEND_BUF values were 256 B
(SEND_BUF=256), 512 B (SEND_BUF=512), 4 KiB (SEND_BUF=4K), and 64 KiB
(SEND_BUF=64K).
Each state used a fresh Guest.  Each workload uses 20 paired runs, with 10
runs in each order.  The reported values are
Guest RX throughput in Gbits/s.  The baseline and batching columns are the
geometric means over the 20 runs; change is batching / baseline - 1,
computed from the unrounded values:

  workload   baseline RX    batching RX   change   faster
  256 B      0.0795724      0.0831509      +4.497%  20/20
  512 B      0.1194885      0.1210297      +1.290%  14/20
  4 KiB      0.7208273      0.7242053      +0.469%  11/20
  64 KiB     2.1712797      2.1951941      +1.101%  13/20

For reference, the table below gives the 95% normal-approximation intervals
obtained from the 20 paired log(batching / baseline) values:

  workload   paired 95% interval
  256 B      +3.985% to +5.011%
  512 B      +0.206% to +2.385%
  4 KiB      -1.442% to +2.416%
  64 KiB     -1.474% to +3.745%

All transfers passed byte-count checks, and no kernel errors were observed
in the logs.  The 256-byte workload improved in every pair.  The 512 B
workload was faster in 14 of 20 pairs, with a small gain.  The 4 KiB and
64 KiB workloads showed no material throughput change; the difference
between their results may be due to scheduling and execution variation.

Link: https://lore.kernel.org/r/20181214082146-mutt-send-email-mst@kernel.org
Link: https://lore.kernel.org/r/20220901055434.824-4-qtxuning1999@sjtu.edu.cn
Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
 drivers/vhost/vsock.c | 41 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 39 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 9aaab6bb8..d8050cca2 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -103,12 +103,37 @@ static bool vhost_transport_has_remote_cid(struct vsock_sock *vsk, u32 cid)
 	return found;
 }
 
+static bool vhost_vsock_flush_used(struct vhost_virtqueue *vq,
+				   unsigned int *used_count)
+{
+	if (!*used_count)
+		return false;
+
+	vhost_add_used_n(vq, vq->heads, vq->nheads, *used_count);
+	*used_count = 0;
+	return true;
+}
+
+static void vhost_vsock_add_used(struct vhost_virtqueue *vq,
+				 unsigned int *used_count,
+				 unsigned int head, unsigned int len)
+{
+	struct vring_used_elem *used = &vq->heads[*used_count];
+
+	used->id = cpu_to_vhost32(vq, head);
+	used->len = cpu_to_vhost32(vq, len);
+	vq->nheads[*used_count] = 1;
+	(*used_count)++;
+}
+
 static void
 vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
 			    struct vhost_virtqueue *vq)
 {
 	struct vhost_virtqueue *tx_vq = &vsock->vqs[VSOCK_VQ_TX];
 	int pkts = 0, total_len = 0;
+	unsigned int used_count = 0;
+	unsigned int used_limit;
 	bool added = false;
 	bool restart_tx = false;
 
@@ -120,6 +145,12 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
 	if (!vq_meta_prefetch(vq))
 		goto out;
 
+	used_limit = min_t(unsigned int, vq->num,
+			   min_t(unsigned int, vq->dev->iov_limit,
+				 vq->dev->weight));
+	if (unlikely(!used_limit))
+		goto out;
+
 	/* Avoid further vmexits, we're already processing the virtqueue */
 	vhost_disable_notify(&vsock->dev, vq);
 
@@ -134,9 +165,13 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
 		u32 offset;
 		int head;
 
+		if (used_count == used_limit)
+			added |= vhost_vsock_flush_used(vq, &used_count);
+
 		skb = virtio_vsock_skb_dequeue(&vsock->send_pkt_queue);
 
 		if (!skb) {
+			added |= vhost_vsock_flush_used(vq, &used_count);
 			vhost_enable_notify(&vsock->dev, vq);
 			break;
 		}
@@ -153,6 +188,7 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
 			/* We cannot finish yet if more buffers snuck in while
 			 * re-enabling notify.
 			 */
+			added |= vhost_vsock_flush_used(vq, &used_count);
 			if (unlikely(vhost_enable_notify(&vsock->dev, vq))) {
 				vhost_disable_notify(&vsock->dev, vq);
 				continue;
@@ -230,8 +266,8 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
 		 */
 		virtio_transport_deliver_tap_pkt(skb);
 
-		vhost_add_used(vq, head, sizeof(*hdr) + payload_len);
-		added = true;
+		vhost_vsock_add_used(vq, &used_count, head,
+				     sizeof(*hdr) + payload_len);
 
 		VIRTIO_VSOCK_SKB_CB(skb)->offset += payload_len;
 		total_len += payload_len;
@@ -264,6 +300,7 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
 			virtio_transport_consume_skb_sent(skb, true);
 		}
 	} while(likely(!vhost_exceeds_weight(vq, ++pkts, total_len)));
+	added |= vhost_vsock_flush_used(vq, &used_count);
 	if (added)
 		vhost_signal(&vsock->dev, vq);
 
-- 
2.53.0
