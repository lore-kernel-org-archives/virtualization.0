Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793869053;
	b=0C6d9JSpn7Ud3uU+7lIjY9lEFFcz8c3Wn+T7iJYf8P8VCg7DPomG1vsl0W784yw87+L3
	 gPsnvvn0Ocb7blxEO8k7sZTFbY5Mbob8hEVGt/YTyugI+UxP6KnjGIGH6Cx1tsFS2VzHf
	 GnqaZ+EgxgBDhUUSF/Fxs6HilOK5Ypwrmowqrhef6IcXQLUGpv30hN/rau8j3Yp0C9AdH
	 zjxUYoGMEt5RvYUNkG91S59HG0erJ5OMYqQ17dS1fBIec/maTdeDnJzj2Po+rxKYsD9wv
	 vE9Do+VkH7u2fV/1Th2f6t1+CwlaIbL62yLA0x4qYj4JnRQgsKGnrR7SaubYez/wDCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793869053;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=IBmbzTXF6cFSRl3S48ClKmFsXUP/ozRPwaaP8s1XxGI=;
	b=NAn7luFzt7EZmPA1autQ34+kaEGuO+4+AKx9qf/fVmrXkCxUqnY5ZgWJx5dPNh0JFEQg
	 aVtxrjjI8QDjrpUGpNhEHOLl63/PA4H3+aXGxaE2snGPnd2X/AbAyRfGipb4IJuMvxvoK
	 4rhAzB9W/Rxo0d8NWm+0+nRpMzyU82V3TNBmPQl2VjaObEY1b85L+lzkQecruyMQqa0iv
	 m1/6q8hTGdeaZKUAPMq44N2OCezqZA99YhZbnZe2IwbL2/9JXRyqbOwEBL4NuCTRBRI+6
	 ticlFPWM3Bv92AqKT5oQsM1BlIu9r1IUDrWt7DP+zY1+xHRGtfbZklXD23nC2gKWajg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IBGVEqo2;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E78606A335
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 08:57:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45E78606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IBGVEqo2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793869051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IBmbzTXF6cFSRl3S48ClKmFsXUP/ozRPwaaP8s1XxGI=;
	b=IBGVEqo2oYzGLFJWX2CCfYYNIvCosv+9+GGpwBscJ/5fkx3PDxNLycNEdnVcubDKQScjbp
	8QRWimaLVJ5xz7/zhb5gPZwMo4yAAUqFkKYJqnu3AMEqRsxfDgz7voG1mZbWKkfpcslIsj
	0jcYAVf3fJhQRNJD3YEFszw+9Jzhgvg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-zZ3EmpaoN0qgAeCiKtTOXQ-1; Thu, 05 Nov 2026 03:57:30 -0500
X-MC-Unique: zZ3EmpaoN0qgAeCiKtTOXQ-1
X-Mimecast-MFC-AGG-ID: zZ3EmpaoN0qgAeCiKtTOXQ_1793869049
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48e17d30a79so1024926f8f.3
        for <virtualization@lists.linux.dev>; Thu, 05 Nov 2026 00:57:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793869049; x=1794473849;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IBmbzTXF6cFSRl3S48ClKmFsXUP/ozRPwaaP8s1XxGI=;
        b=JG/wjPYHR2xjleaXxEnRdGrwJj4nwn/h40W8sXYNz2khHTJ5M/rMOTJanw00jmqxm3
         Zu7vKV0oWC8nFiqGBxRoUITLUsZkOBCDiPk0YvOurypW10KURpAfu434DTJbCU92qRcU
         bkjVV1w5yNEj3HIy1eNQnwNSaxSzFRrsixfwk3djD4I0cmOLQORGysnliWIh5UxGCTf6
         zd9FYFr1JrJZIUPZMgqsC+2LvZIASPqKbi8LyPmxLGYtB7NUToU22oCXU7ADIgr4+Hi/
         cUVgturLdyt4w1+Pf67tDj8wjAomO758sNi34A/iFfMh4xmVNn7jHyYiQjsnCJSLpw9Z
         SUaw==
X-Forwarded-Encrypted: i=1; AKwUvBz3lDcQwCzD9C56w12Io3ezg7wd6wLQMy/5Au9JS+ReSxEuaIeHjfaeHf/rMcCF4OJq6WxD/eovqbjKgqWCQw==@lists.linux.dev
X-Gm-Message-State: APuU4Z9qlq/UT+omdXVY3VVHF4olAmZNbABLdO+rFbEkZAv1LU1jAKBA
	SzIBSGlOyHtw5yHA7IvmFIjeRtReNonHuHmsyPRFocS4s2lPWfZIxp+yftagsBJYtq1pVmYEkAU
	yy8ts6LL6iYX1Qglizoh7HpX6qF4/9RuSKdnSN3Kg+Fxog/y7ciTL1NC5IGz9Rsqf8+6x
X-Gm-Gg: AYBFou3oK7+JTJu4vDW1F6jWo3auI6S8gKIhBvVcd3YUnSemf6slUagq7lxjj/qnzjL
	gHi4HZx2NomGlcfgdhvPYxAaTFaitNxpx2QhCN6ePs8tcSGqlJH1C/ZOO5+GwUdmNYhinD4lk0T
	Pgjf5wuCVbdunpts/xPAxgG1UkPvTC8zm6LH2Xisatolm+7IV4xC+pBN2ZxplTK+qfF+4NMVrh0
	Q/WRK8uVG1w4YiK10aDZEs4ua86Dr47u7h5OHb+JzX+rTzZODw4CLiatnX7jqLH3z+xd4/fo/jN
	H2VGcnWkdYRNOoxWttzAZPci+H7NsUbooLK+jLlDFL0MzgF3PXrAr0W+dhQT1Vg4J0b3nBVMxbW
	r3HVoMEOt3fQS78zaUV0ZZYjNUlajm0T7I3he2K3+JhDmoqDSe7BW
X-Received: by 2002:a05:6000:240a:b0:490:ef5a:bf39 with SMTP id ffacd0b85a97d-490ef5abfc9mr4406354f8f.6.1793869048575;
        Thu, 05 Nov 2026 00:57:28 -0800 (PST)
X-Received: by 2002:a05:6000:240a:b0:490:ef5a:bf39 with SMTP id ffacd0b85a97d-490ef5abfc9mr4406314f8f.6.1793869048098;
        Thu, 05 Nov 2026 00:57:28 -0800 (PST)
Received: from sgarzare-redhat ([80.116.143.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fea180e7csm8809554f8f.5.2026.11.05.00.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 00:57:26 -0800 (PST)
Date: Thu, 5 Nov 2026 09:57:18 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jia Jia <physicalmtea@gmail.com>
Cc: netdev@vger.kernel.org, stefanha@redhat.com, bobbyeshleman@gmail.com, 
	mst@redhat.com, jasowangio@gmail.com, eperezma@redhat.com, 
	xuanzhuo@linux.alibaba.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 3/5] vsock/virtio: amortize RX socket locking
 for stream packets
Message-ID: <auxDWISLHB8Ln1x7@sgarzare-redhat>
References: <20261103041134.33310-1-physicalmtea@gmail.com>
 <20261103041134.33310-4-physicalmtea@gmail.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261103041134.33310-4-physicalmtea@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: oKwyAGUJRNEZKbkPE5m2pUws8rhpEr6xavNvU-xVX54_1793869049
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Nov 03, 2026 at 12:11:32PM +0800, Jia Jia wrote:
>The virtio-vsock RX worker looks up a socket and takes its lock for every
>packet. Retain the connected lookup reference and socket lock across a
>bounded run of STREAM/RW packets for one established native socket.
>
>Reuse the locked socket while packets match the same flow. Finish the
>batch on a malformed packet, flow change, non-RW traffic, or a change to
>the socket state, transport, protocol, sockmap state, or receive buffer
>limits. A connected lookup miss falls back to the existing receive path,
>which can still find a bound socket.
>
>Limit an uninterrupted socket-lock ownership interval to 64 packets and
>64 KiB of payload. The payload limit is one
>VIRTIO_VSOCK_MAX_PKT_BUF_SIZE. Small or zero-length packets still incur
>per-packet work, so an independent packet limit is needed. The 64-packet
>limit uses VHOST_NET_BATCH as a reference; it is a policy choice rather
>than a protocol limit.
>
>Beyond these limits, a larger batch would only further amortize socket
>lookup and lock/unlock operations, while virtqueue work, validation,
>tracing, skb ownership, credit update, and queueing remain per-packet. I
>therefore expect diminishing returns while the uninterrupted socket-lock
>interval continues to grow, but I have not measured larger limits yet.
>
>Only the guest virtio RX worker is changed. The benchmark exercises the
>host-sender-to-guest-receiver direction, where this worker is on the
>receive path. I have not measured the corresponding worker and socket-lock
>overhead in vhost-vsock or vsock_loopback, and they use different worker
>and locking models. Leave those paths unchanged pending separate policy
>and validation. I plan to evaluate vhost-vsock separately as follow-up
>work.
>
>Performance:
>
>These results cover P1-P3, before the notification changes in P4 and P5.
>
>Tested on a single-stream vsock connection (one Guest receiver thread on
>CPU0, virtio-vsock IRQ on Guest CPU1, fresh QEMU Guest per state). The host
>uses vhost-vsock.
>
>For throughput, vsock_perf runs on the host as the
>sender, with a custom single-threaded Guest receiver pinned to Guest CPU0
>using blocking recv(). The fixed-64K table uses a 64K buffer; the matched
>table uses the sender's request size. The virtio-vsock IRQ/RX worker is
>pinned to Guest CPU1. To normalize run times across payloads into a
>bounded, deterministic window and avoid long runs being skewed by host
>background noise or virtualization scheduling jitter, transfer sizes scale
>proportionally with the request size (64B/64M, 256B/256M, etc.), capped at
>2G for 4K-64K. The custom receiver keeps the recv() size and count
>explicit; vsock_perf's receiver uses poll()+read().
>
>End-to-end RX throughput (fixed-64K receiver; Gbit/s):
>
>  payload  baseline RX  PATCH RX  throughput change (95% CI)
>           (Gbit/s)      (Gbit/s)
>  64B        0.1285       0.2462    +91.59% [+79.74%, +104.22%]
>  256B       0.5909       0.9666    +63.59% [+61.03%, +66.19%]
>  512B       1.1817       1.8350    +55.29% [+46.76%, +64.32%]
>  1K         2.3252       3.3600    +44.50% [+38.93%, +50.30%]
>  4K         3.8436       5.5661    +44.82% [+40.30%, +49.47%]
>  8K         4.6609       5.4115    +16.10% [ +8.91%, +23.77%]
>  16K        5.1196       5.6399    +10.16% [ +4.07%, +16.61%]
>  64K        5.6095       5.7062     +1.72% [-3.19%, +6.89%]
>
>Fixed-syscall stress test (receiver recv() size = sender write size;
>no perf; Gbit/s):
>
>  payload  baseline RX  PATCH RX  throughput change (95% CI)
>  64B        0.1446       0.2540   +75.71% [+63.67%, +88.62%]
>       recv() calls (baseline/PATCH): 1048577/1048577
>  256B       0.4211       0.9061  +115.18% [+72.13%, +169.00%]
>       recv() calls (baseline/PATCH): 1048577/1048577
>  512B       0.7980       1.6112  +101.90% [+95.30%, +108.72%]
>       recv() calls (baseline/PATCH): 1048577/1048577
>  1K         1.4965       2.6986   +80.33% [+68.93%, +92.49%]
>       recv() calls (baseline/PATCH): 1048577/1048577
>  4K         2.9384       4.8590   +65.36% [+60.17%, +70.72%]
>       recv() calls (baseline/PATCH): 539544/524982
>  8K         3.8170       5.1887   +35.94% [+27.66%, +44.75%]
>       recv() calls (baseline/PATCH): 274857/262991
>  16K        4.6856       5.5996   +19.51% [+15.36%, +23.81%]
>       recv() calls (baseline/PATCH): 147518/131351
>  64K        5.5182       5.8800    +6.56% [-0.83%, +14.49%]
>       recv() calls (baseline/PATCH): 48492/32910
>
>Guest CPU1 aggregate cycles per received byte
>(fixed 64K receiver, with perf):
>
>  Buffer size  baseline cycles/B  PATCH cycles/B  cycles change (95% CI)
>  64B        66.728    61.220  -8.25% [-18.99%, +3.91%]
>  256B       14.363    14.515  +1.06% [ -4.22%, +6.64%]
>  512B        7.792     7.578  -2.74% [ -6.55%, +1.23%]
>  1K          3.988     4.032  +1.09% [ -1.64%, +3.88%]
>  4K          2.063     1.973  -4.38% [ -8.23%, -0.37%]
>  8K          1.702     1.667  -2.06% [ -7.99%, +4.25%]
>  16K         1.473     1.475  +0.17% [ -5.06%, +5.68%]
>  64K         1.385     1.358  -1.96% [-10.61%, +7.53%]
>
>Signed-off-by: Jia Jia <physicalmtea@gmail.com>
>---
> include/linux/virtio_vsock.h            |  23 ++
> net/vmw_vsock/virtio_transport.c        |   7 +-
> net/vmw_vsock/virtio_transport_common.c | 303 ++++++++++++++++++++++--
> 3 files changed, 318 insertions(+), 15 deletions(-)
>
>diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>index f91704731057e..748633aa0cc81 100644
>--- a/include/linux/virtio_vsock.h
>+++ b/include/linux/virtio_vsock.h
>@@ -282,6 +282,29 @@ void virtio_transport_destruct(struct vsock_sock *vsk);
>
> void virtio_transport_recv_pkt(struct virtio_transport *t,
> 			       struct sk_buff *skb, struct net *net);
>+
>+/*
>+ * Initialize a batch to zero before use. A non-empty batch owns @sk's socket
>+ * lock and the reference returned by vsock_find_connected_socket_net(). The
>+ * caller retains both until it calls virtio_transport_rx_batch_finish(). An
>+ * empty batch owns neither.
>+ */
>+struct virtio_transport_rx_batch {
>+	struct sock *sk;
>+	unsigned int pkts;
>+	size_t bytes;
>+};
>+
>+static inline bool
>+virtio_transport_rx_batch_empty(const struct virtio_transport_rx_batch *batch)
>+{
>+	return !batch->sk;
>+}
>+
>+void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
>+				     struct sk_buff *skb, struct net *net,
>+				     struct virtio_transport_rx_batch *batch);
>+void virtio_transport_rx_batch_finish(struct virtio_transport_rx_batch *batch);
> void virtio_transport_inc_tx_pkt(struct virtio_vsock_sock *vvs, struct sk_buff *skb);
> u32 virtio_transport_get_credit(struct virtio_vsock_sock *vvs, u32 wanted);
> void virtio_transport_put_credit(struct virtio_vsock_sock *vvs, u32 credit);
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index 4f9aa9c4c3aa5..9af85712bd387 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -631,6 +631,7 @@ virtio_transport_seqpacket_allow(struct vsock_sock *vsk, u32 remote_cid)
>
> static void virtio_transport_rx_work(struct work_struct *work)
> {
> 	struct virtio_vsock *vsock =
> 		container_of(work, struct virtio_vsock, rx_work);
>+	struct virtio_transport_rx_batch batch = {};
> 	struct virtqueue *vq;
>@@ -666,6 +667,7 @@ static void virtio_transport_rx_work(struct work_struct *work)
> 			/* Drop short/long packets */
> 			if (unlikely(len < sizeof(*hdr) ||
> 				     len > virtio_vsock_skb_len(skb))) {
>+				virtio_transport_rx_batch_finish(&batch);
> 				kfree_skb(skb);
> 				continue;
> 			}
>@@ -673,6 +675,7 @@ static void virtio_transport_rx_work(struct work_struct *work)
> 			hdr = virtio_vsock_hdr(skb);
> 			payload_len = le32_to_cpu(hdr->len);
> 			if (unlikely(payload_len > len - sizeof(*hdr))) {
>+				virtio_transport_rx_batch_finish(&batch);
> 				kfree_skb(skb);
> 				continue;
> 			}
>@@ -685,11 +688,13 @@ static void virtio_transport_rx_work(struct work_struct *work)
> 			/* Force virtio-transport into global mode since it
> 			 * does not yet support local-mode namespacing.
> 			 */
>-			virtio_transport_recv_pkt(&virtio_transport, skb, NULL);
>+			virtio_transport_recv_pkt_batch(&virtio_transport, skb,
>+							NULL, &batch);
> 		}
> 	} while (!virtqueue_enable_cb(vq));
>
> out:
>+	virtio_transport_rx_batch_finish(&batch);
> 	if (vsock->rx_buf_nr < vsock->rx_buf_max_nr / 2)
> 		virtio_vsock_rx_fill(vsock);
> out_nofill:
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 2a9cfed085515..f83e5b2edce35 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -33,6 +33,15 @@
> #define MAX_COLLAPSE_LEN \
> 	SKB_MAX_ORDER(VIRTIO_VSOCK_SKB_HEADROOM, PAGE_ALLOC_COSTLY_ORDER)
>
>+/*
>+ * Bound the interval that an RX worker owns a socket lock. One maximum packet
>+ * buffer (64 KiB) bounds payload in one uninterrupted ownership interval.
>+ * Small and zero-length packets need a packet limit to bound per-packet work;
>+ * the 64-packet policy uses VHOST_NET_BATCH as a reference.
>+ */
>+#define VIRTIO_TRANSPORT_RX_BATCH_MAX_PKTS	64
>+#define VIRTIO_TRANSPORT_RX_BATCH_MAX_BYTES	VIRTIO_VSOCK_MAX_PKT_BUF_SIZE
>+
> static void virtio_transport_cancel_close_work(struct vsock_sock *vsk,
> 					       bool cancel_timeout);
> static s64 virtio_transport_has_space(struct virtio_vsock_sock *vvs);
>@@ -1793,13 +1802,94 @@ virtio_transport_find_socket(struct sockaddr_vm *src,
> 	return sk;
> }
>
>+static void
>+virtio_transport_trace_recv_pkt(const struct virtio_vsock_hdr *hdr,
>+				const struct sockaddr_vm *src,
>+				const struct sockaddr_vm *dst)
>+{
>+	trace_virtio_transport_recv_pkt(src->svm_cid, src->svm_port,
>+					dst->svm_cid, dst->svm_port,
>+					le32_to_cpu(hdr->len),
>+					le16_to_cpu(hdr->type),
>+					le16_to_cpu(hdr->op),
>+					le32_to_cpu(hdr->flags),
>+					le32_to_cpu(hdr->buf_alloc),
>+					le32_to_cpu(hdr->fwd_cnt));
>+}
>+
>+static bool
>+virtio_transport_recv_pkt_set_owner(struct sk_buff *skb, struct sock *sk)
>+{
>+	if (skb_set_owner_sk_safe(skb, sk))
>+		return true;
>+
>+	WARN_ONCE(1, "receiving vsock socket has sk_refcnt == 0\n");
>+	return false;
>+}
>+
>+static bool
>+virtio_transport_sock_has_psock(const struct sock *sk)
>+{
>+	return (uintptr_t)rcu_access_pointer(__sk_user_data(sk)) &
>+	       SK_USER_DATA_PSOCK;
>+}
>+
>+/* The caller holds sk's socket lock. */
>+static bool
>+virtio_transport_rx_batch_can_continue(struct virtio_transport *t,
>+				       struct sock *sk, u32 len)
>+{
>+	struct virtio_vsock_sock *vvs;
>+	struct vsock_sock *vsk;
>+
>+	vsk = vsock_sk(sk);
>+	vvs = vsk->trans;
>+
>+	/*
>+	 * Keep a connected lookup reference only for the native, established
>+	 * STREAM path. Sockets outside ESTABLISHED can change table membership;
>+	 * a completed or reassigned socket must resume the per-packet path.
>+	 */
>+	if (sk->sk_state != TCP_ESTABLISHED ||
>+	    sk->sk_type != SOCK_STREAM ||
>+	    sock_flag(sk, SOCK_DONE) ||
>+	    vsk->transport != &t->transport || !vvs)
>+		return false;
>+
>+	/*
>+	 * Do not admit a packet that would hit an existing RX limit while the
>+	 * worker owns the socket lock. The caller holds that lock, so no reader can
>+	 * dequeue until the batch is released.
>+	 */
>+	return (u64)vvs->buf_used + len <= vvs->buf_alloc &&
>+	       !virtio_transport_rx_buf_full(vvs);

I don't understand this. We recently introduce the collapse, so when we 
will call virtio_transport_recv_enqueue(), all the queue will be 
collapsed, including packets in the batch.

Or am I missing something?

Thanks,
Stefano

