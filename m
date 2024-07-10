Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D11713C90E
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Jul 2024 21:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720646761; cv=none; b=hrdKVUxqnliXMM0K/Adkol7V7Xxr5LozAGqC09tijkXslm0UVLXTW/fl8vrGNz9w2HNPFnr41NsFgDrMAqdAGBtvcqicfo1bVCkkkZ32bppxQnn+3gUEr0NrgttRlThr6yVDPOMmf3F37GUlA6Qn/xajCQOiLLh53Hs4ztn+KCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720646761; c=relaxed/simple;
	bh=2oNBKsr/zKHor9vzhBEXHNQLyKLNT6n5DiR1niLN3c8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=px6ofoMqBheuVQH0hbXIlWT4fdLVNzavSpNvlYC9cllRpS8Hcw/bZkF7C2S/oRgogWbIGUt17RX2/IG7rUPukLc7JzXKONBUaRffAccAmdb2+LsV/yQUFC847ly6fNuFO7Tc9I7sQ5fWQKT2pqxkmb7EhIONQWCLF+3FXSS0v5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gyjPfDLZ; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gyjPfDLZ"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4CF7482230
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Jul 2024 21:25:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: 1.236
X-Spam-Level: *
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xEwav5zRiYnq for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Jul 2024 21:25:58 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::72c; helo=mail-qk1-x72c.google.com; envelope-from=ameryhung@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 3A66F821F0
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3A66F821F0
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=gyjPfDLZ
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3A66F821F0
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Jul 2024 21:25:58 +0000 (UTC)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-7a05b4fa525so20546785a.1
        for <virtualization@lists.linux-foundation.org>; Wed, 10 Jul 2024 14:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720646757; x=1721251557; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KX8KIo3iV7NoMHa3zqkZ0Z+vhF8zraRE7TtvznvQNIg=;
        b=gyjPfDLZB9aJ6TzkR0UrDH7wrK2VQ9x8X4amjPWwYhLo1PdLl8bXCMK3Mj9YVCFyVS
         seKR/BB2fDQTQ7i0Gvu6ecv+62dnXyuJZavFKKJzB+fkwpu3O21rBuOr6HrYSRxADraJ
         TGtz7C/DfqlAq8V71oFDtW54xHcODzjJxJwhZuN8TiERcdS0mF9GMiOnF2on3Jg+5glN
         7jcJkxzYHtitC0PfRc4Eumu3FdQSPw3eD7pDwzv6nvHAF0drCI/oMTiNoSckUIkKvdJI
         YqlrBG9lEkXV1wg1JhPA64ijk7nlb7pQkOSdycycjQe6CsP0PgJzDvA7ONAxR6h1GUNI
         W8rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720646757; x=1721251557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KX8KIo3iV7NoMHa3zqkZ0Z+vhF8zraRE7TtvznvQNIg=;
        b=Mu70RI7IKXzm34wGFvGSUQf0dmKZT5sd5DM7H0F1WUEELZFlx3ol4te9L9xoEhRoz/
         tK5b5kNzsoy6abmCwE19dnW+ccRWJ3hN4rmJsPFad7qJkCQVqdjD8LrxFaHoF2VeKSYS
         fh0oeaQNwWy2Ck6OSLMsOpUS6UR9QtEtdTXa4NqzM+fZLgwPrMUBK2lVHFakYbguWatb
         sO/z2ECND1yCHNm8ZmVxEp/OJOSQ+z41186hr8UaSkfAHGBPTIWU6o+iy5I02S4pM08p
         Un48ZRkvhgZg9XIpJy0Z0fb6EoIlW46UkdjpTciWNyyPLNYdzr92eiy7EJpxiy1TDhvQ
         raUg==
X-Forwarded-Encrypted: i=1; AJvYcCUtwlG1ZejGlFD6Ad79zELioZJ8y3pCsQSLPpiTqkccVBtiiLVLd8gGHhff2qpWlha7xrZZwoHsiejStsbyn3iwnN7gHIGjEWHHF7Jdwxu6mhx+zTFNq/knCQ==
X-Gm-Message-State: AOJu0YwBJV5hO0ly57KQCfAm5Q5Plph8XRH2AUEmdpVXFOvixjcYB5/r
	Zs6seAxeg0f1Iurta1SVu77tCrAAA+qUCKldU2Eq9a53Yqx7XMpW
X-Google-Smtp-Source: AGHT+IFSj7+MYM52RaS6eZWKXpFPukkOvw7LM6PzzibSNjmPqd57Dl57Ba5FqQJnizrjtsz6ZhSPkQ==
X-Received: by 2002:a05:620a:2444:b0:79e:f9f4:3e99 with SMTP id af79cd13be357-7a1469a84d6mr197991885a.1.1720646756780;
        Wed, 10 Jul 2024 14:25:56 -0700 (PDT)
Received: from n36-183-057.byted.org ([130.44.215.118])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79f190b0af1sm228791885a.122.2024.07.10.14.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 14:25:56 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
X-Google-Original-From: Amery Hung <amery.hung@bytedance.com>
To: stefanha@redhat.com,
	sgarzare@redhat.com,
	mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	bryantan@vmware.com,
	vdasa@vmware.com,
	pv-drivers@vmware.com
Cc: dan.carpenter@linaro.org,
	simon.horman@corigine.com,
	oxffffaa@gmail.com,
	kvm@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	bpf@vger.kernel.org,
	bobby.eshleman@bytedance.com,
	jiang.wang@bytedance.com,
	amery.hung@bytedance.com,
	ameryhung@gmail.com,
	xiyou.wangcong@gmail.com
Subject: [RFC PATCH net-next v6 01/14] af_vsock: generalize vsock_dgram_recvmsg() to all transports
Date: Wed, 10 Jul 2024 21:25:42 +0000
Message-Id: <20240710212555.1617795-2-amery.hung@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240710212555.1617795-1-amery.hung@bytedance.com>
References: <20240710212555.1617795-1-amery.hung@bytedance.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bobby Eshleman <bobby.eshleman@bytedance.com>

This commit drops the transport->dgram_dequeue callback and makes
vsock_dgram_recvmsg() generic to all transports.

To make this possible, two transport-level changes are introduced:
- transport in the receiving path now stores the cid and port into
  the control buffer of an skb when populating an skb. The information
  later is used to initialize sockaddr_vm structure in recvmsg()
  without referencing vsk->transport.
- transport implementations set the skb->data pointer to the beginning
  of the payload prior to adding the skb to the socket's receive queue.
  That is, they must use skb_pull() before enqueuing. This is an
  agreement between the transport and the socket layer that skb->data
  always points to the beginning of the payload (and not, for example,
  the packet header).

Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
Signed-off-by: Amery Hung <amery.hung@bytedance.com>
---
 drivers/vhost/vsock.c                   |  1 -
 include/linux/virtio_vsock.h            |  5 ---
 include/net/af_vsock.h                  | 11 ++++-
 net/vmw_vsock/af_vsock.c                | 42 +++++++++++++++++-
 net/vmw_vsock/hyperv_transport.c        |  7 ---
 net/vmw_vsock/virtio_transport.c        |  1 -
 net/vmw_vsock/virtio_transport_common.c |  9 ----
 net/vmw_vsock/vmci_transport.c          | 59 +++----------------------
 net/vmw_vsock/vsock_loopback.c          |  1 -
 9 files changed, 55 insertions(+), 81 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index ec20ecff85c7..97fffa914e66 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -419,7 +419,6 @@ static struct virtio_transport vhost_transport = {
 		.cancel_pkt               = vhost_transport_cancel_pkt,
 
 		.dgram_enqueue            = virtio_transport_dgram_enqueue,
-		.dgram_dequeue            = virtio_transport_dgram_dequeue,
 		.dgram_bind               = virtio_transport_dgram_bind,
 		.dgram_allow              = virtio_transport_dgram_allow,
 
diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index c82089dee0c8..8b56b8a19ddd 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -177,11 +177,6 @@ virtio_transport_stream_dequeue(struct vsock_sock *vsk,
 				size_t len,
 				int type);
 int
-virtio_transport_dgram_dequeue(struct vsock_sock *vsk,
-			       struct msghdr *msg,
-			       size_t len, int flags);
-
-int
 virtio_transport_seqpacket_enqueue(struct vsock_sock *vsk,
 				   struct msghdr *msg,
 				   size_t len);
diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index 535701efc1e5..7aa1f5f2b1a5 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -120,8 +120,6 @@ struct vsock_transport {
 
 	/* DGRAM. */
 	int (*dgram_bind)(struct vsock_sock *, struct sockaddr_vm *);
-	int (*dgram_dequeue)(struct vsock_sock *vsk, struct msghdr *msg,
-			     size_t len, int flags);
 	int (*dgram_enqueue)(struct vsock_sock *, struct sockaddr_vm *,
 			     struct msghdr *, size_t len);
 	bool (*dgram_allow)(u32 cid, u32 port);
@@ -219,6 +217,15 @@ void vsock_for_each_connected_socket(struct vsock_transport *transport,
 int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk);
 bool vsock_find_cid(unsigned int cid);
 
+struct vsock_skb_cb {
+	unsigned int src_cid;
+	unsigned int src_port;
+};
+
+static inline struct vsock_skb_cb *vsock_skb_cb(struct sk_buff *skb) {
+	return (struct vsock_skb_cb *)skb->cb;
+};
+
 /**** TAP ****/
 
 struct vsock_tap {
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 4b040285aa78..5e7d4d99ea2c 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -1273,11 +1273,15 @@ static int vsock_dgram_connect(struct socket *sock,
 int vsock_dgram_recvmsg(struct socket *sock, struct msghdr *msg,
 			size_t len, int flags)
 {
+	struct vsock_skb_cb *vsock_cb;
 #ifdef CONFIG_BPF_SYSCALL
 	const struct proto *prot;
 #endif
 	struct vsock_sock *vsk;
+	struct sk_buff *skb;
+	size_t payload_len;
 	struct sock *sk;
+	int err;
 
 	sk = sock->sk;
 	vsk = vsock_sk(sk);
@@ -1288,7 +1292,43 @@ int vsock_dgram_recvmsg(struct socket *sock, struct msghdr *msg,
 		return prot->recvmsg(sk, msg, len, flags, NULL);
 #endif
 
-	return vsk->transport->dgram_dequeue(vsk, msg, len, flags);
+	if (flags & MSG_OOB || flags & MSG_ERRQUEUE)
+		return -EOPNOTSUPP;
+
+	if (unlikely(flags & MSG_ERRQUEUE))
+		return sock_recv_errqueue(sk, msg, len, SOL_VSOCK, 0);
+
+	/* Retrieve the head sk_buff from the socket's receive queue. */
+	err = 0;
+	skb = skb_recv_datagram(sk_vsock(vsk), flags, &err);
+	if (!skb)
+		return err;
+
+	payload_len = skb->len;
+
+	if (payload_len > len) {
+		payload_len = len;
+		msg->msg_flags |= MSG_TRUNC;
+	}
+
+	/* Place the datagram payload in the user's iovec. */
+	err = skb_copy_datagram_msg(skb, 0, msg, payload_len);
+	if (err)
+		goto out;
+
+	if (msg->msg_name) {
+		/* Provide the address of the sender. */
+		DECLARE_SOCKADDR(struct sockaddr_vm *, vm_addr, msg->msg_name);
+
+		vsock_cb = vsock_skb_cb(skb);
+		vsock_addr_init(vm_addr, vsock_cb->src_cid, vsock_cb->src_port);
+		msg->msg_namelen = sizeof(*vm_addr);
+	}
+	err = payload_len;
+
+out:
+	skb_free_datagram(&vsk->sk, skb);
+	return err;
 }
 EXPORT_SYMBOL_GPL(vsock_dgram_recvmsg);
 
diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
index e2157e387217..326dd41ee2d5 100644
--- a/net/vmw_vsock/hyperv_transport.c
+++ b/net/vmw_vsock/hyperv_transport.c
@@ -556,12 +556,6 @@ static int hvs_dgram_bind(struct vsock_sock *vsk, struct sockaddr_vm *addr)
 	return -EOPNOTSUPP;
 }
 
-static int hvs_dgram_dequeue(struct vsock_sock *vsk, struct msghdr *msg,
-			     size_t len, int flags)
-{
-	return -EOPNOTSUPP;
-}
-
 static int hvs_dgram_enqueue(struct vsock_sock *vsk,
 			     struct sockaddr_vm *remote, struct msghdr *msg,
 			     size_t dgram_len)
@@ -833,7 +827,6 @@ static struct vsock_transport hvs_transport = {
 	.shutdown                 = hvs_shutdown,
 
 	.dgram_bind               = hvs_dgram_bind,
-	.dgram_dequeue            = hvs_dgram_dequeue,
 	.dgram_enqueue            = hvs_dgram_enqueue,
 	.dgram_allow              = hvs_dgram_allow,
 
diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index 43d405298857..a8c97e95622a 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -508,7 +508,6 @@ static struct virtio_transport virtio_transport = {
 		.cancel_pkt               = virtio_transport_cancel_pkt,
 
 		.dgram_bind               = virtio_transport_dgram_bind,
-		.dgram_dequeue            = virtio_transport_dgram_dequeue,
 		.dgram_enqueue            = virtio_transport_dgram_enqueue,
 		.dgram_allow              = virtio_transport_dgram_allow,
 
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 16ff976a86e3..4bf73d20c12a 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -810,15 +810,6 @@ virtio_transport_seqpacket_enqueue(struct vsock_sock *vsk,
 }
 EXPORT_SYMBOL_GPL(virtio_transport_seqpacket_enqueue);
 
-int
-virtio_transport_dgram_dequeue(struct vsock_sock *vsk,
-			       struct msghdr *msg,
-			       size_t len, int flags)
-{
-	return -EOPNOTSUPP;
-}
-EXPORT_SYMBOL_GPL(virtio_transport_dgram_dequeue);
-
 s64 virtio_transport_stream_has_data(struct vsock_sock *vsk)
 {
 	struct virtio_vsock_sock *vvs = vsk->trans;
diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
index b370070194fa..b39df3ed8c8d 100644
--- a/net/vmw_vsock/vmci_transport.c
+++ b/net/vmw_vsock/vmci_transport.c
@@ -610,6 +610,7 @@ vmci_transport_datagram_create_hnd(u32 resource_id,
 
 static int vmci_transport_recv_dgram_cb(void *data, struct vmci_datagram *dg)
 {
+	struct vsock_skb_cb *vsock_cb;
 	struct sock *sk;
 	size_t size;
 	struct sk_buff *skb;
@@ -637,10 +638,14 @@ static int vmci_transport_recv_dgram_cb(void *data, struct vmci_datagram *dg)
 	if (!skb)
 		return VMCI_ERROR_NO_MEM;
 
+	vsock_cb = vsock_skb_cb(skb);
+	vsock_cb->src_cid = dg->src.context;
+	vsock_cb->src_port = dg->src.resource;
 	/* sk_receive_skb() will do a sock_put(), so hold here. */
 	sock_hold(sk);
 	skb_put(skb, size);
 	memcpy(skb->data, dg, size);
+	skb_pull(skb, VMCI_DG_HEADERSIZE);
 	sk_receive_skb(sk, skb, 0);
 
 	return VMCI_SUCCESS;
@@ -1731,59 +1736,6 @@ static int vmci_transport_dgram_enqueue(
 	return err - sizeof(*dg);
 }
 
-static int vmci_transport_dgram_dequeue(struct vsock_sock *vsk,
-					struct msghdr *msg, size_t len,
-					int flags)
-{
-	int err;
-	struct vmci_datagram *dg;
-	size_t payload_len;
-	struct sk_buff *skb;
-
-	if (flags & MSG_OOB || flags & MSG_ERRQUEUE)
-		return -EOPNOTSUPP;
-
-	/* Retrieve the head sk_buff from the socket's receive queue. */
-	err = 0;
-	skb = skb_recv_datagram(&vsk->sk, flags, &err);
-	if (!skb)
-		return err;
-
-	dg = (struct vmci_datagram *)skb->data;
-	if (!dg)
-		/* err is 0, meaning we read zero bytes. */
-		goto out;
-
-	payload_len = dg->payload_size;
-	/* Ensure the sk_buff matches the payload size claimed in the packet. */
-	if (payload_len != skb->len - sizeof(*dg)) {
-		err = -EINVAL;
-		goto out;
-	}
-
-	if (payload_len > len) {
-		payload_len = len;
-		msg->msg_flags |= MSG_TRUNC;
-	}
-
-	/* Place the datagram payload in the user's iovec. */
-	err = skb_copy_datagram_msg(skb, sizeof(*dg), msg, payload_len);
-	if (err)
-		goto out;
-
-	if (msg->msg_name) {
-		/* Provide the address of the sender. */
-		DECLARE_SOCKADDR(struct sockaddr_vm *, vm_addr, msg->msg_name);
-		vsock_addr_init(vm_addr, dg->src.context, dg->src.resource);
-		msg->msg_namelen = sizeof(*vm_addr);
-	}
-	err = payload_len;
-
-out:
-	skb_free_datagram(&vsk->sk, skb);
-	return err;
-}
-
 static bool vmci_transport_dgram_allow(u32 cid, u32 port)
 {
 	if (cid == VMADDR_CID_HYPERVISOR) {
@@ -2040,7 +1992,6 @@ static struct vsock_transport vmci_transport = {
 	.release = vmci_transport_release,
 	.connect = vmci_transport_connect,
 	.dgram_bind = vmci_transport_dgram_bind,
-	.dgram_dequeue = vmci_transport_dgram_dequeue,
 	.dgram_enqueue = vmci_transport_dgram_enqueue,
 	.dgram_allow = vmci_transport_dgram_allow,
 	.stream_dequeue = vmci_transport_stream_dequeue,
diff --git a/net/vmw_vsock/vsock_loopback.c b/net/vmw_vsock/vsock_loopback.c
index 6dea6119f5b2..11488887a5cc 100644
--- a/net/vmw_vsock/vsock_loopback.c
+++ b/net/vmw_vsock/vsock_loopback.c
@@ -66,7 +66,6 @@ static struct virtio_transport loopback_transport = {
 		.cancel_pkt               = vsock_loopback_cancel_pkt,
 
 		.dgram_bind               = virtio_transport_dgram_bind,
-		.dgram_dequeue            = virtio_transport_dgram_dequeue,
 		.dgram_enqueue            = virtio_transport_dgram_enqueue,
 		.dgram_allow              = virtio_transport_dgram_allow,
 
-- 
2.20.1

