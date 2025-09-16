Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DC92F3C1D
	for <virtualization@lists.linux.dev>; Tue, 16 Sep 2025 23:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758066241; cv=none; b=rOm/PXeMGjDPM9SK22Lc8RszUDBbCgHlwUMQSaC+6veS7Vq4jlvc+P4BI9A1o1pvX2sajoDX8nBN5DWdn2p7LfFG55AuHSZfa+dn6c90IcTYi/2YMdjY/nW/8dfqFSUPUTUCb0D+iAJv973/cmIXp8FlnYzGtTxsHEehmUkNiGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758066241; c=relaxed/simple;
	bh=EH9ooYSziv5KhjIFRNdY5bYLFFDgOaXRzl70F+kjAYk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pvt0qxXgWD66h/5zWfo+TaJqCxa3MgaS2Ml17YWVid60akVnF7BCLlus6/d97x54V2vu8jBCVeGajJP6kpXWnw4cU50W0ZvDca7tkjBX6XqzJHba/vIw6h3CJrmH2GOEMHIUpHQyg351oArtKJZgWuSXoj6XbcQmTMqG57WEdlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C8IkeHtx; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C8IkeHtx"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7762021c574so3666722b3a.0
        for <virtualization@lists.linux.dev>; Tue, 16 Sep 2025 16:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758066239; x=1758671039; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GVUMTjnbN6eX5riUEyr4WxlmQzTb3YpJ8a1+nr7efDY=;
        b=C8IkeHtxIsdt01D5SepPhSAcIX09FsDSGPqIMsdlX/oYfyZ+0m+Bpz9ZpUpm4Jpi4F
         IaFo1nAKXuIjnwzAK4aYxIeCDwOdWsmkJXhLxbt5h7wPoWspB/zbK/S1kKa6hAKLpgCp
         3wnm31xZnHrQppP72Xmg4UGZqhMKDk+gow10TSgeqNHfxQsleEpbAfVfk83Gq5vZgFKp
         JrsrwLHB2lmu+LjVusjC7bRrVR7+0cP5LUk5oegcPcdDq/OT3KCD9vrcboSOCmR5PE5g
         SzYgBxf30XqbTKlq/mYjLoHnJcr3vbg4u2l2LZSUbmCbtZAeKTrjBtD2YtbEtMcy9xM7
         30Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758066239; x=1758671039;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GVUMTjnbN6eX5riUEyr4WxlmQzTb3YpJ8a1+nr7efDY=;
        b=DAQTG95ngtBjjKCTQWrksrK5bVc1NTZEczm8w9QaIjKRucyz7hcrmEKqzp7xmE6U+y
         TarsjKmmtmJvbCWrh/D+WIhSbjPxO7utUG6QPmv4qpm4lSJ2wyaMN1AE5uAYc1jWDpNa
         eFS6mijNkfGRG8hMMJMjTs5PBEh7cHmAZbLsxruO6iYd2xKa3TcVrBviY8vUcX3uSSXF
         Icgp4Y055U+tE0TNMj3fBpGemZ7EhPilP/KYldZVhX2sZKPtAPKqpBLu6hL6XrKCtZPb
         Fl5GRadQ/ACGhesmpIV92epV7wKbydJpVJ1efYu+Z2v2Du3Bd8zL82kC4zFxE6Yo8tWC
         KVXA==
X-Gm-Message-State: AOJu0Ywk5OREsDfgtEGaNC1h5bXPpC5knC7ECxCMjHm0GRxTHiFieCNG
	vzsF5pe6wV7GOSbZEbdSR2SLB0tBglYQvXrYfXawQOh0UPw3DCI9DZDd
X-Gm-Gg: ASbGncsFP/n/Yr/tVWesFW+QiMeaR2HBEatf63aOMLAyEr9QnSOxJBP74BUbqtw6zWR
	8oEh+EGe+7eQquPFQKiBv1Lq1jFleFOVCp6ksk/INF3iat4jNSrXTHg8NgMgsgxgoahl+65/ozh
	weJkE6YNFVITMsokqzcWFTnMeOGomSeLiIYIvti0mvmycShM5+ZfexeBlbp+hlE1W4DtYCWunBM
	o3sPm95ErrJhr6Y5xw9LgjFMExoB4tPeK/3nqnUGbsk8eVjjD/EOwTuZ4h0CaUgpq0z8Q3wB4Sr
	umKPEdAhPUF3XFrb8Z55xsU9RuwKD4wdRdnJoyvPtnii4nUCCkV9EBgAj8aJm+iDQ3cQIwixjq6
	ppHU3ok0OMNowxjp5ILIMUU2KLUajrMBzXoauzjIM2g==
X-Google-Smtp-Source: AGHT+IHh73YIhkH04jOcSNkz8qf8UKgUb5SUQdLJktTvor8RNRMCdjI+LaMxqb5RVFwojQ7SBvQpvw==
X-Received: by 2002:a05:6a00:3e1a:b0:772:260f:d7b1 with SMTP id d2e1a72fcca58-77bf8c7796emr66050b3a.16.1758066239010;
        Tue, 16 Sep 2025 16:43:59 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:48::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-776210c4a5bsm11338744b3a.47.2025.09.16.16.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 16:43:58 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 16 Sep 2025 16:43:49 -0700
Subject: [PATCH net-next v6 5/9] vsock/virtio: add netns to virtio
 transport common
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-vsock-vmtest-v6-5-064d2eb0c89d@meta.com>
References: <20250916-vsock-vmtest-v6-0-064d2eb0c89d@meta.com>
In-Reply-To: <20250916-vsock-vmtest-v6-0-064d2eb0c89d@meta.com>
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
 net/vmw_vsock/virtio_transport_common.c | 18 ++++++++++++++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index ea955892488a..165157580cb8 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -196,6 +196,7 @@ struct virtio_vsock_pkt_info {
 	u32 remote_cid, remote_port;
 	struct vsock_sock *vsk;
 	struct msghdr *msg;
+	struct net *net;
 	u32 pkt_len;
 	u16 type;
 	u16 op;
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 1a9129e33d51..8a08a5103e7c 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -316,6 +316,11 @@ static struct sk_buff *virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *
 					 info->flags,
 					 zcopy);
 
+	virtio_vsock_skb_set_net(skb, info->net);
+
+	if (vsk)
+		virtio_vsock_skb_set_orig_net_mode(skb, vsk->orig_net_mode);
+
 	return skb;
 out:
 	kfree_skb(skb);
@@ -527,6 +532,7 @@ static int virtio_transport_send_credit_update(struct vsock_sock *vsk)
 	struct virtio_vsock_pkt_info info = {
 		.op = VIRTIO_VSOCK_OP_CREDIT_UPDATE,
 		.vsk = vsk,
+		.net = sock_net(sk_vsock(vsk)),
 	};
 
 	return virtio_transport_send_pkt_info(vsk, &info);
@@ -1067,6 +1073,7 @@ int virtio_transport_connect(struct vsock_sock *vsk)
 	struct virtio_vsock_pkt_info info = {
 		.op = VIRTIO_VSOCK_OP_REQUEST,
 		.vsk = vsk,
+		.net = sock_net(sk_vsock(vsk)),
 	};
 
 	return virtio_transport_send_pkt_info(vsk, &info);
@@ -1082,6 +1089,7 @@ int virtio_transport_shutdown(struct vsock_sock *vsk, int mode)
 			 (mode & SEND_SHUTDOWN ?
 			  VIRTIO_VSOCK_SHUTDOWN_SEND : 0),
 		.vsk = vsk,
+		.net = sock_net(sk_vsock(vsk)),
 	};
 
 	return virtio_transport_send_pkt_info(vsk, &info);
@@ -1108,6 +1116,7 @@ virtio_transport_stream_enqueue(struct vsock_sock *vsk,
 		.msg = msg,
 		.pkt_len = len,
 		.vsk = vsk,
+		.net = sock_net(sk_vsock(vsk)),
 	};
 
 	return virtio_transport_send_pkt_info(vsk, &info);
@@ -1145,6 +1154,7 @@ static int virtio_transport_reset(struct vsock_sock *vsk,
 		.op = VIRTIO_VSOCK_OP_RST,
 		.reply = !!skb,
 		.vsk = vsk,
+		.net = sock_net(sk_vsock(vsk)),
 	};
 
 	/* Send RST only if the original pkt is not a RST pkt */
@@ -1165,6 +1175,7 @@ static int virtio_transport_reset_no_sock(const struct virtio_transport *t,
 		.op = VIRTIO_VSOCK_OP_RST,
 		.type = le16_to_cpu(hdr->type),
 		.reply = true,
+		.net = virtio_vsock_skb_net(skb),
 	};
 	struct sk_buff *reply;
 
@@ -1465,6 +1476,7 @@ virtio_transport_send_response(struct vsock_sock *vsk,
 		.remote_port = le32_to_cpu(hdr->src_port),
 		.reply = true,
 		.vsk = vsk,
+		.net = sock_net(sk_vsock(vsk)),
 	};
 
 	return virtio_transport_send_pkt_info(vsk, &info);
@@ -1578,7 +1590,9 @@ static bool virtio_transport_valid_type(u16 type)
 void virtio_transport_recv_pkt(struct virtio_transport *t,
 			       struct sk_buff *skb)
 {
+	enum vsock_net_mode orig_net_mode = virtio_vsock_skb_orig_net_mode(skb);
 	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
+	struct net *net = virtio_vsock_skb_net(skb);
 	struct sockaddr_vm src, dst;
 	struct vsock_sock *vsk;
 	struct sock *sk;
@@ -1606,9 +1620,9 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 	/* The socket must be in connected or bound table
 	 * otherwise send reset back
 	 */
-	sk = vsock_find_connected_socket(&src, &dst, vsock_global_dummy_net());
+	sk = vsock_find_connected_socket(&src, &dst, net, orig_net_mode);
 	if (!sk) {
-		sk = vsock_find_bound_socket(&dst, vsock_global_dummy_net());
+		sk = vsock_find_bound_socket(&dst, net, orig_net_mode);
 		if (!sk) {
 			(void)virtio_transport_reset_no_sock(t, skb);
 			goto free_pkt;

-- 
2.47.3

