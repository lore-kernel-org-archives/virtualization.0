Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A0820E03F
	for <virtualization@lists.linux.dev>; Thu, 28 Aug 2025 00:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756341103; cv=none; b=ReNUcXE6fhO7vXXGPW6pq3lfzwo4cecHBWVSSIZA2RSXhXgnRo3i95afjpd78FQIPvtlEyZepY7hfVDzmN+Xz0fkpkqLz4n9ld1uTpV5FMmHYEtPaeGbpMzrkM/Z6bH76S1fCan0/GPQQgyCD21HMF1Lw30Q2Mna4u+zI7ECSLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756341103; c=relaxed/simple;
	bh=XcqxKWbcR9R+GFEDVaS469hmzOI/5gU8TKoZ33SLMAM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ikpFBx0UHyeKxZkpkUBLx6UatHAxqyOcvJlcvKTF1QRhJlhLlYJoJo0Js7BKB9Mb+vLQ92G8ef7NibwNio7tx0Nm9T7eDDG5mnkoPxCrJT5KWy3VsLxJE3GctwjfHzwqM/JuQJcmLhbJQJ8pAUBYlOtSBEndbw12YTw8Q55G+yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FeJRYjl6; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FeJRYjl6"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-244582738b5so3892815ad.3
        for <virtualization@lists.linux.dev>; Wed, 27 Aug 2025 17:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756341101; x=1756945901; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UNMRyhXc58NJQADKxcGV3IzP2b9a+EmxeUKj/JoKFFQ=;
        b=FeJRYjl6mErc3SswRmm/m2CuO+trrB9wC/nqxOoH3bM/bWV8KV+TjeXj6ayMNh1NeV
         hLBWRShk/haxX/0CMD2wfHijKVcRvMstoSZyf3qOGzh9LXgncR2fevP69YAtHwl/Y8fx
         fDqJCni+JrE+3UK8nX1KA9Zy2p7R4RUJXW3lOpJQcEFuA5Ryx7PiDzCpdNwdAI0AQWD1
         52c9dqZtYGPrxh1x55bRwWfxXqVb/+S2k6jeTeMca6sMIOZ/8dZsGt5od7tIemv7TR7D
         Xv+q34fJ4j8n9aNldTmGus1bexdeVCkT+Dcw2RFC+E6ebgcgjjQWsyVtIUsnCEyvCa00
         fo/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756341101; x=1756945901;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UNMRyhXc58NJQADKxcGV3IzP2b9a+EmxeUKj/JoKFFQ=;
        b=LqycJcL1Cfo3FHExmTxBsciemV8NJQrNzXjal+UZmNVWxDhrK0OMNAdpFadjjaBnf3
         NZlqD4FC/20Tx1v7EOYyzdjMisg6lzn+/Pe0kfmuG4E+xPkmXnsplZkKNLGWLjtEpUwI
         mR4TJ7xY0Xs41zD3BO7rpZc62hlUuYIDCMrhQpDwegwojkuqkBV4Y2z4X9KJRvLUHlXE
         wkRkX76P5ySoOpf0Zy09J6YEM0Ef0eB5lx/wTsWnoBGHkSDbynT7ajb3jDM2HFvraAEV
         3sfmjZXCBtithXTxk1AdJdFzlWKYY8dYcnBJmlMsRerl+XV0ZIZQ/2zyR6skheBHlGo1
         B2bA==
X-Gm-Message-State: AOJu0YxaPXt9qy/BZuWsPExplGLsrK+OKZ0nPjgSU5eDiZDO1QDCj+U0
	5VuVxoWHi5gTXBxsPGQ5uZnncoilQ8QwD0M01CuJ5MdC9zrTRbJ40gPp
X-Gm-Gg: ASbGnctIMx4azokpYjT1JToBRUdR9nNY3xJBznmndX4BCT256NkLoyWh8Wx07V/3N/z
	OSR68nWeGKxKKSHhHFxN18G2MUnHExwQls/GZ6YizBnP1awtYB3JnNdc3lcZ3JqY36t4pEfT5BW
	ow8v24uYUIfeADSnmtxaT67Wnx8+2B4fez9nR8cwi1pkuitxLXW/0kO6bcaLz8u7GtJF+yG8Krs
	ZGvimn7MesCQwfegU4KgNaRtUc8lQMLfJCM4QIUh5BLV4rfctI1XY84hBu+vVrYXCA0djE62Yvi
	qB4i/R3UgPxbPZd8y9UKFqNy7feha8OL8ugZdUilMyu1/Yc2Wsad8cE4/aX4D9pKL8e402kS/yW
	zI1TfkXQGN8Bxb1r+MCMFn/mXrvreick=
X-Google-Smtp-Source: AGHT+IFjSJ3lNQyXihNLyzpDRLaKGYXU6ozW/kmFwiBYAHcnoyr5/NLuHTzQ3rWReb04ry+yDvDZSA==
X-Received: by 2002:a17:903:1ae4:b0:245:f7f3:6760 with SMTP id d9443c01a7336-2462efb1aa9mr236094525ad.55.1756341100823;
        Wed, 27 Aug 2025 17:31:40 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:47::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24668880260sm132633545ad.128.2025.08.27.17.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 17:31:39 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 27 Aug 2025 17:31:33 -0700
Subject: [PATCH net-next v5 5/9] vsock/virtio: add netns to virtio
 transport common
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250827-vsock-vmtest-v5-5-0ba580bede5b@meta.com>
References: <20250827-vsock-vmtest-v5-0-0ba580bede5b@meta.com>
In-Reply-To: <20250827-vsock-vmtest-v5-0-0ba580bede5b@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
 Vishnu Dasa <vishnu.dasa@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, berrange@redhat.com, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add support to the virtio-vsock common code for passing around net
namespace pointers (tx and rx). The series still requires vhost/virtio
transport support to be added by future patches.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 include/linux/virtio_vsock.h            |  1 +
 net/vmw_vsock/virtio_transport_common.c | 14 ++++++++++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index c547cda7196b..ce6d15eede9c 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -184,6 +184,7 @@ struct virtio_vsock_pkt_info {
 	u32 remote_cid, remote_port;
 	struct vsock_sock *vsk;
 	struct msghdr *msg;
+	struct net *net;
 	u32 pkt_len;
 	u16 type;
 	u16 op;
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 9b3aa4f0395d..7b566c8f8082 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -314,6 +314,8 @@ static struct sk_buff *virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *
 					 info->flags,
 					 zcopy);
 
+	virtio_vsock_skb_set_net(skb, info->net);
+
 	return skb;
 out:
 	kfree_skb(skb);
@@ -525,6 +527,7 @@ static int virtio_transport_send_credit_update(struct vsock_sock *vsk)
 	struct virtio_vsock_pkt_info info = {
 		.op = VIRTIO_VSOCK_OP_CREDIT_UPDATE,
 		.vsk = vsk,
+		.net = sock_net(sk_vsock(vsk)),
 	};
 
 	return virtio_transport_send_pkt_info(vsk, &info);
@@ -1065,6 +1068,7 @@ int virtio_transport_connect(struct vsock_sock *vsk)
 	struct virtio_vsock_pkt_info info = {
 		.op = VIRTIO_VSOCK_OP_REQUEST,
 		.vsk = vsk,
+		.net = sock_net(sk_vsock(vsk)),
 	};
 
 	return virtio_transport_send_pkt_info(vsk, &info);
@@ -1080,6 +1084,7 @@ int virtio_transport_shutdown(struct vsock_sock *vsk, int mode)
 			 (mode & SEND_SHUTDOWN ?
 			  VIRTIO_VSOCK_SHUTDOWN_SEND : 0),
 		.vsk = vsk,
+		.net = sock_net(sk_vsock(vsk)),
 	};
 
 	return virtio_transport_send_pkt_info(vsk, &info);
@@ -1106,6 +1111,7 @@ virtio_transport_stream_enqueue(struct vsock_sock *vsk,
 		.msg = msg,
 		.pkt_len = len,
 		.vsk = vsk,
+		.net = sock_net(sk_vsock(vsk)),
 	};
 
 	return virtio_transport_send_pkt_info(vsk, &info);
@@ -1143,6 +1149,7 @@ static int virtio_transport_reset(struct vsock_sock *vsk,
 		.op = VIRTIO_VSOCK_OP_RST,
 		.reply = !!skb,
 		.vsk = vsk,
+		.net = sock_net(sk_vsock(vsk)),
 	};
 
 	/* Send RST only if the original pkt is not a RST pkt */
@@ -1163,6 +1170,7 @@ static int virtio_transport_reset_no_sock(const struct virtio_transport *t,
 		.op = VIRTIO_VSOCK_OP_RST,
 		.type = le16_to_cpu(hdr->type),
 		.reply = true,
+		.net = virtio_vsock_skb_net(skb),
 	};
 	struct sk_buff *reply;
 
@@ -1463,6 +1471,7 @@ virtio_transport_send_response(struct vsock_sock *vsk,
 		.remote_port = le32_to_cpu(hdr->src_port),
 		.reply = true,
 		.vsk = vsk,
+		.net = sock_net(sk_vsock(vsk)),
 	};
 
 	return virtio_transport_send_pkt_info(vsk, &info);
@@ -1577,6 +1586,7 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 			       struct sk_buff *skb)
 {
 	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
+	struct net *net = virtio_vsock_skb_net(skb);
 	struct sockaddr_vm src, dst;
 	struct vsock_sock *vsk;
 	struct sock *sk;
@@ -1604,9 +1614,9 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 	/* The socket must be in connected or bound table
 	 * otherwise send reset back
 	 */
-	sk = vsock_find_connected_socket(&src, &dst, vsock_global_dummy_net());
+	sk = vsock_find_connected_socket(&src, &dst, net);
 	if (!sk) {
-		sk = vsock_find_bound_socket(&dst, vsock_global_dummy_net());
+		sk = vsock_find_bound_socket(&dst, net);
 		if (!sk) {
 			(void)virtio_transport_reset_no_sock(t, skb);
 			goto free_pkt;

-- 
2.47.3

