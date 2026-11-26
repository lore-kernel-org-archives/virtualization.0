Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795713115;
	b=NrTYpcy9f5OxYuDqKg0hbIy1aqp8slS1YBAPvHT7A5McZZ8quomCvbHoK1qYAVsJH0yR
	 uYiYeGXLIYYLNjTl+4iTPVy2Yc0tasRP1Hm6rJniiyvXbgMyCKToZ1twaeVix3NdbZA/c
	 hJrU7SkeUuPoOpd84rBtXNEH6Bm6tdyei/sftRQ8DL/5u1gwbfhjO3DzTtXAujWyJ+WH+
	 aZV/XBkexXaWxf4pwi/xMlnz8MEoGlLSo3fEJw6vKhFaiArzZCKLzSwJXZR6B4b9CetUb
	 ny5hJKAxppKfQdh8nOxIMCxiH42tHHd1W+CdcVzEcg8iO9AD3B4ZpeKxaioaFKs09DA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795713115;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=zcsn+s07qIWSCH6CAt8hTslj76QVGyHgKy0O9c7o/Tg=;
	b=fAvlTS1fXYxp1FtsrpPtAV2sstYsDG/vDnumRgiNM5QY1TCY42UgSRc88cQOPMkXIuKf
	 BqnswDF95hJTn4B+0PQ+XP7hhNACzl5qahSna3AfLQ+jwdiUEIGA5MKqrKzpCFa/wb+lS
	 /uVu8Ueh7+0vkS/b+CrRPtJWQkhw2E7/BuPjXCHTiWL7ZoiD5S9lx4GriVSe6M/NYsiv+
	 IadYWUX5xQY96UrcKCm8WtFoWDjTTsiKv3S60BAyrAlzu1N0UCCNdpA70oPq7ufmWgX25
	 GiNKihjhOQDR/u7bhC3uPuRaW62oNAIag2IbAhKPQhFxbPGg3OsEL8OHnwzjQMBCZPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TWdAx69I;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30834606A326
	for <virtualization@lists.linux.dev>; Thu, 26 Nov 2026 17:11:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30834606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TWdAx69I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795713114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zcsn+s07qIWSCH6CAt8hTslj76QVGyHgKy0O9c7o/Tg=;
	b=TWdAx69IrYARhTQfZ2JmEinERFzAxF+LtOGWTRh+c/F34S6nk+zuEfj66aownViQk77h/e
	SY6q0w76eF0/H+X4bQo+D4/0ckOOrbs1iDtUCpMKb2RwL8DL61UWEV8Qu8gWnHqRsle6ST
	jkAyQ98lr/78engHuv017Az8iLc1yTc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-184-qQif7NjlOjy-OueFLBSwpQ-1; Thu, 26 Nov 2026 17:11:52 +0000
X-MC-Unique: qQif7NjlOjy-OueFLBSwpQ-1
X-Mimecast-MFC-AGG-ID: qQif7NjlOjy-OueFLBSwpQ_1795713111
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-4a3705ea6ccso4037027f8f.2
        for <virtualization@lists.linux.dev>; Thu, 26 Nov 2026 09:11:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795713111; x=1796317911;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zcsn+s07qIWSCH6CAt8hTslj76QVGyHgKy0O9c7o/Tg=;
        b=gQ51KAXfRbeqrNd8TThDT2g5efoP/5bGxfftSXgD9HIYdjxIVvXrx4h2jEczU1vdZ+
         EonnskDy8ELEfcrXflK+1fUMFMSmS4Bo8ovb+0fDpMxYtZa9uRq69njw4CP9y0XR3TXk
         xV3iqlm+lyRjL8XxNeTwVQj7gqytPVvp66Ix1SX5wlE6T+C7F9vQefFyG8/XNjUFDGQV
         Q09ZUphrkX7IU/HxMnttvTK4M9rW3aS4CFJ64JVEQ3UqcMkuZlRaR6cBaBde2cOo5WM2
         pSlteIzQBLVq0qxFrZ2DlboZKqHW/CPmtfYnU5RlYqXKVfYf90D7obtDbCk+iRsi5BGs
         A+Ow==
X-Forwarded-Encrypted: i=1; AL+hErFCPOkb/XL99T52T7phoF+PxIhD947ByvsPn6Gwq4g3P+viwajEk0vkzQxxONW5KWGgNcOKDvhz3VGHb+THlQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z/wChf1W/i2wtjMOyT2A/ROw8x7pNddjGg3V5iKcearDDxiHBpf
	otsoGfdSajqBzsXuDYFwjHFHTOGAAu6GX6wkY6rTjyz1hBWdq1x61cIo1wA8KDAi96marunjykI
	OBwOrZKiWeC8RQ6XQ1Wec3ILTsb56+dGZHALLnm8plvDxFybuQk31Jims4H6W0zgdo+N7
X-Gm-Gg: AZFdTZcUCbPasrqblYpdu7a6OuMFC6cX0UVZgHuq0yUPzmcYGU1t+kxJWBGO+tSrOZv
	q2xwy5xBqkLosXlsrBxqIsRiyozD37B4ECgNJCpKMley2mn0jyomV/dEUKzO7BLQ6Qkx65N2eVM
	22Ra8dPL/GkrA6AcpBXZpDYl/E7+wytm/RV6BXTWwwJLxSsnmD8jZt/SLZz5aghnQsUjp0oxpxy
	NIZTLwOatyhh2lLMaya9VGrf7yTTLyeo68URnWeIj+iCeeEYaq6VMNwPUFQl5O4PzmU5JLT0jSz
	rclMwKlmTQK9BGLkx2kyKtZIu9hOOLHQ6r4VvUzAXiCVFSDxk97MOerH1t1ni5VU6K9oyimPcUi
	5lUrt3QSGbboaXZiLW/FChszzykdUpiU82aj6ucmcHbz5MKITKeIWOQ==
X-Received: by 2002:a05:6000:186b:b0:4a6:4f35:336b with SMTP id ffacd0b85a97d-4abab02c60amr43563856f8f.5.1795713110927;
        Thu, 26 Nov 2026 09:11:50 -0800 (PST)
X-Received: by 2002:a05:6000:186b:b0:4a6:4f35:336b with SMTP id ffacd0b85a97d-4abab02c60amr43563788f8f.5.1795713110359;
        Thu, 26 Nov 2026 09:11:50 -0800 (PST)
Received: from sgarzare-redhat ([80.116.143.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b10b5f6sm39482837f8f.34.2026.11.26.09.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 09:11:48 -0800 (PST)
Date: Thu, 26 Nov 2026 18:11:40 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Sergio Lopez <slp@redhat.com>
Cc: Bobby Eshleman <bobbyeshleman@meta.com>, 
	Alexei Starovoitov <ast@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, bpf@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, 
	Sashiko AI bot <sashiko-bot@kernel.org>
Subject: Re: [PATCH RFC v4 2/8] vsock: report datagram receive and send queue
 state
Message-ID: <awhnykxnmbUH3tlG@sgarzare-redhat>
References: <20261124-vsock-dgram-support-v4-0-3607484e85e8@redhat.com>
 <20261124-vsock-dgram-support-v4-2-3607484e85e8@redhat.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261124-vsock-dgram-support-v4-2-3607484e85e8@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MMmRkdrn8mEmyPHXlIG6Yop7p3u9zWNC8cCXFibcuVQ_1795713111
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Nov 24, 2026 at 01:20:20PM +0100, Sergio Lopez wrote:
>Datagram receive queues hold whole messages, and transports may charge
>queued datagrams to the socket send buffer. Report the size of the
>next datagram payload for SIOCINQ under the receive-queue lock, so

Why only the size of the next datagram?

>concurrent recvmsg() cannot free the skb during the query. Let
>transports override the length calculation to exclude headers such as
>VMCI's.
>
>Report datagram write readiness only while the send buffer has space.
>Set the asynchronous no-space flag when it is full so freeing pending
>send buffers can wake poll waiters.
>
>Signed-off-by: Sergio Lopez <slp@redhat.com>
>---
> include/net/af_vsock.h         |  2 ++
> net/vmw_vsock/af_vsock.c       | 32 ++++++++++++++++++++++++--------
> net/vmw_vsock/vmci_transport.c |  9 +++++++++
> 3 files changed, 35 insertions(+), 8 deletions(-)
>
>diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
>index ac061115ed30..e4fbea3b0e46 100644
>--- a/include/net/af_vsock.h
>+++ b/include/net/af_vsock.h
>@@ -124,6 +124,8 @@ struct vsock_transport {
> 	int (*dgram_enqueue)(struct vsock_sock *, struct sockaddr_vm *,
> 			     struct msghdr *, size_t len);
> 	bool (*dgram_allow)(struct vsock_sock *vsk, u32 cid, u32 port);
>+	/* Optional payload length override, called with the receive queue locked. */
>+	size_t (*dgram_payload_len)(const struct sk_buff *skb);

I was trying to figure out how it was implemented for virtio with the 
entire series applied to see if it's just a constant, and thus avoid a 
callback, but I noticed that it's removed afterward. What's the point of 
adding it in this patch and removing it right after?

Thanks,
Stefano

>
> 	/* STREAM. */
> 	/* TODO: stream_bind() */
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index d5cf240d4ece..8a271eb66860 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1359,16 +1359,20 @@ static __poll_t vsock_poll(struct file *file, struct socket *sock,
> 		mask |= vsock_poll_shutdown(sk, peer_shutdown);
>
> 		/* For datagram sockets we can read if there is something in
>-		 * the queue and write as long as the socket isn't shutdown for
>-		 * sending.
>+		 * the queue and write if the send buffer has space and the
>+		 * socket isn't shutdown for sending.
> 		 */
> 		if (!skb_queue_empty_lockless(&sk->sk_receive_queue) ||
> 		    (sk->sk_shutdown & RCV_SHUTDOWN)) {
> 			mask |= EPOLLIN | EPOLLRDNORM;
> 		}
>
>-		if (!(sk->sk_shutdown & SEND_SHUTDOWN))
>-			mask |= EPOLLOUT | EPOLLWRNORM | EPOLLWRBAND;
>+		if (!(sk->sk_shutdown & SEND_SHUTDOWN)) {
>+			if (sock_writeable(sk))
>+				mask |= EPOLLOUT | EPOLLWRNORM | EPOLLWRBAND;
>+			else
>+				sk_set_bit(SOCKWQ_ASYNC_NOSPACE, sk);
>+		}
>
> 	} else if (sock_type_connectible(sk->sk_type)) {
> 		const struct vsock_transport *transport;
>@@ -1632,10 +1636,22 @@ static int vsock_do_ioctl(struct socket *sock, unsigned int cmd,
> 			break;
> 		}
>
>-		n_bytes = vsock_stream_has_data(vsk);
>-		if (n_bytes < 0) {
>-			ret = n_bytes;
>-			break;
>+		if (sk->sk_type == SOCK_DGRAM) {
>+			struct sk_buff *skb;
>+
>+			spin_lock_bh(&sk->sk_receive_queue.lock);
>+			skb = skb_peek(&sk->sk_receive_queue);
>+			if (skb && vsk->transport->dgram_payload_len)
>+				n_bytes = vsk->transport->dgram_payload_len(skb);
>+			else
>+				n_bytes = skb ? skb->len : 0;
>+			spin_unlock_bh(&sk->sk_receive_queue.lock);
>+		} else {
>+			n_bytes = vsock_stream_has_data(vsk);
>+			if (n_bytes < 0) {
>+				ret = n_bytes;
>+				break;
>+			}
> 		}
> 		ret = put_user(n_bytes, arg);
> 		break;
>diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
>index 1f186e8f8364..2b9493e987d1 100644
>--- a/net/vmw_vsock/vmci_transport.c
>+++ b/net/vmw_vsock/vmci_transport.c
>@@ -1761,6 +1761,14 @@ static int vmci_transport_dgram_enqueue(
> 	return err - sizeof(*dg);
> }
>
>+static size_t vmci_transport_dgram_payload_len(const struct sk_buff *skb)
>+{
>+	if (skb->len < sizeof(struct vmci_datagram))
>+		return 0;
>+
>+	return skb->len - sizeof(struct vmci_datagram);
>+}
>+
> static int vmci_transport_dgram_dequeue(struct vsock_sock *vsk,
> 					struct msghdr *msg, size_t len,
> 					int flags)
>@@ -2075,6 +2083,7 @@ static struct vsock_transport vmci_transport = {
> 	.connect = vmci_transport_connect,
> 	.dgram_bind = vmci_transport_dgram_bind,
> 	.dgram_dequeue = vmci_transport_dgram_dequeue,
>+	.dgram_payload_len = vmci_transport_dgram_payload_len,
> 	.dgram_enqueue = vmci_transport_dgram_enqueue,
> 	.dgram_allow = vmci_transport_dgram_allow,
> 	.stream_dequeue = vmci_transport_stream_dequeue,
>
>-- 
>2.56.0
>
