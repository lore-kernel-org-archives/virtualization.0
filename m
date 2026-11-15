Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.226.149.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794784346;
	b=nXvXdvIzvrPTKU390TebBrIk0iOYEnu9BlZ+pV+NPOEh3XQEhTiKJ6YREYSlMMUMRA0w
	 9OQyiypjKX0nzvSnvR9qQgKEw0T0p6cIrX9jhxM2JYkiMy3S7+BwYXn02gm6M2J6XRutZ
	 BRX0xkw/j84RRS13v220X6a4vTXudsPIJO4QI3MIjDtfdWrkpHqXc5SFvIz9Piii+L8Yl
	 4x7USSaTBAFwjE/IesYW9usnHiiT1ruzx3gggG2HS5bzP5vYgObo3APKwk+kVziD6BO3G
	 i8FmYQWdLPvtCtpaa5pX9rIGbJnGR08lGvmhiYQc8TkY+rKTQhqGdMBRVRxvavvqnEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794784346;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:X-Enigmail-Draft-Status:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=FQPiI1sK/RmnMC3Xc5d6YPeVKE55+XAHMigA8a+Dn40=;
	b=uyDHZL6hTaTrAImq2E3YytXq8Ll6wj6Yg2lv/PPu8/K2c+wrQK8eZDZ4Ze8jtbZCub7N
	 k7XENrObz5mKrS0m3EO/hQQs+Gbnfx99C2kZH8f64QU2SqZX5F8A5Zww0J5p/XK5QXEaj
	 UGGWbmPRFuZnpNOxDOtacUr7XfDnYpdGjgqxQ/JVQZ3B0wqDv8tEicBWdN+XKUbuyQwoc
	 1BZto0xlT0di5gUhAvDIiPtqTqSZMvQwlGC+v16gKvEmimPFvhc3G4/DQd12HViHo+Y+/
	 M7YjIfk++uWD+N2rW6YG+yEtiMa/HZn6UtMGsqtcVQr+jy0XSgPWJr/YblZAaGfYl4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rbox.co;
	spf=pass smtp.mailfrom=rbox.co;
	dkim=pass header.d=rbox.co header.i=@rbox.co header.a=rsa-sha256 header.s=selector1 header.b=kbullyvV;
	arc=none smtp.remote-ip=185.226.149.37
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD35A606A32C;
	Sun, 15 Nov 2026 23:12:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD35A606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rbox.co header.i=@rbox.co header.a=rsa-sha256 header.s=selector1 header.b=kbullyvV
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1xSjOR-00EbX3-7v; Mon, 16 Nov 2026 00:12:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=FQPiI1sK/RmnMC3Xc5d6YPeVKE55+XAHMigA8a+Dn40=; b=kbullyvVsEGwkPk54Suco60e8X
	2j+51rlW+XYeTY3s6SXPZvF4hWDh5YZ90jkQOouWMijxQGlQC5tpI8tswqOnlq6QKIwPQFQJSTDh0
	aTNWzTm0koKs5udpN/7hRTtCWSXbfezYX612jCdeABJ6EIzs0WzwB3qu2PmzefGI28VgvYsFarb9r
	naR3poHw8VxIaAPz3XbzwhEB0XSr1jUCUrH78X/dtkqZucXGNrapz6pv5G+TRd92Qiju/ApMjz4V1
	N7W5NUHyacfSh5GH4VXDMRaia3/r88ATMBWovk+o/4DjDjrAXc4ENQh55uKEtjjkyPVJ8IBVnFh50
	PpDGkbLw==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1xSjOJ-00050n-7i; Mon, 16 Nov 2026 00:12:10 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1xSjO4-000q4y-Ei;
	Mon, 16 Nov 2026 00:11:52 +0100
Message-ID: <35c21a88-9e0b-4238-8926-b97cef74e1c9@rbox.co>
Date: Mon, 16 Nov 2026 00:11:50 +0100
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 1/8] vsock: only undo SS_CONNECTING when
 connect() fails
To: netdev-bot+sashiko@kernel.org, bobbyeshleman@meta.com
Cc: sgarzare@redhat.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, stefanha@redhat.com, mst@redhat.com,
 jasowangio@gmail.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 shuah@kernel.org, rdunlap@infradead.org, donald.hunter@gmail.com,
 edumazet@kernel.org, georgezhang@vmware.com, acking@vmware.com,
 dtor@vmware.com, virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, sargun@sargun.me,
 jlinbox@meta.com, bobbyeshleman@gmail.com
References: <20261113-vsock-guest-ns-v6-1-3737ce4673c0@meta.com>
 <179471528724.2199510.7407342828719727367@kernel.org>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
X-Enigmail-Draft-Status: N11222
Autocrypt: addr=regenrecht@o2.pl; keydata=
 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
In-Reply-To: <179471528724.2199510.7407342828719727367@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/15/26 05:01, netdev-bot+sashiko@kernel.org wrote:

> [Severity: Low]
> Do vhost_vsock_reset_orphans() and vmci_transport_handle_detach() really
> reach connect() through the sk_err path described here?

The other (also fixed) path is signal/timeout, unrelated to sk_err.

> vhost_vsock_reset_orphans() in drivers/vhost/vsock.c writes:
> 
> 	sk->sk_state = SS_UNCONNECTED;
> 	sk->sk_err = ECONNRESET;
> 
> SS_UNCONNECTED is 1, which is the same value as TCP_ESTABLISHED. When
> vsock_connect() takes the lock again, this check runs first:

The sk_state assignment is wrong and it's getting fixed:
https://lore.kernel.org/netdev/20261112-transport-reset-state-fix-v1-1-5698375f52a9@rbox.co/

> [Severity: Low]
> Should the changelog also describe the same-transport case? This patch
> seems to close that one too.

It generally closes the issue of unexpected socket state transition.

> [Severity: Medium]
> Does the rest of vsock_connect() need to recognize SS_CONNECTED now?
> 
> With this patch the failure paths can run on a socket whose
> sock->state is SS_CONNECTED. The wait loop and the signal/timeout
> branch still only treat TCP_ESTABLISHED and TCP_CLOSING as success:
> 
> 	while (sk->sk_state != TCP_ESTABLISHED &&
> 	       sk->sk_state != TCP_CLOSING && sk->sk_err == 0) {
> 
> Suppose the handshake completes while connect() sleeps, and the
> socket is then moved to TCP_CLOSE with sk_err == 0. The loop keeps
> sleeping. vmci_transport_handle_detach() does that for an established
> socket, since it only sets sk_err in TCP_SYN_SENT. With virtio,
> virtio_vsock_reset_sock() sets ECONNRESET, but another thread can
> clear it with getsockopt(SO_ERROR) before connect() takes the lock
> again. connect() then waits for the whole connect_timeout, or until a
> signal arrives, and ends up in this branch.
> 
> Here vsock_connect_close() now leaves the socket SS_CONNECTED, yet
> vsock_transport_cancel_pkt() is still called right after it. For
> virtio this reaches virtio_transport_purge_skbs(), which drops every
> skb queued for this vsk, not only the OP_REQUEST mentioned in the
> comment.
> 
> If a concurrent sendmsg() queued OP_RW skbs while the socket was
> TCP_ESTABLISHED, virtio_transport_get_credit() already added them to
> vvs->bytes_unsent. Purging them without
> virtio_transport_consume_skb_sent() seems to leave bytes_unsent
> non-zero for good. SIOCOUTQ then reports stale data, and
> vsock_linger() waits out the full SO_LINGER time on close().
> 
> The caller also gets -ETIMEDOUT or -EINTR for a socket that now
> reports SS_CONNECTED. If the error is -ERESTARTSYS, the restarted
> connect() fails with -EISCONN.
> 
> The long wait and the vsock_transport_cancel_pkt() call predate this
> patch. But this patch is what decides that such a socket stays
> SS_CONNECTED, so the rest of vsock_connect() should probably agree
> with it. Should the loop also stop when sock->state is no longer
> SS_CONNECTING? And should an already connected socket skip
> vsock_transport_cancel_pkt() and return sock_error() (or 0) instead?

This patch is about keeping a bricked socket - safely bricked.

> [Severity: Low]
> Can this leave a socket that never connected stuck in SS_DISCONNECTING?
> 
> Consider a blocking connect() racing with shutdown():
> 
> Thread A                          Thread B
> vsock_connect()
>   sock->state = SS_CONNECTING
>   release_sock(sk)
>   schedule_timeout()
>                                   vsock_shutdown()
>                                     sock->state = SS_DISCONNECTING;
>   lock_sock(sk)
>   timeout, signal or sk_err
>   vsock_connect_close()
>     sk_state = TCP_CLOSE
>     sock->state stays SS_DISCONNECTING
> 
> After this, every later connect() fails here:
> 
> 	case SS_DISCONNECTING:
> 		err = -EINVAL;
> 		goto out;

IOW, after shutdown() races connect(), socket cannot be used to re-connect
(or become a listener). I'm not sure if that's an issue.

