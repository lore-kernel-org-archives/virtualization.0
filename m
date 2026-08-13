Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2359B36B93C
	for <virtualization@lists.linux.dev>; Thu, 13 Aug 2026 08:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786609475; cv=none; b=Lx+NTNqvU49EIn1Z8LqMLlkQpZaOZ9YyP9EgvmtGss8PXYQ2RRm7QbmIznjvriTjkgdzK/UGHSv+6+WkBnxMj8Wz3VSh0mlPiIWbcHLOqzOk+kzWjiZNfPqfNii6WSfRW1NRStUyyoBa5whcO+gewOOp1ckCjems68iqHE4/Tdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786609475; c=relaxed/simple;
	bh=ekNRTv/TL9qdTGaqKTU3xjKI2pnys6eRJiotTASXKJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=kGXEbYfj321jj4E0Sc2MNgyQtZNv58wYgGKDNQ7KMX1vdTp1f/EkYc/XGyHnJRDPpXY/RZTGvrzMSUTWIp/qM1HYXW/mk/0HMgXu222P6pHCoMB4mXRPwDbFxac7JZVmJ+IwAOkq3i2R7RRVUjJMrENeqALfS7hYX95wz8aN228=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AFdy0VQA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AFdy0VQA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786609473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F7osRv4SiTFi2D7w5M5+xxh/Lfv3v0Z21SGPsrlY9PI=;
	b=AFdy0VQAcFqnk8EVLZHWgXn+qu8v+3KbuJ+5TfcPJSkvPkkdWFHBKvJgyWOyReQeswmri4
	doA/Wx7pYF7jgeH9xuNxNIYNZ5/w7tC+Fg0lJmn4oe1bJ2Ev4CG1QBNnISK/tAZcR7uLz8
	BQT1toXKWH66x+1vwHoug4tV0u59VyI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-mdLuKcx9MK-Th2J5tMbBYQ-1; Thu, 13 Aug 2026 04:24:31 -0400
X-MC-Unique: mdLuKcx9MK-Th2J5tMbBYQ-1
X-Mimecast-MFC-AGG-ID: mdLuKcx9MK-Th2J5tMbBYQ_1786609470
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49554715277so15361915e9.1
        for <virtualization@lists.linux.dev>; Thu, 13 Aug 2026 01:24:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786609470; x=1787214270;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F7osRv4SiTFi2D7w5M5+xxh/Lfv3v0Z21SGPsrlY9PI=;
        b=R+m0FILivqf8Nhum7tuHG/plPaJhfabyPh+7PB49gDTijlnVQZXRPzUuqMnvv8Jxeg
         XNUQKMOwurwSV81N0wwsU9/g0AGUALXoKruvGzLb6iZkZUvRRGezwFNf02XuxUszXgpv
         NGE1aoRGJvWpbfu90UeE3iZC3FEBUPEslrLCaI8FxO/fb+0kgg2Wi6yUNClXSCR71Gfs
         p3bm0LowFhwKPjHG90aYXed8ufb9Y50BQBNDihHnHMSP7a4QMye/rlTjlrlDFDHOIC3e
         LWRF0myC5iwlD5+3eUggtR9D5PZOmN8AeR6mEGUZv43oTI5dbb07xwvK5sBJ7piip44r
         ODgw==
X-Forwarded-Encrypted: i=1; AHgh+Rpf2SFNfM/hZZLWKmrF1xYJsA54QxSnM5LjV6Cs1/uu+qHyXzg3uaYKsKiiMMn06L4+I8djrrV+ue77ocOE4w==@lists.linux.dev
X-Gm-Message-State: AOJu0YwQNP9aBlBIvpyHZGEimIwiiX5OkAean3l8ilUL0kTTbqrmH5gP
	HXno+YTKu1an4OuW0X1uHD8ElNIgoXzc70nO1cPqQmR95g1iqRQR+19cLiyCdMI+ezhfUmArzb5
	J2H2NFFWwMA4FHuzqW8zevW9OqD2O5zYTU8cT0EdjE5d0U7SAblp3aznhmqgnPiJjatZ8
X-Gm-Gg: AR+sD135fSGWj5dICv/JkRNUUqeVOGG4DfQuuqDqL9JF0nu/mn85ow/vzlbDIbPsTBp
	JAlBkx5hwuDfFjSx4+1pRShyDiUvFbaGlOzMMbLKg3GhDbZ77BI5pYqbgi9biRpbruvmJBIcU6J
	RrpiODvNANJMEypItC1X3jEmy/Dma2LiKrpJwHeYmLjpWuGfsj0pgOD5GOKID+lxTqQKX9vKt94
	f6g3xF/Aw6nF9fxqoSBWrl1uLP0ryUAvZPjT6GO9DATTXJokNhzm4HFfvfKRh5bk30MNVX94HqC
	zr0pNb1zyuW3522ttxPbG0cuW0JhwGwQPJnYvDorXHN2AIp+sNcwrXjIVxotkaiJ6b2VpavEYk1
	RBKm0oBmSY737X37wX3rM96XSE8xukwuiybZJl2jML+4GFZJI7sZI
X-Received: by 2002:a05:600c:1c21:b0:495:6396:8b67 with SMTP id 5b1f17b1804b1-499821c335amr48238805e9.4.1786609470442;
        Thu, 13 Aug 2026 01:24:30 -0700 (PDT)
X-Received: by 2002:a05:600c:1c21:b0:495:6396:8b67 with SMTP id 5b1f17b1804b1-499821c335amr48237755e9.4.1786609469913;
        Thu, 13 Aug 2026 01:24:29 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-154.retail.telecomitalia.it. [82.53.135.154])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49981b1063esm57093855e9.6.2026.08.13.01.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 01:24:29 -0700 (PDT)
Date: Thu, 13 Aug 2026 10:24:02 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Nguyen Dinh Phi <phind.uet@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	George Zhang <georgezhang@vmware.com>, Dmitry Torokhov <dtor@vmware.com>, Andy King <acking@vmware.com>, 
	syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com, Michal Luczaj <mhal@rbox.co>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/3] vsock: don't check the listener's sk_err in
 vsock_accept()
Message-ID: <an14GupikpFAtRHn@sgarzare-redhat>
References: <20260810170935.2242314-1-phind.uet@gmail.com>
 <20260810170935.2242314-2-phind.uet@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260810170935.2242314-2-phind.uet@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: aGFsMmmOtfqEdxg1Qq5qeXgc9TB-dDkRjXRl1v7DoRs_1786609470
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Aug 11, 2026 at 01:09:30AM +0800, Nguyen Dinh Phi wrote:
>Syzbot reported an issue which can be reproduced with these steps:
>	r0 = socket(AF_VSOCK, SOCK_STREAM, 0)
>	bind(r0, {VMADDR_CID_ANY, PORT})
>	connect(r0, {VMADDR_CID_LOCAL, PORT}) -> -1, EPROTO (self-connect)
>	listen(r0, backlog)                   -> 0
>	r1 = socket(AF_VSOCK, SOCK_STREAM, 0)
>	connect(r1, {VMADDR_CID_LOCAL, PORT}) -> 0
>	accept(r0)                            -> -1, EPROTO (stale sk_err)
>
>Basically, it creates a socket (r0) and triggers a self-connect after
>binding it. This self-connect fails with EPROTO because it loops back
>to r0 while the socket is still in the TCP_SYN_SENT state, causing it
>to be incorrectly dispatched to the connecting-client path. The
>unexpected packet type encountered there sets sk_err to EPROTO.
>
>After that, it invokes a listen() call on the same socket. This
>listen() call succeeds because the kernel's listening path never
>inspects or clears sk_err. Then, a new socket (r1) is created as a
>normal client and connects to r0. However, vsock_accept() rejects this
>incoming connection because the listener's sk_err still holds the
>EPROTO error from the earlier failed self-connect.
>
>This rejection causes the child socket created for r1's connection to
>never be freed on virtio or hyperv transports; only the VMCI transport
>implements pending_work to revisit and clean up a rejected socket.
>
>For a non-blocking connect(), vsock_connect() may return -EINPROGRESS
>immediately, and vsock_connect_timeout() can later set sk->sk_err
>asynchronously.
>
>Since no vsock transport ever sets sk_err on a socket while it is in
>TCP_LISTEN state, checking it in vsock_accept() serves no purpose and
>only carries forward errors left behind by earlier, unrelated
>connection attempts on the same socket. Remove the checks so accept()
>no longer rejects valid incoming connections because of a stale
>error, which also avoids the resource leak described above.
>
>Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
>Reported-by: syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com
>Closes: https://syzkaller.appspot.com/bug?extid=1b2c9c4a0f8708082678
>Suggested-by: Michal Luczaj <mhal@rbox.co>
>Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
>---
> net/vmw_vsock/af_vsock.c | 10 +++-------
> 1 file changed, 3 insertions(+), 7 deletions(-)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 622dbd046799..ff507761f472 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1893,7 +1893,7 @@ static int vsock_accept(struct socket *sock, struct socket *newsock,
> 	timeout = sock_rcvtimeo(listener, arg->flags & O_NONBLOCK);
>
> 	while ((connected = vsock_dequeue_accept(listener)) == NULL &&
>-	       listener->sk_err == 0 && timeout != 0) {
>+		timeout != 0) {
> 		prepare_to_wait(sk_sleep(listener), &wait, TASK_INTERRUPTIBLE);
> 		release_sock(listener);
> 		timeout = schedule_timeout(timeout);
>@@ -1906,12 +1906,6 @@ static int vsock_accept(struct socket *sock, struct socket *newsock,
> 		}
> 	}
>
>-	if (listener->sk_err) {
>-		err = -listener->sk_err;
>-	} else if (!connected) {
>-		err = -EAGAIN;
>-	}
>-

As I suggested in v4, please just add here:
	if (!connected) {
		err = -EAGAIN;
	} else {

I prefer the `goto`, but I understand that for a stable patch it might 
affect too much code, so we can do that later as part of a cleanup.
Anyway having the smallest block at the beginning of an `if/else` 
statement greatly improves readability IMO.

The rest LGTM.

Thanks,
Stefano

> 	if (connected) {
> 		sk_acceptq_removed(listener);
>
>@@ -1941,6 +1935,8 @@ static int vsock_accept(struct socket *sock, struct socket *newsock,
>
> 		release_sock(connected);
> 		sock_put(connected);
>+	} else {
>+		err = -EAGAIN;
> 	}
>
> out:
>-- 
>2.53.0
>

