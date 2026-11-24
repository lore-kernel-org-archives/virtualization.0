Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795522900;
	b=LXA5V9ITxfh3bx1PAFA05MOREAcmsV7+NoJsYeXZUrxs15zJHnO29wvCe1GsmQypYMIZ
	 Cy9r3zvp+pjSrRQDnQvFf/2oDGjhjIN8iOK7XzABAF8uR6n8SaPL0aI4JkuK1G1Q9DjL/
	 GLzqISuURHqKFj+Zz46AiBRZp8b5KcbemH0b8Xf5SCeNaFVXNr16gNsWqoK2RxyV1wIiR
	 2Vi9gu+OBr4Va92WasXTKAtT8ERBRjHzK71IsODJAmPFRXgPCT7XV2kbd01RIRWeolnVm
	 poT25mONJG3YgZSDP+Exk9NmYnrTgDXXfD2Lt4BngCRxkqZh0PPqpjFKztK5EDd7sTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795522900;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=TzwipR1LCMAEarIzxU+ebA22tLIFqbxvhpauSxtFZxw=;
	b=lkZVNybO3ccug+CxdSpUKGs7t0HpaOfdumrR8COTR5n3lE7okjDQchAxx8APQz44AldL
	 aBQ0QpmNbJYTz+7arvLUC6D+Kn5DE1W7o4xvVmHtHqb7KgUk3CUPbXK22U5zz055sgxgX
	 FVCmFUZJj7xQf8j8z8ksqilQDSuPlbYWnb+3BKWwT9mpna0rJC8LXPeHoy14grC9RjB4b
	 s6KIWAt9lR44lqQ0EUVg1vjiepdF3YN1VYABGxurFfcvTC/lPTpK9VB7V9UyX/Fcg6xso
	 ogUSqtU270tLPARMbZ09EadlpsBPPZqujD73ouz3V6eS22SF/nN80OUmMZ4vFJ0skUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Rm0cXtLN;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0697606A69D
	for <virtualization@lists.linux.dev>; Tue, 24 Nov 2026 12:21:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0697606A69D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Rm0cXtLN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795522898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TzwipR1LCMAEarIzxU+ebA22tLIFqbxvhpauSxtFZxw=;
	b=Rm0cXtLN1MpqBh5FEF1xF1yDA+4n6qaTJZXmKm8rGKeHi3PM3msGSDwaNxjEtid+JriI8f
	qqXLprD3Bc4OFjTFK0cfIBdp5CYBS1Q0ZGAHUtNOrrsROdpWNWnhxLNXJIoYZIrRMet56j
	AGy3Lo/8NXNpP1+kZrN+8QrSCGCB9XE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-r-AT5Z5PPC2z27FcPvGtPA-1; Tue, 24 Nov 2026 12:21:37 +0000
X-MC-Unique: r-AT5Z5PPC2z27FcPvGtPA-1
X-Mimecast-MFC-AGG-ID: r-AT5Z5PPC2z27FcPvGtPA_1795522896
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48df02b91f9so2869719f8f.1
        for <virtualization@lists.linux.dev>; Tue, 24 Nov 2026 04:21:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795522896; x=1796127696;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TzwipR1LCMAEarIzxU+ebA22tLIFqbxvhpauSxtFZxw=;
        b=Kk0z6Q3cA+o/Z8MVIGLvYH8CSj1nkM+K/yoRCy2FzMaXVhzHOVODjFk5W9Gwzx5OM8
         Opr7OIk9UfkA1K45ypIIZcK5Nwpr93zzxrRQ/7GzU+BM1FNNzsZhPTvrV1LNXfDkh29B
         PEkcMwlm7gH80mk7OpuYczChYg+2a8yvuSQDJ3zIDXbNdUEUPxE6j6wlnHWtXkWuuclo
         /+G++hl0ZIVn+mZmGIixgYIip0T2pO9RpQHw7S28FOKA+6Khrx3VX1AOOwPPrLPVrKw4
         tZDQkaVdk8IiEruqMWOc6f/MTif3yFrm4OiUDhkXfcF6UE+V0868I4qH7c7qq1pgF7VE
         yWDg==
X-Gm-Message-State: APuU4Z/tGIaRVp8kGHET+PMZ5g3KSJUtNlwACyczBluwRoLDxRueQ7f6
	SwDHlVUglFoG5sxUM1w+oGrZgyZ4aEbY/QrMI1sMAxqdu4qeljKDUQrYMMHefByxmr6odeSed7z
	Y0vjDbT7Erx8Hdgy27kJY34/llzaJ2MdXC/+rICACfWtsEbw+oQW4gZEfXbx5Du3zn5Se
X-Gm-Gg: AZFdTZdo/gbNevNeVOxa7+bxe5tFfc6HGABCeIsMe3UFPTV3GvReffgUQMCWD8tS9fg
	15AhqjnTQ1wpWJMALTC3RhHHtsFG8NQ5gZxWUjHX+xS9V0ojeLCdviCDeaPNYgnmLCp+lDCq+q+
	6inNa941JUiyXVB6Q5dDGptwb0ofp3dEGxkofIduC7HyH2p8aF2F/iZpqymlXMZp+l6OR4dg4TF
	5DIrQPE0smDSPRkL6Tpx7oCYjXJkbQW7uwTnUyMd0Npc9yNHMXH2aVL7sdWHy7ciiZcLVOfjKIj
	/6BT3Kl6unmQjE5+fhY+cZ27CBuJqyl/j0LoB6n5UI1b0yQt/mdQf9Vw5shmP1xkUEYQAiGCp7z
	0GlY1IGt7R9AO+0da+RbJp24Jpgyc2LP20Tn3rqRzXgCS2Bb+eIcWyTNvHGHkd4zijyrF2bt+GD
	YjcABqpwJeILs=
X-Received: by 2002:adf:e00c:0:10b0:4a9:6c58:1794 with SMTP id ffacd0b85a97d-4abb0b66bfbmr20062028f8f.10.1795522895744;
        Tue, 24 Nov 2026 04:21:35 -0800 (PST)
X-Received: by 2002:adf:e00c:0:10b0:4a9:6c58:1794 with SMTP id ffacd0b85a97d-4abb0b66bfbmr20061998f8f.10.1795522895343;
        Tue, 24 Nov 2026 04:21:35 -0800 (PST)
Received: from [192.168.0.19] (217.red-88-4-146.dynamicip.rima-tde.net. [88.4.146.217])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b110ba3sm22753198f8f.35.2026.11.24.04.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 04:21:34 -0800 (PST)
From: Sergio Lopez <slp@redhat.com>
Date: Tue, 24 Nov 2026 13:20:20 +0100
Subject: [PATCH RFC v4 2/8] vsock: report datagram receive and send queue
 state
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Message-Id: <20261124-vsock-dgram-support-v4-2-3607484e85e8@redhat.com>
References: <20261124-vsock-dgram-support-v4-0-3607484e85e8@redhat.com>
In-Reply-To: <20261124-vsock-dgram-support-v4-0-3607484e85e8@redhat.com>
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
 linux-doc@vger.kernel.org, Sashiko AI bot <sashiko-bot@kernel.org>, 
 Sergio Lopez <slp@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4270; i=slp@redhat.com;
 h=from:subject:message-id; bh=DAGnzS4beIxvhBc5LWV62Y4RCwEPeEYebUU+gVLqZ9Q=;
 b=owEBbQKS/ZANAwAKAfRpJ40vDAI1AcsmYgBrBYFDM0alN2qcB2uN4zvRdHQFPo6uBvEPQ9IoP
 7IXAHpQ1uGJAjMEAAEKAB0WIQS+1fz3US2GgJFC6KL0aSeNLwwCNQUCawWBQwAKCRD0aSeNLwwC
 NWJyD/44s7CCvnIfT0+tJ3gDVvgHW2kGx/HIvC6vIhUFdUwaB4b7MkZLyBshjtahlGFOlshLTuY
 ow/X1/NpwQcGM4B8xChp9k6ohdYWRBFVtq7B338KPsfiiTo+6PELxlOXjGUmpQr+AmMQACmCiFa
 xXBT0v2dGfywk/SU42+Uy+ErfSkNh0z2BKMwQyfcNbD+bOV2UY97+Hk1EGbmKZj1/2TfU8a5xBX
 iamcB1oTr3FJtt9LIYrgJeuszuq3ZFy3zlFk3VSatzgaSEEpV1d/ULS5jjLgPDDCXagO9F3Y7hS
 G1vXj7H7QZ7mSs4b37bgPMcrsv5jkMCp5adznc+DLkOTrN0oGL3FuyPPJeB5To1I9C907U8YZAO
 j/8+TRIEITbFARS31o5OLIShXeSS0I9Ckzgagv/ykEYWOdR53sy+upqVpP2svj0zP4UXJTmMbzP
 ec/lvuViSv0xOnR/kgyVDT5ngLpYw+eTYFR9M2nfpveZD7NY67T8IteY11MhinqubZzQKYLw+I8
 1H8SiRk2kvi6D6tjEFEplZcdR4041IDA7C5kIWrwB20+8wMTnJwBnkICA6nxrZC8+/sqbsV7fZj
 BxN6w8I1EYQxYkQ7TTBNoJE65G8BPvDgVKNx7cE7MB2HLMieKCo+h+sD4u8CHDVBjbSAzaLgTdI
 f7oadBmJ3O/SWsQ==
X-Developer-Key: i=slp@redhat.com; a=openpgp;
 fpr=BED5FCF7512D86809142E8A2F469278D2F0C0235
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 34bTINUGcz7ohHkU_OB1kQ2oq3WNnNwUXNja71wtb_0_1795522896
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Datagram receive queues hold whole messages, and transports may charge
queued datagrams to the socket send buffer. Report the size of the
next datagram payload for SIOCINQ under the receive-queue lock, so
concurrent recvmsg() cannot free the skb during the query. Let
transports override the length calculation to exclude headers such as
VMCI's.

Report datagram write readiness only while the send buffer has space.
Set the asynchronous no-space flag when it is full so freeing pending
send buffers can wake poll waiters.

Signed-off-by: Sergio Lopez <slp@redhat.com>
---
 include/net/af_vsock.h         |  2 ++
 net/vmw_vsock/af_vsock.c       | 32 ++++++++++++++++++++++++--------
 net/vmw_vsock/vmci_transport.c |  9 +++++++++
 3 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index ac061115ed30..e4fbea3b0e46 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -124,6 +124,8 @@ struct vsock_transport {
 	int (*dgram_enqueue)(struct vsock_sock *, struct sockaddr_vm *,
 			     struct msghdr *, size_t len);
 	bool (*dgram_allow)(struct vsock_sock *vsk, u32 cid, u32 port);
+	/* Optional payload length override, called with the receive queue locked. */
+	size_t (*dgram_payload_len)(const struct sk_buff *skb);
 
 	/* STREAM. */
 	/* TODO: stream_bind() */
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index d5cf240d4ece..8a271eb66860 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -1359,16 +1359,20 @@ static __poll_t vsock_poll(struct file *file, struct socket *sock,
 		mask |= vsock_poll_shutdown(sk, peer_shutdown);
 
 		/* For datagram sockets we can read if there is something in
-		 * the queue and write as long as the socket isn't shutdown for
-		 * sending.
+		 * the queue and write if the send buffer has space and the
+		 * socket isn't shutdown for sending.
 		 */
 		if (!skb_queue_empty_lockless(&sk->sk_receive_queue) ||
 		    (sk->sk_shutdown & RCV_SHUTDOWN)) {
 			mask |= EPOLLIN | EPOLLRDNORM;
 		}
 
-		if (!(sk->sk_shutdown & SEND_SHUTDOWN))
-			mask |= EPOLLOUT | EPOLLWRNORM | EPOLLWRBAND;
+		if (!(sk->sk_shutdown & SEND_SHUTDOWN)) {
+			if (sock_writeable(sk))
+				mask |= EPOLLOUT | EPOLLWRNORM | EPOLLWRBAND;
+			else
+				sk_set_bit(SOCKWQ_ASYNC_NOSPACE, sk);
+		}
 
 	} else if (sock_type_connectible(sk->sk_type)) {
 		const struct vsock_transport *transport;
@@ -1632,10 +1636,22 @@ static int vsock_do_ioctl(struct socket *sock, unsigned int cmd,
 			break;
 		}
 
-		n_bytes = vsock_stream_has_data(vsk);
-		if (n_bytes < 0) {
-			ret = n_bytes;
-			break;
+		if (sk->sk_type == SOCK_DGRAM) {
+			struct sk_buff *skb;
+
+			spin_lock_bh(&sk->sk_receive_queue.lock);
+			skb = skb_peek(&sk->sk_receive_queue);
+			if (skb && vsk->transport->dgram_payload_len)
+				n_bytes = vsk->transport->dgram_payload_len(skb);
+			else
+				n_bytes = skb ? skb->len : 0;
+			spin_unlock_bh(&sk->sk_receive_queue.lock);
+		} else {
+			n_bytes = vsock_stream_has_data(vsk);
+			if (n_bytes < 0) {
+				ret = n_bytes;
+				break;
+			}
 		}
 		ret = put_user(n_bytes, arg);
 		break;
diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
index 1f186e8f8364..2b9493e987d1 100644
--- a/net/vmw_vsock/vmci_transport.c
+++ b/net/vmw_vsock/vmci_transport.c
@@ -1761,6 +1761,14 @@ static int vmci_transport_dgram_enqueue(
 	return err - sizeof(*dg);
 }
 
+static size_t vmci_transport_dgram_payload_len(const struct sk_buff *skb)
+{
+	if (skb->len < sizeof(struct vmci_datagram))
+		return 0;
+
+	return skb->len - sizeof(struct vmci_datagram);
+}
+
 static int vmci_transport_dgram_dequeue(struct vsock_sock *vsk,
 					struct msghdr *msg, size_t len,
 					int flags)
@@ -2075,6 +2083,7 @@ static struct vsock_transport vmci_transport = {
 	.connect = vmci_transport_connect,
 	.dgram_bind = vmci_transport_dgram_bind,
 	.dgram_dequeue = vmci_transport_dgram_dequeue,
+	.dgram_payload_len = vmci_transport_dgram_payload_len,
 	.dgram_enqueue = vmci_transport_dgram_enqueue,
 	.dgram_allow = vmci_transport_dgram_allow,
 	.stream_dequeue = vmci_transport_stream_dequeue,

-- 
2.56.0

