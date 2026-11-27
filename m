Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795760857;
	b=IpfbslAFaErjX/MQgt/fyhmf4iXFBOdMaM6654TBidzkQb2chwFuYzJ3uyN5GcwlrwCQ
	 5kf6Ad9EoLog10Kcg1C0QqspIGKPM1gjvUccU+A5R+TlkdxnMcaOBPDsJCpnLZTsNfANy
	 uPtT9fILDJgZ1JNk2MbULf6Kwh+2Ps+bkmn++eQUF2ObXvpRteRwv5odknJtIWUA21uIp
	 ze5kzSCUUoS6m+3MAUay2aGq+mLT/4GGTNb1UNbRwfKSn1luXKqinpQVLGaqKWa/HrDDK
	 IoapXmMhrNoSmTA6HI/1Cpgm/Y9pqn5A2GuTIzMj8vHaxLhjNwoI9C3hQW5Cg1U/PUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795760857;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=dMJvqq139olJaZVoTthnrd3VudVqIEoTi32eu7L85vk=;
	b=5Zg7jBjVStBrCeLTUYdsR079kqbGVFcR6ytVuc0UFkRm5lRgjYA1SxZrEw896Q7gQESs
	 yR5Ykq9i9DEDYsbp+d5wkwlH+hxOidvw10Lc9QeEUtpKgIw27xXJJk40DjYsXV2TpgdD3
	 grXlejRA8u3Ev5V67EyZ0iEnZEt1AD1x2gbknJvTYM2l3FtpCeuRrFO6Bdq9Pdfzyohq4
	 VOuunW/LM19KOlCSEjy/spYmhLJc8mo9hn0HtXPRQQpvYEgt2Ekr/cW0K9WQKMcIjek1Q
	 ZfOrEu13n7rot9EUCjB+qrBS/S9UrRDg4wz3k6AMSsekEay9tuiQ2dUjugZZsskx0/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TGRCzo1x;
	arc=none smtp.remote-ip=209.85.215.182
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C9C606A324
	for <virtualization@lists.linux.dev>; Fri, 27 Nov 2026 06:27:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74C9C606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TGRCzo1x
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cde5a7d7849so3374172a12.0
        for <virtualization@lists.linux.dev>; Thu, 26 Nov 2026 22:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795760855; x=1796365655; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dMJvqq139olJaZVoTthnrd3VudVqIEoTi32eu7L85vk=;
        b=TGRCzo1xWdLfLoxTUauohcvWWZwDyKbhuNBCCt2jYiJCe4YFKuJ3HmTrQ94p1l9Rpt
         EttezJu6Z9DLJ+Jq9ZI/3pXp8GMfzY3rezALNUw0MNubg+PyMrMZV16NJRMTRnEmZBa8
         4QnwcogdVJXVzQH6zMjDejAbBQe1B5FuboxZXIxvxECzVwhiEphpe/Wls0UJwRaA3rPp
         3vsipmvXG4iWcgaulN0r10PJPlTgAfarF6DOs5+xgTP3FekPGEC+TZ3nlYDWfD9AkUHn
         PnZWI+Hl6gazuFFZl47lliMoOLJHoBb3n42HQopJOGMQzfNVEl6wnQhzQLC3AuT2u5XK
         GglA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795760855; x=1796365655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dMJvqq139olJaZVoTthnrd3VudVqIEoTi32eu7L85vk=;
        b=ELsqEdYbXPyVlCFBAc0vwcsxtSLvVkv1I0qeMvvl+mUF8iHz9VTITmZhYTOd1D84FM
         ufgSd5L3QePLB4DFgBL+zjPlqqlJCjdvzqRPNHPEQKTwlOlFR/jHRoHqL+Xk9hwA9Leb
         f7Cr6o57ad1OKCbWqqX6KsoOfwdktrSbSu2ytBnP4ehST2kTRZVsrH32a1vYSiAncD5T
         ffvPumc/hOFq6OCA60eF+P3YgjGYg62L2UQSK0QPpAKzEnSz9sHK/i6fPfejodMsm0jy
         7etCnxmnQWvZXfntfboUqO+milfN4Ngy0ZyIdSfULvIeZYj0HzzF/us2iugmiLcxS8dQ
         O1KA==
X-Forwarded-Encrypted: i=1; AL+hErFmDXI4Um6Y+wJwRiNVFfPEEKka4GAmGD0mXs9YWg4sdphbOWX8ystE8JmYGl5j6/4w9TVl7BHsChkZ2p7Rew==@lists.linux.dev
X-Gm-Message-State: APuU4Z/6D3B/eoWD7j+GJ9gOdMlismjRpdKirolFRtv4TOn+hqP8phuT
	vUvBhLusXGlyveTpO0ArlTcb0kEQDIJZs4Yo4s+mjvNQwfUJgwE/XAwS
X-Gm-Gg: AZFdTZfeJdEURB5lCgDiPreycm/o1LfbbXcv1xkgOm3M12w+0jGf8Ui/qvmJ+zYpZ07
	deIehCGX4OnkMJm1DffJzkOqckkkPJnVYIuv/lGb387alaWMVd/34WiONjigXubHGJNH9tyl7nK
	6EBI+gJMJMciAocQSqmNvotRT8CVAwzy+jdToH9HyEqgboq4e//9Zk4Wf3AKul1DRCeakQAJ2VF
	vQcT+9hXhoXSJcdOWLSZwQ5sdtX9iDNzsaztoNX2CwFY8D5TL5/baf+mNLJqzkxbr9hlVEuqvBy
	xchUffIBSWZbagDNu830rAlJM3n5kq0lBE4uEjWgMJ/TmNmjTTPNhOoPizbtrwbNcp5aXjPxQ9V
	q9VOdqjDHCjQe55rYzcZESogDZPvGc7FpTcXowJb8Yby59i1Nv/StHqemt31KN17lFkdh0oUBkn
	sILa/M6uYPiP1Tj6QHcOoC3Tm2bLsT9eTKslSYIXEX2g06Jj4QjCeai8n88h/79vpWmWPfLIFQU
	UvY5lXjI2d0QgaqiL1kJVBXNsNGMlL4f8EKvB0Hfgipk9NpCJi9m4+eWrOg9EW0u/5/8uJAreGD
	B2QFT6m+OgKEUarZD+EAJaVw6EjF
X-Received: by 2002:a17:90b:2cce:b0:3b0:9a1b:b709 with SMTP id 98e67ed59e1d1-3b41c95f64dmr23981506a91.54.1795760854355;
        Thu, 26 Nov 2026 22:27:34 -0800 (PST)
Received: from dbg-srv ([111.194.74.218])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b44b82e624sm15986522a91.4.2026.11.26.22.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 22:27:34 -0800 (PST)
From: Jia Jia <physicalmtea@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>,
	Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH net-next v6 2/2] vsock/virtio: amortize RX socket locking for stream packets
Date: Fri, 27 Nov 2026 06:27:00 +0000
Message-ID: <20261127062700.29387-3-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261127062700.29387-1-physicalmtea@gmail.com>
References: <20261127062700.29387-1-physicalmtea@gmail.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The virtio-vsock RX worker looks up a socket and takes its lock for every
packet. Retain the connected lookup reference and socket lock across a
bounded run of STREAM/RW packets for one established native socket.

Reuse the locked socket while packets match the same flow. Finish the
batch on a malformed packet, flow change, non-RW traffic, or a change to
the socket state, transport, protocol, sockmap state, or receive buffer
limits. A connected lookup miss falls back to the existing receive path,
which can still find a bound socket.

Limit an uninterrupted socket-lock ownership interval to 64 packets and
64 KiB of payload. The payload limit is one
VIRTIO_VSOCK_MAX_PKT_BUF_SIZE. Small or zero-length packets still incur
per-packet work, so an independent packet limit is needed. The 64-packet
limit uses VHOST_NET_BATCH as a reference; it is a policy choice rather
than a protocol limit.

Beyond these limits, a larger batch would only further amortize socket
lookup and lock/unlock operations, while virtqueue work, validation,
tracing, skb ownership, credit update, and queueing remain per-packet. I
therefore expect diminishing returns while the uninterrupted socket-lock
interval continues to grow, but I have not measured larger limits yet.

Only the guest virtio RX worker is changed. The benchmark exercises the
host-sender-to-guest-receiver direction, where this worker is on the
receive path. I have not measured the corresponding worker and socket-lock
overhead in vhost-vsock or vsock_loopback, and they use different worker
and locking models. Leave those paths unchanged pending separate policy
and validation. I plan to evaluate vhost-vsock separately as follow-up
work.

Performance:

These results cover both patches in this series.

Tested on a single-stream vsock connection (one Guest receiver thread on
CPU0, virtio-vsock IRQ on Guest CPU1, fresh QEMU Guest per state, with 16
accepted, balanced AB/BA pairs per payload). The host uses vhost-vsock.

For throughput, vsock_perf runs on the host as the
sender, with a custom single-threaded Guest receiver pinned to Guest CPU0
using blocking recv(). The table uses a 64K buffer. The virtio-vsock
IRQ/RX worker is pinned to Guest CPU1. To normalize run times across
payloads into a bounded, deterministic window and avoid long runs being
skewed by host background noise or virtualization scheduling jitter,
transfer sizes scale proportionally with the request size (64B/64M,
256B/256M, etc.), capped at 2G for 4K-64K. The custom receiver keeps the
recv() size and count explicit; vsock_perf's receiver uses poll()+read().

End-to-end RX throughput
(64K Guest recv() size, SO_RCVLOWAT=1; Gbit/s):

  payload  baseline RX  series RX  throughput change (95% CI)
           (Gbit/s)     (Gbit/s)
  64B          0.1212      0.2555  +110.81% [+106.99%, +114.70%]
  256B         0.5551      1.0212  +83.95% [+79.94%, +88.06%]
  512B         1.0568      1.8761  +77.53% [+73.02%, +82.15%]
  1K           1.9260      3.1453  +63.31% [+58.58%, +68.17%]
  4K           3.5175      6.3239  +79.78% [+72.79%, +87.06%]
  8K           4.1183      5.6867  +38.08% [+31.06%, +45.48%]
  16K          5.0155      6.8346  +36.27% [+31.12%, +41.62%]
  64K          5.0541      5.8403  +15.56% [+11.12%, +20.17%]

Fixed-syscall stress test
(receiver recv() size = sender write size; Gbit/s):

  payload  baseline RX  series RX  throughput change (95% CI)
           (Gbit/s)     (Gbit/s)
  64B          0.1435      0.2750  +91.60% [+82.19%, +101.50%]
       recv() calls (baseline/series): 1048577/1048577
  256B         0.4218      0.9659  +129.00% [+110.65%, +148.95%]
       recv() calls (baseline/series): 1048577/1048577
  512B         0.8062      1.6979  +110.60% [+94.49%, +128.04%]
       recv() calls (baseline/series): 1048577/1048577
  1K           1.5116      2.9585  +95.72% [+85.22%, +106.82%]
       recv() calls (baseline/series): 1048577/1048577
  4K           2.9234      6.3365  +116.75% [+110.78%, +122.89%]
       recv() calls (baseline/series): 538537/525565
  8K           4.0430      7.1193  +76.09% [+69.04%, +83.44%]
       recv() calls (baseline/series): 276901/264412
  16K          4.9182      7.7688  +57.96% [+54.40%, +61.60%]
       recv() calls (baseline/series): 147674/132088
  64K          5.6683      7.1636  +26.38% [+20.49%, +32.56%]
       recv() calls (baseline/series): 50615/33343

Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
 include/linux/virtio_vsock.h                  |  23 ++
 .../events/vsock_virtio_transport_common.h    |  40 +--
 net/vmw_vsock/virtio_transport.c              |   7 +-
 net/vmw_vsock/virtio_transport_common.c       | 268 +++++++++++++++++-
 4 files changed, 297 insertions(+), 41 deletions(-)

diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index f91704731057e..748633aa0cc81 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -282,6 +282,29 @@ void virtio_transport_destruct(struct vsock_sock *vsk);
 
 void virtio_transport_recv_pkt(struct virtio_transport *t,
 			       struct sk_buff *skb, struct net *net);
+
+/*
+ * Initialize a batch to zero before use. A non-empty batch owns @sk's socket
+ * lock and the reference returned by vsock_find_connected_socket_net(). The
+ * caller retains both until it calls virtio_transport_rx_batch_finish(). An
+ * empty batch owns neither.
+ */
+struct virtio_transport_rx_batch {
+	struct sock *sk;
+	unsigned int pkts;
+	size_t bytes;
+};
+
+static inline bool
+virtio_transport_rx_batch_empty(const struct virtio_transport_rx_batch *batch)
+{
+	return !batch->sk;
+}
+
+void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
+				     struct sk_buff *skb, struct net *net,
+				     struct virtio_transport_rx_batch *batch);
+void virtio_transport_rx_batch_finish(struct virtio_transport_rx_batch *batch);
 void virtio_transport_inc_tx_pkt(struct virtio_vsock_sock *vvs, struct sk_buff *skb);
 u32 virtio_transport_get_credit(struct virtio_vsock_sock *vvs, u32 wanted);
 void virtio_transport_put_credit(struct virtio_vsock_sock *vvs, u32 credit);
diff --git a/include/trace/events/vsock_virtio_transport_common.h b/include/trace/events/vsock_virtio_transport_common.h
index f1ebe36787c3d..53a4c9ec47dae 100644
--- a/include/trace/events/vsock_virtio_transport_common.h
+++ b/include/trace/events/vsock_virtio_transport_common.h
@@ -88,24 +88,12 @@ TRACE_EVENT(virtio_transport_alloc_pkt,
 
 TRACE_EVENT(virtio_transport_recv_pkt,
 	TP_PROTO(
-		 __u32 src_cid, __u32 src_port,
-		 __u32 dst_cid, __u32 dst_port,
-		 __u32 len,
-		 __u16 type,
-		 __u16 op,
-		 __u32 flags,
-		 __u32 buf_alloc,
-		 __u32 fwd_cnt
+		 const struct virtio_vsock_hdr *hdr,
+		 const struct sockaddr_vm *src,
+		 const struct sockaddr_vm *dst
 	),
 	TP_ARGS(
-		src_cid, src_port,
-		dst_cid, dst_port,
-		len,
-		type,
-		op,
-		flags,
-		buf_alloc,
-		fwd_cnt
+		hdr, src, dst
 	),
 	TP_STRUCT__entry(
 		__field(__u32, src_cid)
@@ -120,16 +108,16 @@ TRACE_EVENT(virtio_transport_recv_pkt,
 		__field(__u32, fwd_cnt)
 	),
 	TP_fast_assign(
-		__entry->src_cid = src_cid;
-		__entry->src_port = src_port;
-		__entry->dst_cid = dst_cid;
-		__entry->dst_port = dst_port;
-		__entry->len = len;
-		__entry->type = type;
-		__entry->op = op;
-		__entry->flags = flags;
-		__entry->buf_alloc = buf_alloc;
-		__entry->fwd_cnt = fwd_cnt;
+		__entry->src_cid = src->svm_cid;
+		__entry->src_port = src->svm_port;
+		__entry->dst_cid = dst->svm_cid;
+		__entry->dst_port = dst->svm_port;
+		__entry->len = le32_to_cpu(hdr->len);
+		__entry->type = le16_to_cpu(hdr->type);
+		__entry->op = le16_to_cpu(hdr->op);
+		__entry->flags = le32_to_cpu(hdr->flags);
+		__entry->buf_alloc = le32_to_cpu(hdr->buf_alloc);
+		__entry->fwd_cnt = le32_to_cpu(hdr->fwd_cnt);
 	),
 	TP_printk("%u:%u -> %u:%u len=%u type=%s op=%s flags=%#x "
 		  "buf_alloc=%u fwd_cnt=%u",
diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index 4f9aa9c4c3aa5..9af85712bd387 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -633,6 +633,7 @@ static void virtio_transport_rx_work(struct work_struct *work)
 {
 	struct virtio_vsock *vsock =
 		container_of(work, struct virtio_vsock, rx_work);
+	struct virtio_transport_rx_batch batch = {};
 	struct virtqueue *vq;
 
 	mutex_lock(&vsock->rx_lock);
@@ -666,6 +667,7 @@ static void virtio_transport_rx_work(struct work_struct *work)
 			/* Drop short/long packets */
 			if (unlikely(len < sizeof(*hdr) ||
 				     len > virtio_vsock_skb_len(skb))) {
+				virtio_transport_rx_batch_finish(&batch);
 				kfree_skb(skb);
 				continue;
 			}
@@ -673,6 +675,7 @@ static void virtio_transport_rx_work(struct work_struct *work)
 			hdr = virtio_vsock_hdr(skb);
 			payload_len = le32_to_cpu(hdr->len);
 			if (unlikely(payload_len > len - sizeof(*hdr))) {
+				virtio_transport_rx_batch_finish(&batch);
 				kfree_skb(skb);
 				continue;
 			}
@@ -685,11 +688,13 @@ static void virtio_transport_rx_work(struct work_struct *work)
 			/* Force virtio-transport into global mode since it
 			 * does not yet support local-mode namespacing.
 			 */
-			virtio_transport_recv_pkt(&virtio_transport, skb, NULL);
+			virtio_transport_recv_pkt_batch(&virtio_transport, skb,
+							NULL, &batch);
 		}
 	} while (!virtqueue_enable_cb(vq));
 
 out:
+	virtio_transport_rx_batch_finish(&batch);
 	if (vsock->rx_buf_nr < vsock->rx_buf_max_nr / 2)
 		virtio_vsock_rx_fill(vsock);
 out_nofill:
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index bebf63115b263..34d6864917bc9 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -33,6 +33,15 @@
 #define MAX_COLLAPSE_LEN \
 	SKB_MAX_ORDER(VIRTIO_VSOCK_SKB_HEADROOM, PAGE_ALLOC_COSTLY_ORDER)
 
+/*
+ * Bound the interval that an RX worker owns a socket lock. One maximum packet
+ * buffer (64 KiB) bounds payload in one uninterrupted ownership interval.
+ * Small and zero-length packets need a packet limit to bound per-packet work;
+ * the 64-packet policy uses VHOST_NET_BATCH as a reference.
+ */
+#define VIRTIO_TRANSPORT_RX_BATCH_MAX_PKTS	64
+#define VIRTIO_TRANSPORT_RX_BATCH_MAX_BYTES	VIRTIO_VSOCK_MAX_PKT_BUF_SIZE
+
 static void virtio_transport_cancel_close_work(struct vsock_sock *vsk,
 					       bool cancel_timeout);
 static s64 virtio_transport_has_space(struct virtio_vsock_sock *vvs);
@@ -1787,10 +1796,70 @@ virtio_transport_find_socket(struct sockaddr_vm *src,
 	return sk;
 }
 
+static bool
+virtio_transport_recv_pkt_set_owner(struct sk_buff *skb, struct sock *sk)
+{
+	if (skb_set_owner_sk_safe(skb, sk))
+		return true;
+
+	WARN_ONCE(1, "receiving vsock socket has sk_refcnt == 0\n");
+	return false;
+}
+
+static bool
+virtio_transport_sock_has_psock(const struct sock *sk)
+{
+	return (uintptr_t)rcu_access_pointer(__sk_user_data(sk)) &
+	       SK_USER_DATA_PSOCK;
+}
+
+/* The caller holds sk's socket lock. */
+static bool
+virtio_transport_rx_batch_can_continue(struct virtio_transport *t,
+				       struct sock *sk, u32 len)
+{
+	struct virtio_vsock_sock *vvs;
+	struct vsock_sock *vsk;
+
+	vsk = vsock_sk(sk);
+	vvs = vsk->trans;
+
+	/*
+	 * Keep a connected lookup reference only for the native, established
+	 * STREAM path. Sockets outside ESTABLISHED can change table membership;
+	 * a completed or reassigned socket must resume the per-packet path.
+	 */
+	if (sk->sk_state != TCP_ESTABLISHED ||
+	    sk->sk_type != SOCK_STREAM ||
+	    sock_flag(sk, SOCK_DONE) ||
+	    vsk->transport != &t->transport || !vvs)
+		return false;
+
+	return (u64)vvs->buf_used + len <= vvs->buf_alloc;
+}
+
+/* The caller holds sk's socket lock. */
+static bool
+virtio_transport_rx_batch_can_receive(struct virtio_transport *t,
+				      struct sock *sk, u32 len)
+{
+	if (!virtio_transport_rx_batch_can_continue(t, sk, len))
+		return false;
+
+	/*
+	 * Sockmap can replace sk_prot and publish a psock without the socket lock.
+	 * Check both at each packet boundary; a boundary that sees a replacement
+	 * returns to the existing per-packet path.
+	 */
+	return READ_ONCE(sk->sk_prot) == sk->sk_prot_creator &&
+	       !virtio_transport_sock_has_psock(sk);
+}
+
 /*
- * The caller holds sk's socket lock.
+ * The caller holds sk's socket lock. Return false if socket/source validation
+ * rejects the packet.
  */
-static void
+static bool
 virtio_transport_recv_pkt_locked(struct virtio_transport *t,
 				 struct sk_buff *skb, struct sock *sk,
 				 struct net *net)
@@ -1813,7 +1882,7 @@ virtio_transport_recv_pkt_locked(struct virtio_transport *t,
 	     !vsock_check_source(vsk, &t->transport, &src))) {
 		(void)virtio_transport_reset_no_sock(t, skb, net);
 		kfree_skb(skb);
-		return;
+		return false;
 	}
 
 	space_available = virtio_transport_space_update(sk, skb);
@@ -1846,6 +1915,8 @@ virtio_transport_recv_pkt_locked(struct virtio_transport *t,
 		kfree_skb(skb);
 		break;
 	}
+
+	return true;
 }
 
 /* We are under the virtio-vsock's vsock->rx_lock or vhost-vsock's vq->mutex
@@ -1863,14 +1934,7 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 	vsock_addr_init(&dst, le64_to_cpu(hdr->dst_cid),
 			le32_to_cpu(hdr->dst_port));
 
-	trace_virtio_transport_recv_pkt(src.svm_cid, src.svm_port,
-					dst.svm_cid, dst.svm_port,
-					le32_to_cpu(hdr->len),
-					le16_to_cpu(hdr->type),
-					le16_to_cpu(hdr->op),
-					le32_to_cpu(hdr->flags),
-					le32_to_cpu(hdr->buf_alloc),
-					le32_to_cpu(hdr->fwd_cnt));
+	trace_virtio_transport_recv_pkt(hdr, &src, &dst);
 
 	if (!virtio_transport_valid_type(le16_to_cpu(hdr->type))) {
 		(void)virtio_transport_reset_no_sock(t, skb, net);
@@ -1892,10 +1956,8 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 		goto free_pkt;
 	}
 
-	if (!skb_set_owner_sk_safe(skb, sk)) {
-		WARN_ONCE(1, "receiving vsock socket has sk_refcnt == 0\n");
+	if (!virtio_transport_recv_pkt_set_owner(skb, sk))
 		goto free_pkt;
-	}
 
 	lock_sock(sk);
 	virtio_transport_recv_pkt_locked(t, skb, sk, net);
@@ -1912,6 +1974,184 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 }
 EXPORT_SYMBOL_GPL(virtio_transport_recv_pkt);
 
+/*
+ * Release an active RX batch. A non-empty batch holds the socket lock and the
+ * reference returned by vsock_find_connected_socket_net(). An empty batch
+ * holds neither.
+ */
+void virtio_transport_rx_batch_finish(struct virtio_transport_rx_batch *batch)
+{
+	struct sock *sk = batch->sk;
+
+	batch->sk = NULL;
+	batch->pkts = 0;
+	batch->bytes = 0;
+
+	if (!sk)
+		return;
+
+	release_sock(sk);
+	sock_put(sk);
+}
+EXPORT_SYMBOL_GPL(virtio_transport_rx_batch_finish);
+
+static bool
+virtio_transport_rx_batch_matches(const struct virtio_transport_rx_batch *batch,
+				  const struct sockaddr_vm *src,
+				  const struct sockaddr_vm *dst,
+				  struct net *net)
+{
+	struct vsock_sock *vsk = vsock_sk(batch->sk);
+
+	/* The connected table is keyed by peer address and local port. */
+	return vsock_addr_equals_addr(src, &vsk->remote_addr) &&
+	       dst->svm_port == vsk->local_addr.svm_port &&
+	       vsock_net_check_mode(sock_net(batch->sk), net);
+}
+
+static bool
+virtio_transport_rx_batch_can_add(const struct virtio_transport_rx_batch *batch,
+				  u32 len)
+{
+	if (batch->pkts >= VIRTIO_TRANSPORT_RX_BATCH_MAX_PKTS ||
+	    batch->bytes >= VIRTIO_TRANSPORT_RX_BATCH_MAX_BYTES)
+		return false;
+
+	return len <= VIRTIO_TRANSPORT_RX_BATCH_MAX_BYTES - batch->bytes;
+}
+
+static void
+virtio_transport_rx_batch_account(struct virtio_transport_rx_batch *batch,
+				  u32 len)
+{
+	batch->pkts++;
+	batch->bytes += len;
+}
+
+static void
+virtio_transport_rx_batch_process(struct virtio_transport *t,
+				  struct sk_buff *skb, struct net *net,
+				  struct virtio_transport_rx_batch *batch,
+				  const struct sockaddr_vm *src,
+				  const struct sockaddr_vm *dst)
+{
+	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
+	u32 len;
+
+	len = le32_to_cpu(hdr->len);
+	trace_virtio_transport_recv_pkt(hdr, src, dst);
+
+	if (!virtio_transport_recv_pkt_set_owner(skb, batch->sk)) {
+		virtio_transport_rx_batch_finish(batch);
+		kfree_skb(skb);
+		return;
+	}
+
+	if (!virtio_transport_recv_pkt_locked(t, skb, batch->sk, net) ||
+	    !virtio_transport_rx_batch_can_continue(t, batch->sk, 0)) {
+		virtio_transport_rx_batch_finish(batch);
+		return;
+	}
+
+	virtio_transport_rx_batch_account(batch, len);
+	if (!virtio_transport_rx_batch_can_add(batch, 0))
+		virtio_transport_rx_batch_finish(batch);
+}
+
+void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
+				     struct sk_buff *skb, struct net *net,
+				     struct virtio_transport_rx_batch *batch)
+{
+	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
+	struct sockaddr_vm src, dst;
+	struct sock *sk;
+	u32 len;
+
+	/*
+	 * Batch only STREAM data packets. Control packets can change connection
+	 * state or send a reply. Keep SEQPACKET on its existing path: its EOM/EOR
+	 * record-boundary semantics have not been separately evaluated for batching.
+	 */
+	if (le16_to_cpu(hdr->type) != VIRTIO_VSOCK_TYPE_STREAM ||
+	    le16_to_cpu(hdr->op) != VIRTIO_VSOCK_OP_RW) {
+		virtio_transport_rx_batch_finish(batch);
+		goto recv_pkt;
+	}
+
+	len = le32_to_cpu(hdr->len);
+	vsock_addr_init(&src, le64_to_cpu(hdr->src_cid),
+			le32_to_cpu(hdr->src_port));
+	vsock_addr_init(&dst, le64_to_cpu(hdr->dst_cid),
+			le32_to_cpu(hdr->dst_port));
+
+	if (!virtio_transport_rx_batch_empty(batch)) {
+		/* A post-processing check cannot bound a packet already admitted. */
+		if (!virtio_transport_rx_batch_can_add(batch, len) ||
+		    !virtio_transport_rx_batch_matches(batch, &src, &dst, net)) {
+			virtio_transport_rx_batch_finish(batch);
+		} else if (!virtio_transport_rx_batch_can_receive(t, batch->sk,
+							   len)) {
+			virtio_transport_rx_batch_finish(batch);
+			goto recv_pkt;
+		}
+	}
+
+	if (!virtio_transport_rx_batch_empty(batch)) {
+		virtio_transport_rx_batch_process(t, skb, net, batch, &src, &dst);
+		return;
+	}
+
+	/*
+	 * A packet larger than the byte cap must take the regular path. Starting a
+	 * one-packet batch would already exceed the bound on socket-lock ownership.
+	 */
+	if (!virtio_transport_rx_batch_can_add(batch, len))
+		goto recv_pkt;
+
+	sk = vsock_find_connected_socket_net(&src, &dst, net);
+	if (!sk) {
+		/*
+		 * A connected lookup miss can still match a bound socket in
+		 * virtio_transport_recv_pkt().
+		 */
+		goto recv_pkt;
+	}
+
+	if (virtio_transport_get_type(sk) != le16_to_cpu(hdr->type)) {
+		/* Let the regular receive path send the type-mismatch reset. */
+		sock_put(sk);
+		goto recv_pkt;
+	}
+
+	lock_sock(sk);
+	if (!virtio_transport_rx_batch_can_receive(t, sk, len)) {
+		/* State or receive-buffer failures keep the regular lookup path. */
+		if (!virtio_transport_rx_batch_can_continue(t, sk, len)) {
+			release_sock(sk);
+			sock_put(sk);
+			goto recv_pkt;
+		}
+
+		trace_virtio_transport_recv_pkt(hdr, &src, &dst);
+		if (virtio_transport_recv_pkt_set_owner(skb, sk))
+			virtio_transport_recv_pkt_locked(t, skb, sk, net);
+		else
+			kfree_skb(skb);
+
+		release_sock(sk);
+		sock_put(sk);
+		return;
+	}
+
+	batch->sk = sk;
+	virtio_transport_rx_batch_process(t, skb, net, batch, &src, &dst);
+	return;
+
+recv_pkt:
+	virtio_transport_recv_pkt(t, skb, net);
+}
+EXPORT_SYMBOL_GPL(virtio_transport_recv_pkt_batch);
+
 /* Remove skbs found in a queue that have a vsk that matches.
  *
  * Each skb is freed.
-- 
2.53.0

