Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD14318BA8
	for <virtualization@lists.linux.dev>; Mon, 18 May 2026 10:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779099380; cv=none; b=NaLRkWvhmEbOLAJFf9mXmqMIdUiWJ0VdyL2U28o4qMjGu3uxI/gviplv3d6vCmC+IundBe7HaGV34SMgrCYDFGCVQTsXZJO/2QPMWH1Dnpogbn3R7Fz4Q0DF1aQASORNHWF3tQv3nduHZwIMawnWt8ExoiRuefwbqvBjGdBx6PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779099380; c=relaxed/simple;
	bh=p2oIC8NYFEoKssE9YGgapSCQbvrsyIhbBtAn1ZjbU6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=c27y42QlgcLuRDAWXBsnwR9qSSY8WbOydatxzXJgPY0yISAsO4tFn63vRSc2hUc2fQVUHaCN3I9zLF1B5Won2gsrb2s7DnQHbNbN0Zk8NEaGfPUCKqeazQTF/OIm4CsZZb2ADQjWu4jnWM1qVXlxH7EJRaPIJlWMlfcBiZIBEKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z8hy/8B7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z8hy/8B7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779099377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U+bPT0OwjK2/sBWY1H6birk4kBm4U11B33CKAu6EoPE=;
	b=Z8hy/8B7GM33tHtIMt5wRDi5h5a4svNIhsrtfhzaWObvVRaaOV8ftqi47e22eH+JewSEwf
	6NBWgcb55CzCwJR+fB214iElFi0ArjwMiIxL7SBhyLpi9gwKjXFD+LL1jE+MwGTxmPRRKr
	IsAXgx5jQ1Al06+fXxwJ/Zs4G4KyXQE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-42z381vXMoKOqxaJ9KlM9A-1; Mon, 18 May 2026 06:16:14 -0400
X-MC-Unique: 42z381vXMoKOqxaJ9KlM9A-1
X-Mimecast-MFC-AGG-ID: 42z381vXMoKOqxaJ9KlM9A_1779099373
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-48fd8162ed7so16955225e9.2
        for <virtualization@lists.linux.dev>; Mon, 18 May 2026 03:16:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779099373; x=1779704173;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U+bPT0OwjK2/sBWY1H6birk4kBm4U11B33CKAu6EoPE=;
        b=hkh4cX+PPIef23blDgQJYxNN23VS50INodqFcYcFbec1k/XAtw5N3iDi/uKtDllwht
         r68r6qRhIjLgjBzpB2pfDa7/20TeBntSWV1sT6TKKjL1i1aXORqe7N6Hf2m0dAmYqErC
         ghOyJJlpP4pjl9faDNglYSF1Vb0T/GICEnJ1NlFx3h+ksvFvsPZCbpkVYKutb8YnJE7d
         3ORm4ZzFXMSKcSPRIZSEJi7GVChtchENl1Ange3VdIrVK+SCwsSXcspbeAv7j7dMwBiE
         IwcglKDkHBXx183wMtnxgrMYWH0T4Qoi/sk1hhsfJ8zLzgLARhle7iKmJOkS9CqwZ8/Q
         Xzzg==
X-Forwarded-Encrypted: i=1; AFNElJ+qdRjm5xT3lfbjMVzryaXGW6wUzH2t8NHO/o8wQOPARSwXvt8gLwInBVnYbJkFXSXQGv4bwmcCl4RtvRJaNQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx+OjeCkVl5RUtyZTE3mvcjLTnHOhbNKYE6xY6nM4KDS7Y1o16S
	0eSIRQkHnNiyftLMVVRaf2576yjf4cg0ve/FCt5EjBH2c57ARJCSGm3JxP2RlWrIpDbeEbYRcJ1
	OFca6ARb+mYNCqDtmZ1Ei9gkQEcemkTY/GGRzr8ZezPPE9MgTTRZbnNSw3vloltaB6sF9
X-Gm-Gg: Acq92OFRw15lDKHynUqXT3HF8pfZy50mQYse22UkBWmVWoXq812WifNuL3e3VUOir3S
	EFPJg7cVwzvhjXb59Jt7IvY2sPYlAFKZ+ykO2haxMW7zMmCtQ7Qx6cbhd903yPqkzZdkBPKAxQc
	APIFVDqXrknII76TO7zEeY51x1VDIFr4J+vMzFBfSjzqVWDYeb5UFKQMLh9JfKGJc/NdHj3cYQf
	yIbG0dPyD1hfwKexCYqhC4NO6hk6LaXW4k22LiHmzzmUJE1GS8KpIS+a+VCbntJf/KjVrlC9ERP
	mZRaksGu1pGHH8RIp9wtU5h1n0lUNvmAlXB8cPihoShdXEQ6Ur1yoctZlhxIHH5qDQDsOmlbHup
	FikxjAcTtr4/2rDDUqTxNhC1bTPeJBgUK1uTqEUN0nxU2eqiUj2naYefmllwwEego71abLo1dFg
	==
X-Received: by 2002:a05:600c:c494:b0:485:4388:3492 with SMTP id 5b1f17b1804b1-48fe60ed839mr211919035e9.11.1779099372910;
        Mon, 18 May 2026 03:16:12 -0700 (PDT)
X-Received: by 2002:a05:600c:c494:b0:485:4388:3492 with SMTP id 5b1f17b1804b1-48fe60ed839mr211918235e9.11.1779099372199;
        Mon, 18 May 2026 03:16:12 -0700 (PDT)
Received: from sgarzare-redhat (host-87-16-204-231.retail.telecomitalia.it. [87.16.204.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe53ab6aasm261827455e9.2.2026.05.18.03.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 03:16:11 -0700 (PDT)
Date: Mon, 18 May 2026 12:16:05 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Ziyu Zhang <ziyuzhang201@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andy King <acking@vmware.com>, 
	George Zhang <georgezhang@vmware.com>, Dmitry Torokhov <dtor@vmware.com>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	baijiaju1990@gmail.com, r33s3n6@gmail.com, gality369@gmail.com, zhenghaoran154@gmail.com, 
	hanguidong02@gmail.com, zzzccc427@gmail.com
Subject: Re: [PATCH net] vsock: keep poll shutdown state consistent
Message-ID: <agrldIdftDXvATYx@sgarzare-redhat>
References: <20260516034745.260442-1-ziyuzhang201@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260516034745.260442-1-ziyuzhang201@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4MxiaNQ71abGzlOR85-rfEftBEEtO2cFE7vYcuG6M-Y_1779099373
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Sat, May 16, 2026 at 11:47:45AM +0800, Ziyu Zhang wrote:
>vsock_poll() reads vsk->peer_shutdown before taking the socket
>lock to set EPOLLHUP and EPOLLRDHUP, then reads it again under the
>lock to report EOF readability. A shutdown packet can update
>peer_shutdown while poll is waiting for the lock, so one poll invocation
>can report EPOLLIN without the corresponding HUP/RDHUP bits.
>
>Keep non-connectible sockets on a single lockless READ_ONCE()

Should this be paired with WRITE_ONCE() on writers?

>snapshot. For connectible sockets, defer shutdown-derived poll bits
>until after lock_sock() and use one READ_ONCE() snapshot for both EOF
>readability and HUP/RDHUP. This preserves shutdowns that arrive before
>the lock is acquired and keeps all peer-shutdown-derived bits consistent
>for a poll pass.
>
>Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
>Signed-off-by: Ziyu Zhang <ziyuzhang201@gmail.com>
>---
> net/vmw_vsock/af_vsock.c | 40 ++++++++++++++++++++++++++--------------
> 1 file changed, 26 insertions(+), 14 deletions(-)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index adcba1b7b..bed42347b 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1122,6 +1122,25 @@ static int vsock_shutdown(struct socket *sock, int mode)
> 	return err;
> }
>
>+static __poll_t vsock_poll_shutdown(struct sock *sk, u32 peer_shutdown)
>+{
>+	__poll_t mask = 0;
>+
>+	/* INET sockets treat local write shutdown and peer write shutdown as a
>+	 * case of EPOLLHUP set.
>+	 */
>+	if (sk->sk_shutdown == SHUTDOWN_MASK ||
>+	    ((sk->sk_shutdown & SEND_SHUTDOWN) &&
>+	     (peer_shutdown & SEND_SHUTDOWN)))
>+		mask |= EPOLLHUP;
>+
>+	if (sk->sk_shutdown & RCV_SHUTDOWN ||
>+	    peer_shutdown & SEND_SHUTDOWN)
>+		mask |= EPOLLRDHUP;
>+
>+	return mask;
>+}
>+
> static __poll_t vsock_poll(struct file *file, struct socket *sock,
> 			       poll_table *wait)
> {
>@@ -1139,19 +1158,9 @@ static __poll_t vsock_poll(struct file *file, struct socket *sock,
> 		/* Signify that there has been an error on this socket. */
> 		mask |= EPOLLERR;
>
>-	/* INET sockets treat local write shutdown and peer write shutdown as a
>-	 * case of EPOLLHUP set.
>-	 */
>-	if ((sk->sk_shutdown == SHUTDOWN_MASK) ||
>-	    ((sk->sk_shutdown & SEND_SHUTDOWN) &&
>-	     (vsk->peer_shutdown & SEND_SHUTDOWN))) {
>-		mask |= EPOLLHUP;
>-	}
>-
>-	if (sk->sk_shutdown & RCV_SHUTDOWN ||
>-	    vsk->peer_shutdown & SEND_SHUTDOWN) {
>-		mask |= EPOLLRDHUP;
>-	}
>+	if (!sock_type_connectible(sk->sk_type))
>+		mask |= vsock_poll_shutdown(sk,
>+					    READ_ONCE(vsk->peer_shutdown));

Can we move this in the `if (sock->type == SOCK_DGRAM)` branch ?

Not a strong opinion about that, but in any case IMO we should add a 
comment here to explain why we are doing only for not connectible 
sockets.

That said, if we use WRITE_ONCE in the writers, do we really need to 
move this after the lock_sock for the connectable ones?

>
> 	if (sk_is_readable(sk))
> 		mask |= EPOLLIN | EPOLLRDNORM;
>@@ -1171,6 +1180,7 @@ static __poll_t vsock_poll(struct file *file, struct socket *sock,
>
> 	} else if (sock_type_connectible(sk->sk_type)) {
> 		const struct vsock_transport *transport;
>+		u32 peer_shutdown;
>
> 		lock_sock(sk);
>
>@@ -1203,10 +1213,12 @@ static __poll_t vsock_poll(struct file *file, struct socket *sock,
> 		 * terminated should also be considered read, and we check the
> 		 * shutdown flag for that.
> 		 */
>+		peer_shutdown = READ_ONCE(vsk->peer_shutdown);
> 		if (sk->sk_shutdown & RCV_SHUTDOWN ||
>-		    vsk->peer_shutdown & SEND_SHUTDOWN) {
>+		    peer_shutdown & SEND_SHUTDOWN) {
> 			mask |= EPOLLIN | EPOLLRDNORM;
> 		}
>+		mask |= vsock_poll_shutdown(sk, peer_shutdown);

nit: to keep the order the same as before, I would move this call just 
before this `if` block, but I don't think it makes any difference in the 
end.

>
> 		/* Connected sockets that can produce data can be written. */
> 		if (transport && sk->sk_state == TCP_ESTABLISHED) {
>-- 
>2.43.0
>

