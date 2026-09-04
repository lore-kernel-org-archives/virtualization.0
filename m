Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7638B369D7D
	for <virtualization@lists.linux.dev>; Fri,  4 Sep 2026 01:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788485168; cv=none; b=WwR6GYCDz8CD3z+byCHoYS4Jbcf7EOmpxMXD8L4+giDqrWJ1OxIZPGcmYGijrjx1JwN4IVn+eTWv65v8Tbp4RxZ2S6kztKr1Xihn2GKQ6QLgrueOTlJODfKq3rmktZ1AJ1hSr+3uyccGZR/9Kf4k3XYbLLs4xx0oG8S9WS5gbD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788485168; c=relaxed/simple;
	bh=fyxUxFpPOKbdsMZB2InFEsgL6IMYq89RBtd0J/wf9jA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=YWjwMJ99J+d1cwbJcdVAEL1x5sgjGtZ/cJtViaRrlG+vCUnoR9KN6pqdo0hgZWjCe1N9gOKEOiHXGlTQ0e50wQFE2AWcxq1H+APCD2l6XhukDn2KG+4KJYQ2urQwvcprYDb2hcphqUKt2ivRC/ogE9VCHHu+uoB3/WOfn7L8c8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R3pMyyjS; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R3pMyyjS"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-855d2bfae95so1968340b3a.1
        for <virtualization@lists.linux.dev>; Thu, 03 Sep 2026 18:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788485166; x=1789089966; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lGIGBADpvEEmG1ODLz64s9T6Bd70WxUxThc6mlkI/xc=;
        b=R3pMyyjSKE6Gk9NUJUfp+3ya68XYrZKtJJBmAo7ZBpq+XIlaDRyL5OA+PDToD9RXnY
         v599yK+yduBqkHwgG17hLqweev1vES3fPf+5owHCyRHYtm2O72hzMDBcMWLUX4I1siik
         mY7r8yLzM5Z/zQVBJs4c84yZBl9CCnIYvfNJCh5jfcDKFK4jcm36jER2tv2u1R6ivBYc
         dAHHIXN46AdHbwyVpZdxAwjgHbjia85FZiil4jCATt45jnXhUz/w7mFiHygPWSRH4FAK
         p72BOAAsITxX3Xk6+ZE0cSj2JlscjRO14BNYaWPdEmRmWZO3Lwi3yHoSlS7Ra2wjyeYi
         DEPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788485166; x=1789089966;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lGIGBADpvEEmG1ODLz64s9T6Bd70WxUxThc6mlkI/xc=;
        b=Kjt3GJkjx7u2fnlub0U06Z1Icbcl3wwz3K25PWQFrWq1RPua27fJm7L/WYy8OfFCFU
         PRUMeUtzEHLQkk/di5QB+AK16PcKPXk9eDRCoStXAO0wJZx3EGtE4s1fjnmQJAuPV1hg
         EPRmrMkchJI4kuhXN3k40F/X7Y13/sWCkv5GwcZ0r/kL4x4WlhD2KZeHkR/7Syykn5HC
         00UvWWeHfiWlY6U81XX1WtQE40U9z+0fR6XH5kZz9PNIJT63poTL3p83u6YueZgB39me
         hju1mATG3kqXBTUWmBgDsNjLVufzoquFyZuye3UYPEBKFtIniBNDfOc7Yk7CmkSYuQI6
         ytrA==
X-Forwarded-Encrypted: i=1; AKwUvBy2hrn1xQ88c5tashp9FoDtp9/XmId720Fkdos475yYAaN9Wkgjdg+bPmeAZ3zSO9UpptU1uTM4qRs1eUi1pQ==@lists.linux.dev
X-Gm-Message-State: AFuF++l9YMKOBIqcyWw3S6yJcY9RU4awwLj2qUBRwhNTKW2HzMvLzCUe
	AKlru/PbMhhx0pFF0zLG2rcAEEXSDV/S5oR5D5BmXq8paM+x9/H9Qjit
X-Gm-Gg: AYBFou3ccR4wWEkPfhS9J85gjb03Vf3JOCS8qCDNUtCoMmqC/NOUGtvoMTH4NxUq0bW
	Vj3KcHuk9xx38HXJRO1nVHF2/VHxZnSOSAQzhKrJe9hgREuIfMDrfc9Yv4oVcz0opbAtZ7G/Bj/
	b730zM8cPw6FiiqhsyRCi5fewJg3G63J51Z1JrJMwDhxZPXCckzm/r8+gM3oLCmyc3s8iJeI0+Q
	8HyGyRhIXoZcb23Q1XgiBaUBo8RXoLK5/upx6XfuRN5ugJaiYBy3DcdVJjVR7FnidXbrl3IpJoX
	m5pU0m13LGpNzREaIO1JaUYuNzXbHkWZy4pvv8b1b6tCNe3bvU5JEqakvEXmwnKsTlPFvQVOkCx
	SAkGFuyNR63p6mL9//I7TkZNdvwWz+sOPlWw3rvbw1CJ2dxEgw2TQWK9ndEtjHrUisIjY9YpS9B
	Jo8zZhbcJ8j+RNZODSvHm2SOZcy3CoUrA5WQZWGV+/aNigK+l/4EeHS9TPvOkd
X-Received: by 2002:a17:90b:2244:b0:380:86d8:8162 with SMTP id 98e67ed59e1d1-39b0865353bmr10028411a91.18.1788485165653;
        Thu, 03 Sep 2026 18:26:05 -0700 (PDT)
Received: from gmail.com ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339885ce1csm2299014eec.4.2026.09.03.18.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 18:26:05 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>
Cc: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] vhost/vsock: batch RX used-ring updates
Date: Fri,  4 Sep 2026 09:25:37 +0800
Message-Id: <20260904012537.503230-1-physicalmtea@gmail.com>
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

The Guest RX throughput results above are the primary performance
measurement. For additional Host-side context, I measured the vhost
worker thread servicing the vhost-vsock RX queue in a separate set of
10 paired runs, with five runs in each AB/BA order. Counters were
normalized by the verified transferred GiB and summarized using
geometric means. Worker cycles/GiB improved by 3.846%, 2.162%, and
4.109% for 256 B, 4 KiB, and 64 KiB, respectively. The corresponding
worker instructions/GiB improvements were 2.548%, 2.084%, and 4.637%.
The patched implementation used fewer cycles in 10/10, 8/10, and
10/10 paired runs, respectively, and fewer instructions in 10/10
paired runs for all three workloads. This measures the complete vhost
worker thread during the transfer, rather than an individual helper
function, and is supplementary to the Guest RX throughput results.

Link: https://lore.kernel.org/r/20181214082146-mutt-send-email-mst@kernel.org
Link: https://lore.kernel.org/r/20220901055434.824-4-qtxuning1999@sjtu.edu.cn
Signed-off-by: Jia Jia <physicalmtea@gmail.com>
Acked-by: Eugenio Pérez <eperezma@redhat.com>
---
Changes in v3:
- Add supplementary Host-side perf measurements for the complete
  vhost worker thread during the transfer.
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
