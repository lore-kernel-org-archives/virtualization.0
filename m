Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742B1475357
	for <virtualization@lists.linux.dev>; Fri,  2 Oct 2026 10:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790937556; cv=none; b=SbDJGrMtnwh7iYHHa+anFpBpK5S7nBVtboGtRX69NVuSvJnnDrTX3ZSyn8+m2f1hF2wWCGWxPVDk+BhLod8wSJSsuCt12FENYJmNMI6vJgZsfrosJNBZsVQoQDH0p6oSWvjIyjgccHnkS3Xtpx/G3lIq5UfXilCcyvpuiddTW2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790937556; c=relaxed/simple;
	bh=KtkrCiH2Hb/NMXldy9WUxOKupOTiAB7hAqMQ2sR7Kok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=rZoHhGbMs5wUj6Raupk+46qpISQt7A8MVk3sUpKad/sBjpyQKgy0V1TMwO1GoHCIy/w2FOfD2cUQSfIX7NW+JX0sltN/+Wq3WXtfYYgrlWShEISlxpbiMwG+Ob2o6aUBvQaqdRufLS7WQy3vTh3prIWDx/14A4rrr7ySwZhrh9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CqahzRIz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CqahzRIz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790937552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MJkvDY/VxTHA+7Il1t54O0cGx3YczFz/IeL9Lev4wYw=;
	b=CqahzRIzRE4SK+wsKuhUl3J+4FgM/JaIJzEwtbRntD1DyRJpoWZT4XOQQpHT9QurdpCU3M
	XFsfJBB8i/N0E01WYRF8RDzAvwJLMM5v7NQE8ASlo5HI8rtpO25FmMxRLj4zIdF+XizUPy
	56B+Q7zesrKPcR75lkapffq9UyTrXl8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-mrUhVyNlMaSXwqdmHG8B_A-1; Fri, 02 Oct 2026 06:39:11 -0400
X-MC-Unique: mrUhVyNlMaSXwqdmHG8B_A-1
X-Mimecast-MFC-AGG-ID: mrUhVyNlMaSXwqdmHG8B_A_1790937550
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-487038bc9b8so5496789f8f.2
        for <virtualization@lists.linux.dev>; Fri, 02 Oct 2026 03:39:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790937550; x=1791542350;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MJkvDY/VxTHA+7Il1t54O0cGx3YczFz/IeL9Lev4wYw=;
        b=FxLhC6eYN3VyRwM4sqgkoEaS8cT7GRuvFFnkj3p9wOXNHOb32Hmlfi+Xzh5+FbZ15C
         4yyOwkWEJ0EV7vDjrSfjJpLSuePNeJfzr+jXbGu8/k8EC+1kotCO3BclHe8DY0eE9Cqs
         QrJTRQfQ1QBNXwkQPFuR8QfRHsoPT0lEp4MS96dA6z1hfHbi3cvMltDOh930qJx0Vozu
         /rz4YTDgHRNmwnNy1087FOMPIF0cDNficWC9NawlXL/0jDPMCbnymoMfvOFiWIT8IcR4
         Eydbhjj6JH7kNxqW0Kp5cRCCUkgKZJawqTXroDOYRrSf+ucoBSzyLOsDv9cH6IR1C8ZA
         OqLQ==
X-Forwarded-Encrypted: i=1; AKwUvBwznA3y6hpWoKB3p7OSuKszAfEDvUuABzSE01JG9Xz7gegfw79+nzynuEmQqoUg38s5nUBp/hwswjvxVO+ktQ==@lists.linux.dev
X-Gm-Message-State: AFuF++mA2hiX6uTWZiPxdw3s8PGfPHHa0s7/Kz+vNjnpIDeHf8hZOtvn
	gmKeR+a2Cu3hV+2QbQKTBf4al7ohEt+aSEZQBiHdjuTKjyshY/HaunTec7Uumh10kvrnJMM83hA
	bPUDuN6Zd4aINVoiaWGxlmIBX2HlXBTbY0gi02v6jKPBh6f/2bqsxc8iw0LQuUiWM1UDh
X-Gm-Gg: AYBFou2LzmXJhAcvjIl6n91eiyBvg6Il8jDtRniMEZ8HhBlZrV8wj018dQGuK36S+Q7
	xnf8YzTIm3vGCT6UNOUxAHWZfYSfoSNueyE9FANBa0LZwybGRkExshWiv3tJX6+iMdJ+7+eDkbx
	UJuDmqj9r6otR+gpKeUyWiUDbUJi2zFYbmKqFtxdZQbmzxlUxzPdHjIAKBNVaJ6lI6geZxzlXEl
	HtQBs+VEL8HaHlk0BaKjlFz5c/FgQa3iBvlpPluUk10njrgA/T7gA4dtLDo11IrGKcfqcar+DIN
	m45q0AdtDvqh2g0SmWpfiunI2BMJ6PO6Ljia5psWiD7fc3t2a4pHMSdNPQFwUIU1SA963D54rqf
	uIB13
X-Received: by 2002:a05:600c:4e50:b0:49f:faa3:3ca2 with SMTP id 5b1f17b1804b1-4a0275840aamr42203165e9.13.1790937549593;
        Fri, 02 Oct 2026 03:39:09 -0700 (PDT)
X-Received: by 2002:a05:600c:4e50:b0:49f:faa3:3ca2 with SMTP id 5b1f17b1804b1-4a0275840aamr42202565e9.13.1790937549019;
        Fri, 02 Oct 2026 03:39:09 -0700 (PDT)
Received: from sgarzare-redhat ([178.99.185.246])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a03fef174bsm38987125e9.2.2026.10.02.03.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 03:39:08 -0700 (PDT)
Date: Fri, 2 Oct 2026 12:39:03 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: physicalmtea@gmail.com
Cc: stefanha@redhat.com, mst@redhat.com, jasowangio@gmail.com, 
	eperezma@redhat.com, xuanzhuo@linux.alibaba.com, davem@davemloft.net, 
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] vsock: reduce RX per-packet socket overhead
Message-ID: <ar95red76pmfQwvF@sgarzare-redhat>
References: <20261002074551.318789-1-physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20261002074551.318789-1-physicalmtea@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mGT9Fk0NUi7ujRR3mPoDMHNw76dxtGekY_VMKuc91F0_1790937550
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Fri, Oct 02, 2026 at 07:45:46AM +0000, physicalmtea@gmail.com wrote:
>From: Jia Jia <physicalmtea@gmail.com>
>
>This series reduces per-packet socket overhead in the virtio-vsock RX
>worker.

I did a quick look but IMO this is hard to review, please try to keep 
patches as small as possible, e.g. where you are introducing ctx, store 
ctx->net in a net variable, so you don't need to touch the entire 
function, etc.

Please check https://docs.kernel.org/process/coding-assistants.html
and also https://docs.kernel.org/process/submitting-patches.html
ans also https://docs.kernel.org/process/maintainer-netdev.html#git-trees-and-patch-flow
(I guess this is net-next material).

I don't think this series was sent properly, I tried
`b4 am 20261002074551.318789-1-physicalmtea@gmail.com` without success 
and also looking at 
https://lore.kernel.org/virtualization/20261002074551.318789-1-physicalmtea@gmail.com/ 
I can't see the full series, please check your workflow.

Also, is this for vsock core or just virtio-vsock? if it's just 
virtio-vsock transports, please use "vsock/virtio" prefix.


>
>Patch 1: separate socket lookup from locked packet processing.
>
>Patch 2: keep one socket lock across a bounded run of established
>STREAM/RW packets for the same native socket.
>
>Patch 3: reuse the locked socket for later packets with the same
>address tuple.
>
>Patch 4: coalesce default write-space notifications while that
>lock is held.
>
>Patch 5: defer the default readable callback until after the batch
>unlocks. Custom callbacks retain per-packet notification behavior.
>
>Performance:
>
>Tested on single-stream AF_VSOCK (1 reader on Guest CPU0, virtio-vsock IRQ
>on Guest CPU1, fresh QEMU guest per state, 16 balanced AB/BA pairs per
>payload).

What the host is using? vhost-vsock?

>
>End-to-end RX throughput (64K receiver buffer, SO_RCVLOWAT=1):
>
>  payload  baseline RX (G/s)  PATCH RX (G/s)  throughput change (95% CI)

What G is? Gbit? Gbytes?

>  256B     0.5722             1.0286          +79.76% [+75.40%, +84.23%]
>  512B     1.1464             1.9779          +72.53% [+69.50%, +75.63%]
>  1K       2.2714             3.6368          +60.12% [+56.92%, +63.37%]
>  4K       3.9095             7.7160          +97.37% [+92.09%, +102.79%]

Why stop to 4k?

>
>Fixed-syscall stress test (receiver buffer = sender write size; RX in G/s):
>
>  payload baseline RX PATCH RX throughput change (95% CI) recv() base/patch
>  256B     0.2885       0.6737    +133.50% [+123.58%, +143.86%]  1048577/1048577
>  512B     0.5631       1.2091    +114.71% [+104.97%, +124.92%]  1048577/1048577
>  1K       1.5361       2.9678    +93.20% [+80.15%, +107.20%]     1048577/1048577
>  4K       2.8378       6.1878    +118.05% [+109.15%, +127.33%]  538802/525645
>
>Request-response latency (Ping-Pong RTT, 10,000 requests):

What tool did you used for both throughput and latency?

>
>  payload  baseline mean RTT (us)  PATCH mean RTT (us)  change (95% CI)
>  256B     126.968                124.541              -1.91% [-3.35%, -0.45%]
>  4K       130.362                126.664              -2.84% [-5.12%, -0.50%]

Whys only this payload cases? For latency we should use even try small 
payloads IMO like 64 bytes.

Thanks,
Stefano

>
>Diagnostic Guest CPU1 system-wide cycles (fixed-64K receiver, with perf):
>
>  Buffer size  baseline cycles/B  PATCH cycles/B  cycles change (95% CI)
>  256B     15.287            13.630          -10.84% [-12.51%, -9.14%]
>  512B      7.306             6.611           -9.51% [-10.92%, -8.08%]
>  1K        3.811             3.458           -9.25% [-10.96%, -7.50%]
>  4K        1.850             1.669           -9.75% [-11.78%, -7.67%]
>
>Jia Jia (5):
>  vsock: split socket lookup from locked RX processing
>  vsock: amortize RX socket locking for stream packets
>  vsock: reuse same-flow socket lookup in RX batches
>  vsock: coalesce RX write-space notifications in lock batches
>  vsock: defer RX readable notifications until batch unlock
>
> include/linux/virtio_vsock.h            |  14 ++
> include/net/af_vsock.h                  |   3 +
> net/vmw_vsock/af_vsock.c                |   2 +
> net/vmw_vsock/virtio_transport.c        |  48 ++++-
> net/vmw_vsock/virtio_transport_common.c | 341 +++++++++++++++++++++++++++-----
> 5 files changed, 357 insertions(+), 51 deletions(-)
>
>base-commit: f5f84daefcd92d7a630066635ecea1433ed5eac7
>-- 
>2.53.0
>

