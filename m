Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793203501;
	b=cqonjr/78RHzdhcBascGTma1vp1ZZteUMSmzIRyYrBeM450BUT9pP59G5Z9LXtNkG3ty
	 8SS7RxDw++wzpFxLqgaD2xdPL6Kjkrj9M8GgTXgMxhAf7kiF3QhIvMajWgq1VKPtV9qke
	 8+9soLgP7AzpJHZrA7WZSLsnQxVPOfKMoP0vj3RSuGQn0hdgRGy0cbcI5rw6Z5Itgk0us
	 Ij2n3EVz02Jdyh8qr6tpHpm18LDFRBcoiw1Y38D4qPxWlZygddUoHuNM2BtTn9v7/yet8
	 wi5dY+H54azF8DDzK3AlFOgR6X4OOwMfnugtYosfuIf7ITfFJNjrV2azOJFJeiKYgJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793203501;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=VToKcD9exB05u0wmkPQ4zmuhJE5oZK966jaJjguWNd0=;
	b=UZPRM62Q3xk/pqswm4I3rtBr8u382K98/8UjLaX6PTRh7ia7KdzNJtbmBLDwNVWJaQEQ
	 DTHI2hk5mod/cAyaFvpXZ3DSSLCam31ziUYuVZ+O4l1lF9xKwlQBLqzg56UBrHW/a/vef
	 /J13OTQSwtWFHU5O2Pqw774KQvyd+EH+0TzRfKSoN6AhBdftqyQAyeuscxhPzylC5rhZD
	 1VjFRGnpW6QhC5X2CF0OlXkJjByKhC4GUFLBAJAj1bF3yVhnz8m7ypFuoFHMZwdlAb/qV
	 BFdhZ8JI5fZvS0QbyINupsHVADQY67+bGlWs+9l6MPyJwexBAx50dlYPiTOHJwnXOsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MhQ9bZSm;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507AC60A261D
	for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 16:05:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 507AC60A261D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MhQ9bZSm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793203500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VToKcD9exB05u0wmkPQ4zmuhJE5oZK966jaJjguWNd0=;
	b=MhQ9bZSmE67o3+Uj403RkIxRj8Ir5+xiC+v/j3r7WvXl7ll3V3h1jZ82JGqGpG/abjvfML
	KgCD7EbFnrGPUYKO3L3jdEXUphlq7O8Y3mrJky4a+Dnq7v2tC3KuPBJPTVOYNGdWCiipwP
	F1tB8R2oUV7xrJZzogZQ4H35djisCOk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-548-v6eJCxO2MnWJ9Kq3fcZViA-1; Wed, 28 Oct 2026 12:04:59 -0400
X-MC-Unique: v6eJCxO2MnWJ9Kq3fcZViA-1
X-Mimecast-MFC-AGG-ID: v6eJCxO2MnWJ9Kq3fcZViA_1793203498
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48e1291432aso842758f8f.2
        for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 09:04:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793203498; x=1793808298;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VToKcD9exB05u0wmkPQ4zmuhJE5oZK966jaJjguWNd0=;
        b=Qj+OF1fJiU5swRXl7+ZsaH6Jz7etK5kYimegfxIT/cjBVpp2Z01LK+b2GAZy0uAGvV
         yIW4C7ljQ/aisaMnKIqUe52QfrKLlR/DES8D6TkvvzhQFodzmBZ5ifHYUEOgOqcFP96K
         nKwPry03IvNbIQjshqQ4YLRtqB+zKypRdVUFGXU0f48dycTvyvywwNy6JZa8fSKqmS4U
         qmwAsqzLv6Y/Mpd5RY9AmJeNlISPmMJ+sbr/vcQnSm7s/3alQfhK1YFr2ngzeG6s32GZ
         8RAEKUNIxjaMFjvsq3l261yqN3XPuTihLRRge02qnwppgib7QP6k5xh6yWU+wNwmc1ju
         FgIA==
X-Gm-Message-State: AFq9FYLpuww4aagUGqanMcZMg0qby7tKBaiE0YM2SHkez8MbItISvd5N
	4C+2hhGOc6ElyUDg88vprvDKH0w/D0riJCs2GkySE/480PDO7jT3Z7RD82r9T9Alx+x5Cd043Bm
	8oKN7nAwDbbHz0lhNy43cTWuFhdeqZHmbw0PDXub2c5d2VaR8ckisb+cGMYU7Q+HzAIkH
X-Gm-Gg: AYBFou16BxohkNQgU9HF5iRXCm8/Vjv4BjHkWETYTnCmOJ7AJb78rq2+BSxXOAF0j30
	qPCcPEx3YeBUWuwzOeECTgPC+KCxhMZ0OmB5l85SA1oMIMx4glyzyjOmef7eDuxbs48WVLQcpKz
	FKHJlistuZgKC7Wz5TlvLJtGO9IGfkxQg8M1pWnpzJ+xo6oN7Wa4EKmSsxDPI/8rdBicl5dtbz/
	tdTxoJwh9S4Fucxa2ZdFCSW+f34Rdw+vW4dxBnxEfXjtk2azsAPV5ndfZDL1fae17oKOJFuqEGY
	pE7ni4grzPWqcLi2VV4QiR/w3FPdwh4LTVAugLK34rnE0rcn4lGwBEz7NjJEbqhKrToPaU9orvV
	sCw0vAUEDNxvNUYo53Rm1ffWfrptbq+oHMdfdAnwEeCJpoaUG/7JI5SCofOU4JAilaAU4FKhP23
	BOwimkl5Nu/SM=
X-Received: by 2002:a5d:6f0b:0:b0:48d:f0e4:27a4 with SMTP id ffacd0b85a97d-48e5d5c6fe4mr6785814f8f.24.1793203497900;
        Wed, 28 Oct 2026 09:04:57 -0700 (PDT)
X-Received: by 2002:a5d:6f0b:0:b0:48d:f0e4:27a4 with SMTP id ffacd0b85a97d-48e5d5c6fe4mr6785713f8f.24.1793203497394;
        Wed, 28 Oct 2026 09:04:57 -0700 (PDT)
Received: from [192.168.0.19] (217.red-88-4-146.dynamicip.rima-tde.net. [88.4.146.217])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebd47basm31898410f8f.32.2026.10.28.09.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:04:56 -0700 (PDT)
From: Sergio Lopez <slp@redhat.com>
Date: Wed, 28 Oct 2026 17:04:31 +0100
Subject: [PATCH RFC 2/8] vsock: report datagram receive and send queue
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
Message-Id: <20261028-vsock-dgram-support-v1-2-e457cf7cee78@sinrega.org>
References: <20261028-vsock-dgram-support-v1-0-e457cf7cee78@sinrega.org>
In-Reply-To: <20261028-vsock-dgram-support-v1-0-e457cf7cee78@sinrega.org>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>, 
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
 Dexuan Cui <decui@microsoft.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, bpf@vger.kernel.org, 
 linux-hyperv@vger.kernel.org, Sergio Lopez <slp@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4270; i=slp@sinrega.org;
 h=from:subject:message-id; bh=WVlKgJMoA9cer/yRiYHMwmDZxpTADMU0XzrISzF2HDw=;
 b=owEBbQKS/ZANAwAKAfRpJ40vDAI1AcsmYgBq4h0cCC2WdG4G+W0eDlbVWxWN7XHmMk8djieLa
 ArqExYppPiJAjMEAAEKAB0WIQS+1fz3US2GgJFC6KL0aSeNLwwCNQUCauIdHAAKCRD0aSeNLwwC
 NYrOEACfPbC9AhTS1tqaaVJrhHYajwVLLx0wyc/uD3GQKasz9wtW04pgfy2dv4m8p9B8HJkP1hM
 dEwEHnk2w/Pqc0q97k/cID1zq/pWkHH4EpvuJQjS6V4JncEe82siIv9QgoI22BLX+MWgx0s14qX
 tSFNbpnlhZILA1Gr7WOIUT56+fDuEtthBjzM38ovfgJsJqSLyYJuycyfAX4KpqrQUb+wIr8cYx3
 n4XPwfehB8+oyo13u4DRagj2echrQ6ISu2lMk+vBgXXrecINXvsy+t/qdjKbjGGN/eV+a35fegP
 NJ9VXSdLxLAuQzbYDQUDoA5wde/Wo11Ju0GDwN5m3tTfGSwCZshHkBIhAVk7FxQ44qmGzKt4I5/
 VJughrbHN1Otuvdcru0r3uX1nvijOM/58er0L5eKNM41fpPhsADirw2UNIwfZoFnZHfKIsd1jwP
 ipSyaJJKRCM60ptwlRfsUxvikHpUIMfrF5F5LWPBSDJYR6qC5bTOxuPG9BpllDal/1KY35pwTdA
 ofneAOt6DSuWd3GVEPJ2Rt07x3NJCnhcZz4GBfCcFTo6FRvfAEZ0EVmj5vJSX6n2ymPluJydcEc
 NMaDx98F9tslw0FyCUNtuc25G8b/B2TtARI5JLLt8Fv97FGQb1PPDoudl83Nk5GQ6oAcD/LiQLt
 otlGbIjCgvO9Gtw==
X-Developer-Key: i=slp@sinrega.org; a=openpgp;
 fpr=BED5FCF7512D86809142E8A2F469278D2F0C0235
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: G2FihZ3K0YYbR8Oe0EPoJGEpYsoxw0nUN8p5KyyHS5M_1793203498
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
index 19bd9c1c3e5b..0c8b8a815b04 100644
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
index 5d1d85e5f519..dc1add2d2e89 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -1344,16 +1344,20 @@ static __poll_t vsock_poll(struct file *file, struct socket *sock,
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
@@ -1617,10 +1621,22 @@ static int vsock_do_ioctl(struct socket *sock, unsigned int cmd,
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

