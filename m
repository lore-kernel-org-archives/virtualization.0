Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12583FCB2A
	for <virtualization@lists.linux.dev>; Thu,  9 Jul 2026 08:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783587288; cv=none; b=elCuww79vx8I1i9X3qBmx/olFoSW+xT7Ox9grCUE8Q6VGetUlsiIg4VJR9MY+MwOlQiqcOoyUgFnNKpUrsNdcdKnP4CLc4y/ra/h1GrkuKa2cw7iPqW7MLarloJIuWcO0VyWe+pdsWBXJzNZkP3I1aM4/RCPu+yV2mNjXSNhJeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783587288; c=relaxed/simple;
	bh=wRRaBds4GutgazHTelDLWoEKQjUD+qekfGeab8oKIas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=CrRXCrs+LlDluXzCDXTRtqwN77VE35VTqrekzDYCVhu2lvLp0+5YVfmCPeWJPFHVpFd9P/zY8jkU+IelgaLiCo35ueIiBlTSbGMwje2uwMeofIenoYvBA+UJzZMzaC/CyKySO9iJbKvsfLYiVW5GyT8djNpmw8ac0SyIsNY5blo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BlAyjAbL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BlAyjAbL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783587284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jKBatJUUTBddrBcocZDnsS1t1LpIJaEaNIf3BrEu4hE=;
	b=BlAyjAbLykGVnxtSiIUcYYke3Ot7vTQth/cP4NWIv/m6yme76bTdo9jqpsi3IYY+qSWdvD
	SKW+4Du4VQksNJlpdpoG0V2F1lHYKZGzb9QLREV/M3l1h9mJ0K4HFkiHgR3ii7CKsWXGyS
	7EePKe9LQiCImxRy38vrkBO56kdltGw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-WbMXoQKdMceLObTZ0l8c_g-1; Thu, 09 Jul 2026 04:54:43 -0400
X-MC-Unique: WbMXoQKdMceLObTZ0l8c_g-1
X-Mimecast-MFC-AGG-ID: WbMXoQKdMceLObTZ0l8c_g_1783587282
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-493bc2b376fso13892395e9.3
        for <virtualization@lists.linux.dev>; Thu, 09 Jul 2026 01:54:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783587282; x=1784192082;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jKBatJUUTBddrBcocZDnsS1t1LpIJaEaNIf3BrEu4hE=;
        b=RvAvZFoiK6fEdKD0sPqlGKALD+W0S9y/YuA4pvtLj29OngcFN/hS7eCh9fQRUEZbYm
         yWSjmf+9Go0qZQtNALeUKp++3lbJYMDF2dhRVKmJB3vEsiyuipQo1U8r7puWr/3cKPH4
         4iQy2/CCEo8jbI1RLjMJ/ol5/hQY1rOdbp90XBGEpjsUIRw+5ne7wmoivljFd8Gnb8ie
         EgNNrdRB+Uz8v7pnau5Q9xhdTN/qi+7b5Jbk3o/BNp579qy7iGLWnGA3xRuhNBO6jABO
         kprE/Y9rCaz3j+lB9GVhEfU+qHpGUxswb/kYudDfmGtYnFXo2JXPtlJpDJQtWBV8h9Of
         N6tQ==
X-Forwarded-Encrypted: i=1; AHgh+RoAPYRpNFxRyfqlZmJhCMTwoQEWRrOKHyQkUcoaZXSslFRr8+nGNpVsi+HyPNdBrAXPL1OVLYUhGEEzGm7oYg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzbCdBMwH7wfliZNozHAHLPTcuTvwzu8MBLjV8kYKuzRLxszkJL
	O9sVmJO6MZ0Loq6d94hQ3zKHPPNOlFT90uI2o20pxNroOPAb02a/yeC0SIQo4lI4JWHKHpTTUnr
	2S74uF7AnNmKS/JsyPJ5BqizKVKyYeqSg0jHt1rZy1sj43jqvGfI968vrDJaoxPNEUzhk
X-Gm-Gg: AfdE7ckPRglTKECEZT1r3nksIbZJGsb2JjzYD4j01iUKjJBpxfpYGIkOxy4zWvOwXAw
	gLKH1xwDiqfjTRw+zOZ5vC85H7zDYEjxZUSpDuwGcldGNHQscEO/CLgyVUp/o04Csar8IFjF4VN
	OjfiU1xPajx2A4vS3MIMPEm8J1LGeLpluC6LDxhyRpMCy+QkIIh2Bb4iFVrk09sEK4BPL10TbcC
	so76zCG2LKKJnn6/owv6Oh5zHHxy1C/Q6RNl8N1Z1B9Trr5gVwi0Ypagj2R5G6J065M6Omrfauc
	KaFh+3d0YbxtH5+oZnS8F2V4VUpZJcSeatzGM1IF8PyAuP6qJYWKBWvZ1O4eJf8CTwc0SVdscL9
	p5yjxzmc0h14WuHBhMjn1P4+lZBSm88wXBSXm8rio4eoc/oIdx+TU56rL3eV0
X-Received: by 2002:a05:600c:1993:b0:48a:906b:14ca with SMTP id 5b1f17b1804b1-493e68c6c98mr55722805e9.20.1783587282372;
        Thu, 09 Jul 2026 01:54:42 -0700 (PDT)
X-Received: by 2002:a05:600c:1993:b0:48a:906b:14ca with SMTP id 5b1f17b1804b1-493e68c6c98mr55722455e9.20.1783587281922;
        Thu, 09 Jul 2026 01:54:41 -0700 (PDT)
Received: from sgarzare-redhat (host-79-34-22-35.business.telecomitalia.it. [79.34.22.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb6df6d9sm54564705e9.7.2026.07.09.01.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 01:54:41 -0700 (PDT)
Date: Thu, 9 Jul 2026 10:54:34 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowangio@gmail.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eric Dumazet <edumazet@google.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	virtualization@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>, 
	Jason Wang <jasowang@redhat.com>, stable@vger.kernel.org, Brien Oberstein <brienpub@gmail.com>
Subject: Re: [PATCH net v2 1/2] vsock/virtio: collapse receive queue under
 memory pressure
Message-ID: <ak9fGNnW7gdqVXie@sgarzare-redhat>
References: <20260708102904.50732-1-sgarzare@redhat.com>
 <20260708102904.50732-2-sgarzare@redhat.com>
 <20260708065947-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260708065947-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _okE85-ux8zUXE1NH4pRbU28tfo4B5shIoSc83O1oLs_1783587282
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Jul 08, 2026 at 07:00:00AM -0400, Michael S. Tsirkin wrote:
>On Wed, Jul 08, 2026 at 12:29:03PM +0200, Stefano Garzarella wrote:
>> From: Stefano Garzarella <sgarzare@redhat.com>
>>
>> When many small packets accumulate in the receive queue, the skb overhead
>> can exceed buf_alloc even while the payload is within bounds. This causes
>> virtio_transport_inc_rx_pkt() to reject packets, leading to connection
>> resets during large transfers under backpressure.
>>
>> The issue was reported by Brien, who has a reproducer, but it is also
>> easily reproducible with iperf-vsock [1] using a small packet size:
>>
>>   iperf3 --vsock -c $CID -l 129
>>
>> which fails immediately without this patch but with commit 059b7dbd20a6
>> ("vsock/virtio: fix potential unbounded skb queue").
>>
>> Inspired by TCP's tcp_collapse() which solves a similar problem, add
>> virtio_transport_collapse_rx_queue() that walks the receive queue and
>> re-copies data into compact linear skbs to reduce the overhead.
>>
>> The collapse is triggered proactively from when the number of skb queued
>> is close to exceeding the overhead budget.
>>
>> A pre-scan counts the eligible bytes to size each allocation precisely,
>> avoiding waste for isolated small packets. Partially consumed skbs are
>> kept as-is to preserve buf_used/fwd_cnt accounting, EOM-marked skbs to
>> maintain SEQPACKET message boundaries, and skbs already larger than the
>> collapse target because they already have a good data-to-overhead ratio.
>>
>> Walking a large queue may take a significant amount of time and cache
>> misses, causing traffic burstiness. To limit this, the collapse stops
>> once enough room is freed for this packet and the next one, but may
>> opportunistically free more to fill each collapsed skb to capacity.
>>
>> [1] https://github.com/stefano-garzarella/iperf-vsock
>>
>> Fixes: 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb queue")
>> Cc: stable@vger.kernel.org
>> Reported-by: Brien Oberstein <brienpub@gmail.com>
>> Closes: https://lore.kernel.org/netdev/618701dd023e$063de350$12b9a9f0$@gmail.com/
>> Tested-by: Brien Oberstein <brienpub@gmail.com>
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>
>
>this is the right approach

Yeah, I have a follow up to start to use skb->truesize, etc. but I guess 
more net-next material.

>
>Acked-by: Michael S. Tsirkin <mst@redhat.com>

Thanks,
Stefano

