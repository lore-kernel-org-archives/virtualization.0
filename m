Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F259B25178C
	for <virtualization@lists.linux.dev>; Tue, 17 Jun 2025 04:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750134784; cv=none; b=DLLByBMaCHQzvUGljHDs65UtXIddVEcujPGw3PVK76ilaZkR6Te8+wyryCYJ5vN9giR75WL7mJx6PK6MR4eZ1ozXpWrT9HQSe1dQsFZwLOEJBTmmO/sTYfWTzDY6F4nSGsATzMZ1yJ7rVmzIH2Vma5Hva95YHwNMVcoEiKBxMEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750134784; c=relaxed/simple;
	bh=rWN+0kzz66BwYpbXVApft3NajZyjUkLvELDV5jgoh9Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jigAWAm/t4y3ySn0ThrB1T/7S2XAhg2WFaTs2wfcNUs4/g46cTqnIxgF8dDzSHiYoTe+SH8igtYT5DP73ewousQTwGV9zfQ181GJDGcuC5J+vxbQ8ANjM1EQHRGP8/a+7Bua8sFAO40uf/x+YLFw0AjDUrBlAj4QlOq5c6lPnGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kiLUG2n7; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kiLUG2n7"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-234f17910d8so48145575ad.3
        for <virtualization@lists.linux.dev>; Mon, 16 Jun 2025 21:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750134782; x=1750739582; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LclXjvFFmEwW0GFpupYPppfQlsjXKq5ckw5t+NfgedU=;
        b=kiLUG2n7a8SwjrZhnxYgRJB+E9DCrs7+zWG2EH6meWe4JV39PAA7SyvBqUe/V/+IHy
         C6QwYmRtyjlnwhKs0a0pOMTUplsQE12akbyXRHXxsKmlCewWQQskJk6ioZxdsCVig+so
         Cw97XR7HQiwuxxGUFCt+LxvUdbfk6AuP2y3PNPzySkpvvovXTPYQkBzJYQBNKI7DYM9U
         nMNzSNhMDr7PqGGoQ6n2nPeWRpe4W3aWR5ouj/IxnBszvBvUMIaUqvccIpqhq5MD+t7h
         t+WmwrLTnCNbBh/9vn6VXVKvGvtoKtGzuN1M6D4DnWBabwG3rCq7qhgqtms5INnlzaIs
         UzQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750134782; x=1750739582;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LclXjvFFmEwW0GFpupYPppfQlsjXKq5ckw5t+NfgedU=;
        b=Zs+mu6Fxqa9QTDCm1RfHxxRt0B1K6P6UYPMsOhu/2yzC1k9GhXpsDvha0yS+oZ8VO3
         kE6OlyktycpBGk69em8L/H+q5zx/qkRndSSkYbCzSekWJVA/E4w4BYfoMvzR+CCNEC60
         lxsP7ws/8Vg9geaXqY+rS9suTeId2rVEiDm7o6nYlzvUnw+UJkwXPkJYMYWRx0SFJg9y
         GsyRNsrikjUarQ3xO7vXVQCaI5GDDQ2jrC2DrXA6AOXWk4izccPsKRQlGuim9baokRyY
         zE+P/DtBSLlMw2sL+wA2B+SISagxebKmdTPgRHFMvDbKDBIQhPxp75J1AKOMgWh33lKI
         iHpA==
X-Forwarded-Encrypted: i=1; AJvYcCXMwQu72JqMKLSxOUpp203OENOmqK9aptrNlX9EjJkFxR2BXEY0Bmuatpk+bRel/MbhFzznvj6D8mOvQCIFkA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyE0ykqUcVTbgukaHhjqZIRmhwS4UED+tlLfncjwqBiFRK4YJfq
	AEw/9deFtbr9HaR/ygUsXIzNbSY7+83KVEQu916ioXq5nh4pYzjDsVuh
X-Gm-Gg: ASbGnctbpMTwQ5oZLHPQXtSGafoBIvpM7v7xBehkD2JtXQKQRIXZsGm/oXphUtqYB+A
	omn7x2ubXE5gmD02wIknSXspA/p+mAooWDrbraqqRSHihvT3hCu+/jK9jhC1p6DZYUldKI5mZPH
	PWJBbH/meRFZpWi/KCwiypqLg3+vcTgJUMchEg0uBnx1A2TJykj5kr6BL3tJe/amjcy3DHjad8+
	kS9T4pKH1GvuvDLWPDpxlrhS0uqV5GrpuOL6bHKgqDzh0POYIk/KgJwZpMELIhIp49rCKuTkhCl
	7+K1EN1hUm9m6bhBQBPL3Qipa8jpq05rqO+ROyyKxgv9zFLtmQ/dMg0B/DRrqkFOudXz+co=
X-Google-Smtp-Source: AGHT+IFfHIKMTehJBbHbzXm+VgitB5C8K3/zKbjZaoAyzCeAaD3PR/+OGHYbSxWh4cZBh7ugMRypPw==
X-Received: by 2002:a17:902:ce8d:b0:235:f3df:bbff with SMTP id d9443c01a7336-2366b00163dmr182222645ad.4.1750134782256;
        Mon, 16 Jun 2025 21:33:02 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:74::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-313fcae18e1sm1521189a91.0.2025.06.16.21.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 21:33:01 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Mon, 16 Jun 2025 21:32:55 -0700
Subject: [PATCH RFC net-next v4 06/11] virtio-vsock: add netns to common
 code
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250616-vsock-vmtest-v4-6-bdd1659c33fb@meta.com>
References: <20250616-vsock-vmtest-v4-0-bdd1659c33fb@meta.com>
In-Reply-To: <20250616-vsock-vmtest-v4-0-bdd1659c33fb@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: kvm@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add support to the virtio common code for passing around net namespace
pointers (tx and rx). The series still requires non-common transport
support to be added by future patches.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 include/linux/virtio_vsock.h            |  1 +
 net/vmw_vsock/virtio_transport_common.c | 14 ++++++++++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index 93edc1e798a5..81355f84b76c 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -160,6 +160,7 @@ struct virtio_vsock_pkt_info {
 	u32 remote_cid, remote_port;
 	struct vsock_sock *vsk;
 	struct msghdr *msg;
+	struct net *net;
 	u32 pkt_len;
 	u16 type;
 	u16 op;
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 1b5d9896edae..310f2e92c527 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -313,6 +313,8 @@ static struct sk_buff *virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *
 					 info->flags,
 					 zcopy);
 
+	virtio_vsock_skb_set_net(skb, info->net);
+
 	return skb;
 out:
 	kfree_skb(skb);
@@ -524,6 +526,7 @@ static int virtio_transport_send_credit_update(struct vsock_sock *vsk)
 	struct virtio_vsock_pkt_info info = {
 		.op = VIRTIO_VSOCK_OP_CREDIT_UPDATE,
 		.vsk = vsk,
+		.net = sock_net(sk_vsock(vsk)),
 	};
 
 	return virtio_transport_send_pkt_info(vsk, &info);
@@ -1064,6 +1067,7 @@ int virtio_transport_connect(struct vsock_sock *vsk)
 	struct virtio_vsock_pkt_info info = {
 		.op = VIRTIO_VSOCK_OP_REQUEST,
 		.vsk = vsk,
+		.net = sock_net(sk_vsock(vsk)),
 	};
 
 	return virtio_transport_send_pkt_info(vsk, &info);
@@ -1079,6 +1083,7 @@ int virtio_transport_shutdown(struct vsock_sock *vsk, int mode)
 			 (mode & SEND_SHUTDOWN ?
 			  VIRTIO_VSOCK_SHUTDOWN_SEND : 0),
 		.vsk = vsk,
+		.net = sock_net(sk_vsock(vsk)),
 	};
 
 	return virtio_transport_send_pkt_info(vsk, &info);
@@ -1105,6 +1110,7 @@ virtio_transport_stream_enqueue(struct vsock_sock *vsk,
 		.msg = msg,
 		.pkt_len = len,
 		.vsk = vsk,
+		.net = sock_net(sk_vsock(vsk)),
 	};
 
 	return virtio_transport_send_pkt_info(vsk, &info);
@@ -1142,6 +1148,7 @@ static int virtio_transport_reset(struct vsock_sock *vsk,
 		.op = VIRTIO_VSOCK_OP_RST,
 		.reply = !!skb,
 		.vsk = vsk,
+		.net = sock_net(sk_vsock(vsk)),
 	};
 
 	/* Send RST only if the original pkt is not a RST pkt */
@@ -1162,6 +1169,7 @@ static int virtio_transport_reset_no_sock(const struct virtio_transport *t,
 		.op = VIRTIO_VSOCK_OP_RST,
 		.type = le16_to_cpu(hdr->type),
 		.reply = true,
+		.net = virtio_vsock_skb_net(skb),
 	};
 	struct sk_buff *reply;
 
@@ -1462,6 +1470,7 @@ virtio_transport_send_response(struct vsock_sock *vsk,
 		.remote_port = le32_to_cpu(hdr->src_port),
 		.reply = true,
 		.vsk = vsk,
+		.net = sock_net(sk_vsock(vsk)),
 	};
 
 	return virtio_transport_send_pkt_info(vsk, &info);
@@ -1576,6 +1585,7 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 			       struct sk_buff *skb)
 {
 	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
+	struct net *net = virtio_vsock_skb_net(skb);
 	struct sockaddr_vm src, dst;
 	struct vsock_sock *vsk;
 	struct sock *sk;
@@ -1603,9 +1613,9 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 	/* The socket must be in connected or bound table
 	 * otherwise send reset back
 	 */
-	sk = vsock_find_connected_socket(&src, &dst);
+	sk = vsock_find_connected_socket(&src, &dst, net);
 	if (!sk) {
-		sk = vsock_find_bound_socket(&dst);
+		sk = vsock_find_bound_socket(&dst, net);
 		if (!sk) {
 			(void)virtio_transport_reset_no_sock(t, skb);
 			goto free_pkt;

-- 
2.47.1

