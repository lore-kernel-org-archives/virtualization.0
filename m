Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794574192;
	b=ieDL7CweIvjcW2pIH82JpovKv7D+XqBZVZe31rY5P4Ifr+TcWPz/zkHbSxXBox90qfVW
	 TpQSB/6qXwe//YK4LgKOP0pCkUIbUM4ywAKhgg+T7J/uhC4Py0SWP/6Zkpm9tYHvw9B/b
	 dZpnD2XcGw/yYJLoRjrMhvj5UPTqdbB3WRvLOd+qTJqsJ+Jvp6wYa1ZIlIyYVacAchbfv
	 BQmEijePFmikyrv09OBCA7A2wY9BtGiGKPfDos/Ft3JVZyl2HL1h5fpZVDIkNrUy8+pl4
	 g7E68B7GSMNDj8tpcSVxNFjPeRozn+leyM30HWWuR7zoZ6ztAXzvlhV8dhAhSi0+9rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794574192;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=TzwipR1LCMAEarIzxU+ebA22tLIFqbxvhpauSxtFZxw=;
	b=pOpiS/VjJ2wvm6WFKXikDcn/hjWpqEuLG3WkZXXB+9Ci424M/tSqC3K51v4tsfvqJJMR
	 dsq+JC/c9T4n0zII4ozmpRITR0GA0r9KkajReLG68bh74mJ1FPxSGv340ZgNl4Irn+iFZ
	 PhMsj4hg+yyBcSJXx4tMUko9WmGaQ7Y0j3NKd0Yvj7hS4yspjyDh4lQZSU5GH41Tquhns
	 l4FZ/c6SlX22Xlsl6tg0/SiEyDlkFolV7XVN32ngmKwFJqxKw+qNTgThbR+kTZQa1xpQu
	 bd+elqfD1uLy6Z7hD0AJ/pugoE8gvWovfnFi7IWa8B/JZ7gifdt18hmNpkKM8nbBw5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ufs+XkD1;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C8A606A33D
	for <virtualization@lists.linux.dev>; Fri, 13 Nov 2026 12:49:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94C8A606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ufs+XkD1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794574190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TzwipR1LCMAEarIzxU+ebA22tLIFqbxvhpauSxtFZxw=;
	b=Ufs+XkD1JsW2snGybwJeCFbsxdmrSizDVvAn0b9KAshLaUTqOiF8RacB3wwj76Kw1QQVTC
	L8ut/9FxvLxEW7pSEPtX3rb+ugWNBk0euZPn95KWbgYD9KTqbkrpp5dmeq14akbXy7nRZk
	7G91PsAUrCYd+zYfvSNSjljLniyMuME=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-Ji13y0VgNQiGzpkwZ_mx6w-1; Fri, 13 Nov 2026 07:49:49 -0500
X-MC-Unique: Ji13y0VgNQiGzpkwZ_mx6w-1
X-Mimecast-MFC-AGG-ID: Ji13y0VgNQiGzpkwZ_mx6w_1794574188
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-49205554e17so457834f8f.1
        for <virtualization@lists.linux.dev>; Fri, 13 Nov 2026 04:49:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794574188; x=1795178988;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TzwipR1LCMAEarIzxU+ebA22tLIFqbxvhpauSxtFZxw=;
        b=hEenHFWJic9XS3rskBu5epvyHkaU6InRL36YBEpDCI/zY7NtVLX/HvgSkvHe2JJhIN
         +Epo+jQdi2NZ9v33OvD8nhPSsRVSInEgtNinY7dt8unRhxyOicj2sa/B+SYmesCxsYkB
         h/NbVHJfAMDuhQ1u4ZFVKDCNng9OA6WrvkG+z8rg8T1Mrps6zwzOE83ZJcGhJuLHOZM8
         mnycx6EzO4i3ddSmnmg56f7sU9oZ5lPMwNPKY6MYn0Xs2CH8o9E3OCfnjmSMjpowEaRX
         tqXFvugqEIDUmXLT9KIJJe/HwQ/ZVwlYXjJVoXRbIWaeWfObmBAy9A9BFLVR8FbJBq+e
         8xFA==
X-Gm-Message-State: APuU4Z/JfEeZAuHHX1slwDi782P1Gu/xxplLKLPHCU5+TTVNr0r8ppiI
	iBzkihLJpYskUb7XkAl+RvZE99fW6E6BI8zs5vAn2IeXpV5qJswi/r+umDfQwux6rV1txM+T/vI
	QDy2VqHyAGpEP4SAvvf2vc4AJj8Nj/DaKtUDykFUk74JzZsmzz70MxEmHxKP/1x19HipZ
X-Gm-Gg: AYBFou2JzqWg9ZXZHx0qHvX8Bn4++nES1WvGK4tWuf6alHDmphHJfuMmxIAM5nQno67
	8umoq/ugX92Akh6NQ7U4ywmtrUk+UcqUDpE49Jml90S9yGMRFAQKVfV3zG/MDkq8ni2Jr/VNSVO
	N0tBzemUzVUMJavIaMxEVTTUgQ5eKl/j2ZxjBRhuIEzucbjtiX3sg5ZfiB1zA/LwHIZZXH7r8pt
	hMldcWnd3ZPgYYoYVaSFxPOgbgWbFEOxe74S1V0gTIeBgSn9ONIYJh798d3SLZB4wMUlVQZ0IX5
	QV9SC/H4y3AnapEknksSEyOBaRHNA7g72RfM4tuWANyQxD+xGNmIUMzHvtxCaClBruNBxpFpMFw
	38aqwbKCPwhct3gkASEXaz14WWXnYxFlu3gkW5lxJiLp6UZGk4AN8SsKaDCL1L9U04bkOAv//U0
	dHZOceN1jsqc8=
X-Received: by 2002:a05:600c:a30e:b0:4a6:42cc:bf66 with SMTP id 5b1f17b1804b1-4bb55a5d63fmr43628965e9.11.1794574188165;
        Fri, 13 Nov 2026 04:49:48 -0800 (PST)
X-Received: by 2002:a05:600c:a30e:b0:4a6:42cc:bf66 with SMTP id 5b1f17b1804b1-4bb55a5d63fmr43628375e9.11.1794574187689;
        Fri, 13 Nov 2026 04:49:47 -0800 (PST)
Received: from [192.168.0.19] (217.red-88-4-146.dynamicip.rima-tde.net. [88.4.146.217])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e2adf53sm151135805e9.15.2026.11.13.04.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 04:49:45 -0800 (PST)
From: Sergio Lopez <slp@redhat.com>
Date: Fri, 13 Nov 2026 13:47:35 +0100
Subject: [PATCH RFC v2 2/8] vsock: report datagram receive and send queue
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
Message-Id: <20261113-vsock-dgram-support-v2-2-bacfc85b71ce@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4270; i=slp@redhat.com;
 h=from:subject:message-id; bh=DAGnzS4beIxvhBc5LWV62Y4RCwEPeEYebUU+gVLqZ9Q=;
 b=owEBbQKS/ZANAwAKAfRpJ40vDAI1AcsmYgBq9wdc1HVuwZr7WAO3p5X3i9Hbncg0wLnW2CWGa
 dt8UHDsRAGJAjMEAAEKAB0WIQS+1fz3US2GgJFC6KL0aSeNLwwCNQUCavcHXAAKCRD0aSeNLwwC
 Ne95D/4xcEjEk6TsQj6Ph8foZvuU98DdLBcYKq+Lywy9+F8qDFnfQY7bzbWE3k0FAswmveRqM9n
 pBPGB7f2ZPGyg5EMdAEUL1HQd2TtMVa0soWaiphkuqn/P72rTNImirhe6RFeX9yynltp0UgQ2DH
 ZogLxK6KPSrRl5ThiNzbF+La2F94WXzvfytjX2MbFhQP7CyyrjkmrUUZJd6YEoo+1fsTb1dRvBG
 D2HSG3i3C+M0K4KqIZObgWkfzaqKCYyqtqMsqbMED93+wpapn2copA/Zs18H578VdZRj/URVj2Y
 0i6QDx5WlAa/FX7MBkp+FsjiPgaOmrP7MAWiu9fLmVRj7PlKppl/X8j0LtGDOgq/Y+J54ZXlWa8
 VQVT/VqTVvFG+lXUtA6//a9k9ytewq3ZOXiEZpldYKURp5E47aLuRA9YwZ6Z/mIY0tAs8zdg7l9
 o6bnO2mC2sFMFlRGcz2/o/4RVadRtdDQrmQqwCfxfz5HmL2SRA6wzKWEVPS/Tg1aCe3YgsEoGzC
 ywsKTw7HVls7gnJz1GmtgR687mjJpN+ELLSAGwWS7unPCdyhGNU0JgZArRz9m2nNbuCMSdrPwrG
 EcIiZyURGquQ+Z94G9Oh6MSlbYNcflDRo2Wk/lglGuImynATDU82u8wQuOcvkPBkeGw7Hlmguk7
 zjlR5wTokFxLAxg==
X-Developer-Key: i=slp@redhat.com; a=openpgp;
 fpr=BED5FCF7512D86809142E8A2F469278D2F0C0235
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: NX1cLPWoS_lp6w8tv0sDrqZtTlSWU3BUootelkCsXBg_1794574188
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

