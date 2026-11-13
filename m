Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794590171;
	b=UieoIhl37jPA9oMdyXPvy6jZ9zd48gFFwhSohsj7nvqbG90FanbJnPlWTsVTZmVWMEzh
	 B/L84vzwQpmkr/0VBCKj4r28aIWXq/z4S2hLA6li45uBlmrQhDTYrvhN3QDuQgIQv4aKp
	 fHnJvTspE3g6ljP5T8fc6/n5CZUrem+NS43Ha6qeFrMmjCiD4bQGNQxyF/92DyVDHgDKC
	 MppfO0oz+IVdcc89ZLTUUWEtJQnx1v767fHkkCVpnxsu6pFdqQTVJcxweRqNhn1+3bwYm
	 xdfkjYRlWoqf4muMI5HcFYU6zaoNM14OIvnYONlZi93LY5MKaVYIpQFzYshmnwZOT8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794590171;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=TzwipR1LCMAEarIzxU+ebA22tLIFqbxvhpauSxtFZxw=;
	b=mdARBwDWTbzd63iuogh3Ie7WLb66IFRjkC0f6IyA46F9rOplz6bhHvI5BjEJZbY8mgJv
	 BFq6hXYr0R85M1Eria/8+drI9X+wbArLRLpEaZbeDwtCEQXT0OJPbYnOQ1aNPPjrht7c9
	 9SBSnPiYzY+cPCcCuRZ2y75SB3KfKbQbZML6EeSy6eSXYfI7e6YqV01qIu3SzkHuPjZZN
	 XluzOrzzvKuNvMgUME4bMyE40C/kF/DtFP2z7+hFc4v1m1L1i20r52mSLKz4attaOBOuz
	 dz54w0Fis2IQkT3LBaLwPvAqn14FdFhFg+xaUAz0MxI/fH6FsZkqn34G/a+MJd9wlxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=a8QdYgDN;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7688606E654
	for <virtualization@lists.linux.dev>; Fri, 13 Nov 2026 17:16:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7688606E654
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=a8QdYgDN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794590169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TzwipR1LCMAEarIzxU+ebA22tLIFqbxvhpauSxtFZxw=;
	b=a8QdYgDN8AudaG5YD+oJ1jjouCKb66LW+eR52d+htCnqs60amomEeKzM3kbe2ld0P+7QCV
	wzCyEHMJ6B0po+LcfA/N/aSnIRYgp+9CtoKzAoURSPVO+a69KCbOTDihdYfcVwu0DCqp/+
	FGCo5bkw4Fsy7JPew7PowrEIldWCP2o=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-jKlZJOB_NXGXXl-flqpa7A-1; Fri, 13 Nov 2026 12:16:08 -0500
X-MC-Unique: jKlZJOB_NXGXXl-flqpa7A-1
X-Mimecast-MFC-AGG-ID: jKlZJOB_NXGXXl-flqpa7A_1794590167
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-490ab0a20ebso783543f8f.1
        for <virtualization@lists.linux.dev>; Fri, 13 Nov 2026 09:16:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794590167; x=1795194967;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TzwipR1LCMAEarIzxU+ebA22tLIFqbxvhpauSxtFZxw=;
        b=WOS3Qdi8Q+6+y2Vxq4vgwNsYb70w4oDoLLHNYlOXvHd4JrairJsVdgxwh4twhqpkza
         0F0pnAFUq+XyQa8uqD6sOy9Fsu9D77cBp99TBeEL1wpuEfkKH0ea44S73PAAFB1HkJRg
         dg4Nw1ny7pOL1Z9MNBgHeU+b0c0ksOFEjCYFAV0mERuCZClIj1YYlP0GwtV1r5k/umXs
         DZTrNeyYv/3L2KoAfy6lzWNsPf3ygOTNwpJVbGzqtzAdzA0OQMFTw6L9NOMBDMKAEJZB
         XyOsujstyOBeQFczPZLq2VH7N5KuUvmiKANmz9lLxx/WmA+QwpOwNiGP3NOImfR1gHwp
         Gq6g==
X-Gm-Message-State: APuU4Z9Spb2b1CswXuW0xqYuypP/gLSAWbXC0md7hOHFGttSD6C6GpSB
	HP32Pijf7x/QnB9K7hgOx8InPUjaIQSPSOo9WTAFBJEndRTi2ufbYK1+n6HTKihAtBEzjPGdYtl
	ZxCRtdKFbdiAOXYMTss5ijJyialPRYRmm4O9+ECDSn+q0O/ARvW6ND2rml0h0TmKL21nE
X-Gm-Gg: AYBFou19M61KqchDiCqQZ0McPfO9OO6T0zaOkQR7KmSAvDDc6sDFuM5+XulfY1lFFA3
	4Dr3P+Hmmk7/lDCauWl+Q5Ur06ZOt8veosrcOptoMxxGWCv4sYainluWp9LXyyZJ5aJ9qT/dIEz
	8mtdxCiy98H+9LY3nYAzgei5yxhugM+HdE6JyQGMNgeD+8SEwUxF8z5F6t+5Zlwbg0kEQNHiY8r
	2igkKIM+ld7AsZla2xk6mBNZCZtnVbYNRt2tvTxFCDNlYqIKnHvLU0hpWq4OUwkkT3TESk49Pu0
	Ex4JtTTSPi5UFtS/XHHX9G1ydo8AHUTkqnkaSAWkKM/2sACjNhjvWz2C+cS3nbLwdxomsUL1IjZ
	neLWxxE1El/aww+puZfFJdp+0CKEOYtpivrhOK6TSI/WQKCAnEH2db+lbMfrT+rwvx6aDMCaakQ
	EZ/0Aa/su1oBA=
X-Received: by 2002:a05:6000:490a:b0:48e:353b:9f28 with SMTP id ffacd0b85a97d-49c6dc01369mr7027356f8f.1.1794590167344;
        Fri, 13 Nov 2026 09:16:07 -0800 (PST)
X-Received: by 2002:a05:6000:490a:b0:48e:353b:9f28 with SMTP id ffacd0b85a97d-49c6dc01369mr7027274f8f.1.1794590166887;
        Fri, 13 Nov 2026 09:16:06 -0800 (PST)
Received: from [192.168.0.19] (217.red-88-4-146.dynamicip.rima-tde.net. [88.4.146.217])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c7da37b19sm5811907f8f.5.2026.11.13.09.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 09:16:06 -0800 (PST)
From: Sergio Lopez <slp@redhat.com>
Date: Fri, 13 Nov 2026 18:15:42 +0100
Subject: [PATCH RFC v3 2/8] vsock: report datagram receive and send queue
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
Message-Id: <20261113-vsock-dgram-support-v3-2-1523c8e9b27e@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4270; i=slp@redhat.com;
 h=from:subject:message-id; bh=DAGnzS4beIxvhBc5LWV62Y4RCwEPeEYebUU+gVLqZ9Q=;
 b=owEBbQKS/ZANAwAKAfRpJ40vDAI1AcsmYgBq90XIreajZ9sPLqnxrRyNPvzJRU0Io7e2OxtiN
 6rwdgMKWyyJAjMEAAEKAB0WIQS+1fz3US2GgJFC6KL0aSeNLwwCNQUCavdFyAAKCRD0aSeNLwwC
 NaHAEACQ95E153IO/phwfTijz24avrBMLZWaj9Ed8fBh5YY68WHbWnE1aCms+dqMaB24KPyE7wb
 X0zpl1q3dDmzYvkvYgR8YOFtwOxgj5Ga22RREE4aoqjaE9BILwVLCjbHTljdK3N23nW0z5OIJJU
 KM9V4A9rgbHVKYAERIKfcI9+4fB4C5DUsWE4HKbhfxYkvN/BT/gAPKFaF/L80BlN7fyoEtp+OV8
 UEYPaEm5QiV3f5TgHRFkmp8535mnJfXbMEQC7qU3/3SAdjqjN2OIWsR2eBT3b8/iFWrAtYXN+P3
 IJYjf/LIMYiWXOyYLx5j77BIpX8JiCgeO+G6YdqmNKcA5DO5qVUI91DL+5t/XfIJGKYROrGcwvb
 Oaob46SOwl4/+c6ic3yTyEp5d1lGaXn1NDaXCKySFZ0YlMhJJ0BjpKIVmF8ovJ7KeEEI52BN2ej
 RwDQmuqdcFYIPIFqsRcfjTM6noI91hyS3XnFOdVCz4O3w+nCEaRPi/X5cFA8NKJiVlTzVKft/OD
 R7nDEQsMsBOd+vzZSpfzd2lhx2zhcp5nkfX6EIU6GToqnbnpmALJJMn0dVBb+sh5iVBICPyfiHT
 Z8unW8scI/2K34XYCpyHvlEnze02bpd1ka1UG2EGtWlGoaNmv0dI3FK9vdKArxiDF5unKDxrfHL
 bMHFCEaNYrenSvA==
X-Developer-Key: i=slp@redhat.com; a=openpgp;
 fpr=BED5FCF7512D86809142E8A2F469278D2F0C0235
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: da9JqkHpx3sBh3wTISUmQdJPmtORVrU_KhknZhZ3GhQ_1794590167
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

