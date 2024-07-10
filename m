Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA8E13AD04
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Jul 2024 21:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720646772; cv=none; b=aFbqGPuvNNCB/HGiPN/YT8XY+LQXRymBtyIDb78qI/KX0PG7pjn2DqQWmt3KRb2TtKH3XDB08fC3nnHSgYUf7Hqd8UqJlEAIpsCDgI4YCDYr5rWNHgfhtLRVz77vVXfdpejhZH757Aq2baFFQ592JqrpEfqRGZlEmx847CxVoYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720646772; c=relaxed/simple;
	bh=n39Do9tgRbgw3ZexXlykzLjGhES5h4aEp9HSXPdUahY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QfMu7sNFirNdCaTWudwRK9xwg8I0NQ2iTBQFOeiRwhVzeKMwvj7049TfLzoawER2fwWU96Ad7q2NIMlAflh8lnx2iqjkA+2Bm/vl855LVYqWVvfLbV5K99ua08bttrhXuzSrOUsiuIA/mJFDomuGGph/QBNUhtarYzbKOFaJGOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dvOhFmRy; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dvOhFmRy"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DFAA561045
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Jul 2024 21:26:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: 1.236
X-Spam-Level: *
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rGsSn_wCHC6r for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Jul 2024 21:26:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::736; helo=mail-qk1-x736.google.com; envelope-from=ameryhung@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 07EB960EDF
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 07EB960EDF
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=dvOhFmRy
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 07EB960EDF
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Jul 2024 21:26:04 +0000 (UTC)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-79f323f084eso13656785a.3
        for <virtualization@lists.linux-foundation.org>; Wed, 10 Jul 2024 14:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720646763; x=1721251563; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AFRj+5GbXZp5LYveWDQo7+PJsMaLqCxqCVhahBc+e9E=;
        b=dvOhFmRyaTQIVoU4WCX06VZ/4Za82BC/gyjaIisufvK69yBCXS0EzJ+gS08Hs49uj9
         XUOtMag40VPBHagSFM7CrodYgrnsANEYrIJXLoYM8DpJM7ajBUT/J9oW7baLnUslL3WD
         EkiX2dvB5hP4xRAGtpv5kutqXlA26JIHR2mlSz9mx3u+U511aZhS5klprPS7yz1J7PrQ
         rVvJjontku+21ZPGD0AHAiOG1l4PtM/Qc8t3l4y/QrzWVKYxcONkjcCx5cD+PBgxTtYT
         vN+lfq9s+GRagwvFKeExBboAZsFqb9E4vHWUXbaLThGC5Ea44guQTqHnVsFvWeBw+H/Y
         dQEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720646763; x=1721251563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AFRj+5GbXZp5LYveWDQo7+PJsMaLqCxqCVhahBc+e9E=;
        b=UrGzL7MO9aAyaQMlIXoJwrN4hg88GFqbPet7Z4C7L9dRs27E66Y+toaTBaFLWq1feG
         M/c6s+tNam9QtB7OgDAMBIYUiFV/LaiX7HvYpFgSLoqqM1br9NKdO0Yeot7DkaZR46Q2
         ZRjiYXVP1YSEjeI77Dh6yte1V/pNP+uG3TkL1WlmnKz0Apjx7igLr55Z3vfyKG+sDk4m
         7zfSNwVgxyyZMzmlKD3AeNFQE4PGonQic/zsVOZPCd/n6hY1mW1We9DUl8p6rGgdrsWi
         Qo0+zSi+PL8NflJwzDn1sH38/nVPd/0/kP9Tk/XLl6r7mqXJL37U7uzN8PRJAk3ZarZe
         FQXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNAMy1+fGtAsw8Fygi2tEhHzA6ldMKtT/U5LrRUa8CT/jVd86P5xUvv+L2vy+SF95AHCiAlVOzg2MdLrpx/RiF8GyWWPc4Sz2gwnEVwUx25+Go7wbsX4S3yg==
X-Gm-Message-State: AOJu0YylVfrPUy28k3atJxG49uFA2rI+jvL/MaOL1h9b52EIFbd3TJa/
	2UcnkBvL+3beOe2xYij8MQxxrahSgDYD9CdyRnH5gHkKA1G9rEHd
X-Google-Smtp-Source: AGHT+IHqZShenZdCom11Cahq1mvTkynECydjnvU9rIy9/fCc1xw0zjvl3LB4oJWNPyqHWZq+r+EQ8A==
X-Received: by 2002:a05:620a:1aa4:b0:79f:67b:4fdc with SMTP id af79cd13be357-79f19a36bb9mr1028884485a.2.1720646763205;
        Wed, 10 Jul 2024 14:26:03 -0700 (PDT)
Received: from n36-183-057.byted.org ([130.44.215.118])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79f190b0af1sm228791885a.122.2024.07.10.14.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 14:26:02 -0700 (PDT)
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
Subject: [RFC PATCH net-next v6 09/14] virtio/vsock: add common datagram recv path
Date: Wed, 10 Jul 2024 21:25:50 +0000
Message-Id: <20240710212555.1617795-10-amery.hung@bytedance.com>
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

This commit adds the common datagram receive functionality for virtio
transports. It does not add the vhost/virtio users of that
functionality.

This functionality includes:
- changes to the virtio_transport_recv_pkt() path for finding the
  bound socket receiver for incoming packets
- virtio_transport_recv_pkt() saves the source cid and port to the
  control buffer for recvmsg() to initialize sockaddr_vm structure
  when using datagram

Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
Signed-off-by: Amery Hung <amery.hung@bytedance.com>
---
 net/vmw_vsock/virtio_transport_common.c | 79 +++++++++++++++++++++----
 1 file changed, 66 insertions(+), 13 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 46cd1807f8e3..a571b575fde9 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -235,7 +235,9 @@ EXPORT_SYMBOL_GPL(virtio_transport_deliver_tap_pkt);
 
 static u16 virtio_transport_get_type(struct sock *sk)
 {
-	if (sk->sk_type == SOCK_STREAM)
+	if (sk->sk_type == SOCK_DGRAM)
+		return VIRTIO_VSOCK_TYPE_DGRAM;
+	else if (sk->sk_type == SOCK_STREAM)
 		return VIRTIO_VSOCK_TYPE_STREAM;
 	else
 		return VIRTIO_VSOCK_TYPE_SEQPACKET;
@@ -1422,6 +1424,33 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
 		kfree_skb(skb);
 }
 
+static void
+virtio_transport_dgram_kfree_skb(struct sk_buff *skb, int err)
+{
+	if (err == -ENOMEM)
+		kfree_skb_reason(skb, SKB_DROP_REASON_SOCKET_RCVBUFF);
+	else if (err == -ENOBUFS)
+		kfree_skb_reason(skb, SKB_DROP_REASON_PROTO_MEM);
+	else
+		kfree_skb(skb);
+}
+
+/* This function takes ownership of the skb.
+ *
+ * It either places the skb on the sk_receive_queue or frees it.
+ */
+static void
+virtio_transport_recv_dgram(struct sock *sk, struct sk_buff *skb)
+{
+	int err;
+
+	err = sock_queue_rcv_skb(sk, skb);
+	if (err) {
+		virtio_transport_dgram_kfree_skb(skb, err);
+		return;
+	}
+}
+
 static int
 virtio_transport_recv_connected(struct sock *sk,
 				struct sk_buff *skb)
@@ -1591,7 +1620,8 @@ virtio_transport_recv_listen(struct sock *sk, struct sk_buff *skb,
 static bool virtio_transport_valid_type(u16 type)
 {
 	return (type == VIRTIO_VSOCK_TYPE_STREAM) ||
-	       (type == VIRTIO_VSOCK_TYPE_SEQPACKET);
+	       (type == VIRTIO_VSOCK_TYPE_SEQPACKET) ||
+	       (type == VIRTIO_VSOCK_TYPE_DGRAM);
 }
 
 /* We are under the virtio-vsock's vsock->rx_lock or vhost-vsock's vq->mutex
@@ -1601,44 +1631,57 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 			       struct sk_buff *skb)
 {
 	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
+	struct vsock_skb_cb *vsock_cb;
 	struct sockaddr_vm src, dst;
 	struct vsock_sock *vsk;
 	struct sock *sk;
 	bool space_available;
+	u16 type;
 
 	vsock_addr_init(&src, le64_to_cpu(hdr->src_cid),
 			le32_to_cpu(hdr->src_port));
 	vsock_addr_init(&dst, le64_to_cpu(hdr->dst_cid),
 			le32_to_cpu(hdr->dst_port));
 
+	type = le16_to_cpu(hdr->type);
+
 	trace_virtio_transport_recv_pkt(src.svm_cid, src.svm_port,
 					dst.svm_cid, dst.svm_port,
 					le32_to_cpu(hdr->len),
-					le16_to_cpu(hdr->type),
+					type,
 					le16_to_cpu(hdr->op),
 					le32_to_cpu(hdr->flags),
 					le32_to_cpu(hdr->buf_alloc),
 					le32_to_cpu(hdr->fwd_cnt));
 
-	if (!virtio_transport_valid_type(le16_to_cpu(hdr->type))) {
+	if (!virtio_transport_valid_type(type)) {
 		(void)virtio_transport_reset_no_sock(t, skb);
 		goto free_pkt;
 	}
 
-	/* The socket must be in connected or bound table
-	 * otherwise send reset back
+	/* For stream/seqpacket, the socket must be in connected or bound table
+	 * otherwise send reset back.
+	 *
+	 * For datagrams, no reset is sent back.
 	 */
 	sk = vsock_find_connected_socket(&src, &dst);
 	if (!sk) {
-		sk = vsock_find_bound_socket(&dst);
-		if (!sk) {
-			(void)virtio_transport_reset_no_sock(t, skb);
-			goto free_pkt;
+		if (type == VIRTIO_VSOCK_TYPE_DGRAM) {
+			sk = vsock_find_bound_dgram_socket(&dst);
+			if (!sk)
+				goto free_pkt;
+		} else {
+			sk = vsock_find_bound_socket(&dst);
+			if (!sk) {
+				(void)virtio_transport_reset_no_sock(t, skb);
+				goto free_pkt;
+			}
 		}
 	}
 
-	if (virtio_transport_get_type(sk) != le16_to_cpu(hdr->type)) {
-		(void)virtio_transport_reset_no_sock(t, skb);
+	if (virtio_transport_get_type(sk) != type) {
+		if (type != VIRTIO_VSOCK_TYPE_DGRAM)
+			(void)virtio_transport_reset_no_sock(t, skb);
 		sock_put(sk);
 		goto free_pkt;
 	}
@@ -1654,12 +1697,21 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 
 	/* Check if sk has been closed before lock_sock */
 	if (sock_flag(sk, SOCK_DONE)) {
-		(void)virtio_transport_reset_no_sock(t, skb);
+		if (type != VIRTIO_VSOCK_TYPE_DGRAM)
+			(void)virtio_transport_reset_no_sock(t, skb);
 		release_sock(sk);
 		sock_put(sk);
 		goto free_pkt;
 	}
 
+	if (sk->sk_type == SOCK_DGRAM) {
+		vsock_cb = vsock_skb_cb(skb);
+		vsock_cb->src_cid = src.svm_cid;
+		vsock_cb->src_port = src.svm_port;
+		virtio_transport_recv_dgram(sk, skb);
+		goto out;
+	}
+
 	space_available = virtio_transport_space_update(sk, skb);
 
 	/* Update CID in case it has changed after a transport reset event */
@@ -1691,6 +1743,7 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 		break;
 	}
 
+out:
 	release_sock(sk);
 
 	/* Release refcnt obtained when we fetched this socket out of the
-- 
2.20.1

