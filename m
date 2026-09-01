Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A6D43A807
	for <virtualization@lists.linux.dev>; Tue,  1 Sep 2026 03:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788232675; cv=none; b=fo28cAwQbAdLloOi4au5G+qIKg86E//DtFsLf0Gg8YQKJweLqojxMQXJgN9Q063I0bVceYwd9rdh08tQzel+n3MiuMwSu4t3AMEmcBbrQzQTlgYjyghlpAVCiHc6nyF7pNuFMnThnZ+E1c8vvRFGbVSECZrI1B8AZ+dUrlP7t4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788232675; c=relaxed/simple;
	bh=jGwwSAzdsI1x694uTmEB/L0jmbLi7GZ29rqwKsyXlu4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=PU5tMnBkaoXv1m4lKVEY+Cvrgjqmzxf7y/PaneMj6rRGddytkNY3BOJiDOJbdH+px4xUQ5lONdpn4M5RgWG+bnlirxBpv4pArUf5MQH8/mGiKczyS1PVmv7gc5mfsh3jdKkBLkUItUGdN1UqfkO2leTJSx+mU5w0aNM7eUQMRU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EfTkscOY; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EfTkscOY"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8525efa7274so313784b3a.2
        for <virtualization@lists.linux.dev>; Mon, 31 Aug 2026 20:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788232672; x=1788837472; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qVvb9puxMkwSFWKQtCywkwivRBgKsNgnDLb5dUD4vjE=;
        b=EfTkscOYsjdu4pdltxgqruTjSwz9840rFSlLAb762CHDtm8lsAXkxcx+SUGrHJIx9B
         4kmn9xZkT8I1E2rD/Yh2HKkvutTKNWnxxvS/WNViFf2gnrQXFMQQjt6uD57SRDAkDVEQ
         8K0uMxZy7XtbLpEFqUi2XS90BfGX6o7UjYLYc66Yh6/us6j09WJs5Z+tUseExUrrBFfl
         4XQ3cslDW3OxaqwoHbS+hjzKFBM3G8UXwCXmw8UTq+LN28S+LEUvvOAitBTkH/gpt0oW
         VkRAQcvHW73bjRdEf1KTxoVozmafk1uu2hV6tF3y3Djs7uX7S0m3qRQsc6zHtEZfoZ2X
         KcOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788232672; x=1788837472;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qVvb9puxMkwSFWKQtCywkwivRBgKsNgnDLb5dUD4vjE=;
        b=GMY27piTSCCK29Rs84W8t/iE5F+M4rPjp3L9MMlogG2mIKf0KLOeD0msHohRnC8LmV
         cpvTJFBdoPPdVCoF2O1NM9DdjShr/zFAycN0G7KC6vBg+CvAAD14VuOSP11kSZPyEvCl
         2aG5J8s6lQaOAWgFAyA5XUWT9jyjTqLil/Ai9lzFrkqDoNZtCrI5KF9x8GwTpLjNngrp
         VeugE/kI+5y6QbD7aJYFpaVtrmSIZN3re25SG2WvMR1euq0rQVpd/C5rEj3KXZuztVzs
         a8QxqDlCZQ5DwMtGFxKrUFwlqqRNj21eZMxzdaoNI7oRuVQVW145P6UnZ4GWp0H3Rzj+
         tlvQ==
X-Forwarded-Encrypted: i=1; AHgh+RpqAqne0Qc6DtBVUQVccQvLEqlxP8gPAdC5bIbXFrQOwo7Zeaunx7RPMlu5iR714yKgosO6RtCIVeM6RbWIWQ==@lists.linux.dev
X-Gm-Message-State: AFuF++nPxsme1HsNFgnAAibSnK+m+UnWhU3B4YcsYPiHY36f60gYSK+e
	VUkXvwIQp0viBXnpPYg3eYB0Ta2rhr+nrDX5niSoOFGUuuZZySBr/L/o
X-Gm-Gg: AR+sD12uQkZ9toOpO8Fxa8UwYuPpJ+Otzwb8n+TyCo+I4t60Iu4TBr8Q5sjUPBdQ+GD
	bQaxzGDNC9NKdtWF8CZbNjxOQg00WDtspfjLyNzQp9kAnM3fZNcMmelukgNvP4tnCByFAeNrxUa
	rffexKk9cMaaB6hbaCqreS3XKyG+zZ6UKupc+5KdjLVSU7m4pe8p1SV6Ni8lf/zVFLv+vI0vOrY
	a1+QoY+8/v3vTR+ZVQ8q5phIWFzsPX+a/9N1LMq9VuPUeoUVa8WrVXYTdyrJAjUrTNjzZHmqs/0
	xXXuTYS+YNeqvbcCNVDbcM0689oODYTOfp7wVXTszHnpYoOTkQMR/oy+y54fkXTVqIjzp4rJY1c
	nOwK1SZnzFcwYlEaWfV8ccR7LUFHji8W7nZrO8iCfCvmDOk1/XA3R1DqJixaDRdr1mSSCe5qyQn
	wVqXb6F3u5JIh03O7IXMxxLbcyqwfrj9ZG7+SiM8iSohxEFxMHHpz/wvIzcPqIJw==
X-Received: by 2002:a05:6a00:148f:b0:857:727c:a1f6 with SMTP id d2e1a72fcca58-857727ca403mr30481781b3a.24.1788232672232;
        Mon, 31 Aug 2026 20:17:52 -0700 (PDT)
Received: from gmail.com ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-85be93489f0sm332827b3a.40.2026.08.31.20.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 20:17:51 -0700 (PDT)
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
Subject: [PATCH v2] vhost/vsock: batch RX used-ring updates
Date: Tue,  1 Sep 2026 11:17:37 +0800
Message-Id: <20260901031737.201896-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Acked-by: Eugenio Pérez <eperezma@redhat.com>
---
Changes in v2:
- Pass used_count by value to the helper functions and update it in
  vhost_transport_do_send_pkt().
---
 drivers/vhost/vsock.c | 53 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 51 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 9aaab6bb8061..9e72c67c287f 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -103,12 +103,35 @@ static bool vhost_transport_has_remote_cid(struct vsock_sock *vsk, u32 cid)
 	return found;
 }
 
+static bool vhost_vsock_flush_used(struct vhost_virtqueue *vq,
+				   unsigned int used_count)
+{
+	if (!used_count)
+		return false;
+
+	vhost_add_used_n(vq, vq->heads, vq->nheads, used_count);
+	return true;
+}
+
+static void vhost_vsock_add_used(struct vhost_virtqueue *vq,
+				 unsigned int used_count,
+				 unsigned int head, unsigned int len)
+{
+	struct vring_used_elem *used = &vq->heads[used_count];
+
+	used->id = cpu_to_vhost32(vq, head);
+	used->len = cpu_to_vhost32(vq, len);
+	vq->nheads[used_count] = 1;
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
 
@@ -120,6 +143,12 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
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
 
@@ -134,9 +163,20 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
 		u32 offset;
 		int head;
 
+		if (used_count == used_limit) {
+			if (vhost_vsock_flush_used(vq, used_count)) {
+				added = true;
+				used_count = 0;
+			}
+		}
+
 		skb = virtio_vsock_skb_dequeue(&vsock->send_pkt_queue);
 
 		if (!skb) {
+			if (vhost_vsock_flush_used(vq, used_count)) {
+				added = true;
+				used_count = 0;
+			}
 			vhost_enable_notify(&vsock->dev, vq);
 			break;
 		}
@@ -153,6 +193,10 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
 			/* We cannot finish yet if more buffers snuck in while
 			 * re-enabling notify.
 			 */
+			if (vhost_vsock_flush_used(vq, used_count)) {
+				added = true;
+				used_count = 0;
+			}
 			if (unlikely(vhost_enable_notify(&vsock->dev, vq))) {
 				vhost_disable_notify(&vsock->dev, vq);
 				continue;
@@ -230,8 +274,9 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
 		 */
 		virtio_transport_deliver_tap_pkt(skb);
 
-		vhost_add_used(vq, head, sizeof(*hdr) + payload_len);
-		added = true;
+		vhost_vsock_add_used(vq, used_count, head,
+				     sizeof(*hdr) + payload_len);
+		used_count++;
 
 		VIRTIO_VSOCK_SKB_CB(skb)->offset += payload_len;
 		total_len += payload_len;
@@ -264,6 +309,10 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
 			virtio_transport_consume_skb_sent(skb, true);
 		}
 	} while(likely(!vhost_exceeds_weight(vq, ++pkts, total_len)));
+	if (vhost_vsock_flush_used(vq, used_count)) {
+		added = true;
+		used_count = 0;
+	}
 	if (added)
 		vhost_signal(&vsock->dev, vq);
 
-- 
2.34.1
