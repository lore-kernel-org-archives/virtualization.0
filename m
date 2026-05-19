Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FF94048A3
	for <virtualization@lists.linux.dev>; Tue, 19 May 2026 09:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779183381; cv=none; b=gDo+Os3MeJMEQ/ix8hYJMcWLyiU4xDG6VWzFdE1X7BBTqiUnOQGfNdJweW7tot2pr3PsigqsMxnIFkKqBCEILUtzlmTzuocRJLAwhXjk8RoXSm2qAW03t+ljUuApvKrfvk9ImkFDBU5DAO5j0rw8WMxaEpQajfa6lM4BNZelBOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779183381; c=relaxed/simple;
	bh=iTxsJxAr/FOzDabg6fAhhdzq5XWXfyV2NneHC6h5vAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=qjqwyj1SoQ+8bfJB7nNM9XOMQwvtJUOWmjuuVrv9t9HLTPeh0gjwcgYlmymOkVouT7BiKwnwa1IHNLJ8zudLK8oSyLH+nIRFsTJu2bzyx2rQyvaj+W30oKuKRZLOSRBmX2u3tVaumUl00y9KxbsflsgXGcLZTO/1gDb8dCLlNh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MJyLJjm4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MJyLJjm4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779183376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2uul1ADh4nKHpxPod9aowoWLoDn8Jx6PN3i3WQIGWzk=;
	b=MJyLJjm4v7B2wIUmPBP3E6XWlhtizghgDGUQ7D3+6+BnjVZYygydnajJqscrCUwDBgsAfb
	kM14wqr97WNez0Ywi6eehVGu7Z8VaDkeEiwzMf3ji2pC7i5rvNbC+lJy3VaPDFv2hPkKPF
	wN7OEh2lCCAzUVihXoVTcPuw/cB/0Fc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-tMX9ASekOuSeBYCGc6LM7Q-1; Tue, 19 May 2026 05:36:15 -0400
X-MC-Unique: tMX9ASekOuSeBYCGc6LM7Q-1
X-Mimecast-MFC-AGG-ID: tMX9ASekOuSeBYCGc6LM7Q_1779183374
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48feb8b9acfso19914445e9.3
        for <virtualization@lists.linux.dev>; Tue, 19 May 2026 02:36:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779183374; x=1779788174;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2uul1ADh4nKHpxPod9aowoWLoDn8Jx6PN3i3WQIGWzk=;
        b=HJVy6l+qsOC2KAe5oYkhiTjBpRZ7ERqfSQKGI1fUSsjOdY/GpNZbNmNrO39mW5b5kl
         x8uWrTRoMYviixtzo21TrXryb9cKnpcJ16G+Bnr59tLGYYFcH2ERkdIlEmvDpiIF9dp5
         B8bLxdHvpDdKe+bbJBYOzHQShrBN4oU3cUnsR+JqfnYILdAmzGEk9JML8KJEwa9Nduym
         o6R3pUr9HCMEv08SREiVbmeBhNRphUq2v6vXv3THKa1YRCouAt8+o+vRybqGWIOB4znM
         iNNwoz5SKkPHsNiYjtorQOtVbWFQC7GvBbGe+RamKUjFUiKwhmXCtlaBCQ1aZLL66+RW
         af6Q==
X-Forwarded-Encrypted: i=1; AFNElJ/JXp72RvaHwrsW3D8v8bin9mUL4YkmNnWE5TjD54Mgtb41uw+/fTjRJu5SBHvPpYMO6JJxsMXulPA4nMrAoQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwKDx9HIXLlZCH3b4O+vZT+a/0LQCXfTVycGBri7sEjJAo3LLLI
	nLJ6DfcUMhE4R3W8jiMnoDcK+k0/aECChS4G46ZbH6nl5c1HNZ2ozPuD3OErXo32MO/4yvw+NLt
	AXudaQ/d3LS/uGdv6/X7FQnA06ciZ+f2Zs9u+5DI9MobQpOeb5weHqNm7AaaZxgYLToeR
X-Gm-Gg: Acq92OFvIMhoi06kQdps/Kuo35Xuc0KyNciwCzL3PVX2MjVzjrZOtABZ6wpHpA0GqIz
	fQlgmdeAO+2SvRb+Wv0pYf0eqcXBtlOgRRlDja7NQYBL2fR1TvpSpVRl2nW+A0M4zUr50JdTHqK
	eGnBKZ9bRNPVFIL8P7woCVudVK3HGJBu6Id9qxv1wFBaducQdoudZi3C/8jzn02/I7Mx51Fp56d
	mgyqnFkOQ93g+IdludIib3ZL7tbo634I8sB3n9n4NIWjl/nSYTd0Xx6WJsI/4UEhkRlFshS21UV
	82nQ1CbgVO8ktOfh8p6Hh0/livxLXU1VLAiOXYgc+4f4dcsWw6q8PRQcx433tdPguex8r3Mw7Xo
	65JLW7TJEwGaGm1ZHRjd3hLZXPks/aFSxLHT4ETZ5xYououTvIP88bsZJQjaqlIhNingqjsa1HA
	==
X-Received: by 2002:a05:600c:848c:b0:485:3ff1:d5ed with SMTP id 5b1f17b1804b1-48fe60e3c3fmr285046695e9.1.1779183373869;
        Tue, 19 May 2026 02:36:13 -0700 (PDT)
X-Received: by 2002:a05:600c:848c:b0:485:3ff1:d5ed with SMTP id 5b1f17b1804b1-48fe60e3c3fmr285046015e9.1.1779183373393;
        Tue, 19 May 2026 02:36:13 -0700 (PDT)
Received: from sgarzare-redhat (host-87-16-204-231.retail.telecomitalia.it. [87.16.204.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe537c788sm298640545e9.12.2026.05.19.02.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 02:36:12 -0700 (PDT)
Date: Tue, 19 May 2026 11:36:04 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: ziyu zhang <ziyuzhang201@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andy King <acking@vmware.com>, 
	George Zhang <georgezhang@vmware.com>, Dmitry Torokhov <dtor@vmware.com>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	baijiaju1990@gmail.com, r33s3n6@gmail.com, gality369@gmail.com, zhenghaoran154@gmail.com, 
	hanguidong02@gmail.com, zzzccc427@gmail.com
Subject: Re: [PATCH net] vsock: keep poll shutdown state consistent
Message-ID: <agwugKMrTsNxQ2BD@sgarzare-redhat>
References: <20260516034745.260442-1-ziyuzhang201@gmail.com>
 <agrldIdftDXvATYx@sgarzare-redhat>
 <CACPoYJx6szY6HcvBf+aNr5+BgrxNNJM0su-qKxzp0qW+cJWO9w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACPoYJx6szY6HcvBf+aNr5+BgrxNNJM0su-qKxzp0qW+cJWO9w@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: r-TYYve88teysH3KeNqIQ0kD8LRy3sv810oIeZG3hkA_1779183374
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, May 18, 2026 at 08:39:37PM +0800, ziyu zhang wrote:
>On Mon, 18 May 2026 at 18:16, Stefano Garzarella <sgarzare@redhat.com> wrote:
>>
>> On Sat, May 16, 2026 at 11:47:45AM +0800, Ziyu Zhang wrote:
>> >vsock_poll() reads vsk->peer_shutdown before taking the socket
>> >lock to set EPOLLHUP and EPOLLRDHUP, then reads it again under the
>> >lock to report EOF readability. A shutdown packet can update
>> >peer_shutdown while poll is waiting for the lock, so one poll invocation
>> >can report EPOLLIN without the corresponding HUP/RDHUP bits.
>> >
>> >Keep non-connectible sockets on a single lockless READ_ONCE()
>>
>> Should this be paired with WRITE_ONCE() on writers?
>
>Yes, since the poll path uses lockless READ_ONCE() snapshots of
>peer_shutdown, the writer side should be annotated with WRITE_ONCE() as
>well. I will add that in v2.
>
>>
>> >snapshot. For connectible sockets, defer shutdown-derived poll bits
>> >until after lock_sock() and use one READ_ONCE() snapshot for both EOF
>> >readability and HUP/RDHUP. This preserves shutdowns that arrive before
>> >the lock is acquired and keeps all peer-shutdown-derived bits consistent
>> >for a poll pass.
>> >
>> >Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
>> >Signed-off-by: Ziyu Zhang <ziyuzhang201@gmail.com>
>> >---
>> > net/vmw_vsock/af_vsock.c | 40 ++++++++++++++++++++++++++--------------
>> > 1 file changed, 26 insertions(+), 14 deletions(-)
>> >
>> >diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>> >index adcba1b7b..bed42347b 100644
>> >--- a/net/vmw_vsock/af_vsock.c
>> >+++ b/net/vmw_vsock/af_vsock.c
>> >@@ -1122,6 +1122,25 @@ static int vsock_shutdown(struct socket *sock, int mode)
>> >       return err;
>> > }
>> >
>> >+static __poll_t vsock_poll_shutdown(struct sock *sk, u32 peer_shutdown)
>> >+{
>> >+      __poll_t mask = 0;
>> >+
>> >+      /* INET sockets treat local write shutdown and peer write shutdown as a
>> >+       * case of EPOLLHUP set.
>> >+       */
>> >+      if (sk->sk_shutdown == SHUTDOWN_MASK ||
>> >+          ((sk->sk_shutdown & SEND_SHUTDOWN) &&
>> >+           (peer_shutdown & SEND_SHUTDOWN)))
>> >+              mask |= EPOLLHUP;
>> >+
>> >+      if (sk->sk_shutdown & RCV_SHUTDOWN ||
>> >+          peer_shutdown & SEND_SHUTDOWN)
>> >+              mask |= EPOLLRDHUP;
>> >+
>> >+      return mask;
>> >+}
>> >+
>> > static __poll_t vsock_poll(struct file *file, struct socket *sock,
>> >                              poll_table *wait)
>> > {
>> >@@ -1139,19 +1158,9 @@ static __poll_t vsock_poll(struct file *file, struct socket *sock,
>> >               /* Signify that there has been an error on this socket. */
>> >               mask |= EPOLLERR;
>> >
>> >-      /* INET sockets treat local write shutdown and peer write shutdown as a
>> >-       * case of EPOLLHUP set.
>> >-       */
>> >-      if ((sk->sk_shutdown == SHUTDOWN_MASK) ||
>> >-          ((sk->sk_shutdown & SEND_SHUTDOWN) &&
>> >-           (vsk->peer_shutdown & SEND_SHUTDOWN))) {
>> >-              mask |= EPOLLHUP;
>> >-      }
>> >-
>> >-      if (sk->sk_shutdown & RCV_SHUTDOWN ||
>> >-          vsk->peer_shutdown & SEND_SHUTDOWN) {
>> >-              mask |= EPOLLRDHUP;
>> >-      }
>> >+      if (!sock_type_connectible(sk->sk_type))
>> >+              mask |= vsock_poll_shutdown(sk,
>> >+                                          READ_ONCE(vsk->peer_shutdown));
>>
>> Can we move this in the `if (sock->type == SOCK_DGRAM)` branch ?
>>
>> Not a strong opinion about that, but in any case IMO we should add a
>> comment here to explain why we are doing only for not connectible
>> sockets.
>>
>> That said, if we use WRITE_ONCE in the writers, do we really need to
>> move this after the lock_sock for the connectable ones?
>
>Yes, I will move the non-connectible handling into the SOCK_DGRAM branch
>and add a comment there.
>
>For connectible sockets, my current understanding is that
>READ_ONCE()/WRITE_ONCE() make the individual lockless accesses explicit, but
>they do not make two separate reads in one vsock_poll() invocation observe the
>same peer_shutdown value. So I still think using one peer_shutdown snapshot
>after lock_sock() is useful for keeping the returned mask internally
>consistent. Please let me know if you think WRITE_ONCE() is enough for this
>case.

What will be the issue of "do not make two separate reads in one 
vsock_poll() invocation observe the same peer_shutdown value." ?

In any case, I'm not against it; I just want to understand the issue 
better.

Thanks,
Stefano

