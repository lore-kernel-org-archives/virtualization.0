Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794504222;
	b=Cxp14l3tD7mVTKXyjtf4EBcGh9KPHmT/gPHmhKUt5Yiohq+DTMAss/8hlloSisxwCzYI
	 NMlDe3hwRVJYETQatV6onrHzmKSmQCFt9ukj9WlS9l67jRCpGaim1NZJsLYMvHqheS2JB
	 M65WZcOifO0dQGpJGCnte+L9ecxPO27kbVWuUQ4byjJRFbIT6nOUlXuUUUu/GahMgKDFk
	 JsCbglh49JfaI/AHfz+fFayaz0gCwkQLJgL4ZHFgn3DSjBKgFE6j+RzvxiETntGixxitq
	 eR0FS59zGtVtEWetMTbF4Mc8WfxS19tmCzEyQlMP2C/nl8dGD0KkPR+x8dPb4XIUaeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794504222;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=Afhs0UD2/muICMANXtYRGRJeNv91U/qFXGHXS8V9iyc=;
	b=kNZbDZ/SUxX4x2wDb5RbSPhhVVVMc4X52+X3Ib/6tw4+uOYtXBxawCpbKOybyvGCyWGw
	 QhPb6euNg6twF4u0UEhGCe2KxJClwvO7+EQoF6z39YLU7TQ7hzXsGAsGKxT5F1Ygn3W0A
	 zp6OnSOX212f16q8ZdgwJiq5bILX8/2ay9HjmfqOuNNKsiDEU1J+yDHI948FzEk/MaCXq
	 eEYz/+tFLfjL22Cyx1LQ/qJZl8CWaJsdUuICOoUKWAChwTK4rT4jgdruysLtvv6qBgr9G
	 A2fNP0qtSWZBXHz6WqDA5sfsH23uJpx5ULK3xgxvho2ESSEPjz1gq3lUyuf6+QbudFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MiBqMz8H;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30266606A323
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 17:23:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30266606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MiBqMz8H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794504220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Afhs0UD2/muICMANXtYRGRJeNv91U/qFXGHXS8V9iyc=;
	b=MiBqMz8Hq/IfxW7facIW1Yoa9oUUHxjoyDeHpAhn1n0uhDayMpHLkKaBLuqWmcD6Sku8Hp
	9Myvi9QVV320N7kR3uUDVrt1k+n1FnwNqDyZb9f0KNoebBUJB6QYTD0qPtgXQ5hnnUz6jK
	CcrUqV2aH23wuQrE+75OQ8OVSzzXowU=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-CjAIT00WMuS9AlvoNGFZzQ-1; Thu, 12 Nov 2026 12:23:39 -0500
X-MC-Unique: CjAIT00WMuS9AlvoNGFZzQ-1
X-Mimecast-MFC-AGG-ID: CjAIT00WMuS9AlvoNGFZzQ_1794504218
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3b0afbf532eso18047a91.0
        for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 09:23:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794504218; x=1795109018;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Afhs0UD2/muICMANXtYRGRJeNv91U/qFXGHXS8V9iyc=;
        b=G5bFyAF7hDrZpVeyD+VWcdb079IuK9p5g+WMVkV00vlNAb+34c/mUclh94LtDzSSqJ
         +19v/33YIFrMTYmEP8tTMLoYJrZjAajDz6pSwzc/fFD/QeltIgpKNDwwejsmKD24CfO7
         s8PsBMDGyhquIrHa2ALlpS5JA303Q6zrUtiopHKMYuakqfnE7/1jbfGTLSBoCGz3FdUV
         nS459WuQh9wrBOjL3E+nKOzJl6kVY1yqLZt2Gbucao6Gg2c9CGHM0nZHefRk+i+9qLtB
         wSeV8XZublPKwI3yTodr/umgdNOB+GmdicL77P9yb6YlTs1X9tFNZp5LEqcxjpwvLssS
         6m4Q==
X-Forwarded-Encrypted: i=1; AL+hErEFeYA30INwd9I9nNrlc2sOmwe5Ec/TyCxyiTcMgw9hoc/zgY569LXUzg4wWVZFSsRs+E1yQvYZ62vqrgktcQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z/HKjX4b3x1gH3+DQYRiwIlqh7pMcUDNRwDP5kUBKU9AqbV7gQ9
	lwjjtfCbUYmV4QeCeTK9I2ELmv6tmtHkV/CsGYCOxEsXbT3tjTuxA+CH9Lweva+Kfpfqcg/JR4H
	Vse3ajAZZsD+Qoevc1mRaXtcP4yD0Q7lCR42i+uXdGD45RF8j831Kts5jc6dekWIqm8Ms
X-Gm-Gg: AYBFou2PcUFMSTlxwSgdS7unrbEgvC6Bc4K1xr5iRGZTK0G754c/gv7sPrduFrJvp/p
	AgpgrsTAblGPTCBQ6QTnekTNmxMgFhrCH+NYfUsMynibkHH7uWDTRGbh1QeX2mQuI9GSUWIABmV
	3xquAFNHOr8yFswDcFD93bK8/kotguqDLyJGkfAbAfba6o2XVih3sv8p0q8aPP2Z0U1GTqBpiJ7
	ZJsoY5oexPdt699Bpz2+THSKbNL+tSq6xnxUUxcRSzGZP/qyDOmj70tJQ4bT3t3RuQ0RWExC3kc
	V3rpyHfFtEMm9Wc57uX01uh3zMdwTPoamC5c8SN48wtr6zj7+RLVZjv64XtSOhwE2ZCBLP6EHKD
	XrZC5xR+kEI+vcBEoGk9dlBlZJ702wZds2obuXHlBeXeD60MyV1lX
X-Received: by 2002:a17:90b:2f04:b0:3b0:9317:5849 with SMTP id 98e67ed59e1d1-3b182e1076dmr5100302a91.1.1794504218190;
        Thu, 12 Nov 2026 09:23:38 -0800 (PST)
X-Received: by 2002:a17:90b:2f04:b0:3b0:9317:5849 with SMTP id 98e67ed59e1d1-3b182e1076dmr5100284a91.1.1794504217598;
        Thu, 12 Nov 2026 09:23:37 -0800 (PST)
Received: from sgarzare-redhat ([209.52.143.85])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197d04336sm5592725a91.7.2026.11.12.09.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 09:23:37 -0800 (PST)
Date: Thu, 12 Nov 2026 18:23:32 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: jrmmhm.kernel@eldare.de
Cc: Bobby Eshleman <bobbyeshleman@meta.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Michal Luczaj <mhal@rbox.co>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v5] vsock/bpf: release sock lock while waiting for
 data in recvmsg
Message-ID: <avXyzxvIN3ngFepE@sgarzare-redhat>
References: <20261109-kbh3-1-022-fix-v2-v5-1-4d9af04f0fad@eldare.de>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261109-kbh3-1-022-fix-v2-v5-1-4d9af04f0fad@eldare.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0iSiw-KJFaWYelf4pOUD4_TI7vV_Sh4aTN_gZZ_xocY_1794504218
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline


On Mon, Nov 09, 2026 at 09:08:29PM +0100, Jerome Mohm via B4 Relay 
wrote:
>From: Jerome Mohm <jrmmhm.kernel@eldare.de>
>
>vsock_bpf_recvmsg() sleeps in vsock_msg_wait_data() with the socket lock
>held, so the virtio delivery worker, which needs that lock, deadlocks
>with the reader and all vsock rx on that worker stops.
>
>Release the lock around the wait. The reader can then wake without
>data, so the wait loops until data arrives, the timeout, a signal
>(wait_woken() returns at once while one is pending), or a state in
>which __vsock_recvmsg() would not wait. Those states, and zero-length,
>MSG_OOB and MSG_ERRQUEUE reads, go to __vsock_recvmsg(), as Alexei
>suggested; a non-blocking read now sees them before -EAGAIN. The loop
>and the zero-length check belong to the fix (without them the reader
>returns early or spins with the lock held), so this is one patch;

I don't understand why that fix can't be in a fist patch of the 
series...

>MSG_OOB and MSG_ERRQUEUE just share that path. One tested difference
>remains: a reader asleep at a virtio transport reset gets -ENOTCONN,
>where a native socket gets -ECONNRESET (0 on seqpacket).
>
>The deadlock and the MSG_ERRQUEUE case were found with the help of
>Anthropic's Claude, the rest by the netdev Sashiko reviews and Alexei.
>Each was reproduced in a VM without kernel changes or error injection
>(the resets unbind the guest's virtio-vsock device), except one Sashiko
>case that was checked in the code; with this patch they behave as on a
>native socket apart from the reset case above. The vsock vmtest.sh
>single-VM tests and the BPF sockmap selftests still pass, though they
>never sleep in this wait.
>
>Fixes: 634f1a7110b4 ("vsock: support sockmap")
>Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
>Cc: stable@vger.kernel.org
>Signed-off-by: Jerome Mohm <jrmmhm.kernel@eldare.de>
>---
>Changes in v5:
>- One patch, using Alexei's approach: in the states where
>  __vsock_recvmsg() does not wait, and for zero-length, MSG_OOB and
>  MSG_ERRQUEUE reads, fall back to __vsock_recvmsg() instead of
>  copying its return values (Alexei).
>- So after a reset, recv(), a zero-length read and MSG_OOB return
>  -ENOTCONN, and a peer shutdown with SO_INQ reports SCM_INQ, as on a
>  socket outside a sockmap. A reset while the reader sleeps now
>  returns -ENOTCONN instead of -ECONNRESET.
>- This also covers the netdev Sashiko review of v4: SEQPACKET after a
>  reset, MSG_OOB on a closed socket and SCM_INQ on a zero-length read;
>  SHUT_RD with a pending sk_err by code reading only. A SEQPACKET
>  reader asleep at a reset still gets -ENOTCONN (native 0).
>- Don't cite the selftests as coverage of the wait (Alexei).
>- Link to v4: https://patch.msgid.link/20261106-kbh3-1-022-fix-v2-v4-0-c7d36703814d@eldare.de
>
>Not tested: virtio-mmio, repeated runs, a sockmap delete while a
>reader sleeps, a signal arriving in the same wakeup as the timeout
>(returns -EAGAIN, native -EINTR), and the vmtest.sh ns_* tests.
>Still left for separate patches, as in v4: data that sits only in
>psock->ingress_skb, and READ_ONCE()/WRITE_ONCE() for the lockless
>accesses.
>
>Changes in v4: comments, one data <= 0 check and message changes
>(Stefano); rebase; retest with a new dataless-wakeup reproducer.
>Changes in v3: split into two patches (Michal); end the wait after a
>reset read with SO_ERROR, and MSG_OOB returns -EOPNOTSUPP (Sashiko).
>Changes in v2: loop in the wait, len == 0 guard (Sashiko); MSG_ERRQUEUE
>to the native path.
>---
> net/vmw_vsock/vsock_bpf.c | 43 ++++++++++++++++++++++++++++---------------
> 1 file changed, 28 insertions(+), 15 deletions(-)
>
>diff --git a/net/vmw_vsock/vsock_bpf.c b/net/vmw_vsock/vsock_bpf.c
>index 9049d2648646..c0c9e69860dc 100644
>--- a/net/vmw_vsock/vsock_bpf.c
>+++ b/net/vmw_vsock/vsock_bpf.c
>@@ -34,24 +34,35 @@ static bool vsock_has_data(struct sock *sk, struct sk_psock *psock)
> 	return vsock_sk_has_data(sk, psock);
> }
>
>-static bool vsock_msg_wait_data(struct sock *sk, struct sk_psock *psock, long timeo)
>+/* __vsock_recvmsg() doesn't wait in these states and knows what to return. */
>+static bool vsock_rx_done(struct sock *sk)
> {
>-	bool ret;
>+	return sk->sk_err || sk->sk_state != TCP_ESTABLISHED ||
>+	       (sk->sk_shutdown & RCV_SHUTDOWN) ||
>+	       (vsock_sk(sk)->peer_shutdown & SEND_SHUTDOWN);
>+}
>+
>+static int vsock_msg_wait_data(struct sock *sk, struct sk_psock *psock,
>+			       long timeo)
>+{
>+	int ret = 0;
>
> 	DEFINE_WAIT_FUNC(wait, woken_wake_function);
>
>-	if (sk->sk_shutdown & RCV_SHUTDOWN)
>-		return true;
>-
>-	if (!timeo)
>-		return false;
>-
> 	add_wait_queue(sk_sleep(sk), &wait);
> 	sk_set_bit(SOCKWQ_ASYNC_WAITDATA, sk);
>-	ret = vsock_has_data(sk, psock);
>-	if (!ret) {
>-		wait_woken(&wait, TASK_INTERRUPTIBLE, timeo);
>-		ret = vsock_has_data(sk, psock);
>+	while (!vsock_has_data(sk, psock) && !vsock_rx_done(sk)) {
>+		if (!timeo) {
>+			ret = -EAGAIN;
>+			break;
>+		}
>+		if (signal_pending(current)) {
>+			ret = sock_intr_errno(timeo);
>+			break;
>+		}
>+		release_sock(sk);
>+		timeo = wait_woken(&wait, TASK_INTERRUPTIBLE, timeo);
>+		lock_sock(sk);
> 	}
> 	sk_clear_bit(SOCKWQ_ASYNC_WAITDATA, sk);
> 	remove_wait_queue(sk_sleep(sk), &wait);
>@@ -80,6 +91,9 @@ static int vsock_bpf_recvmsg(struct sock *sk, struct msghdr *msg,
> 	struct vsock_sock *vsk;
> 	int copied;
>
>+	if (unlikely(!len || (flags & (MSG_OOB | MSG_ERRQUEUE))))
>+		return __vsock_recvmsg(sk, msg, len, flags);

... I mean, why this change ^^^ can't be in patch 1/2?

BTW I'm not asking to split it (at least for now).

I saw some comments from sashiko, can you reply to them?
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261109-kbh3-1-022-fix-v2-v5-1-4d9af04f0fad%40eldare.de

Thanks,
Stefano

