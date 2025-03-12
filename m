Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138421EF0B9
	for <virtualization@lists.linux.dev>; Wed, 12 Mar 2025 20:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741813184; cv=none; b=eIyizqu8L6xvMqXncIjDMzCUi84dTQdAtOU8MlY2tBua7MkEswQOQ7q5h69UH+m72G6bIWZZkAbdbv5Fd0mpGbVf9tDPyEWHiveH10Z2pAnPJjUEPmm9tti7mgrAeCDJ3QfGWHuCDZE408lrax7mmShiL50dLejEI6GF+Ogzktg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741813184; c=relaxed/simple;
	bh=jSOiqzU7LgYk7s3hBpAEWXR6XXPObJfDqvsKHjg2btI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XyAQEwIhkSNHD6RxcwY7wdUeKSBQNnuEk3fCfC0RYT8qVxJDAw8Nnq3UQrPNSoVtnSz/RKzA+QDWX8kLd9YdP5StDpIvVFcXMIdXLbyC8nnktwo/6PE1sa3qsvz/x9BMqYm65zWM5h11kwcCGBBQHfghn+ePJUo3gHYTh1gPQos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gQfTqjwD; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQfTqjwD"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22185cddbffso26286315ad.1
        for <virtualization@lists.linux.dev>; Wed, 12 Mar 2025 13:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741813182; x=1742417982; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NkAj1CKS6gC9G4Byz4nHeWNr5VsXbnbcZlq4lVa0Tbo=;
        b=gQfTqjwD1jAuTdJXVgLpfkqmWIZATQFVs7thhS8aEih4BfpcIrUquzreLry81YJ9EP
         Yh4WOHtiKOsVXWikQGdEfv1GJaOIYfnSf98YFDUvbrUg0nkqoPahFIk9yHwf2/e46sDm
         5kFEkImtoJI8A0vMOTrQsngpmKQr/0YTvS3bQXS8X8P13970U1h+sCXjfIID3NoN8ueD
         sTxo+oWxZNfuEaXi2QqDbgvuBSySYqAafTClvvZt8ftEBsQlSIFS8Gx6SV8+avhm8cFJ
         1MoE93yPem4lapfyvuGzznTZ0x7XVqyG2+YDXoP7ILAc62XXEbYPyAJLqNSYwlHudBDW
         ZeYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741813182; x=1742417982;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NkAj1CKS6gC9G4Byz4nHeWNr5VsXbnbcZlq4lVa0Tbo=;
        b=ZlcFO98MF34p9q11OSgE2jqjNvLXklHSiwOsGejfq4UaOsjELNvnF0QEVNuuZd7djd
         uIhH2zhAjcoVdRSa2KrZUDNcEDnjMCr9R28N/q2V8Tzr7h72QvaZSF6bxVNJmH5Hq7qP
         L77HRDVe8QYFi3vVH/QCW3d2+zWz4o/RX3FTWl75llXUC8twPBZFnx77c37VN4i1JKio
         376VvwfRBCr7lkhxfGVz8wioRxOgdnmz0MEnd5FNDdbZmUSBp3SSsKMjJVYKUXCYSeLZ
         tGzEPUsrXf60zV3/7GDZ5i9V7Ml7vZYC+NM13Sz5BXapDUb/0N51NFOS6DVXNcMud7nu
         q80w==
X-Forwarded-Encrypted: i=1; AJvYcCWRjn744tOtqQRJsLuHf5umDXen4tnxKzkkWlZeGsPirJt/FttRquphlM5Pn3DFjlOqXA8h4d7rTHiXl9Qa4A==@lists.linux.dev
X-Gm-Message-State: AOJu0YyCCvcjndLeVSLS2GLp8A2i1DjoNfJmFtZgoJYQ5qKNOKnThF94
	kRKCGriOK0f2kq0TQJWXSY0fvV8AyfA4+gysSICy59bs6NTtY4CC
X-Gm-Gg: ASbGncvDUWNAPtV5aYJ8Y17P6a8ZVkfLSQTuPV396WRV5/JttXDBdqMrCARE4xd0qbz
	scVQH20T4HB8PjZdXmyTkAV5hGA3LLOowFTeaX/LpJjHPBm3GzYIHroiXK94qKvjEOHhXaLBDBu
	DN1DZbyyHhrie5zclHTAq/B2sEN0sSgT3XB5XBOfSsE4kYebx/7gJWvJg4O8x4F0PWkfjR+vkRl
	YaaM7nL2atTyqgDZsSkYk+wiskRzNdD/Z2WIcizlhKPmlvTiePclHhg3Qq9AKYQYpIRGROgZoAF
	brCsfeDI5dP5uArRTCtbTmmnrZfHdnd3GCEBkhSKgw==
X-Google-Smtp-Source: AGHT+IG2WeNoJMTPTLJVZix48mNFgtFi81bCQiANCHHziaLLADPcNI7nV831oKin4G0DythBHW6eVg==
X-Received: by 2002:a05:6a00:3c96:b0:736:3ea8:4813 with SMTP id d2e1a72fcca58-737106ec2fbmr40172b3a.2.1741813182223;
        Wed, 12 Mar 2025 13:59:42 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:6::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736b9fe8655sm9773862b3a.2.2025.03.12.13.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 13:59:41 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 12 Mar 2025 13:59:36 -0700
Subject: [PATCH v2 2/3] vsock/virtio_transport_common: handle netns of
 received packets
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-vsock-netns-v2-2-84bffa1aa97a@gmail.com>
References: <20250312-vsock-netns-v2-0-84bffa1aa97a@gmail.com>
In-Reply-To: <20250312-vsock-netns-v2-0-84bffa1aa97a@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 Jakub Kicinski <kuba@kernel.org>, "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Bryan Tan <bryan-bt.tan@broadcom.com>, 
 Vishnu Dasa <vishnu.dasa@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: "David S. Miller" <davem@davemloft.net>, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hyperv@vger.kernel.org, kvm@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@gmail.com>
X-Mailer: b4 0.14.2

From: Stefano Garzarella <sgarzare@redhat.com>

This patch allows transports that use virtio_transport_common
to specify the network namespace where a received packet is to
be delivered.

virtio_transport and vhost_transport, for now, still do not use this
capability and preserve old behavior.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Bobby Eshleman <bobbyeshleman@gmail.com>
---
V1 -> V2
 * use vsock_global_net()
 * add net to skb->cb
 * forward port for skb
---
 drivers/vhost/vsock.c                   |  1 +
 include/linux/virtio_vsock.h            |  2 ++
 net/vmw_vsock/virtio_transport.c        |  1 +
 net/vmw_vsock/virtio_transport_common.c | 11 ++++++++++-
 4 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 802153e230730bdbfbbb6f4ae263ae99502ef532..02e2a3551205a4398a74a167a82802d950c962f6 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -525,6 +525,7 @@ static void vhost_vsock_handle_tx_kick(struct vhost_work *work)
 			continue;
 		}
 
+		VIRTIO_VSOCK_SKB_CB(skb)->net = vsock_global_net();
 		total_len += sizeof(*hdr) + skb->len;
 
 		/* Deliver to monitoring devices all received packets */
diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index 0387d64e2c66c69dd7ab0cad58db5cf0682ad424..e51f89559a1d92685027bf83a62c7b05dd9e566d 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -12,6 +12,7 @@
 struct virtio_vsock_skb_cb {
 	bool reply;
 	bool tap_delivered;
+	struct net *net;
 	u32 offset;
 };
 
@@ -148,6 +149,7 @@ struct virtio_vsock_pkt_info {
 	u32 remote_cid, remote_port;
 	struct vsock_sock *vsk;
 	struct msghdr *msg;
+	struct net *net;
 	u32 pkt_len;
 	u16 type;
 	u16 op;
diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index f0e48e6911fc46cba87f7dafeb8dbc21421df254..163ddfc0808529ad6dda7992f9ec48837dd7337c 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -650,6 +650,7 @@ static void virtio_transport_rx_work(struct work_struct *work)
 
 			virtio_vsock_skb_rx_put(skb);
 			virtio_transport_deliver_tap_pkt(skb);
+			VIRTIO_VSOCK_SKB_CB(skb)->net = vsock_global_net();
 			virtio_transport_recv_pkt(&virtio_transport, skb);
 		}
 	} while (!virtqueue_enable_cb(vq));
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 256d2a4fe482b3cb938a681b6924be69b2065616..028591a5863b84059b8e8bbafd499cb997a0c863 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -314,6 +314,8 @@ static struct sk_buff *virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *
 					 info->flags,
 					 zcopy);
 
+	VIRTIO_VSOCK_SKB_CB(skb)->net = info->net;
+
 	return skb;
 out:
 	kfree_skb(skb);
@@ -523,6 +525,7 @@ static int virtio_transport_send_credit_update(struct vsock_sock *vsk)
 	struct virtio_vsock_pkt_info info = {
 		.op = VIRTIO_VSOCK_OP_CREDIT_UPDATE,
 		.vsk = vsk,
+		.net = sock_net(sk_vsock(vsk)),
 	};
 
 	return virtio_transport_send_pkt_info(vsk, &info);
@@ -1061,6 +1064,7 @@ int virtio_transport_connect(struct vsock_sock *vsk)
 	struct virtio_vsock_pkt_info info = {
 		.op = VIRTIO_VSOCK_OP_REQUEST,
 		.vsk = vsk,
+		.net = sock_net(sk_vsock(vsk)),
 	};
 
 	return virtio_transport_send_pkt_info(vsk, &info);
@@ -1076,6 +1080,7 @@ int virtio_transport_shutdown(struct vsock_sock *vsk, int mode)
 			 (mode & SEND_SHUTDOWN ?
 			  VIRTIO_VSOCK_SHUTDOWN_SEND : 0),
 		.vsk = vsk,
+		.net = sock_net(sk_vsock(vsk)),
 	};
 
 	return virtio_transport_send_pkt_info(vsk, &info);
@@ -1102,6 +1107,7 @@ virtio_transport_stream_enqueue(struct vsock_sock *vsk,
 		.msg = msg,
 		.pkt_len = len,
 		.vsk = vsk,
+		.net = sock_net(sk_vsock(vsk)),
 	};
 
 	return virtio_transport_send_pkt_info(vsk, &info);
@@ -1139,6 +1145,7 @@ static int virtio_transport_reset(struct vsock_sock *vsk,
 		.op = VIRTIO_VSOCK_OP_RST,
 		.reply = !!skb,
 		.vsk = vsk,
+		.net = sock_net(sk_vsock(vsk)),
 	};
 
 	/* Send RST only if the original pkt is not a RST pkt */
@@ -1159,6 +1166,7 @@ static int virtio_transport_reset_no_sock(const struct virtio_transport *t,
 		.op = VIRTIO_VSOCK_OP_RST,
 		.type = le16_to_cpu(hdr->type),
 		.reply = true,
+		.net = VIRTIO_VSOCK_SKB_CB(skb)->net,
 	};
 	struct sk_buff *reply;
 
@@ -1476,6 +1484,7 @@ virtio_transport_send_response(struct vsock_sock *vsk,
 		.remote_port = le32_to_cpu(hdr->src_port),
 		.reply = true,
 		.vsk = vsk,
+		.net = sock_net(sk_vsock(vsk)),
 	};
 
 	return virtio_transport_send_pkt_info(vsk, &info);
@@ -1590,7 +1599,7 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 			       struct sk_buff *skb)
 {
 	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
-	struct net *net = vsock_global_net();
+	struct net *net = VIRTIO_VSOCK_SKB_CB(skb)->net;
 	struct sockaddr_vm src, dst;
 	struct vsock_sock *vsk;
 	struct sock *sk;

-- 
2.47.1

