Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9052D248B
	for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 23:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761090429; cv=none; b=h6Nm7xboO5RFJ7efXNfskF1dtu2JFy6wimvWPR9za6IPurMfQKHzaAWtjDzPm6U/t36zuxfIvKwPjxvSJhDt7ePd5v9Cv6ivvZ32fdSCxg0GgpxfMnoHXSzWgKzNZtayJsihRAiXCKZ6lhGacyfjm/sQ01sIDmuhMwdO01EEEZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761090429; c=relaxed/simple;
	bh=vT+Tq/xDspn4kgfcPG0WM13a7POPaOaQ9NQCIKNs450=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mBVYCSVBB8VcugNs33swcM+RkaqcPHDO5W8krsJPyz56JD7x5wMAmGi+hyDC7bKLhrfcyORtiVDLec96QRbiOGDfNkwbJpEPUP9pEakujJ5HaH20C2Y8d9W39so1ilfNAeJbvAMdGwMm5HJrC4vypAJOg8Groi/Yq/BMAsWbOd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KFYluSTh; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KFYluSTh"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-27d4d6b7ab5so81546555ad.2
        for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 16:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761090425; x=1761695225; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bXXMjozyE7G9hxBpLov8fPEzcD6yFRLl/EC2MbvXbp0=;
        b=KFYluSThv6hOL99DkPJ+J2rP1MmNdXQseLhRQ+/q16UWCY0sGc+Yiu7Hjuz/qpBIPY
         s4QnNQasrOes/wLFFGtsXUfiOfD2UOE4FQMilujR7vm2JWPB4JAfW7V5cWsU24Ehw5pS
         OVAc5TJ/HfJcMWPam8mV2fhFm+MOLwJjkZEwAA2tjHP6xLLKZL7CorLn4WwGC+sMAuI9
         wrjYto1tGjMxTgQ5tjbyu2vQOQDd1h5swMpYORtewFS6FM1IsZ0q6AzfJ2WNj0jehkmW
         WLLGQxhiAoE6fJDqo+/bQy5CBInQVQLRMY1UZnVGuGz7W4T3MsiZMz5yuk9dVZ2imgrz
         6ZEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761090425; x=1761695225;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bXXMjozyE7G9hxBpLov8fPEzcD6yFRLl/EC2MbvXbp0=;
        b=QL0VQKnJH4MnsTVcK0vdPoJZpVfQ0jo4ELjz+J05PtLyoWhlVUx9FiX+Nhdto6FgYq
         LC9L/WW1tbrl/eoMFUM/xXNB2hLGcJqALiN23sMDB0f6AYGo8/OlEycg3PZgyTr/5Euf
         KvONSYfRHjJmuPSfirBF5qyMJg2qwWos4bRwzA0Rzm5Sni+ta+cmEsLIel3xmSbEyxgd
         Y+0wFckxtN4d9B4iAzfMKuDJ/+qDYMrCsWnvfE1cFxxt7xCaHiIhq+tsXkt59mMvRRAJ
         cLk+oTF32iTRAzMctEicYPx3QaBqA/3lSreYcQPgaT2zvsmWAcQco1uzccp+TiMLnTlW
         ek+w==
X-Gm-Message-State: AOJu0Yy7Mma8kH0Vy6gMIB19rzaGU0l/DvQtSJ6Rhai8ySyZdN1BIx7e
	+4iUeMjyftUk0ALo9YD4JAbdG5YzSBIe3+YYhf8lkFXkMqG70y/ul5ig
X-Gm-Gg: ASbGncs841vK+Bafl0PeP0BGM8nz/orBCCFADmGIvL1A/N/VB7cAGRBGJRFrsQ+imXV
	hyJy1ejRG0UOeM0VR3prMTBDuqGMnvMJp5LT1UfCcvN7ET8yOpvET2YgGVq8lHDFVj2toWimfMd
	lbBdV9o2BbQAffA0ZO4qW1q0ggc9I1AP/+otutYzE7Z1GnvokRohlbJxRRiYD7kYdJWJm7IQIS8
	epluw9nI519g4Kz0QrCBE1E2M9SlCQ+Z3mJRwxeEd22RO2WHdSi1fILm2Olnj8sqYVTJLXg447h
	5nAESp9xp4YO7NihOtwpdg26tFnEB1dy2hTeFfQTL2SvAwrbJLY7dHGIFGYbo+90F+uim0gfrBp
	Yc+Mh8NzX2mOBSKz7pfCPPeX4Z4Y/JT1EX+OYDcZFePBd36KmDlaRCBO9CfOj69ydVRTYEgIIyB
	c8nBfILZdP
X-Google-Smtp-Source: AGHT+IGisn1W6av3z2asOwJINc4Pm13WD84loloJNSHettssMRmm84ISrxessn3f1FRQqEXghoDjxg==
X-Received: by 2002:a17:902:d584:b0:290:bd1b:cb3d with SMTP id d9443c01a7336-290c9ce67c0mr235162115ad.27.1761090424797;
        Tue, 21 Oct 2025 16:47:04 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:71::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292472197desm120682725ad.115.2025.10.21.16.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 16:47:04 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 21 Oct 2025 16:46:49 -0700
Subject: [PATCH net-next v7 06/26] vsock/virtio: add netns to virtio
 transport common
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-vsock-vmtest-v7-6-0661b7b6f081@meta.com>
References: <20251021-vsock-vmtest-v7-0-0661b7b6f081@meta.com>
In-Reply-To: <20251021-vsock-vmtest-v7-0-0661b7b6f081@meta.com>
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
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, berrange@redhat.com, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add support to the virtio-vsock common code for passing around net
namespace pointers (tx and rx). The series still requires vhost/virtio
transport support to be added by future patches.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v7:
- add comment explaining the !vsk case in virtio_transport_alloc_skb()
---
 include/linux/virtio_vsock.h            |  1 +
 net/vmw_vsock/virtio_transport_common.c | 21 +++++++++++++++++++--
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index 29290395054c..f90646f82993 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -217,6 +217,7 @@ struct virtio_vsock_pkt_info {
 	u32 remote_cid, remote_port;
 	struct vsock_sock *vsk;
 	struct msghdr *msg;
+	struct net *net;
 	u32 pkt_len;
 	u16 type;
 	u16 op;
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index dcc8a1d5851e..b8e52c71920a 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -316,6 +316,15 @@ static struct sk_buff *virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *
 					 info->flags,
 					 zcopy);
 
+	/*
+	 * If there is no corresponding socket, then we don't have a
+	 * corresponding namespace. This only happens For VIRTIO_VSOCK_OP_RST.
+	 */
+	if (vsk) {
+		virtio_vsock_skb_set_net(skb, info->net);
+		virtio_vsock_skb_set_net_mode(skb, vsk->net_mode);
+	}
+
 	return skb;
 out:
 	kfree_skb(skb);
@@ -527,6 +536,7 @@ static int virtio_transport_send_credit_update(struct vsock_sock *vsk)
 	struct virtio_vsock_pkt_info info = {
 		.op = VIRTIO_VSOCK_OP_CREDIT_UPDATE,
 		.vsk = vsk,
+		.net = sock_net(sk_vsock(vsk)),
 	};
 
 	return virtio_transport_send_pkt_info(vsk, &info);
@@ -1067,6 +1077,7 @@ int virtio_transport_connect(struct vsock_sock *vsk)
 	struct virtio_vsock_pkt_info info = {
 		.op = VIRTIO_VSOCK_OP_REQUEST,
 		.vsk = vsk,
+		.net = sock_net(sk_vsock(vsk)),
 	};
 
 	return virtio_transport_send_pkt_info(vsk, &info);
@@ -1082,6 +1093,7 @@ int virtio_transport_shutdown(struct vsock_sock *vsk, int mode)
 			 (mode & SEND_SHUTDOWN ?
 			  VIRTIO_VSOCK_SHUTDOWN_SEND : 0),
 		.vsk = vsk,
+		.net = sock_net(sk_vsock(vsk)),
 	};
 
 	return virtio_transport_send_pkt_info(vsk, &info);
@@ -1108,6 +1120,7 @@ virtio_transport_stream_enqueue(struct vsock_sock *vsk,
 		.msg = msg,
 		.pkt_len = len,
 		.vsk = vsk,
+		.net = sock_net(sk_vsock(vsk)),
 	};
 
 	return virtio_transport_send_pkt_info(vsk, &info);
@@ -1145,6 +1158,7 @@ static int virtio_transport_reset(struct vsock_sock *vsk,
 		.op = VIRTIO_VSOCK_OP_RST,
 		.reply = !!skb,
 		.vsk = vsk,
+		.net = sock_net(sk_vsock(vsk)),
 	};
 
 	/* Send RST only if the original pkt is not a RST pkt */
@@ -1465,6 +1479,7 @@ virtio_transport_send_response(struct vsock_sock *vsk,
 		.remote_port = le32_to_cpu(hdr->src_port),
 		.reply = true,
 		.vsk = vsk,
+		.net = sock_net(sk_vsock(vsk)),
 	};
 
 	return virtio_transport_send_pkt_info(vsk, &info);
@@ -1578,7 +1593,9 @@ static bool virtio_transport_valid_type(u16 type)
 void virtio_transport_recv_pkt(struct virtio_transport *t,
 			       struct sk_buff *skb)
 {
+	enum vsock_net_mode net_mode = virtio_vsock_skb_net_mode(skb);
 	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
+	struct net *net = virtio_vsock_skb_net(skb);
 	struct sockaddr_vm src, dst;
 	struct vsock_sock *vsk;
 	struct sock *sk;
@@ -1606,9 +1623,9 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 	/* The socket must be in connected or bound table
 	 * otherwise send reset back
 	 */
-	sk = vsock_find_connected_socket(&src, &dst);
+	sk = vsock_find_connected_socket_net(&src, &dst, net, net_mode);
 	if (!sk) {
-		sk = vsock_find_bound_socket(&dst);
+		sk = vsock_find_bound_socket_net(&dst, net, net_mode);
 		if (!sk) {
 			(void)virtio_transport_reset_no_sock(t, skb);
 			goto free_pkt;

-- 
2.47.3

