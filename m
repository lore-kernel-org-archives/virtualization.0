Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034ED299952
	for <virtualization@lists.linux.dev>; Tue,  5 Aug 2025 21:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754430561; cv=none; b=jztYdOgvbDHqi+Co+mnNU0HrXXiB2HgDn0NQ2ekkRKSOhExFn/7dq+qIe/V9+X7c7rXczbEYu9Wd+b+cd3+vry/7BYJGDezMKEsRzfulJUttzHUkwPBodguYO/crybpqYc9QqYKPfgxLsosiDzCNTYlk/aq9VLZnSD26SjgqFZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754430561; c=relaxed/simple;
	bh=L8+UJORlszErIif6aAL4B/2M4IL1vW1dLWaDie77K18=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lVOT+A7LC5eW2ScxYtRxidTIO0L+764l/vimWoWYe2uktmwWmlwnL6l5V+B2SN2z/iIZOOuCuaga+XtyOEgQQP5U+OVB4t8o3yoHa6J8TRV2ECqqCyJD1RyXLeeo15Vf9edhbKiqQGX0wogNLP1GGVrY9U97sVDuUsiwuaPSAqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=niH4/WCM; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="niH4/WCM"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-76bd2b11f80so5097281b3a.3
        for <virtualization@lists.linux.dev>; Tue, 05 Aug 2025 14:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754430559; x=1755035359; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vClpSthvja0ciP4EEb0dS5NFu0AwWPReylpsN3j0yGc=;
        b=niH4/WCM1AaL2s6JbP8YCfer4RSn8zRrDglUkIbeHwchVHw9YMZLDN4SDUdUs+Wk6U
         YUSOr2WSs1okuSMqXgVZOWpsAZdhnboNoZdQmNIu2r1/uBL4rH9aXZFMu7+EkT3eYNVM
         GYj+130M7hKEb7F9zt2GSLygovsuVDBqgEx5YedH3j/mmE1l/boanw86ODf4ZtLF369g
         e6CqphefgljCfSuDBGr159nz2/+3TUDxdosP4/3XasSXEsQK/PQa2G/N5hjLd4KlTcwc
         R+MT2j1b3EN/yzajQ+nrT9LBoK7ehgxuqFQvWBN1sNLfo7J9vyrkvclkT9ETeaszvnfN
         x6Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754430559; x=1755035359;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vClpSthvja0ciP4EEb0dS5NFu0AwWPReylpsN3j0yGc=;
        b=rB5umhoGOtv+LVmopSZiTqVDH5udqE2q8eOhpngzpGE1BZf6uGpsVdu/uSzogTFEed
         fPD3pJ1mbKFshphHqUq1QR7bNysVCZJTQQXEgvwB5umHZXEoF/Am6YgogaVgz7tk8/Rv
         tXo+gWx62bkZDB1IS0o9A4TMURCSJ6NYv6ZpdpGHajc56Yi0Ec0vLiKyAiT0otS1fv0e
         D0+KoDMQ4YOFPfeYpDCNDyW9lh+iS/ZMzIa0qiwyjHFyYbG0NvYNxURkpDdV+/BQ7pFb
         YNF0NqGiuOmcjunwxBQ8qN+yPqxUy2vlB5kG/Q27RVnoynG290dQvOCzL7vp4JqUeHZY
         5QDg==
X-Gm-Message-State: AOJu0Yw8kC1Os+fsfLdbLgpqPCT+U0NNIB9v+iR9iv7g21/BV9YUIMIS
	rXBKtotrzFCgXQMm8aDMNDwwTAO983Lhg31g51XulxzwygDOphGZRH2e
X-Gm-Gg: ASbGncsFvrhU/aduiQNVXQcj1TYUDW48HtUg1EbzZ2EmvESoXLt8cmPOCc5AyotahQR
	hHJWEzVUfVI0Hx4uoQ9EKVT0TUoqu+QoH/iXYUed1dbveAiVpz5y0V8LOZaTyNtHw2SJhK5SoEy
	qaWSHymFckbNbidTjvRaBsbqO8doGYDfvfjkEWxELH47Wsw+nt/GntSanHhvXqbotxTKvkkae2x
	ldt/xXt/4WMmoAfK1ad6uh0p5+bm07h00OE7EncKbEbf3Mq7J7oE575JQ2gXETXZ7rZ4h6xUpyY
	2Bfpg5UX1QGjZGwXZBLKazlRgETBs30xjWSlXsZobkdjUcxRZKGXkPXU5GRHVlGlp68BG/oQBQw
	KbfI9WBJ97tmAeXji2fk=
X-Google-Smtp-Source: AGHT+IHIXvB6uOXF9tZ4IgyXPs/ln/7LW82JyFWlXgNyNXaIj2h0hXCpxPlYbwZ9V7Lb/cFmKcuy3w==
X-Received: by 2002:a17:902:f60c:b0:240:2145:e51d with SMTP id d9443c01a7336-2429f625afemr8254875ad.31.1754430559091;
        Tue, 05 Aug 2025 14:49:19 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:7::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e89769c1sm143611275ad.77.2025.08.05.14.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 14:49:18 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 05 Aug 2025 14:49:12 -0700
Subject: [PATCH RFC net-next v4 04/12] vsock/virtio: add netns to virtio
 transport common
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250805-vsock-vmtest-v4-4-059ec51ab111@meta.com>
References: <20250805-vsock-vmtest-v4-0-059ec51ab111@meta.com>
In-Reply-To: <20250805-vsock-vmtest-v4-0-059ec51ab111@meta.com>
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
2.47.3

