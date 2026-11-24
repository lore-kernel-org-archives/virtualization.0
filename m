Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795522905;
	b=dJtAFn/Ih4t4XVMBq9xRIro6Prw6K4ioNsWqK3kMtq23SUhc9g1dFL0UvmbB22Lqp3GW
	 87IJKo2So60P8vaP/5u2pTEtRjkxU8pcu0PHG+UB29IzMzkynikXaVhQD4Mqa3+G3quoK
	 umjzo72qc0hTYrIw1XZFHeBF7PmJ9+AJfIRVNZqiTAOt9MA9YRzf6hyBNj+ctjoc76iXw
	 2Df4iN+IMeez545CzVw1XOlExa+axwWWf00O1xYnl5yYZaGXgrWpt/9XJLogKBA4EFqoX
	 P5+kkeyhJqOji7mlQbO1cl8fOG3UvQnNfdOnELzxVvt53wIwUnBPIHto4myPkNbmM/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795522905;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=sug3sIXb6TOC0bj3jtDZIi7xoEwjk6o8BtETfclb6qA=;
	b=ulew5hxdjA3hypBhrZHpkli/B6dzlmf1L7zICiohycS1SL3EzAjCEiuees9nnD1TZbL+
	 o1H7Er2J2WlkpT+D1EMksYnowdcD0LxRKi4OHC3nzyvHc3sXq1WWqe3iCdEDHzCwsB7yY
	 i7tba+Qh444DgECPmAqb7/yvhglArw28REC8qpb1XOJuz9cFvcuAC4oP8bxH57+XxGtjR
	 T1YCsZU31fJQRKmvToIieL78KMx2kSGEB1gEmDFEDr/Gzgle1eRIN8OWruESOt4DBNaT5
	 9mIXkThjWSfhM7uSabYqj9JidW+H4XKf/GN4LIVXvZp2VBKlcoGKAFmK2tphc/IHpTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bgyGTggW;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E278560A2611
	for <virtualization@lists.linux.dev>; Tue, 24 Nov 2026 12:21:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E278560A2611
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bgyGTggW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795522904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sug3sIXb6TOC0bj3jtDZIi7xoEwjk6o8BtETfclb6qA=;
	b=bgyGTggWD+oAFT8m6ORPS4OCJ653ll2PuLk/Ab3CD+7Y5F25DmWsRwApIop56P2hm7xyFQ
	CsQmAKPX0bc0jPeoE02H1O4BqawH7ltRdtttY/qGfqYuGmwU59T+1uN11B0+5ltDpnIUAc
	P+iiBBcaW4YcirqlGe6L55UlJIdhvQU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-KM5l8ponPrC015EjaCnoDQ-1; Tue, 24 Nov 2026 12:21:42 +0000
X-MC-Unique: KM5l8ponPrC015EjaCnoDQ-1
X-Mimecast-MFC-AGG-ID: KM5l8ponPrC015EjaCnoDQ_1795522901
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a80bd45e1cso24488505e9.3
        for <virtualization@lists.linux.dev>; Tue, 24 Nov 2026 04:21:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795522901; x=1796127701;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sug3sIXb6TOC0bj3jtDZIi7xoEwjk6o8BtETfclb6qA=;
        b=LcVgHj1GJHpatM6aW3W16xFP6C8XuMqo5RTgI4Dez5lIBVL51TdPIQLkS6S1nbqO/Y
         ir7cPppmcOuOwGiqq7bP+REeYrUD7h31+tzqB2rzI7s6FWU0gEc484ywsipUSa11Lox1
         F8iKNR5MdRFseFn8XtX+ToOhrqfdICbMlJ7J7eQudiIUBNbF7CUvoONmlgPXNDLwaRuJ
         u9ts6OoNJ2up+QGAvrva7xpDH+JeVtmm/6zz1aJqU/u4p05r/OBen79O+7Qv51So2Euz
         SZCEs4VXKqsiarIyaZ709gGKfLQOZwS/vpWXwUL+sFBQ8kmFN4aiSoSRkWgWrutEJ3pg
         92MQ==
X-Gm-Message-State: APuU4Z+VjtLuszHwof/OjZZoykkIV7moQ0FZl09qipV1pbNDrpiCpuec
	fwDoJYhE2ZAIpG5ipO5ZLN8sqhBF1ax6DmAEd544Hzux6S1QvjdNYM77MfuqJ+DJiD7FkCt5vcE
	emYl4dbD8KoqMQB13l2za9u7uqyt36rTZmSiAtkmaysGD0nTsaIFcVC5q4w4UyEqyQjpr
X-Gm-Gg: AZFdTZfq99AAuj2PXAS6yQO/5pcJLy8C8Rnq7VI8lItLgpTZJpT3vf00sNc0O230mSf
	CGK+rtWx1S47bAaGU/vpVAJvd8a1M8TRyz7bnb74E2+YnDros+gOzGgr0i8GKv/mvCobv8fsJ/z
	sLfqvS7vutk00+h4PwiRGtJfoi7UdMBVG/0DOMbl5HIaPUBlf9WdJIzzQpOdTVMXCkQpNcYD9V3
	hD1LALfXDBTBFBDuSke8EZVciNAX7YuMn6puk9dyRVt/iKSGsI+sE4QEO3i3G5S2AtJ4h05CYfd
	6RN4zJhSqTr0ZlR8f+4b+c1JualD1VpSdflchq7dG3ND0VwNaYMUqkjiLh1Nu+d+aPFDrukOqXq
	V/5390HGmHZXxR8oJEMBVc3ahPFl193EaPsVfx/lAlgxkvC/G57tB1YMLtNhmExTVcODsY1f0OD
	VMtxoL6eW8Ha8=
X-Received: by 2002:a05:600c:670b:b0:4a6:30c3:1114 with SMTP id 5b1f17b1804b1-4bb88922df3mr276003805e9.12.1795522900836;
        Tue, 24 Nov 2026 04:21:40 -0800 (PST)
X-Received: by 2002:a05:600c:670b:b0:4a6:30c3:1114 with SMTP id 5b1f17b1804b1-4bb88922df3mr276003365e9.12.1795522900467;
        Tue, 24 Nov 2026 04:21:40 -0800 (PST)
Received: from [192.168.0.19] (217.red-88-4-146.dynamicip.rima-tde.net. [88.4.146.217])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b110ba3sm22753198f8f.35.2026.11.24.04.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 04:21:40 -0800 (PST)
From: Sergio Lopez <slp@redhat.com>
Date: Tue, 24 Nov 2026 13:20:23 +0100
Subject: [PATCH RFC v4 5/8] vhost/vsock: negotiate datagram support with
 guests
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Message-Id: <20261124-vsock-dgram-support-v4-5-3607484e85e8@redhat.com>
References: <20261124-vsock-dgram-support-v4-0-3607484e85e8@redhat.com>
In-Reply-To: <20261124-vsock-dgram-support-v4-0-3607484e85e8@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
 Vishnu Dasa <vishnu.dasa@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, bpf@vger.kernel.org, 
 linux-hyperv@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
 linux-doc@vger.kernel.org, Sashiko AI bot <sashiko-bot@kernel.org>, 
 Sergio Lopez <slp@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6390; i=slp@redhat.com;
 h=from:subject:message-id; bh=aPPGnkG3NRN8zsschNikrnYTRtwAoxBD04k3+bLVY5A=;
 b=owEBbQKS/ZANAwAKAfRpJ40vDAI1AcsmYgBrBYFGF4yM5q7avlFZKV6kU2d6VP1EECVsasY5S
 PmvpH1ob/qJAjMEAAEKAB0WIQS+1fz3US2GgJFC6KL0aSeNLwwCNQUCawWBRgAKCRD0aSeNLwwC
 NaLAEACrirJaOKWRU1EbZZ++DhiyHSznTCGcjrDOYWdLr60c9d5CUj4knGY7ONXawzgLD81/b6g
 0mKjlBlqBi55ipnSitwpkkEr1kGoxSnhnP8LdHEwOuAtxobUuqW88uUw0cqJzMpjqRwElfUAsEJ
 2KK4ko6Twsi2CoZ034N6h8S2Qct3i03TCjjpHy8exxDqMfMeQ9Q34Ua24S4aB/Yv3Gw+s1JFODW
 wvGVzPjSD3a9BltbymuORshWmmOWPMh82hQd+kwX0zw523OqsYePRvMv8jK+AVyTtqQzgk4e7DG
 CrNR8MZkxOTqtPfCWBeBYuT16g5DJvzKfpHvTn8rHPE2knPO7ICM+5KfW/zkxm5suF4zaTUoffa
 zs1qgbzFEoUZWBlcE5I+uo2v6gAXY081CkXnJTpsZ8PpJBCgfZ2FsiZQlGxGzepeO4e/NuKjfd7
 FcmdWiAjncq53kJe3Uq4r96SkkCMZkgr9PTxcraOSKQUx3w1IeLDTkYmlUJz7bRjeql4igG7jw6
 P0dViu2yKIMl5C0iCqk8rUingLToJMhY1AqpMzxkUVIznCpzAchEDglOtbLvMbWawzueQABWsxl
 MpPpvDP8dTPJ79vuyalKT2TNZczcwfgSOiZkp0CNfF7v0vuVLwN++vPypclEShPi9E9ogqJpU7T
 kXR84yhdnX71JCA==
X-Developer-Key: i=slp@redhat.com; a=openpgp;
 fpr=BED5FCF7512D86809142E8A2F469278D2F0C0235
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0k7K78kqhGnArxXAowqcrN9B0oA7AUvuLdbl2UJBGRo_1795522901
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Expose VIRTIO_VSOCK_F_DGRAM in the vhost feature bitmap and retain the
negotiated value for each guest.  Keep datagrams disabled until the
feature is negotiated.

Use a vhost-specific datagram destination check to look up the guest
in the socket's network namespace and require its negotiated datagram
feature. The common virtio implementation supplies the bind and
message operations; destination validation remains in connect() and
sendmsg(), where the remote CID is available.

Reject guest datagrams on ingress unless the receiving virtqueue
acknowledged the feature. Complete rejected descriptors normally so the
queue can continue processing subsequent traffic.

Validate the guest TX header before allocating the skb, and size the
skb from its declared payload length rather than the descriptor chain.
A guest can post a descriptor much larger than the packet it sends.
The old allocation could then create a nonlinear skb whose data_len
exceeds len; a socket filter trimming a datagram could make recvmsg()
read beyond the skb data.

Signed-off-by: Sergio Lopez <slp@redhat.com>
---
 drivers/vhost/vsock.c | 66 ++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 44 insertions(+), 22 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 0cb87971d749..767f28794c6b 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -32,7 +32,8 @@
 static const int vhost_vsock_bits[] = {
 	VHOST_FEATURES,
 	VIRTIO_F_ACCESS_PLATFORM,
-	VIRTIO_VSOCK_F_SEQPACKET
+	VIRTIO_VSOCK_F_SEQPACKET,
+	VIRTIO_VSOCK_F_DGRAM,
 };
 
 #define VHOST_VSOCK_FEATURES VHOST_FEATURES_U64(vhost_vsock_bits, 0)
@@ -62,6 +63,7 @@ struct vhost_vsock {
 	u32 guest_cid;
 	bool seqpacket_allow;
 	bool ever_started; /* set on first SET_RUNNING(1); never cleared */
+	bool dgram_allow;
 };
 
 static u32 vhost_transport_get_local_cid(void)
@@ -360,7 +362,7 @@ static struct sk_buff *
 vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
 		      unsigned int out, unsigned int in)
 {
-	struct virtio_vsock_hdr *hdr;
+	struct virtio_vsock_hdr hdr;
 	struct iov_iter iov_iter;
 	struct sk_buff *skb;
 	size_t payload_len;
@@ -378,34 +380,30 @@ vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
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
+	skb = virtio_vsock_alloc_skb(sizeof(hdr) + payload_len, GFP_KERNEL);
+	if (!skb)
+		return NULL;
+	*virtio_vsock_hdr(skb) = hdr;
 
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
@@ -436,6 +434,8 @@ static bool vhost_transport_msgzerocopy_allow(void)
 
 static bool vhost_transport_seqpacket_allow(struct vsock_sock *vsk,
 					    u32 remote_cid);
+static bool vhost_transport_dgram_allow(struct vsock_sock *vsk,
+					u32 cid, u32 port);
 
 static bool
 vhost_transport_stream_allow(struct vsock_sock *vsk, u32 cid, u32 port)
@@ -460,7 +460,7 @@ static struct virtio_transport vhost_transport = {
 		.dgram_enqueue            = virtio_transport_dgram_enqueue,
 		.dgram_dequeue            = virtio_transport_dgram_dequeue,
 		.dgram_bind               = virtio_transport_dgram_bind,
-		.dgram_allow              = virtio_transport_dgram_allow,
+		.dgram_allow              = vhost_transport_dgram_allow,
 
 		.stream_enqueue           = virtio_transport_stream_enqueue,
 		.stream_dequeue           = virtio_transport_stream_dequeue,
@@ -516,6 +516,24 @@ static bool vhost_transport_seqpacket_allow(struct vsock_sock *vsk,
 	return seqpacket_allow;
 }
 
+static bool vhost_transport_dgram_allow(struct vsock_sock *vsk,
+					u32 cid, u32 port)
+{
+	struct net *net = sock_net(sk_vsock(vsk));
+	struct vhost_vsock *vsock;
+	bool dgram_allow = false;
+
+	rcu_read_lock();
+	vsock = vhost_vsock_get(cid, net);
+
+	if (vsock)
+		dgram_allow = vsock->dgram_allow;
+
+	rcu_read_unlock();
+
+	return dgram_allow;
+}
+
 static void vhost_vsock_handle_tx_kick(struct vhost_work *work)
 {
 	struct vhost_virtqueue *vq = container_of(work, struct vhost_virtqueue,
@@ -573,10 +591,12 @@ static void vhost_vsock_handle_tx_kick(struct vhost_work *work)
 
 		hdr = virtio_vsock_hdr(skb);
 
-		/* Only accept correctly addressed packets */
+		/* Check addressing and datagram feature negotiation. */
 		if (le64_to_cpu(hdr->src_cid) == vsock->guest_cid &&
 		    le64_to_cpu(hdr->dst_cid) ==
-		    vhost_transport_get_local_cid())
+		    vhost_transport_get_local_cid() &&
+		    (le16_to_cpu(hdr->type) != VIRTIO_VSOCK_TYPE_DGRAM ||
+		     vhost_has_feature(vq, VIRTIO_VSOCK_F_DGRAM)))
 			virtio_transport_recv_pkt(&vhost_transport, skb,
 						  vsock->net);
 		else
@@ -737,6 +757,7 @@ static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
 	vsock->guest_cid = 0; /* no CID assigned yet */
 	vsock->seqpacket_allow = false;
 	vsock->ever_started = false;
+	vsock->dgram_allow = false;
 
 	atomic_set(&vsock->queued_replies, 0);
 
@@ -890,6 +911,7 @@ static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
 	}
 
 	vsock->seqpacket_allow = features & (1ULL << VIRTIO_VSOCK_F_SEQPACKET);
+	vsock->dgram_allow = features & (1ULL << VIRTIO_VSOCK_F_DGRAM);
 
 	for (i = 0; i < ARRAY_SIZE(vsock->vqs); i++) {
 		vq = &vsock->vqs[i];

-- 
2.56.0

