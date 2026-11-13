Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794590178;
	b=AIbsNe6jG9zMQw/eKSaglabwaHJ1TmtZndXfynC6I5Jq0NzDovj6/M+9c2uC9vq7U2p2
	 bKDp3ksOquKD0Ho3lhdHA+rlLxH1mUI6UkHCDu1ta+umyOpb1W81ApeWbfHZKngPy6N4C
	 gFiENy4NYCLatklQzU9J9ZO1siGxMfrYp+xx+j5W3TxUrFQvEzede4pE3fQK+NIhkolUL
	 6to4HW6V01lqJFIFopC1sAN+rkdtTmRpPQzkrB0gWFF8oNr8pBXVP0sTFocTx8fUJVshu
	 CFz/nc7KPmzUtoXpgBOUn9i83hHe9RbcYbvUlc6MCq6EvDhIh/Uuvd1IY/Yl+EKM0YA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794590178;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=kRsJjjCDtc2CMBY4DZcEpFvNQQYyCSaW8arjfgYBJKM=;
	b=DCq59/P5ezEuTEYkw9G44z01MPz/bQRZIl1EuQdOJCaWtS1yQfIyJ+1ca0KTesrqAQ1k
	 gHlioOKPlvFSzwZe6nHzT4Se6glSzW+7aTcxH4/keshGt6SEheloTpDnFKg8hGW0xctzM
	 ow+NNQP1BAIHvpkf7VLWwTOZEg7fvaMlZ9IBpyxWq79OE7ukO7uWqBY4zn4iC72dkLiYR
	 4sp8w5TfH7GcsWdCL3c4sODleaH5JnxR5Vp0AASXsgZGRfKYwOzhh9CMxAoxgsRxM8AYe
	 CvwROjPSA8PC5KMuwbTtXmM5/kxnRg5sojxF8TFkbWqR+LjwcNJVZktNLSK1X3iKttg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GN+ZWE6C;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EDE606B34D
	for <virtualization@lists.linux.dev>; Fri, 13 Nov 2026 17:16:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90EDE606B34D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GN+ZWE6C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794590176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kRsJjjCDtc2CMBY4DZcEpFvNQQYyCSaW8arjfgYBJKM=;
	b=GN+ZWE6CX3HXpJkgAQw1n6ercSnSOBNw/iTxPLLP9YafWGoIv1GxzyA7W/Upr6uh3QvCT5
	JF2h56EQWAkGlY/4igZH2z56ta2MtHdJHmm8Mcay9H+GzuR0HKW6q+q2UpuT5DxDR6wY1g
	zAvP9CqJRaBus3wCJGyprq+WoU1HGzU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-108-iPADRVOJNquvlTcbN8jDnA-1; Fri, 13 Nov 2026 12:16:13 -0500
X-MC-Unique: iPADRVOJNquvlTcbN8jDnA-1
X-Mimecast-MFC-AGG-ID: iPADRVOJNquvlTcbN8jDnA_1794590172
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4994d67d0e3so7556055e9.2
        for <virtualization@lists.linux.dev>; Fri, 13 Nov 2026 09:16:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794590172; x=1795194972;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kRsJjjCDtc2CMBY4DZcEpFvNQQYyCSaW8arjfgYBJKM=;
        b=WIGFg+M2YYq/wgKhTxvU8W/0cQNiMQtnBTtnb5VAg1O93y2jiWgoNid1dfyBEHIYmK
         PItKAzE1e3yogJeXrumeMFt8ZX97WNWaOB3hdkGeLXMNzBZQ480vh38RWQb9jnzhDGxj
         rUi6y6eSjBVzHVufTRLU/5DUI4bmus1vf2tX02bm9DA/o39YpZQfDCVkPg/Yeb7xQMPS
         2aVzLvPLLkMQCO6wnlN5xMqFcxNAjUsOKuQUjnU1Sr5bR2IkOGzjKaFWA2yxu3OYPKlz
         Ofo040pYOYV7wz/KXkjRT/hNLlrk3XY5Uc/TY3lb4njbmvXcdJmQ5/2H/9XZ0ewAgFpY
         zYGA==
X-Gm-Message-State: APuU4Z/tMz0VN0QRSFFiKfvWreZND0b1LIKy8DsVPD1bzAobwo1+kNzB
	h4y8AmbyQ/KrMxEPeuzDnD823bqGfn8oCJF5NeqmnDCasEo9zs5jpV5dBnnfnNheWt3lg1vZ1Xi
	Pyl63FiaqMLhmh3xTA2747d7h4NHs2CGOXx4A3bqWS+jQY7HaF+Kak5M+nnFga0mm/aIc
X-Gm-Gg: AYBFou05eR8mPbKmUx+66TE+7X1Dr3JGWoxyy/OAUH5fu7Y6SZ8/hXKVG9HHiqP676V
	8mNgzQEcLD3TjiKFysWC9xCpa/CMsbVmdAG1zj/U/2eOpAbZLcNSVWp4LojttHCTfJYvmHlwx15
	BBJmDR8tsEfoIExGluciS/N12Y6q3gwU5EXlnRdGfhl4aXCt6DJhvr254uL4g9VnEQlr+C9hCrX
	bDfxxVzZBOd4Xhe606B0EkK2NwnQ3e9FUp/EzkcPhEVnX2cCaXKr2EB343ai2riQ7rerYR34N3S
	2gRyl1OZFaBNOvs2AiqXnjqkgChZJCdNlnOU8NRes06TyW2I6zdXn5JJb3e5G06buwufzBvYB0X
	duX2fPXqhdaMcNjMJVeeEMWb1DbEIwO7Tpq/JoBIACd1ur/g3xfPbMVF4I8ff21bjRb6NF3pLpd
	Dj6i3qaio6aZg=
X-Received: by 2002:a05:600c:482:b0:4a5:75d2:c104 with SMTP id 5b1f17b1804b1-4bb55a59c9dmr52778495e9.22.1794590172136;
        Fri, 13 Nov 2026 09:16:12 -0800 (PST)
X-Received: by 2002:a05:600c:482:b0:4a5:75d2:c104 with SMTP id 5b1f17b1804b1-4bb55a59c9dmr52778145e9.22.1794590171733;
        Fri, 13 Nov 2026 09:16:11 -0800 (PST)
Received: from [192.168.0.19] (217.red-88-4-146.dynamicip.rima-tde.net. [88.4.146.217])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c7da37b19sm5811907f8f.5.2026.11.13.09.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 09:16:10 -0800 (PST)
From: Sergio Lopez <slp@redhat.com>
Date: Fri, 13 Nov 2026 18:15:44 +0100
Subject: [PATCH RFC v3 4/8] vsock/virtio: negotiate datagram support on the
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
Message-Id: <20261113-vsock-dgram-support-v3-4-1523c8e9b27e@redhat.com>
References: <20261113-vsock-dgram-support-v3-0-1523c8e9b27e@redhat.com>
In-Reply-To: <20261113-vsock-dgram-support-v3-0-1523c8e9b27e@redhat.com>
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
 b=owEBbQKS/ZANAwAKAfRpJ40vDAI1AcsmYgBq90XKvfm0hTTG6KsZStQJuRB62faAzxwGpGWU8
 ILOUbyp246JAjMEAAEKAB0WIQS+1fz3US2GgJFC6KL0aSeNLwwCNQUCavdFygAKCRD0aSeNLwwC
 NVdXD/47YUNIzBO/XENYFXoxqGPmqN+8yVZHcyoNUMMah35eGC6B53jAKm9RQU/0+E7kK47Sdfu
 gO4o4evEqajRNvW4/JOPh7i6l67FhTUujzADMrwKNUWNAovE6UP/M4+PQoA9UcsWlygIDMjAMj0
 iWQDFbq7s8cEZizQjZQaDzN8sow9UhjTQK8u1gImlXBQ9qj2MelvgZx/yDRozXziSKYExv2lh9j
 Y5kllkMR/kAeh6dRLnBOaKZHy8ahVMHIHqsEwa9umUpxWTLaEkhlt5SIbwZwji2EoaiNkON6xZD
 7UmlQpATXdRkBIRyHZemx5NkxWmOnAGPx588b1DbouVIZhB+yhEMOvBk08eFUopwuHHWZezNsi3
 vwXmFQytj9hjaLpf8veYIB9Py+4f3+xmEeCg4XM0l1IoYVNFOyFDRhpA3Hb2htQRcWFem9+gpor
 5bR9RCjfp2fdccHdUak3TECEtG2w511JFRzUKZ0jNnkCJURHRQOCaXvmM4j0U00xHVxfAfJLY9t
 ySy1NrdB2QtRWCbcz1pc8oEdwWZjrXEJbvpmdg4ALHuJFUDY8RHFt58DGHngu/3Gdv+66hrdLKD
 PtZdss3zxmACCa6YgdSsuTS/+x02M8KJ5WhfCoEG6mzgvqxXlv90P3diEHIUL7OTb4AoNrPdn6R
 zCi6/vQWhtZSNaA==
X-Developer-Key: i=slp@redhat.com; a=openpgp;
 fpr=BED5FCF7512D86809142E8A2F469278D2F0C0235
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XXdr3OMTZTifbL6OX9hmrFsh16KZG0LuDt8GVIoNe2s_1794590172
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

