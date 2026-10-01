Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981E1468C30
	for <virtualization@lists.linux.dev>; Thu,  1 Oct 2026 09:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790845300; cv=none; b=JpE0nXsDI+ptDjYfFR4F7hZFGa4l0dkkS1ZCBKajFXkA5r248qRS6G0K9L74tQZG4BEmmynfJqaM0MLI6fW4Q8au8ytw7NIwT79IfEg2uhuM4wvTsyCxBssDZfe98GS0RURAAStp1putgbEWn3o+b6bC2ULsxeaP284I/7PbW6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790845300; c=relaxed/simple;
	bh=ZT6ldM6Rero3wx3eaj6hdpLUx6fVOW1BsVRzAoran5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=dh8bedsr5ggToogcvDuTHwRXH+bFyg1na09V1m3NG8jygGJJ/J5ZMZoyRKreIPeLC9ydyNhVsC+iRvx4y/tyNJwIKANpDYwSwvbE+yjX8Ux8BesG/lDpnwKGyp1LsO/twPcR1GOwNOdQ3JwKklpOdZABQkSymevMgNc2z/MBDLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NhT2GLcL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NhT2GLcL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790845297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3KLyDgLq+sWfesxSNS4ik2xszHhIAyJ1EGfG6IG1kIs=;
	b=NhT2GLcLb3q13laHZKmUUFj3PFyuS+pchklnpxTpkaWQ3r4z2kYWvML59Oz/LSkKRxo2mK
	Umng8mGKRs2f4urSV7HXQvfZXbewIrE2csKplHMYzob7zdmPk80TedEolh0iC+AxO/lXp0
	zF+2yyRTNyMeUNGVcL1N/p9c3CBpmhg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-QSKhEci3M9iMPKi2Lhch9w-1; Thu, 01 Oct 2026 05:01:36 -0400
X-MC-Unique: QSKhEci3M9iMPKi2Lhch9w-1
X-Mimecast-MFC-AGG-ID: QSKhEci3M9iMPKi2Lhch9w_1790845295
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a004b70f99so23952495e9.2
        for <virtualization@lists.linux.dev>; Thu, 01 Oct 2026 02:01:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790845295; x=1791450095;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3KLyDgLq+sWfesxSNS4ik2xszHhIAyJ1EGfG6IG1kIs=;
        b=tRSDLzfeoZlcN6hP+0wkJ+0mrvZK2cvs/ef8HGt0i5yRFAYEkFdE+OGSkK7LEH5J5g
         oD2SUlgdavB2rrwjbUuRiy1FTS8iHzbmYnL0xiaBmg7CR8VOiacc2qkQotWnP9IjceLm
         5uHHxcwJo6D1lyJ33GOqWRTNlIAUMKMakF7gG1+eg/HFi2/dT7J8J8lZNAlLmkvzJw/y
         HipvGnIV0QtRAzTHIjaS7YGINz0rzA4XGp8UUc+OpNE5Co5jUAev+eBBZgp0GDHWOimx
         rAPytkkRa6FM5CNpci587HIu+QmdzOu8AC1Uqk7uMVOA+8kbQoXoX26NOWEBcARrChN4
         iFFg==
X-Forwarded-Encrypted: i=1; AKwUvBykbYEbL1MPz5n/qKcO4is/4OkTKz6NfjPpbzMqZ7UcMGP2RvDIoihYZFyiA7Sjs8mOmLj65fSGKY5aHL3acg==@lists.linux.dev
X-Gm-Message-State: AFuF++n7Gesc7W//bCeS5urDQo06PWGlv4cC/RP+XhHU86FCVGkAaftd
	2Sm96BlJmVGma3jQZ/OTYOBFQ+B8Pbj/twKIy5eAHMCafdO0lCweNKRfbNTvc4bUwS/3XAHq/La
	Py0uYZvp0219TkV4q9cRewHRz53/d5Gfgc/C0dtjgxU08YlfZ2HRbYbYTjUbDXx7+ikYZ
X-Gm-Gg: AYBFou24EIbNppArw2ZSeioivqTtBfI2xsKrQP+zma+jFUEuUz/QYSpOrwP+Jg4Up/C
	wXrNDxT/ePUx2mT68GpAxN93/q63qYaa6+e7phVU8UfKyTa+QaD56GJKR1j2KQ+uSk9DmkR2nAt
	DNixOWX2l2X1Jb3uUctzm3PYpLiIFqnFwL1tJkGM21Wu0aScXu0WsoR8t4y6vL3I5jvh0uZzf1X
	YAMgnRstVws5rwdDndreSfzSK7KMcj6IQO4YgXkbKpL0gmjJ/2XZL2+t1Tf1YJ4A2ju7qmdcrpw
	DqB+wApsOu9ynV/iEmCqIZhA7moSp/uYdphu6zIsyEThGB9cQ7DinSy3gKD+fhPSgOfZLN1mUrv
	s
X-Received: by 2002:a05:600c:4e42:b0:4a0:1d:3ac4 with SMTP id 5b1f17b1804b1-4a01aff06d5mr64713595e9.6.1790845295066;
        Thu, 01 Oct 2026 02:01:35 -0700 (PDT)
X-Received: by 2002:a05:600c:4e42:b0:4a0:1d:3ac4 with SMTP id 5b1f17b1804b1-4a01aff06d5mr64713135e9.6.1790845294456;
        Thu, 01 Oct 2026 02:01:34 -0700 (PDT)
Received: from sgarzare-redhat ([5.77.112.40])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01feb7198sm42199885e9.1.2026.10.01.02.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 02:01:33 -0700 (PDT)
Date: Thu, 1 Oct 2026 11:01:24 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: jrmmhm.kernel@eldare.de, Michal Luczaj <mhal@rbox.co>, 
	Bobby Eshleman <bobbyeshleman@meta.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] vsock/bpf: release sock lock while waiting for data
 in recvmsg
Message-ID: <ar4gvlZL1JyPycg1@sgarzare-redhat>
References: <20260929-kbh3-1-022-fix-v1-1-cc97cc95d269@eldare.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260929-kbh3-1-022-fix-v1-1-cc97cc95d269@eldare.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: eouG6Px7XolwuMV7SaH4-KQsO0SDSkv1O7s91TbuXms_1790845295
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

+cc Bobby and Michal who touched this code recently

On Tue, Sep 29, 2026 at 06:33:04PM +0200, Jerome Mohm via B4 Relay wrote:
>From: Jerome Mohm <jrmmhm.kernel@eldare.de>
>
>vsock_bpf_recvmsg() takes lock_sock(sk) and holds it across the whole
>receive loop, including vsock_msg_wait_data(), which sleeps in
>wait_woken() without dropping the lock. When data arrives, the
>transport's delivery context (the vsock-loopback worker, or the
>virtio/vhost rx path) calls virtio_transport_recv_pkt() -> lock_sock()
>on the same socket and blocks. That context is the only one that would
>queue the skb and call sk_data_ready() to wake the reader, so neither
>side makes progress. A blocking recv() hangs until a signal arrives (a
>finite SO_RCVTIMEO also breaks it); while it lasts the shared delivery
>worker is stalled, so all vsock rx on that transport stops, not only
>the affected socket. The hung-task watchdog reports the worker blocked
>in D state:
>
>  INFO: task kworker/1:3:107 blocked for more than 5 seconds.
>  task:kworker/1:3 state:D Workqueue: vsock-loopback vsock_loopback_work
>  Call Trace:
>   __schedule
>   schedule
>   __lock_sock
>   lock_sock_nested
>   virtio_transport_recv_pkt
>   vsock_loopback_work
>
>The reader holds the same sk_lock-AF_VSOCK it is waiting on, taken in
>vsock_bpf_recvmsg().
>
>This code is based on net/unix/unix_bpf.c, whose unix_msg_wait_data()
>drops u->iolock around wait_woken() and re-takes it afterwards. The
>vsock port substituted lock_sock() for that serialisation lock but
>omitted the unlock and relock. tcp_bpf and the native
>vsock_connectible_wait_data() both drop the lock across the wait;
>vsock_bpf is the only one that does not.
>
>Release the socket lock around the wait and re-acquire it before
>re-checking for data, so the caller's locking is unchanged.
>
>Fixes: 634f1a7110b4 ("vsock: support sockmap")
>Cc: stable@vger.kernel.org
>Assisted-by: LLM
>Signed-off-by: Jerome Mohm <jrmmhm.kernel@eldare.de>
>---
> net/vmw_vsock/vsock_bpf.c | 2 ++
> 1 file changed, 2 insertions(+)
>
>diff --git a/net/vmw_vsock/vsock_bpf.c b/net/vmw_vsock/vsock_bpf.c
>index 9049d2648646..bb7d81a95baa 100644
>--- a/net/vmw_vsock/vsock_bpf.c
>+++ b/net/vmw_vsock/vsock_bpf.c
>@@ -50,7 +50,9 @@ static bool vsock_msg_wait_data(struct sock *sk, struct sk_psock *psock, long ti
> 	sk_set_bit(SOCKWQ_ASYNC_WAITDATA, sk);
> 	ret = vsock_has_data(sk, psock);
> 	if (!ret) {
>+		release_sock(sk);
> 		wait_woken(&wait, TASK_INTERRUPTIBLE, timeo);
>+		lock_sock(sk);
> 		ret = vsock_has_data(sk, psock);
> 	}
> 	sk_clear_bit(SOCKWQ_ASYNC_WAITDATA, sk);
>
>---
>base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
>change-id: 20260929-kbh3-1-022-fix-340aa3f7f071
>
>Best regards,
>--
>Jerome Mohm <jrmmhm.kernel@eldare.de>
>

LGTM, but I'd like also Bobby and Michal opinion:

Acked-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

