Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794574198;
	b=DhhoYwUH9bwtY23cJBV4bcbiXIQX0EVtaGxDL0FIEK7jCfNr3JESRI6ARI5Dv1WWl8rp
	 8aXLXrC7U+NzIenqPQwErW9uZ7Gs5d6dxEQnIE5LgCevltuu9UODJ7wPwvjd5AWOdwO9l
	 LikRj97FJ7KLp8v+N0M2nyOxwJGgeN1NtGeluNEJVUlWSOWo7C5Q5KiGuu8/22AJ1JQab
	 ZdCKUsDOq6ZlIpn9WDqnh7+mMOjfithbpN11AOerwcSH65MztTWqOYVwnPDK39QMVlhR2
	 MoP81ZtDEWPOdO82Yzp3/mvSPY5/ul/ibCoT5LKGTUveMD9IKLu1qG5HVqB8FYyFwIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794574198;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=kRsJjjCDtc2CMBY4DZcEpFvNQQYyCSaW8arjfgYBJKM=;
	b=3vIkzoPL6sbPaTdwxKte17zFVawiXKkmQJWq1vzrN6wWxy+6ePJ1usAh5Tuo75zjrY3V
	 M3rIP55ze/x/3rasmPhurT3zZr1huYX5Rv3EUQEIHH70dlcuprHGyaqdlC55JwuUNS83B
	 0/CT6RD3n5oXv+Jj5PtOLM7qLyRxXGAVXBWe3ZK+9dcMTjSQgoINYrlmMMx01MMdIK8GS
	 kR0y+ibcSZpnlprcqNBb17WCo9qfe+aeUgIDdR0q+8n1B6bZPPhIiYUSauSs6/YvZyKFQ
	 e/CFn+JzW6Gn+5ZyKWA2KJz5yNLqyWBn6bxQx2lOUfgQFIYwPYC8QuntOyFqVO8hzyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HlPIyGsl;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B1160A3818
	for <virtualization@lists.linux.dev>; Fri, 13 Nov 2026 12:49:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81B1160A3818
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HlPIyGsl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794574196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kRsJjjCDtc2CMBY4DZcEpFvNQQYyCSaW8arjfgYBJKM=;
	b=HlPIyGslCW6bUqqF7CbuC66awmsdMHoiNinxge/sQLCVe/VJPTEm04LrvNJ1LAdTnfGI3W
	+Uvwy5Zb+gcXH2ERQi53Pt2NT3m+zzcWwelZ39heMG7KdYwMdqXEx7NmlVQnSQK/jlBE8W
	SrvHF5Co+Yb5Ck00Byb8gJiiBe5gudE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-zEmMQc6TNL2PBatV-c4nCA-1; Fri, 13 Nov 2026 07:49:55 -0500
X-MC-Unique: zEmMQc6TNL2PBatV-c4nCA-1
X-Mimecast-MFC-AGG-ID: zEmMQc6TNL2PBatV-c4nCA_1794574194
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4b64722b5e6so8295305e9.2
        for <virtualization@lists.linux.dev>; Fri, 13 Nov 2026 04:49:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794574194; x=1795178994;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kRsJjjCDtc2CMBY4DZcEpFvNQQYyCSaW8arjfgYBJKM=;
        b=aVhl2Ue1MF0u4wprfXqb7oBcPUvakvL/FpgU7jTLzJT49AE1vAbgIlF1+U81SC9+QM
         eOboIejfrs9IyaN709w7vRas57Yac9U77n1V3MZfsCovX0EBeXplRuL5ANxeclusSvyY
         WoWyJwHX62QV6Fn50XAYXXktom3kCYSKNXy0JSg8eq79agQ0tTws0sQWyry0tyDtx6sO
         cRUkUvDmXXlCmakxv5uN5+oPnzJOiTiU7Xmpx5bRZYmzQL1fuaiolJwJ4SsMEY1lJsve
         isPNhmn/4jMAi2tLHWFWzY0v9VZKJ2vivw9rdHH/quou0bXrPfa6UQP19ZKlhzERfLUW
         mHyA==
X-Gm-Message-State: APuU4Z/QHrJaOH3RAAfp6WIPn8I6+4tSnXYz6yLYZ69Z/YSIhLsUTTcV
	ZiKStBjbvX1vJMuvBiM4m0J0RsRWl8CRuNxNrzay+9rzRzVWyb04oVJPXLeRlfCUsuDZTWvs2RX
	XgvMkpEEYqlAIrHWuK1Zv3yIe0Z7T2h3S4uPgL1wKgCpdiYqTsRtTY3kH4Lm5+sgfsO4W
X-Gm-Gg: AYBFou1CcFtfAcFk7k23fwyV+7IXKOwUd1Iu5RJR/+EnUolGbwJHIF1aeixXAz0/8/W
	GOWrWSUH/QdG4od6md592Mqtk7i1jb9xO75k5WbeIs10DTFxOZxLpHh9g4mGVs+H9dp0pmIoQHM
	FBnVgve4uEhTbz1+2qrvR7KbrtECSQt0npDqJQSHEYy+2bazSa5tsu0AtwKJzVyPZ5keaAi1tkC
	xQPTQo1k/EVWO8JYCW4aiEgam4gwxt/seuh9XUfG+XddJ/uyeh9XTeDiP84nVnZonnmvyf968Ei
	7s7ZBn3HxbUmuPRcYAdG/aBZLiDyXuQuKmCK/ulffHPRnarOy1CYpxh7kRX6+i5MD9MhPQmQZiT
	z0dI310xN0yELWb15g/unBKoLm76+MhIHMcchZSkeX3cvu8WY33Dh1H24/RzLonwOlfI2Y3BL
X-Received: by 2002:a05:600c:6219:b0:4b7:6aac:7406 with SMTP id 5b1f17b1804b1-4bb55a23b41mr43805215e9.3.1794574193939;
        Fri, 13 Nov 2026 04:49:53 -0800 (PST)
X-Received: by 2002:a05:600c:6219:b0:4b7:6aac:7406 with SMTP id 5b1f17b1804b1-4bb55a23b41mr43804695e9.3.1794574193541;
        Fri, 13 Nov 2026 04:49:53 -0800 (PST)
Received: from [192.168.0.19] (217.red-88-4-146.dynamicip.rima-tde.net. [88.4.146.217])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e2adf53sm151135805e9.15.2026.11.13.04.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 04:49:52 -0800 (PST)
From: Sergio Lopez <slp@redhat.com>
Date: Fri, 13 Nov 2026 13:47:37 +0100
Subject: [PATCH RFC v2 4/8] vsock/virtio: negotiate datagram support on the
 guest
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Message-Id: <20261113-vsock-dgram-support-v2-4-bacfc85b71ce@redhat.com>
References: <20261113-vsock-dgram-support-v2-0-bacfc85b71ce@redhat.com>
In-Reply-To: <20261113-vsock-dgram-support-v2-0-bacfc85b71ce@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4746; i=slp@redhat.com;
 h=from:subject:message-id; bh=iq6ep5+lpyNre87c+82+rRsIkGG2RBevg46oczOnz0k=;
 b=owEBbQKS/ZANAwAKAfRpJ40vDAI1AcsmYgBq9wdeh/fbg8dtYF2DcAbRaFeKvm+icn7ibkHUI
 9UDc3bUTuCJAjMEAAEKAB0WIQS+1fz3US2GgJFC6KL0aSeNLwwCNQUCavcHXgAKCRD0aSeNLwwC
 NawhD/4yNgrww43ef4iLOcszJW/Vt9MQ3fWu2LbAo/inVbx5U5pXTx6wb0mGebUaDw/EjjYsNd1
 hl7B6IFWykqjaE2K+qsEkL86SvLKJtPqHf+dhdgkXqTfgHzgYJq6zgLAfB2O+KREcuH4GuRa5iw
 /7IWcNoRiicOapx87Te+iwT7K+oYtdjTKzTkCXUumOL1KVCPl1EExuywDO2A+fAcsxfYUNBLknR
 hS+ExF4RKc4Ygx+nv9cPLZb2zNpA4ofI/GRvAivuDOl7gUhsZ9UMoqMTSTFdVm+hm7hp7WMxu9j
 mhGRMQkUqXf4yvCV/zb59WFbNAk0Y9fKthrj4aqZKKNsdNdJ5VYdPt2/aqNvtFfQXNzzy98qE1I
 QNrePr/T7btb19CqzTiGKYLjYeYUMqLRMzk8jTv4IsAWznc4LDyFD1arq8gK2JXOds4FHC9aOVd
 xxcnITpeQhtXqE0BH6pVM/aLJieAX/JPFhx2HbIA709Pv2Gp17nTtEXAmVPpYs8JJBxig6U8Q78
 AceTOeKwXHhQm5BfKSnAhUQj2Vf/qJwgH1Pr8Xla3pKX3o5kq7LAnmqXcADRUeDWIPDyp+5lkMN
 Nb9NTW8KBk/pEgvtH1GQXnINsSlthdAqlC3Q6vL8ED9yQwmPDh7D1VXTpYHb9DXvlL03WS02LHj
 NWJUmzBel0efycg==
X-Developer-Key: i=slp@redhat.com; a=openpgp;
 fpr=BED5FCF7512D86809142E8A2F469278D2F0C0235
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Jk1pXuBlRSUVfNh3LyN3ESuSdJ0e885ayLYL5Dm8zbQ_1794574194
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Advertise VIRTIO_VSOCK_F_DGRAM and record whether the device
negotiated it. Gate datagram socket initialization and destination
checks on the negotiated feature and the transport's supported network
namespace mode.

Perform device capability checks at socket creation without requiring
a remote address, which is not yet known for an unconnected datagram
socket. The common virtio implementation provides the datagram data
path.

Discard received datagrams when the device has not negotiated support,
including when a socket was initialized through another transport.
Reject packets addressed to a different CID using the full 64-bit wire
value before bound-socket lookup narrows it or matches a wildcard.

Signed-off-by: Sergio Lopez <slp@redhat.com>
---
 net/vmw_vsock/virtio_transport.c | 50 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 47 insertions(+), 3 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index 4f9aa9c4c3aa..fd10f20d7611 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -57,6 +57,7 @@ struct virtio_vsock {
 
 	u32 guest_cid;
 	bool seqpacket_allow;
+	bool dgram_allow;
 
 	/* These fields are used only in tx path in function
 	 * 'virtio_transport_send_pkt_work()', so to save
@@ -547,6 +548,18 @@ bool virtio_transport_stream_allow(struct vsock_sock *vsk, u32 cid, u32 port)
 
 static bool virtio_transport_seqpacket_allow(struct vsock_sock *vsk,
 					     u32 remote_cid);
+static bool virtio_transport_dgram_allow_check(struct vsock_sock *vsk,
+					       u32 cid, u32 port);
+
+static int virtio_transport_socket_init(struct vsock_sock *vsk,
+					struct vsock_sock *psk)
+{
+	if (sk_vsock(vsk)->sk_type == SOCK_DGRAM &&
+	    !virtio_transport_dgram_allow_check(vsk, 0, 0))
+		return -ESOCKTNOSUPPORT;
+
+	return virtio_transport_do_socket_init(vsk, psk);
+}
 
 static bool virtio_transport_has_remote_cid(struct vsock_sock *vsk, u32 cid)
 {
@@ -561,7 +574,7 @@ static struct virtio_transport virtio_transport = {
 		.get_local_cid            = virtio_transport_get_local_cid,
 		.has_remote_cid           = virtio_transport_has_remote_cid,
 
-		.init                     = virtio_transport_do_socket_init,
+		.init                     = virtio_transport_socket_init,
 		.destruct                 = virtio_transport_destruct,
 		.release                  = virtio_transport_release,
 		.connect                  = virtio_transport_connect,
@@ -571,7 +584,7 @@ static struct virtio_transport virtio_transport = {
 		.dgram_bind               = virtio_transport_dgram_bind,
 		.dgram_dequeue            = virtio_transport_dgram_dequeue,
 		.dgram_enqueue            = virtio_transport_dgram_enqueue,
-		.dgram_allow              = virtio_transport_dgram_allow,
+		.dgram_allow              = virtio_transport_dgram_allow_check,
 
 		.stream_dequeue           = virtio_transport_stream_dequeue,
 		.stream_enqueue           = virtio_transport_stream_enqueue,
@@ -629,6 +642,25 @@ virtio_transport_seqpacket_allow(struct vsock_sock *vsk, u32 remote_cid)
 	return seqpacket_allow;
 }
 
+static bool
+virtio_transport_dgram_allow_check(struct vsock_sock *vsk, u32 cid, u32 port)
+{
+	struct virtio_vsock *vsock;
+	bool dgram_allow;
+
+	if (!vsock_net_mode_global(vsk))
+		return false;
+
+	dgram_allow = false;
+	rcu_read_lock();
+	vsock = rcu_dereference(the_virtio_vsock);
+	if (vsock)
+		dgram_allow = vsock->dgram_allow;
+	rcu_read_unlock();
+
+	return dgram_allow;
+}
+
 static void virtio_transport_rx_work(struct work_struct *work)
 {
 	struct virtio_vsock *vsock =
@@ -677,6 +709,14 @@ static void virtio_transport_rx_work(struct work_struct *work)
 				continue;
 			}
 
+			/* Check the full wire CID before socket lookup truncates it. */
+			if (le16_to_cpu(hdr->type) == VIRTIO_VSOCK_TYPE_DGRAM &&
+			    (!vsock->dgram_allow ||
+			     le64_to_cpu(hdr->dst_cid) != vsock->guest_cid)) {
+				kfree_skb(skb);
+				continue;
+			}
+
 			if (payload_len)
 				virtio_vsock_skb_put(skb, payload_len);
 
@@ -835,6 +875,9 @@ static int virtio_vsock_probe(struct virtio_device *vdev)
 	if (virtio_has_feature(vdev, VIRTIO_VSOCK_F_SEQPACKET))
 		vsock->seqpacket_allow = true;
 
+	if (virtio_has_feature(vdev, VIRTIO_VSOCK_F_DGRAM))
+		vsock->dgram_allow = true;
+
 	vdev->priv = vsock;
 
 	ret = virtio_vsock_vqs_init(vsock);
@@ -932,7 +975,8 @@ static struct virtio_device_id id_table[] = {
 };
 
 static unsigned int features[] = {
-	VIRTIO_VSOCK_F_SEQPACKET
+	VIRTIO_VSOCK_F_SEQPACKET,
+	VIRTIO_VSOCK_F_DGRAM,
 };
 
 static struct virtio_driver virtio_vsock_driver = {

-- 
2.56.0

