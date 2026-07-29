Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067893DDAEA
	for <virtualization@lists.linux.dev>; Wed, 29 Jul 2026 13:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785331197; cv=none; b=I3MtxQbltHJlscC8Wh45rx3/cwPPWN2XJeKWkFP8ApM8qdhKApn11BLGJmABhXslZOo57e4uu7fJ9G9mXQhZ0MR1/2Eg/hhFeYTTMFd81w9KgJy/Rma1HeIIo52E3IkyZwQ8FmxH5iU+J6zyGwS+R/ST7Ed9ve/gymvg+XhVTnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785331197; c=relaxed/simple;
	bh=rr8YEWc3HSMWJ/APxhUFP/anlcCNU5lJQeizD/PJNI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=WUVOhNqCm+MYQpNvKjCWFD1PyoCvXd8V/EbHCQW8ggSYTF9s0QOxKNepyiL0m3Qnn7GctbxJ09XPTpW02boGQfToUp0iCaqw9KjYURNY4kzxMqyJgv8DYPDK1PUK9uZ0I/rhntlhF+EZi3YxAwAVXywxu/Qs3K1t9jjA+XmJzNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DhOIGTZy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DhOIGTZy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785331193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gG4+OnzKs4OXOyTaKQLNCs0RTVMvrRHDvkvXHi16iz8=;
	b=DhOIGTZyDInsyO7fPYlO8WVGqLX2D9EoPN2n7YW7kfMQndPgnmMgO11JcL7wwe3i0z4Kp/
	7QPwI3L6lK922GwX9g/Ab2l+gwlY/yBhTgGr0be8Fo48Ky9tOviMuEB8Dd6LPgAqec54Sz
	341ssFo80aKS9Snuy0ThJnb3C4Y4fK0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-sixAnVs4OAOZ0LG3ntLqGA-1; Wed, 29 Jul 2026 09:19:49 -0400
X-MC-Unique: sixAnVs4OAOZ0LG3ntLqGA-1
X-Mimecast-MFC-AGG-ID: sixAnVs4OAOZ0LG3ntLqGA_1785331188
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-47f810c8aebso590731f8f.2
        for <virtualization@lists.linux.dev>; Wed, 29 Jul 2026 06:19:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785331188; x=1785935988;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gG4+OnzKs4OXOyTaKQLNCs0RTVMvrRHDvkvXHi16iz8=;
        b=mSx0GsaicuxeCA4FDQUzLJ+59dqxt1ITeYiq+fRZ7mI+t+19yG0v6Uwk2OiPc7oPvG
         O00AGFhwxsJ1Im8h3UoZ0LKO+1xAzxug62pZAKPIs+EpMBjHSSo7px3QlBVL8C2izT9e
         4zLvGTdPuynFWd/T6je9tnmqreJVZZmT2r5JwPKcWJC1UZafuKI2+3BXb8CNcDIvnzYX
         HFh/Ei89gB18M4lvsRmeXGrhZ/qaZ/HDy9UsmFM0tyJyQKHZZAEmX8rUO1fAb68FDOvu
         2mBbocn4LQay2i724PiZyvgmHQ3AlpGGXs/vPIA96qfai1/VVhDhj0UAQ6d6q8UPH8i1
         IRrQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr6yWPfxHpGBNj85kTLahX3zvhRZQGIDmqBrrW3mGzH8ud6hhbRgDjXjaNMWi8pD+m1Wr+5C7QEc5KgeLbAYA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzmtd/ykl5FENK0iLBszv+O7Kcf4SlbUgozAfXwCePqQpTC+T3Q
	uwjrN59gg/XlA3Xkdfnx+E7WB6+Brx8l6iv9p6gbFpoONlVXjx6YBS8emgIobt/d84DFYLfV5YZ
	i5WIjDVX0ESCjes2F+sW3eUwL3e9GMHnPAXiTLiKwzWTIktRUv9W4cU6NFvN+YTqDVT7i
X-Gm-Gg: AR+sD10X0ZRUOHfat6Jy3XMECJE7bwDBbjQZQv5WyAHv0bW23uy5aDPkeO5xxInQtcd
	OC7qk43IEM1kWSd78OZLgWEcwtjPanknVEJo/WWC5zhFW64ZIbd/Oy89wz+ZWbupcoaUbE3ofek
	zGc9IzVH4nTUj7LCo+XPUVbznFswgXIf47QnNW337dtoAKMIfbksxx2wOHaY+ztGLBiyr3Ld4DI
	CRRRdXFWh/Xrl/MQhPUKiMJC0kuPeXH/6M2dtRE/ix74GhVpfrj4n/5ekqMOAsXvz1Wdd0Zhv6C
	yhg1SuqhkxZ+nXHd2/kQ0cmJQqm0ghxHZ6VU/NX/1SJyPFAb5YBn8jU2otXThukxQtBPjprcK7/
	I0wvpUTlsvw9dgwl8jqsaQcuVV1Bahpj27FrDyameFM4=
X-Received: by 2002:a5d:5d03:0:b0:47f:9642:5cb3 with SMTP id ffacd0b85a97d-47fb1f2205cmr8180294f8f.43.1785331188244;
        Wed, 29 Jul 2026 06:19:48 -0700 (PDT)
X-Received: by 2002:a5d:5d03:0:b0:47f:9642:5cb3 with SMTP id ffacd0b85a97d-47fb1f2205cmr8180221f8f.43.1785331187616;
        Wed, 29 Jul 2026 06:19:47 -0700 (PDT)
Received: from sgarzare-redhat (ip139-137-192-82.pool-bba.aruba.it. [82.192.137.139])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fb6b0ef1asm8208696f8f.19.2026.07.29.06.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 06:19:46 -0700 (PDT)
Date: Wed, 29 Jul 2026 15:19:41 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: phind.uet@gmail.com
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andy King <acking@vmware.com>, 
	Dmitry Torokhov <dtor@vmware.com>, George Zhang <georgezhang@vmware.com>, 
	syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] vsock: use sock_error() to consume sk_err after a
Message-ID: <amn7W3hAIEC7kcQO@sgarzare-redhat>
References: <20260727071305.45826-1-phind.uet@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260727071305.45826-1-phind.uet@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7auu4mcsAeTJJychqP_E8hFI-I6aWQXkdiDAAEfB40M_1785331188
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline


commit title seems truncated, can you check?

On Mon, Jul 27, 2026 at 03:13:02PM +0800, phind.uet@gmail.com wrote:
>From: Nguyen Dinh Phi <phind.uet@gmail.com>
>
>Syzbot report an issue which can be reproduced with these steps:
>   r0 = socket(AF_VSOCK, SOCK_STREAM, 0)
>   bind(r0, {VMADDR_CID_ANY, PORT})
>   connect(r0, {VMADDR_CID_LOCAL, PORT})
>   listen(r0, backlog)
>
>   r1 = socket(AF_VSOCK, SOCK_STREAM, 0)
>   connect(r1, {VMADDR_CID_LOCAL, PORT})
>   connect(r0 -> self) -> -1, EPROTO
>
>   listen(r0)          -> 0
>   connect(r1 -> r0)   -> 0
>   accept(r0)          -> -1, EPROTO

I spent some time to understand this, what about changing in this way
(or something similar):

     r0 = socket(AF_VSOCK, SOCK_STREAM, 0)
     bind(r0, {VMADDR_CID_ANY, PORT})
     connect(r0, {VMADDR_CID_LOCAL, PORT})   -> -1, EPROTO  (self-connect)
     listen(r0, backlog)                     -> 0
     r1 = socket(AF_VSOCK, SOCK_STREAM, 0)
     connect(r1, {VMADDR_CID_LOCAL, PORT})   -> 0
     accept(r0)                              -> -1, EPROTO  (stale sk_err)

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
>implements pending_work to revisit and clean up a rejected socket
>
>Fix the issue by using sock_error() to read the sk_err to prevent the
>rejection branch from occurring  in this scenario.
>
>sock_error() atomically reads and clears sk_err, ensuring the error is
>consumed when vsock_connect() returns and cannot affect subsequent
>operations on the same socket. This matches the established pattern
>used by other protocol connect() implementations in the network
>stack like __inet_stream_connect(), tipc_wait_for_connect()...
>
>Reported-by: syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com
>Closes: https://syzkaller.appspot.com/bug?extid=1b2c9c4a0f8708082678
>Fixes: d021c344051af ("VSOCK: Introduce VM Sockets")
>Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
>---
>V2: Add reproducer steps to commit message.
>
> net/vmw_vsock/af_vsock.c | 7 ++-----
> 1 file changed, 2 insertions(+), 5 deletions(-)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 622dbd046799..43eddc33ed12 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1847,14 +1847,11 @@ static int vsock_connect(struct socket *sock, struct sockaddr_unsized *addr,
> 		prepare_to_wait(sk_sleep(sk), &wait, TASK_INTERRUPTIBLE);
> 	}
>
>-	if (sk->sk_err) {
>-		err = -sk->sk_err;
>+	err = sock_error(sk);

Should we do the same in other paths (e.g. send/recv) as well in a 
follwup patch or in a series?

The patch itself LGTM.

Thanks,
Stefano

>+	if (err) {
> 		sk->sk_state = TCP_CLOSE;
> 		sock->state = SS_UNCONNECTED;
>-	} else {
>-		err = 0;
> 	}
>-
> out_wait:
> 	finish_wait(sk_sleep(sk), &wait);
> out:
>-- 
>2.53.0
>

