Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4967637107B
	for <virtualization@lists.linux.dev>; Thu,  2 Apr 2026 12:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775131386; cv=none; b=NjsXwvwzNOWuKtiGQxRfELDMcOSRDAk1tZYq8iw60ohz+YrqYUa1nTHvOCIRBsIqofV/96OjC5dZ+Mw0xrwPcXAs2HS8K3cBkjJFdzk0o3oqCcb2JpHcwU97CXCh2EVCZdY20TkqVpOd/B8eNDcpyyBlJNcNMqJZ6q44+4J/ER4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775131386; c=relaxed/simple;
	bh=fomV+dLqeGgoLHM89BIl0h+eUKeo11/8svGhhNAX9fY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Z3vRLrr8dwDseoPYFODRvUbhjIkVCvGOY9PSoJaj+dQge1m1OUNcB++mQTnTcTG+CyKHewJoSRMG/U/FFM4h0WjXpOghRY/vBf+Zk4aWG/CUPQ5YD9YwkqFzWeZqlwAXUIBYgiObQDMYGsiN6BYT3UNh6vsuuVj9jtfpXB6uVBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WxsX8XYD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WxsX8XYD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775131381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=31cBQ4GFBHgCy9kgeze7QNmzRd+J2y9VlWwIz+Jz0mc=;
	b=WxsX8XYDio3JEfKOKLtGaiRvW8cecVcikytWJnZguaMaz+WeXqRU/g4QBoCzM36MTUHcoR
	Id7qPovJ6SSG5mOsBxZsZgrL8GRQWr0P61LaP1r+OGrtFsSIpLwvfCKzYFKapI7nYVzhWO
	xof0IzGhIE87zdIs+zW2jJpiKAvyR5A=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-hnxgnka6PNS37-776ih7Kg-1; Thu, 02 Apr 2026 08:03:00 -0400
X-MC-Unique: hnxgnka6PNS37-776ih7Kg-1
X-Mimecast-MFC-AGG-ID: hnxgnka6PNS37-776ih7Kg_1775131379
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-486fe3b9441so6222925e9.3
        for <virtualization@lists.linux.dev>; Thu, 02 Apr 2026 05:03:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775131379; x=1775736179;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=31cBQ4GFBHgCy9kgeze7QNmzRd+J2y9VlWwIz+Jz0mc=;
        b=bZcNY5ZYc4VXFLIjiYXHDdVhB3idlOdO/vp34SN/JTv/Y2l0KKiJ21fUXvr1CLQPCj
         sIM29bR3+ELvBbBSi8IbaGNjSvIdK/sBoDTacUnFmtwehB2yjRPEbbqzusq1urY+72az
         d45VPGdfojBoY+F6bYPJc86NVr4dHmyF/u4D1C/0NPOtSpuqTkz2I8qc8cdzN+9znutn
         TK+/SUgfpBzXze/j6hzQsW2zJYrxV4IqpNAgpOg/IEjI1e/q8uD6sHGmzPnhPJeZMFUN
         iAbPiMuiPlErLIrgXokCINQWBVFR/Yj5bdzzU1Srs9f6PRh8l3NeVLqBkNaff7gxIrdK
         f/AA==
X-Gm-Message-State: AOJu0Ywg0Gjj3dL46y3WhlkZMIFOFERq9Gt1Rf3cUI2YHiG/XJ0lz4N9
	96lLbNg3TzXrnI9qT8HEDUGOnHbXDpjetO2PPLDM52bS/QAEWiDd7kCa73A5NEaTiDTQm0kLZeH
	wB7KARc1Ix6CNf5SyA1BZAXpcw6YepRGe3JwZc8SEac+tY8ShBkIEQ7MrciEaMq02WRAO
X-Gm-Gg: ATEYQzxe7Ljr8NW0aHd67jZf8NuZL4ghC5I1/BrivhS4gJ5yZz2D19vcwtBWBfxglYO
	fiGHCILgQaLcrlzPs3fH6IpmaPib0q+kObg2EAIUMSMPHafCpcrfKNPzHhc4/R3dQ2CDPZuM8Z+
	Coy8zhG1Caav5m5ULupfFShxS2ta7fr5n+LjlF66XfieEO/K5z2YTRVZIGSuGuRS4NfJ1eZptP4
	nVTG1pD2lzhZuCBbLbJxwMRGzZu89KToHrcpdkqWF0rhQXiw8KoAchxhEauyYvwbPq2hXB607KC
	KxUik9kRgX0mi9jtDU+rI2CeYPPq5dgvnL7/DTIIWuD2Qa/cDKE+xue3hlfBinATo08XT3h4zuM
	wa4izynrkZYwOdNQRAqfeXasOkyO7rOC2nJ5OcfNKFJqXPmfZL5a1Std45p3YhcgPaXTa14UrkB
	DE
X-Received: by 2002:a05:600c:a00f:b0:485:469f:5320 with SMTP id 5b1f17b1804b1-4888b7c2d90mr53159465e9.30.1775131378782;
        Thu, 02 Apr 2026 05:02:58 -0700 (PDT)
X-Received: by 2002:a05:600c:a00f:b0:485:469f:5320 with SMTP id 5b1f17b1804b1-4888b7c2d90mr53158705e9.30.1775131378094;
        Thu, 02 Apr 2026 05:02:58 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-139-105.business.telecomitalia.it. [87.12.139.105])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887c8852a5sm154893345e9.9.2026.04.02.05.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 05:02:57 -0700 (PDT)
Date: Thu, 2 Apr 2026 14:02:31 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Laurence Rowe <laurencerowe@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH] vsock: avoid timeout for non-blocking accept() with
 empty backlog
Message-ID: <ac47PYPeL0IyRtY6@sgarzare-redhat>
References: <20260402044637.73531-1-laurencerowe@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260402044637.73531-1-laurencerowe@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6vqCcIwuFjxxkXpU_t0CjKP0p-_jCxJuA4ljPx-oJH0_1775131379
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Apr 01, 2026 at 09:46:37PM -0700, Laurence Rowe wrote:
>A common pattern in epoll network servers is to eagerly accept all
>pending connections from the non-blocking listening socket after
>epoll_wait indicates the socket is ready by calling accept in a loop
>until EAGAIN is returned indicating that the backlog is empty.
>
>Scheduling a timeout for a non-blocking accept with an empty backlog
>meant AF_VSOCK sockets used by epoll network servers incurred hundreds
>of microseconds of additional latency per accept loop compared to
>AF_INET or AF_UNIX sockets.

Not related to this patch, but should we do something similar (in 
another patch) also in vsock_connect() or doesn't matter since usually 
it's always blocking?

>
>Signed-off-by: Laurence Rowe <laurencerowe@gmail.com>
>---
>
>This fixes the observed issue for me:
>
>1. With loopback vsock on the host running Linux v6.19.10 built with
>config-6.17.0-19-generic from Ubuntu 24.04 and make olddefconfig.
>
>2. With Firecracker guests with current torvalds/master, v6.19.10, and
>amazonlinux/microvm-kernel-6.1.166-24.303.amzn2023 used in Firecracker
>CI and examples. (Firecracker guest vsocks are unix sockets on the host
>side so this fix works there with just a fixed guest kernel.)
>
>I struggled to build a generic 6.1.166 kernel that worked as a
>Firecracker guest but the patch applies (conflict due to change of
>`flags` to `arg->flags` in surrounding context) so I believe it should
>work for generic v6.1.166 kernel.
>
>Alternatively a minimal version of this fix is to just wrap the
>`schedule_timeout` in an `if (timeout != 0)` but that leaves an
>unnecessary additional `lock_sock` call.
>
>There are ftrace's and reproduction tools at:
>https://github.com/lrowe/linux-vsock-accept-timeout-investigation
>---
> net/vmw_vsock/af_vsock.c | 16 +++++++---------
> 1 file changed, 7 insertions(+), 9 deletions(-)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 2f7d94d682..483889b6d8 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1850,11 +1850,11 @@ static int vsock_accept(struct socket *sock, struct socket *newsock,
> 	 * created upon connection establishment.
> 	 */
> 	timeout = sock_rcvtimeo(listener, arg->flags & O_NONBLOCK);
>-	prepare_to_wait(sk_sleep(listener), &wait, TASK_INTERRUPTIBLE);
>
> 	while ((connected = vsock_dequeue_accept(listener)) == NULL &&
>-	       listener->sk_err == 0) {
>+	       listener->sk_err == 0 && timeout != 0) {
> 		release_sock(listener);
>+		prepare_to_wait(sk_sleep(listener), &wait, TASK_INTERRUPTIBLE);

Is it okay to move prepare_to_wait() after `release_sock(listener)`?

I'm worried if we can miss any wakeup. BTW if this change is okay, we 
should document that at least in the commit description.

> 		timeout = schedule_timeout(timeout);
> 		finish_wait(sk)sleep(listener), &wait);
> 		lock_sock(listener);
>@@ -1862,17 +1862,15 @@ static int vsock_accept(struct socket *sock, struct socket *newsock,
> 		if (signal_pending(current)) {
> 			err = sock_intr_errno(timeout);
> 			goto out;
>-		} else if (timeout == 0) {
>-			err = -EAGAIN;
>-			goto out;
> 		}
>-
>-		prepare_to_wait(sk_sleep(listener), &wait, TASK_INTERRUPTIBLE);
> 	}
>-	finish_wait(sk_sleep(listener), &wait);
>
>-	if (listener->sk_err)
>+	if (listener->sk_err) {
> 		err = -listener->sk_err;
>+	} else if (timeout == 0 && connected == NULL) {

 From checkpatch:
CHECK: Comparison to NULL could be written "!connected"
#58: FILE: net/vmw_vsock/af_vsock.c:1870:
+	} else if (timeout == 0 && connected == NULL) {

>+		err = -EAGAIN;
>+		goto out;
>+	}

What about simplifying this with (not a strong opinion):

	} else if (connected == NULL) {
		err = -EAGAIN;
	}


Also 
https://patchwork.kernel.org/project/netdevbpf/patch/20260402044637.73531-1-laurencerowe@gmail.com/ 
suggests to specify a tree (net-next I think for this change) and be 
sure to CC other maintainers (scripts/get_maintainer.pl can help).

Thanks,
Stefano

