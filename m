Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9EC16849C
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Jul 2024 21:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720646770; cv=none; b=W3rKvhOikPRtd2XWfS+itaZvvOIgCml2hsZJeisdjaUuXMXG0QtTi//dgxFxKRfClNK2Cz11iZFw/3fARdxPYqH9xYmJQ8c1jxImDLMreIMsI2H4h7ZhNIBy2DCZtvSqu78MLUT3uvxMrZhbME4a3yXy7Z0guQ0v9iOzm5QHJgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720646770; c=relaxed/simple;
	bh=GXo6JSq/5CxjMKofrwy78dq6F+39cdkj30pXolPW1Us=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jlH4VSBZ8fPUsi4VOi/h7vuFtT6N9s/eLM2SNhrreAQ3Sntjtyu0I3yBsG+LWVSPSYAL/KxNM2xRhe6m4NfpzJBJqx/JHBqYj+ieSEb8xaE74mjlQkazNDPSyphvdvv39e9W/Cj1dxTASiB1SRlmR3JxXFIqBk1XbS/yhpvkYgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WEIGz5r6; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WEIGz5r6"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C4A5061026
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Jul 2024 21:26:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: 1.236
X-Spam-Level: *
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cYys4RRpCJFH for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Jul 2024 21:26:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::72b; helo=mail-qk1-x72b.google.com; envelope-from=ameryhung@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org D26E660EDF
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D26E660EDF
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=WEIGz5r6
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D26E660EDF
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Jul 2024 21:26:02 +0000 (UTC)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-79ef82c6391so13083285a.3
        for <virtualization@lists.linux-foundation.org>; Wed, 10 Jul 2024 14:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720646761; x=1721251561; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jcuXrJuADhlXXbo4cjnK+9NG13fjZ+fX0XEhslHQVp4=;
        b=WEIGz5r6Q2p/GkKnGQgmfnRtZZp51KpQFvVxEePQmW3Jnz1AIAW2FYs2pd9mmvYjvR
         TsyPavKnMK8OryEx5sHvEUWfs7QjbVY9BR5LvQnNvt4Tx6Nw6qbHK+wvhOwMM/a1cjsi
         9xQgSz/9f/t1fvyKefsGfBpQTDd03gWee7OxZ9TtuJJIF5hry4T5PyHNGQekPT2ADYfu
         n15dlAa96+aqJSq4kMy1NpJwU8/TAV04wSgbWXzGeYcxYE/lfptI6w3ZF8UuUgotlAeS
         SKKqcIf37txACk49QXWM5fpLXShlojSoWcLa3qInwGJHA/SL+cG2SMwVpPa73Ge98D37
         SfOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720646761; x=1721251561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jcuXrJuADhlXXbo4cjnK+9NG13fjZ+fX0XEhslHQVp4=;
        b=AdE04/fFTYRJ0PaYVqWt0wRXjv2cL2Ad2wrFjnbWdLEHtozNOyERGTroRHdrZ1ODE3
         Ky9HxrNfugyq1jyY1n4Tv/f5s7A1OUoJATFXjJIlu0cE+PLdicbr+b+sv8h9UlhDnHQH
         8CiN+Br96EX4prcl74/oHHx3iEbAzEuxTx1v9nINni9iAR94G9V3RbDTguTGMwTCGDjk
         SLKXYah/c6hI9yliafyrT+OfcHtbozYr5yEfdpIOSd7zClwjm0yQjJObOl9FmZRenHLt
         wQVrGfgUgC++qE7thiL50WE0WNctT0DFgVUt0qt9fsLNjwbWcW7OZYnPttjGa2GlM7oI
         9izw==
X-Forwarded-Encrypted: i=1; AJvYcCWrVCvtPWRE5Xg0+fNA6ZGf76XYgNIKLehJGLbRmvr7ZONcJPKUZAXBuZHtZeKa11ZvxQEVAgpp8NvSjt/8X1J90K14K5fPwZcQ8wX9NzV/nTDc9efYHO3h+w==
X-Gm-Message-State: AOJu0YzcbLbEBHFMs5J8eqmYzUBFZCLQv3BRGjkk+Bi6/CHDNmA8VZ04
	Khulu6AOdSmelDHRZ9DtDnyGTjoxUS0a+lCgun5n7lOW03BBp0rT
X-Google-Smtp-Source: AGHT+IFD1T5j41+YkZKjlX8tb+oypqzwGo0KjjclrVPhg6VzPZNTu72qGOLdEGcwfETG9bkgVsiXwg==
X-Received: by 2002:a05:620a:5604:b0:79d:6169:7ab9 with SMTP id af79cd13be357-79f19c083f0mr801584485a.68.1720646761611;
        Wed, 10 Jul 2024 14:26:01 -0700 (PDT)
Received: from n36-183-057.byted.org ([130.44.215.118])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79f190b0af1sm228791885a.122.2024.07.10.14.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 14:26:01 -0700 (PDT)
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
Subject: [RFC PATCH net-next v6 07/14] virtio/vsock: add common datagram send path
Date: Wed, 10 Jul 2024 21:25:48 +0000
Message-Id: <20240710212555.1617795-8-amery.hung@bytedance.com>
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

This commit implements the common function
virtio_transport_dgram_enqueue for enqueueing datagrams. It does not add
usage in either vhost or virtio yet.

Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
Signed-off-by: Amery Hung <amery.hung@bytedance.com>
---
 include/linux/virtio_vsock.h            |  1 +
 include/net/af_vsock.h                  |  2 +
 net/vmw_vsock/af_vsock.c                |  2 +-
 net/vmw_vsock/virtio_transport_common.c | 87 ++++++++++++++++++++++++-
 4 files changed, 90 insertions(+), 2 deletions(-)

diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index f749a066af46..4408749febd2 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -152,6 +152,7 @@ struct virtio_vsock_pkt_info {
 	u16 op;
 	u32 flags;
 	bool reply;
+	u8 remote_flags;
 };
 
 struct virtio_transport {
diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index 44db8f2c507d..6e97d344ac75 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -216,6 +216,8 @@ void vsock_for_each_connected_socket(struct vsock_transport *transport,
 				     void (*fn)(struct sock *sk));
 int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk);
 bool vsock_find_cid(unsigned int cid);
+const struct vsock_transport *vsock_dgram_lookup_transport(unsigned int cid,
+							   __u8 flags);
 
 struct vsock_skb_cb {
 	unsigned int src_cid;
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index ab08cd81720e..f83b655fdbe9 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -487,7 +487,7 @@ vsock_connectible_lookup_transport(unsigned int cid, __u8 flags)
 	return transport;
 }
 
-static const struct vsock_transport *
+const struct vsock_transport *
 vsock_dgram_lookup_transport(unsigned int cid, __u8 flags)
 {
 	const struct vsock_transport *transport;
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index a1c76836d798..46cd1807f8e3 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1040,13 +1040,98 @@ int virtio_transport_shutdown(struct vsock_sock *vsk, int mode)
 }
 EXPORT_SYMBOL_GPL(virtio_transport_shutdown);
 
+static int virtio_transport_dgram_send_pkt_info(struct vsock_sock *vsk,
+						struct virtio_vsock_pkt_info *info)
+{
+	u32 src_cid, src_port, dst_cid, dst_port;
+	const struct vsock_transport *transport;
+	const struct virtio_transport *t_ops;
+	struct sock *sk = sk_vsock(vsk);
+	struct virtio_vsock_hdr *hdr;
+	struct sk_buff *skb;
+	void *payload;
+	int noblock = 0;
+	int err;
+
+	info->type = virtio_transport_get_type(sk_vsock(vsk));
+
+	if (info->pkt_len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE)
+		return -EMSGSIZE;
+
+	transport = vsock_dgram_lookup_transport(info->remote_cid, info->remote_flags);
+	t_ops = container_of(transport, struct virtio_transport, transport);
+	if (unlikely(!t_ops))
+		return -EFAULT;
+
+	if (info->msg)
+		noblock = info->msg->msg_flags & MSG_DONTWAIT;
+
+	/* Use sock_alloc_send_skb to throttle by sk_sndbuf. This helps avoid
+	 * triggering the OOM.
+	 */
+	skb = sock_alloc_send_skb(sk, info->pkt_len + VIRTIO_VSOCK_SKB_HEADROOM,
+				  noblock, &err);
+	if (!skb)
+		return err;
+
+	skb_reserve(skb, VIRTIO_VSOCK_SKB_HEADROOM);
+
+	src_cid = t_ops->transport.get_local_cid();
+	src_port = vsk->local_addr.svm_port;
+	dst_cid = info->remote_cid;
+	dst_port = info->remote_port;
+
+	hdr = virtio_vsock_hdr(skb);
+	hdr->type	= cpu_to_le16(info->type);
+	hdr->op		= cpu_to_le16(info->op);
+	hdr->src_cid	= cpu_to_le64(src_cid);
+	hdr->dst_cid	= cpu_to_le64(dst_cid);
+	hdr->src_port	= cpu_to_le32(src_port);
+	hdr->dst_port	= cpu_to_le32(dst_port);
+	hdr->flags	= cpu_to_le32(info->flags);
+	hdr->len	= cpu_to_le32(info->pkt_len);
+
+	if (info->msg && info->pkt_len > 0) {
+		payload = skb_put(skb, info->pkt_len);
+		err = memcpy_from_msg(payload, info->msg, info->pkt_len);
+		if (err)
+			goto out;
+	}
+
+	trace_virtio_transport_alloc_pkt(src_cid, src_port,
+					 dst_cid, dst_port,
+					 info->pkt_len,
+					 info->type,
+					 info->op,
+					 info->flags,
+					 false);
+
+	return t_ops->send_pkt(skb);
+out:
+	kfree_skb(skb);
+	return err;
+}
+
 int
 virtio_transport_dgram_enqueue(struct vsock_sock *vsk,
 			       struct sockaddr_vm *remote_addr,
 			       struct msghdr *msg,
 			       size_t dgram_len)
 {
-	return -EOPNOTSUPP;
+	/* Here we are only using the info struct to retain style uniformity
+	 * and to ease future refactoring and merging.
+	 */
+	struct virtio_vsock_pkt_info info = {
+		.op = VIRTIO_VSOCK_OP_RW,
+		.remote_cid = remote_addr->svm_cid,
+		.remote_port = remote_addr->svm_port,
+		.remote_flags = remote_addr->svm_flags,
+		.msg = msg,
+		.vsk = vsk,
+		.pkt_len = dgram_len,
+	};
+
+	return virtio_transport_dgram_send_pkt_info(vsk, &info);
 }
 EXPORT_SYMBOL_GPL(virtio_transport_dgram_enqueue);
 
-- 
2.20.1

