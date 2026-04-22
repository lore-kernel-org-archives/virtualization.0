Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5022773FF
	for <virtualization@lists.linux.dev>; Wed, 22 Apr 2026 06:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776837961; cv=none; b=hxCPIeO+XcSts4HpujJitWZjse9eMS3lbw7Z8YnW9AbpFojTaocZhrGS0/a+Lc9HaVWga74D9JwFHcQwMFPsijNBjEnjAp3Jx6zBPn7GQxmyttN/nfA1lfcld3QNZy3ENom0+0aIO3fbaU0IGcMXAzs0+Lc7UlURurn4/9O8HjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776837961; c=relaxed/simple;
	bh=D0IhErlGrKKuMRwPOP4Tlt1GsqbT8xAI/tb1DvR/nwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=h8osOZv1D0DbNUgN6JTYmDCBNFxquxmasgaEQ8PMRfnn/zP0kS4e2n0HV4w0tF6Wlgry+B3SB5HMw8vQatAauT0x/CY4TllnVYG02xrSsQ5ECkRzO9j2UTITC1V1ifWwl3ohrdFcobBMbhxnAr4C6wOyFoVK+f0tE7KVES10Qjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eqT4Y83e; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eqT4Y83e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776837958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ztMyE+ktT7jgxWkcpg5pXckPoWAOQRydQBsfKgsWIR8=;
	b=eqT4Y83eSEVOld3VSc9b7WKKChHC08li+9tA4dNOM1ML9ACF+kG0NlTbjYqdR3xyk7xBMt
	49uKWpVDpuQ+kpQnt+bMAA/m1QadqB0mwXukWmQBMvVYVm39wJC/R/8yyqoJusF0XIAyeJ
	cMqSDL/Vk4djfsyCVRLAedMpEiQZJ0U=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-456-FExLxkWEMmSo_OK0CHZKQw-1; Wed, 22 Apr 2026 02:05:57 -0400
X-MC-Unique: FExLxkWEMmSo_OK0CHZKQw-1
X-Mimecast-MFC-AGG-ID: FExLxkWEMmSo_OK0CHZKQw_1776837956
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-488d1b5bca0so27545925e9.2
        for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 23:05:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776837956; x=1777442756;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ztMyE+ktT7jgxWkcpg5pXckPoWAOQRydQBsfKgsWIR8=;
        b=cZ6AXcTeWkLiE2VkuN8iR7bzzbVfAuXtgFp+XThk67y0M/7QvmXFXt0Olvkn9Mj9BD
         SyCPWYWYY1t0Y6Xz064er3XgKIza6FfCpWB2l34dTAkLXn4kgh3bRWwqeLSiv243PBCl
         d9mpuc8HOI4OojlWUlJVt5J7kooQOI18zwyP1Y3UTIAIB2rbvtKf4N/UJxUTOkwL420Q
         400PLyIvB3LTrk81LcZEurMCCqcc4afQVtQoqoukE/5Evvas6iu7cy3b9QtI72AV1qAL
         3yhXOQ2183I+TU1ljb4Y2C92PmCPY6efuG/CZjeaahdN6YcmBRy6MzqPPX+Uvpwa7leP
         3uyA==
X-Forwarded-Encrypted: i=1; AFNElJ8N2vWEqHW+ufH06uyDUxGSdYivib/bSp0oqTjRTlTq2Gdb1hP3jqp53E0otiYph8AsP88IjaFCUxayfmGSeg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxaADdj3jQ4Z8DIgrrmtZu+CIvEbZs5LeHQPExB4JtiwqxFNBIm
	2vXgQm3uLammfF94iNriA835EWPIPLhfQjoUClhjdfcZSM+D9BDMc9j+i2VYjVg8bMY92jspzvR
	YmkMTmd6B83gUnCNurgmV7kxW7u/GOnaZjoUpXNpK7n3uoN4/OlmH9lE1kSz2jOXBXqUM
X-Gm-Gg: AeBDievBMGY8Tovs1UX9zKaGPXXkfCyB9tKrM1h5wLczag6oIlYW8zX3CvGe+Ggwayv
	AVAlFmOrxaqQnyJadxMRJWXqT0Lthr6DmIJPqOdJ1DUY2+iiHgU6Lo7yM9lB8z9GZMc0thM6fxi
	EInKlVu2/yoUt9Y6S3McJ0fZO7H8Kjkkhb8iyjeClPR2yia1G32iWjgauRuQytUlE19RwMKNc3W
	+6QvjDOPrLcdJXwTOmr5KR5gv+0CtN3UrYTNjfXjkgX1NS9oyPpu9cukUhduKw5tGewBsFawlPz
	OMUoSMgZ6Xbiro8hSUmGgM7DcKoOvw3gm5zYudugREIYuWXwiChs23RLQKYXR9FRWCZ1K4Wduwz
	tFk6rmYrzEL7AeCbsGPF1n+G2tlAtGRni/qyACwqHUVlAdrsTlhuUqg==
X-Received: by 2002:a05:600c:470d:b0:48a:52ce:a4b1 with SMTP id 5b1f17b1804b1-48a52cea6d8mr117687675e9.15.1776837955984;
        Tue, 21 Apr 2026 23:05:55 -0700 (PDT)
X-Received: by 2002:a05:600c:470d:b0:48a:52ce:a4b1 with SMTP id 5b1f17b1804b1-48a52cea6d8mr117687235e9.15.1776837955527;
        Tue, 21 Apr 2026 23:05:55 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-21.inter.net.il. [80.230.25.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc177dafsm520792265e9.4.2026.04.21.23.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 23:05:54 -0700 (PDT)
Date: Wed, 22 Apr 2026 02:05:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Kohei Enju <kohei@enjuk.jp>
Cc: Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	syzbot+6985cb8e543ea90ba8ee@syzkaller.appspotmail.com
Subject: Re: [PATCH net v1] vhost_net: fix sleeping with preempt-disabled in
 vhost_net_busy_poll()
Message-ID: <20260422020539-mutt-send-email-mst@kernel.org>
References: <20260422023026.81960-1-kohei@enjuk.jp>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260422023026.81960-1-kohei@enjuk.jp>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VG5SowTx-0Fji16ETyTSNlrvmU9wa0t1QUa5IRKhfYU_1776837956
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 22, 2026 at 02:30:24AM +0000, Kohei Enju wrote:
> syzbot reported "sleeping function called from invalid context" in
> vhost_net_busy_poll().
> 
> Commit 030881372460 ("vhost_net: basic polling support") introduced a
> busy-poll loop and preempt_{disable,enable}() around it, where each
> iteration calls a sleepable function inside the loop.
> 
> The purpose of disabling preemption was to keep local_clock()-based
> timeout accounting on a single CPU, rather than as a requirement of
> busy-poll itself:
> 
> https://lore.kernel.org/netdev/1448435489-5949-4-git-send-email-jasowang@redhat.com/T/#u
> 
>   Changes from RFC V1:
>   ...
>   - Disable preemption during busy looping to make sure local_clock()
>     was correctly used.
> 
> >From this perspective, migrate_disable() is sufficient here, so replace
> preempt_disable() with migrate_disable(), avoiding sleepable accesses
> from a preempt-disabled context.
> 
> Fixes: 030881372460 ("vhost_net: basic polling support")
> Tested-by: syzbot+6985cb8e543ea90ba8ee@syzkaller.appspotmail.com
> Reported-by: syzbot+6985cb8e543ea90ba8ee@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/69e6a414.050a0220.24bfd3.002d.GAE@google.com/T/
> Signed-off-by: Kohei Enju <kohei@enjuk.jp>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/vhost/net.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index 80965181920c..c6536cad9c4f 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -560,7 +560,7 @@ static void vhost_net_busy_poll(struct vhost_net *net,
>  	busyloop_timeout = poll_rx ? rvq->busyloop_timeout:
>  				     tvq->busyloop_timeout;
>  
> -	preempt_disable();
> +	migrate_disable();
>  	endtime = busy_clock() + busyloop_timeout;
>  
>  	while (vhost_can_busy_poll(endtime)) {
> @@ -577,7 +577,7 @@ static void vhost_net_busy_poll(struct vhost_net *net,
>  		cpu_relax();
>  	}
>  
> -	preempt_enable();
> +	migrate_enable();
>  
>  	if (poll_rx || sock_has_rx_data(sock))
>  		vhost_net_busy_poll_try_queue(net, vq);
> -- 
> 2.51.0

