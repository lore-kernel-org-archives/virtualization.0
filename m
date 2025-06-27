Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B2E239072
	for <virtualization@lists.linux.dev>; Fri, 27 Jun 2025 08:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751011740; cv=none; b=DBn2jpblS6cWGid8cppeVl+ctqcY+dIOkSzgdH3GDY+vvTjGeedQMBwzBRUNGx3XaytOopitZWLJ4KBgjXQb6pigIGaMwScUt9Vote18EKzTrcxI7if9yryFrlskLfI8Dnh1Mep6LoJbPnnlAmjrjMVvbQkpIsOyq9Ag5lPijzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751011740; c=relaxed/simple;
	bh=4atm7a3aa7XLLdZNBlU0QoQBXv7fksZDQmZpN4oS3ko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=RISXU3VseKQ5IlygMQri7SaW0srksMTD3Q59Iebvfa1qI4VZrwshcomagHb/damQU8TlylHDWtMehVPF0X0SJ1fA+geBGjGXSvyxzyEUAXHbygJ1xq8lnLpDMhkeWwlU0vvzo7S9uay83r9EXxM5reI179vzxt2wEZlVU2IBHCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZLYDaLQL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZLYDaLQL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751011737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/1zTV14SPJKhyzAQ+CnMR/zcHPupL9X+uwgLCPBgwIs=;
	b=ZLYDaLQLvljrIUIZxVPaVq8JzNnpcdErqImpcRKAdAWOMf8gK668FOo8Z/w3NgKKsVmNbO
	Uicmo0abJ2d1lAfUip+enLPE66W46yTJazDmeQwLAhf1XuoZ/ToC/wgutG8WUm84QAcH6v
	detpEWTIEW9S55YxHzkBHKrCc8X2dgA=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-zmRiKd8jMBi4yinWOL_W0w-1; Fri, 27 Jun 2025 04:08:55 -0400
X-MC-Unique: zmRiKd8jMBi4yinWOL_W0w-1
X-Mimecast-MFC-AGG-ID: zmRiKd8jMBi4yinWOL_W0w_1751011734
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b3184712fd8so1474986a12.3
        for <virtualization@lists.linux.dev>; Fri, 27 Jun 2025 01:08:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751011734; x=1751616534;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/1zTV14SPJKhyzAQ+CnMR/zcHPupL9X+uwgLCPBgwIs=;
        b=q4b9lGXIwlOYuOvUzqj8l8nRb5uPULqLYljLY66wDzXvmDTc1Db8sNRRXC771b05fg
         8l5VmmOtS7/F43g8Hyu0dpEWKdFqNPwVdFRQ/BDr54VC792bsmvmm4mLmmvvN3NylVG3
         22aZMcBOQ0A0+lcQaB2NaSkuB7//bNTYHGcK6k7LQ3yfYI6qIj584QJkLxUmK39lHhvw
         0kEXjbkXDoQE3zoyMXTHjnwJyr2TzobeangqH3ZPcgR2lc7fjnBc7OCUYkEoc0W1DvAb
         htS9vL1jzHmySiEWrxlmfre+ip1Qr2EZ8GVJVBjoXV1wyNLE3ej9pCB4qLmohcAU6MHm
         B4rg==
X-Forwarded-Encrypted: i=1; AJvYcCVBZA70wjbjEqPxrKoOXsmKofTsdZTCglKAdo3gqp9ubZXHZX6ZMWQZZLo0uQx3bgZ+hXcz0I9SqvJnqdkT/Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx5E60tnZexaq/YqOyKn05iThlxGnxGMgwwi3NjZXJLTHbPOEqq
	ZElz4bUN9dGFZ/LkZm1JUTThS3oM+CFsbXoGmQWdJmU5pzmK2VYqiMd6E9Rh1Nmt1AXkIxdsniO
	K1H7SWx9o5DgG40pQpNtiQoTs5vE/EadoET44zdOZEUYmbQ0DQPi7dMxBVWaJR1vkE7ci
X-Gm-Gg: ASbGncuFTC4ZLwy763TJuU+H/IyAJ80hNSNYF7sv0QWoo8ISdyCccFlc5VWMInWeDfw
	fAnqPflPYLgOLM1m/JfzRi1PLtNNH2e+HLrYhTziml6GUzcdkuGVRARdkDAxXJ+8dYvGCFyGpYh
	8E389P+xL+o2R+Z6M9rr6jqoFe2fzV3ULHC3ECAD47qqe0HHLzvZSUfpXAZh4fQ85ii+U+Ncg4y
	G2yRUWHZp//x1bocDUpsa3lyKOfS6aCe4lom+DAL/TyL8qtMworFlIIES+WCoBlkf/LTRIs1NVh
	B+OsALXWDBZ2u4xCfGAlQT0EgR4=
X-Received: by 2002:a05:6a21:4606:b0:1f5:7280:1cf2 with SMTP id adf61e73a8af0-220a12dcb62mr3298237637.12.1751011734523;
        Fri, 27 Jun 2025 01:08:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFr/5FfyhGN+rz6LQcfj5dGER/OaxguGxdnRTL3rMKPiYqAnq1lmuYeWjQctcVkptzzUcr5EQ==
X-Received: by 2002:a05:6a21:4606:b0:1f5:7280:1cf2 with SMTP id adf61e73a8af0-220a12dcb62mr3298206637.12.1751011734091;
        Fri, 27 Jun 2025 01:08:54 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.150.33])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af541bd1fsm1597968b3a.47.2025.06.27.01.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 01:08:53 -0700 (PDT)
Date: Fri, 27 Jun 2025 10:08:38 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net v2 2/3] vsock: Fix transport_* TOCTOU
Message-ID: <l6yqfwqjzygrs74shfsiptexwqydw3ts2eiuet2te3b7sseelo@ygussce5st4h>
References: <20250620-vsock-transports-toctou-v2-0-02ebd20b1d03@rbox.co>
 <20250620-vsock-transports-toctou-v2-2-02ebd20b1d03@rbox.co>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250620-vsock-transports-toctou-v2-2-02ebd20b1d03@rbox.co>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GhQCx0WR-kIU7jcLSaKjwhyrN4WNK8HhlXT369-PVVM_1751011734
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Fri, Jun 20, 2025 at 09:52:44PM +0200, Michal Luczaj wrote:
>Transport assignment may race with module unload. Protect new_transport
>from becoming a stale pointer.
>
>This also takes care of an insecure call in vsock_use_local_transport();
>add a lockdep assert.
>
>BUG: unable to handle page fault for address: fffffbfff8056000
>Oops: Oops: 0000 [#1] SMP KASAN
>RIP: 0010:vsock_assign_transport+0x366/0x600
>Call Trace:
> vsock_connect+0x59c/0xc40
> __sys_connect+0xe8/0x100
> __x64_sys_connect+0x6e/0xc0
> do_syscall_64+0x92/0x1c0
> entry_SYSCALL_64_after_hwframe+0x4b/0x53
>
>Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> net/vmw_vsock/af_vsock.c | 28 +++++++++++++++++++++++-----
> 1 file changed, 23 insertions(+), 5 deletions(-)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 63a920af5bfe6960306a3e5eeae0cbf30648985e..a1b1073a2c89f865fcdb58b38d8e7feffcf1544f 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -407,6 +407,8 @@ EXPORT_SYMBOL_GPL(vsock_enqueue_accept);
>
> static bool vsock_use_local_transport(unsigned int remote_cid)
> {
>+	lockdep_assert_held(&vsock_register_mutex);
>+
> 	if (!transport_local)
> 		return false;
>
>@@ -464,6 +466,8 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
>
> 	remote_flags = vsk->remote_addr.svm_flags;
>
>+	mutex_lock(&vsock_register_mutex);
>+
> 	switch (sk->sk_type) {
> 	case SOCK_DGRAM:
> 		new_transport = transport_dgram;
>@@ -479,12 +483,15 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
> 			new_transport = transport_h2g;
> 		break;
> 	default:
>-		return -ESOCKTNOSUPPORT;
>+		ret = -ESOCKTNOSUPPORT;
>+		goto err;
> 	}
>
> 	if (vsk->transport) {
>-		if (vsk->transport == new_transport)
>-			return 0;
>+		if (vsk->transport == new_transport) {
>+			ret = 0;
>+			goto err;
>+		}

		/* transport->release() must be called with sock lock acquired.
		 * This path can only be taken during vsock_connect(), where we
		 * have already held the sock lock. In the other cases, this
		 * function is called on a new socket which is not assigned to
		 * any transport.
		 */
		vsk->transport->release(vsk);
		vsock_deassign_transport(vsk);

Thinking back to this patch, could there be a deadlock between call
vsock_deassign_transport(), which call module_put(), now with the
`vsock_register_mutex` held, and the call to vsock_core_unregister()
usually made by modules in the exit function?

Thanks,
Stefano

>
> 		/* transport->release() must be called with sock lock acquired.
> 		 * This path can only be taken during vsock_connect(), where we
>@@ -508,8 +515,16 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
> 	/* We increase the module refcnt to prevent the transport unloading
> 	 * while there are open sockets assigned to it.
> 	 */
>-	if (!new_transport || !try_module_get(new_transport->module))
>-		return -ENODEV;
>+	if (!new_transport || !try_module_get(new_transport->module)) {
>+		ret = -ENODEV;
>+		goto err;
>+	}
>+
>+	/* It's safe to release the mutex after a successful try_module_get().
>+	 * Whichever transport `new_transport` points at, it won't go await
>+	 * until the last module_put() below or in vsock_deassign_transport().
>+	 */
>+	mutex_unlock(&vsock_register_mutex);
>
> 	if (sk->sk_type == SOCK_SEQPACKET) {
> 		if (!new_transport->seqpacket_allow ||
>@@ -528,6 +543,9 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
> 	vsk->transport = new_transport;
>
> 	return 0;
>+err:
>+	mutex_unlock(&vsock_register_mutex);
>+	return ret;
> }
> EXPORT_SYMBOL_GPL(vsock_assign_transport);
>
>
>-- 
>2.49.0
>

