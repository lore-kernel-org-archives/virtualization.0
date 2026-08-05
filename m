Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F2138E100
	for <virtualization@lists.linux.dev>; Wed,  5 Aug 2026 08:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785918884; cv=none; b=gY2Ns6IbB+QFOLcEM5RdZ3eRSfXXETSyV8hebJY4TXevBmOZnMyPt5nbMBPhyfYLnHvkKIw2PQ8/Ji8pyOZgn09H48BCkmXU3Kje5/ABRlyWKoPkc7QyQKwX8nfw+gLqNepqThTdrtTXeZZjKA/0kAv5L2r+NEs6PBFp+HRyywk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785918884; c=relaxed/simple;
	bh=evmo1oE/Vlvct3s4qgqbQDVtD/iQ06qh/0KgEWFw+kw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=c1OAzlYdiB/Hn+Yblc9cvc22oKWruzzn31SLwfZbQ7f6/aoaKzW8OC2BZq/1V6KQIHQ4AaVQrheyzrg/EjibkUbyK5l6+djqbKPXfw36dQkAZjwwcVa4Sr73a692q0vTs3ezAN/sLyY9GqikFz7jx+OSGGlcwp1nYY6qeKTlXjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DTts97Jt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DTts97Jt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785918881;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W8JKU+udkyyWRXOR82LNQUo+2Yg2NA4KZG9ohOJp2T8=;
	b=DTts97Jt/g0snwaKUpG/6WOvbj2237btv+xg6P2ByIHEcNS+vuwy0phwrtJjnkytAmMo8O
	Nc/NJBhtDj8UdSzdkakSpgVhZZPcgdGS/QtsBcRMs0+Dki4+jFkm8sT0gvxF0Y95ahvsJ+
	KSIvxl+ZGXEKONxnRxcIfT2UMxsWTcQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-4dFrUtRQM6ukK2i_N478_Q-1; Wed, 05 Aug 2026 04:34:40 -0400
X-MC-Unique: 4dFrUtRQM6ukK2i_N478_Q-1
X-Mimecast-MFC-AGG-ID: 4dFrUtRQM6ukK2i_N478_Q_1785918879
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-4729d2a64efso965776f8f.0
        for <virtualization@lists.linux.dev>; Wed, 05 Aug 2026 01:34:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785918879; x=1786523679;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W8JKU+udkyyWRXOR82LNQUo+2Yg2NA4KZG9ohOJp2T8=;
        b=lso8YUB+TIb5hPidI34+65JOeKrGasLi9EqbtjlF2G6gv8t3D/rNl8Q0m8AgIXkOhZ
         jSzKn0p/2HXVCOgftzw5yrv9BgTWrTqfWIFoNWOqOPyUPIAvINb4YBtW610T52N+3uLo
         QkOkPveij/0LZI4TL6Hdn863Mzcrvk2sjoBgu9VF1uD9Yax1fH8i3CaSl/DZqoD9VIjr
         9d82K1Nsnyrh5mq7ft0eORi37WQuik3B20trCS5TwxA81goYFChkbSLbsQuuw+4W5+Kn
         92HR5p3l9ueRoL1myCf9Zt/83SL8lNA+UHpyKTQwwGhz+3ZOp63kmRlDph3GeCarlLwq
         Qnbg==
X-Forwarded-Encrypted: i=1; AHgh+RqtqmXUc5FAHWLHmUW6jIgTYXGQwzeZai+rHZtIT7u8na61QzpzoNAAQ70GvhoSA4f8UWDbPY5s8K4guaHhCg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwloYHDBK9TruKAwOs3uk3ZNT/v2rX9nQjusOaL8dQdH4XDO1Rp
	KP2oU4G8Euo/2F7tQTXl6TQzXYvrvp9PNMuFGLln7pPUhFqIQh6io0VOX+EQiHWB4DtowTWrWBu
	ZctX3asdTVNf+D7ARxRt0olBZy07fZUhb6khMs1nBFvklIKh33Qt9b6DG3hqc55hF34/3
X-Gm-Gg: AR+sD10AGO2wiQpWmDYmqASnCEl8avrrcxRAxDpX1X4Frq0jou/0/7wyiUE9t2ZCob9
	UhyKK2xn56V+sj0POADkmY82zBo03rh5GA0JKWOF/DUIr7L9O3lZR6GVJkx0uvoc8m8ZTM9ESM8
	GHAUz7mxnIAlCLJzm/d8G801pRV56EuDqTzPfkdA453jAkaDJL9oPJb6dm51FXAkbKzcazs6xLv
	YAWBODMJsKhTIriLvJlaJHp53NAK8JQQV4wFeUNkB9BtzSHK365FieJT4XT7PsEpqozhgJVn7NO
	Dciy0fXqusCdQIDfKDmzmSYX2zGP8lekIyKOubpJp2BUYtygZ44P3m1nuFKIbGv6bY/ElK6z4dT
	M+MQ=
X-Received: by 2002:a05:600c:190e:b0:495:5d6d:9cc1 with SMTP id 5b1f17b1804b1-4994e2c39f0mr61976755e9.0.1785918878868;
        Wed, 05 Aug 2026 01:34:38 -0700 (PDT)
X-Received: by 2002:a05:600c:190e:b0:495:5d6d:9cc1 with SMTP id 5b1f17b1804b1-4994e2c39f0mr61975895e9.0.1785918878332;
        Wed, 05 Aug 2026 01:34:38 -0700 (PDT)
Received: from sgarzare-redhat ([5.77.121.223])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994e04db3asm82077995e9.15.2026.08.05.01.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 01:34:37 -0700 (PDT)
Date: Wed, 5 Aug 2026 10:34:31 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: phind.uet@gmail.com
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andy King <acking@vmware.com>, 
	George Zhang <georgezhang@vmware.com>, Dmitry Torokhov <dtor@vmware.com>, 
	syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com, Michal Luczaj <mhal@rbox.co>, Wupeng Ma <mawupeng1@huawei.com>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] vsock: use sock_error() to consume sk_err after a
 failed connect
Message-ID: <anLuRE4ix5-BZ7-t@sgarzare-redhat>
References: <20260804135238.386417-1-phind.uet@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260804135238.386417-1-phind.uet@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: i0g6Oneo6sm0PGzIF4eMoSUkHUfArwWDbTyp-J7I2jM_1785918879
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Aug 04, 2026 at 09:52:36PM +0800, phind.uet@gmail.com wrote:
>From: Nguyen Dinh Phi <phind.uet@gmail.com>
>
>Syzbot reported an issue which can be reproduced with these steps:
>
>   r0 = socket(AF_VSOCK, SOCK_STREAM, 0)
>   bind(r0, {VMADDR_CID_ANY, PORT})
>   connect(r0, {VMADDR_CID_LOCAL, PORT})   -> -1, EPROTO  (self-connect)
>   listen(r0, backlog)                     -> 0
>   r1 = socket(AF_VSOCK, SOCK_STREAM, 0)
>   connect(r1, {VMADDR_CID_LOCAL, PORT})   -> 0
>   accept(r0)                              -> -1, EPROTO  (stale sk_err)
>
>Basically, it creates a socket (r0) and triggers a self-connect after
>binding it. This self-connect fails with EPROTO because it loops back to
>r0 while the socket is still in the TCP_SYN_SENT state, causing it to be
>incorrectly dispatched to the connecting-client path. The unexpected
>packet type encountered there sets sk_err to EPROTO.
>
>After that, it invokes a listen() call on the same socket. This listen()
>call succeeds because the kernel's listening path never inspects or
>clears sk_err. Then, a new socket (r1) is created as a normal client and
>connects to r0. However, vsock_accept() rejects this incoming connection
>because the listener's sk_err still holds the EPROTO error from the
>earlier failed self-connect.
>
>This rejection causes the child socket created for r1's connection to
>never be freed on virtio or hyperv transports; only the VMCI transport
>implements pending_work to revisit and clean up a rejected socket.
>
>Fix the issue in blocking connect() by using sock_error() to read the
>sk_err to prevent the rejection branch from occurring in this scenario.
>
>sock_error() atomically reads and clears sk_err, ensuring the error is
>consumed when vsock_connect() returns and cannot affect subsequent
>operations on the same socket. This matches the established pattern
>used by other protocol connect() implementations in the network
>stack like __inet_stream_connect(), tipc_wait_for_connect()...
>
>For non-blocking connection, vsock_connect_timeout() may set
>sk->sk_err after vsock_connect() has returned. To handle it, we also
>remove the sk_err checks from vsock_accept(). Nothing in vsock sets
>sk_err on a listening socket, so accept() has no reason to inspect it
>at all.
>
>Reported-by: syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com
>Closes: https://syzkaller.appspot.com/bug?extid=1b2c9c4a0f8708082678
>Fixes: d021c344051af ("VSOCK: Introduce VM Sockets")
>Suggested-by: Michal Luczaj <mhal@rbox.co>
>Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
>Tested-by: Wupeng Ma <mawupeng1@huawei.com>
>---
>V2: Add reproducer steps to commit message.
>V3: Fix truncated title and add annotations to reproducer steps.
>V4: Remove sk_err checks from vsock_accept()
>
> net/vmw_vsock/af_vsock.c | 13 ++++---------
> 1 file changed, 4 insertions(+), 9 deletions(-)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 622dbd046799..594fe27d2ebe 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1847,12 +1847,10 @@ static int vsock_connect(struct socket *sock, struct sockaddr_unsized *addr,
> 		prepare_to_wait(sk_sleep(sk), &wait, TASK_INTERRUPTIBLE);
> 	}
>
>-	if (sk->sk_err) {
>-		err = -sk->sk_err;
>+	err = sock_error(sk);
>+	if (err) {
> 		sk->sk_state = TCP_CLOSE;
> 		sock->state = SS_UNCONNECTED;
>-	} else {
>-		err = 0;
> 	}
>
> out_wait:
>@@ -1893,7 +1891,7 @@ static int vsock_accept(struct socket *sock, struct socket *newsock,
> 	timeout = sock_rcvtimeo(listener, arg->flags & O_NONBLOCK);
>
> 	while ((connected = vsock_dequeue_accept(listener)) == NULL &&
>-	       listener->sk_err == 0 && timeout != 0) {
>+	       timeout != 0) {
> 		prepare_to_wait(sk_sleep(listener), &wait, TASK_INTERRUPTIBLE);
> 		release_sock(listener);
> 		timeout = schedule_timeout(timeout);
>@@ -1906,11 +1904,8 @@ static int vsock_accept(struct socket *sock, struct socket *newsock,
> 		}
> 	}
>
>-	if (listener->sk_err) {
>-		err = -listener->sk_err;
>-	} else if (!connected) {
>+	if (!connected)
> 		err = -EAGAIN;
>-	}
>
> 	if (connected) {

Can this become an `} else {` ?

Or just add a `goto out` when setting `err = -EAGAIN`.

> 		sk_acceptq_removed(listener);

		lock_sock_nested(connected, SINGLE_DEPTH_NESTING);
		vconnected = vsock_sk(connected);

		/* If the listener socket has received an error, then we should
		 * reject this socket and return.  Note that we simply mark the
		 * socket rejected, drop our reference, and let the cleanup
		 * function handle the cleanup; the fact that we found it in
		 * the listener's accept queue guarantees that the cleanup
		 * function hasn't run yet.
		 */
		if (err) {
			vconnected->rejected = true;
		} else {


Should we update this comment too and maybe remove the `if (err)` at
all. With that change I guess `rejected` is never set at the end and
maybe we can remove it at all from `struct vsock_sock`.

Looking at commit d021c344051a ("VSOCK: Introduce VM Sockets") where
`rejected` was introduced, I can't see any path where sk_err is set on
a listener socket, so I guess that path was dead since the beginning.

So now I'm thinking if it's better to split in 2 patches (both with the
same Fixes tag):
- Patch 1: "vsock: remove stale sk_err checks from vsock_accept()"
   Where we can also remove `rejected` since it's never set to true since
   the beginning
- Patch 2: "vsock: use sock_error() to consume sk_err after a failed
   connect"

WDYT?

Thanks,
Stefano

