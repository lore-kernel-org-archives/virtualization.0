Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794590180;
	b=K0YdzmVxhWNm1LcLEQUfSSPmwOQC4WlP49CITzMn+QTcNaQoiqTTNBwrRQLuGXT7QtGH
	 jhXHI2WdBimIp1yxsWErBgG9ejuTC9UDxoeJUG7T5SIovs7dufoDAdVMbBIus0SRZnCr6
	 5CF4HOkM7E8nnWw0xncUcLlSyeye/okOlI8xLbtlCwn1grbAQXZi/KqxjHC49RjaC3EYG
	 S4j5PJi1SG+9YEUEex8RaAYWoaKcr7+qQ82wLJ0oXhis0gvbvpaYp0eN0wBWi1E/LQVLC
	 51EZSPW+e7ETLLuSjOoHHkriHj57TccJbEy9SdhAoFP8m9vv1zvVU8UVekCSpX58abg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794590180;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=42m2T+OgUE+WzNUCZPiDLGv4wYEY//5j6O7a88xsAPc=;
	b=ye+kPIyzV8DAtYK/fKnXRCWOE2quWqNz8dkmT6rBWiBbxUHqwj9+qS/HmdN2OwKsa3FU
	 roMX5I9uruD0qXuOxYAFCq+P9WcABIVDGjl6tx8Hhsl5soytLb+rXO65Eq9O4bSws6hEL
	 Oe0d51pNSKAlwpV8BhFllo3qloQtBdHCyK0JC7u9xjxAQfz9hDp1R7gMttNlZF05Tb37/
	 6v9cGUDR/sho3yr2+RaUgs27ADC7yA0HDAKONOkZvDwJvJ9TY8v8cy5YDuV1Gxeg74D+4
	 DCWQ+vUXXU8inv7QoXsDHi2ujKTSAP5Cg/tX7pVyqATn+FeoEUxlx2g4QjI4vYO6tpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gVu6c8uo;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99ABD6071434
	for <virtualization@lists.linux.dev>; Fri, 13 Nov 2026 17:16:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99ABD6071434
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gVu6c8uo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794590178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=42m2T+OgUE+WzNUCZPiDLGv4wYEY//5j6O7a88xsAPc=;
	b=gVu6c8uoR8Vs3MSZo2BwbavqUD7NDOcTKRWnB6oIlUoU3wUcym4/sX52MEhDZMcMHd1Tnt
	Rvm5yC3njgSue3hYuB4m1AMitqvg+vbIEBSUiSmDRNFCS0KWyOGabvZDPsHSPB/5LWN6Qq
	DitMoy6+9MAiWCWgwkg1Lw1+nzrPzeA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-SP0CXVaXMBOEAn4JFh1McQ-1; Fri, 13 Nov 2026 12:16:17 -0500
X-MC-Unique: SP0CXVaXMBOEAn4JFh1McQ-1
X-Mimecast-MFC-AGG-ID: SP0CXVaXMBOEAn4JFh1McQ_1794590176
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48e0fc747a7so846334f8f.1
        for <virtualization@lists.linux.dev>; Fri, 13 Nov 2026 09:16:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794590176; x=1795194976;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=42m2T+OgUE+WzNUCZPiDLGv4wYEY//5j6O7a88xsAPc=;
        b=AW7NzkQORE5JtAEWsTrkHU3vKaIJu/L6nz1a1TvtcWRFO3s8UCXXGiuKjp9A8DcOj7
         N3ktEbuz+h2/+CSmGboG2Bgjb0jWJGO8JqEH23sw/5WkWm5b5onXZgaDPeiK38aRxcB/
         g8o5nozYMpgcnVLXpIrcCNrEuJvzAlZBfnFbv/evliQ9E/x7T0nQF0GDTovB5bnSpr99
         aCnXX4MlKCmbNo6fBuYVGg5eASF2aBwTcDM+ykLsOurhzRlILLEimNACiGp3z1OOJFAJ
         /qlvme+Eo9pnqc0a12zvIwjvZLmSrMWyIgO0oCODTYiwKX4qpRoyMdogb9g8GmyiVa2U
         /40g==
X-Gm-Message-State: APuU4Z/NMfPv+jmbzO1phWs4vzzZNlDj0U3sgFCxLXnFFkbx4S1hGx+A
	rF7RlisQl13lecLGMCvSwb4BBwjh/egddXBa9MKeWmUx2Za/BBC8xJIn4Dbf6rJ61YuuGuVGJyi
	XEHt2dnTnAhM23BfXGgXBMlBe0WfnWWNgScCfUjdrpVdGgvzPfM2HCJ9tXg6ucZDxHl3k
X-Gm-Gg: AYBFou2f87bgy6B34NsavaCQ7/gEXvDUDFxXqCfyws4dVx1MdtugrapMV6EdHs7XsBG
	bvOFpg81LzZU32o1bW/3HpvU9FFWLDeN2V0cPRJmal3uVJOUCXqTORVPwV+6VLiKlmVu5s1hy4x
	bcf4J3KF/2WNesUyfh2PsNWr4PQ06mtSg9fwcnNn+3nS7toMxWq/YLStz6ANny66zY9eMeNuLea
	wTs7TwgV8L4W6XTceaXSkcOwvFXj4TFXKudSp1yrYk7gsN8SCK3aFOHXwGH90mo1vkzfkI8dk+v
	dKFS+mfhgXWBvdpqGDCPU2tp/4mnqc2NMffZOnnAzDiL35ECIeDlyMZW/Ei2yx9TTAuSbsb3yuO
	+1SPmws/l3hBL2bRfTrp1K0zzJB82q50yPITccIJStRTULeTAL1vCvKUvT3X0JZ0X5Pz9LpU7/7
	bIbUhfxQc2xaU=
X-Received: by 2002:a05:6000:4907:b0:48e:b62:d133 with SMTP id ffacd0b85a97d-49c6d453058mr7554608f8f.5.1794590176290;
        Fri, 13 Nov 2026 09:16:16 -0800 (PST)
X-Received: by 2002:a05:6000:4907:b0:48e:b62:d133 with SMTP id ffacd0b85a97d-49c6d453058mr7554512f8f.5.1794590175789;
        Fri, 13 Nov 2026 09:16:15 -0800 (PST)
Received: from [192.168.0.19] (217.red-88-4-146.dynamicip.rima-tde.net. [88.4.146.217])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c7da37b19sm5811907f8f.5.2026.11.13.09.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 09:16:13 -0800 (PST)
From: Sergio Lopez <slp@redhat.com>
Date: Fri, 13 Nov 2026 18:15:45 +0100
Subject: [PATCH RFC v3 5/8] vhost/vsock: negotiate datagram support with
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
Message-Id: <20261113-vsock-dgram-support-v3-5-1523c8e9b27e@redhat.com>
References: <20261113-vsock-dgram-support-v3-0-1523c8e9b27e@redhat.com>
In-Reply-To: <20261113-vsock-dgram-support-v3-0-1523c8e9b27e@redhat.com>
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
 linux-doc@vger.kernel.org, Sergio Lopez <slp@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4280; i=slp@redhat.com;
 h=from:subject:message-id; bh=YKxLSTvJb7wfOxlVHWx31lkfYp2fx1FL4beUkGwefCU=;
 b=kA0DAAoB9GknjS8MAjUByyZiAGr3RcvI3QnmKr/LRFn2Ary4TwcFPckWS7tYNcHGXnxHY4IMx
 YkCMwQAAQoAHRYhBL7V/PdRLYaAkULoovRpJ40vDAI1BQJq90XLAAoJEPRpJ40vDAI1JUsP/RuK
 zWQiElr7d4dJNVClBKs1rzZ0Yj3GcaeAHappnpy6wUu+gmAJFnxM2QFmqVIFxSElR8wNfcYX04t
 V8H+SJ/t0vVBYstyu9Mg7KIrxAWMvfhhIY5LnPwx2ZMfhqsTz+7ACuiDr6pZ2zxB8+CtoC3qu48
 nPzB2yFClOtl59Tbo6kse/qyppGiuKwfwAN8JWzOSeKIpLz7OGpocKl3vzkZ9C+ORgjYAAgvHNq
 teMbYTgAaShLedtIJoHNbCXsC/ZqnKsTuLZAzRnbqpUMdduT7UYOD9I6lvsTzU6b+ahXvZA5eKl
 nnkpvCIm0h1d1BSerC5RQq2JxnsOnW+6RAX/5HK0Pvgw0lXozPmSSKYO7W43WuzPTA+9By5WbSk
 PVaU6jX+oDMLJvH8v+z7hKrdgE6BEP244sZO2UtjODmqipK75ewCBRjhFggUwgPDP29cMMmvd6y
 z4FvZTWeMSYYeuhi6n+zEu3khNX84RSd/MlyCg5toZqRH7WhCC2zvn77ORD4nqPOGQFhFfA+XzX
 4vkl2qZPzHp/B/bz0w/h09prkD8x6/cY0skNUq8DRlnEMu/eXr6jC17IuBrGNW0tg+8u5DsOSiO
 cyAMGfzGZGgiBsCN6erpjNNToul8X5KBhzJ2LaYIVVetDnHyfAJ/4uuhpeA9rGKcWuHyE3YvReY
 rYmJl
X-Developer-Key: i=slp@redhat.com; a=openpgp;
 fpr=BED5FCF7512D86809142E8A2F469278D2F0C0235
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _wc3cXeOwnKv_qqSUbMP4qoaS-0p_yKt_r2gST5c_Os_1794590176
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

Signed-off-by: Sergio Lopez <slp@redhat.com>
---
 drivers/vhost/vsock.c | 34 ++++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 0cb87971d749..7971f6f0b6a2 100644
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
@@ -436,6 +438,8 @@ static bool vhost_transport_msgzerocopy_allow(void)
 
 static bool vhost_transport_seqpacket_allow(struct vsock_sock *vsk,
 					    u32 remote_cid);
+static bool vhost_transport_dgram_allow(struct vsock_sock *vsk,
+					u32 cid, u32 port);
 
 static bool
 vhost_transport_stream_allow(struct vsock_sock *vsk, u32 cid, u32 port)
@@ -460,7 +464,7 @@ static struct virtio_transport vhost_transport = {
 		.dgram_enqueue            = virtio_transport_dgram_enqueue,
 		.dgram_dequeue            = virtio_transport_dgram_dequeue,
 		.dgram_bind               = virtio_transport_dgram_bind,
-		.dgram_allow              = virtio_transport_dgram_allow,
+		.dgram_allow              = vhost_transport_dgram_allow,
 
 		.stream_enqueue           = virtio_transport_stream_enqueue,
 		.stream_dequeue           = virtio_transport_stream_dequeue,
@@ -516,6 +520,24 @@ static bool vhost_transport_seqpacket_allow(struct vsock_sock *vsk,
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
@@ -573,10 +595,12 @@ static void vhost_vsock_handle_tx_kick(struct vhost_work *work)
 
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
@@ -737,6 +761,7 @@ static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
 	vsock->guest_cid = 0; /* no CID assigned yet */
 	vsock->seqpacket_allow = false;
 	vsock->ever_started = false;
+	vsock->dgram_allow = false;
 
 	atomic_set(&vsock->queued_replies, 0);
 
@@ -890,6 +915,7 @@ static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
 	}
 
 	vsock->seqpacket_allow = features & (1ULL << VIRTIO_VSOCK_F_SEQPACKET);
+	vsock->dgram_allow = features & (1ULL << VIRTIO_VSOCK_F_DGRAM);
 
 	for (i = 0; i < ARRAY_SIZE(vsock->vqs); i++) {
 		vq = &vsock->vqs[i];

-- 
2.56.0

